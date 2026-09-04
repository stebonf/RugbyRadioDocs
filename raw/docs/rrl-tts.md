# RRL - TTS, voce e AI-Talker

## Scopo del documento

Raccolta raw delle informazioni disponibili su TTS, voce, audio telecronaca e AI-Talker in Rugby Radio Live, includendo nozioni di prodotto, backend, frontend, storage, flussi e note tecniche.

Fonti principali consultate:

- `llm-wiki/wiki/index.md`
- `llm-wiki/wiki/backend/api/integrations/AzureSpeech (api).md`
- `llm-wiki/wiki/backend/api/services/VoiceService (api).md`
- `llm-wiki/wiki/backend/api/apis/VoicesV1Controller (api).md`
- `llm-wiki/wiki/frontend/web/services/VoiceService (web).md`
- `llm-wiki/wiki/frontend/web/components/MatchEventsComponent (web).md`
- `llm-wiki/wiki/frontend/web/components/MatchCommentatorComponent (web).md`
- `llm-wiki/wiki/concepts/AI-Talker (concept).md`
- `llm-wiki/wiki/concepts/Telecronaca (concept).md`
- `llm-wiki/wiki/workflows/Spettatore Partita (workflow).md`
- `llm-wiki/wiki/business/product/Rugby Radio Live (product).md`
- `src/RugbyRadio/Lib/Services/VoiceService.cs`
- `src/RugbyRadio/Lib/Services/Interfaces/IVoiceService.cs`
- `src/RugbyRadio/Api/Controllers/VoicesV1Controller.cs`
- `src/RugbyRadioWeb/src/app/services/voice.service.ts`
- `src/RugbyRadioWeb/src/app/common/match-events/match-events.component.*`
- `src/RugbyRadioWeb/src/app/common/match-commentator/match-commentator.component.*`
- `src/RugbyRadioWeb/src/app/services/user.service.ts`
- `src/RugbyRadio/HF/Jobs/Core/CreateMatchEventCoreJob.cs`
- `src/RugbyRadio/Tests/Controllers/VoicesV1ControllerTests.cs`

## Nozioni di prodotto

Rugby Radio Live non e una diretta audio tradizionale. Il termine "radio" indica un canale di comunicazione: il cronista clicca eventi partita, gli spettatori ricevono eventi testuali, punteggio e telecronaca generata.

La telecronaca e l'insieme degli eventi cliccati dal cronista durante una partita. Ogni evento viene trasformato in frase di telecronaca tramite AI-Talker e mostrato agli spettatori collegati.

L'AI-Talker e un personaggio virtuale che determina stile e lingua delle frasi di telecronaca. Uno spettatore puo scegliere un AI-Talker diverso, quindi la stessa partita puo essere raccontata con stili e lingue differenti.

Decisione architetturale rilevante: non c'e una chiamata AI realtime al click dell'evento. Le frasi AI sono generate in anticipo, approvate/salvate nel database e poi usate durante la partita.

Il TTS e una funzione opzionale sopra la telecronaca testuale: lo spettatore puo ascoltare gli eventi tramite sintesi vocale, ma questo non trasforma il prodotto in una diretta audio.

## Concetti collegati

- Telecronaca: eventi partita cliccati dal cronista e renderizzati come frasi.
- AI-Talker: stile e lingua della telecronaca; e anche elemento di branding.
- Voice/TTS: generazione MP3 da una frase o da un evento partita.
- SystemMessage: catalogo backend di messaggi approvati per tipo evento, lingua e versione.
- MatchEvent: evento concreto della partita; puo produrre audio evento dedicato.

## Flusso end-to-end

1. I job Hangfire generano o mantengono il catalogo dei messaggi AI in piu lingue e stili.
2. I messaggi approvati vengono salvati in `SystemMessage`.
3. Lo spettatore seleziona un AI-Talker nel frontend.
4. Il frontend salva l'ID del commentatore/lingua in `localStorage` e, se l'utente e autenticato, aggiorna il profilo con `commentaryLanguage`.
5. Nella lista eventi partita, se l'AI-Talker selezionato ha audio disponibile, viene mostrato il pulsante audio.
6. Al click sul pulsante audio, il frontend chiama `GET /v1/voices/events?language={commentatorId}&eventId={eventId}`.
7. Il backend recupera il `MatchEvent`, cerca il relativo `SystemMessage`, genera o riusa il file MP3 su filesystem.
8. Il backend restituisce una stringa `text/plain` con il path relativo dell'MP3.
9. Il frontend costruisce l'URL finale con `environment.audioUrl` (`https://storage-sh.rugbyradiolive.com/audio/`) e riproduce il file con `new Audio(audioUrl).play()`.

## Backend

### Controller

Classe: `src/RugbyRadio/Api/Controllers/VoicesV1Controller.cs`

Base route:

```text
v{version:apiVersion}/voices
```

Versione API:

```text
1.0
```

Produces:

```text
text/plain
```

Endpoint effettivi nel codice:

```text
GET /v1/voices?language={language}&sentence={sentence}
GET /v1/voices/events?language={language}&eventId={eventId}
```

Nota: il wiki `VoicesV1Controller (api)` riporta `GET /v1/voices/{eventId}` per VOC-02, ma il codice backend e il frontend usano `GET /v1/voices/events` con query string.

Comportamento:

- `GetAudio(language, sentence)` chiama `IVoiceService.GetAudioAsync`.
- `GetEventAudio(language, eventId)` chiama `IVoiceService.GetAudioEventAsync`.
- Se il servizio restituisce `null`, il controller risponde `NotFound()`.
- Se il servizio restituisce un path, il controller risponde `Ok(GetFileName(file))`.
- `GetFileName` rimuove il prefisso `D:\Web\RugbyRadioStorage\audio\`, converte `\` in `/` e trimma la stringa.
- Non risultano attributi `[Authorize]` o `[AllowAnonymous]` sul controller o sugli endpoint.

### Interfaccia servizio

Classe: `src/RugbyRadio/Lib/Services/Interfaces/IVoiceService.cs`

Metodi:

```csharp
Task<string?> GetAudioAsync(string language, string sentence);
Task<string?> GetAudioEventAsync(string language, string eventId);
```

Il contratto restituisce una stringa path o `null`, non direttamente uno stream audio.

### Servizio TTS

Classe: `src/RugbyRadio/Lib/Services/VoiceService.cs`

Dipendenze iniettate:

- `IMatchEventRepository`
- `ISystemMessageRepository`
- `IMatchService`

Responsabilita:

- Generare audio MP3 per preview voce da testo/frase.
- Generare audio MP3 per evento partita.
- Caching su filesystem: se il file esiste, non viene rigenerato.
- Pulizia del testo prima della sintesi.
- Mapping tra codice lingua/stile e voce Azure Speech.

### Preview voce

Metodo:

```csharp
GetAudioAsync(string language, string sentence)
```

Path file generato:

```text
D:\Web\RugbyRadioStorage\audio\{language}\{sentence}.mp3
```

Nel frontend il caso noto passa sempre `sentence = "presentation"`, quindi il path tipico e:

```text
D:\Web\RugbyRadioStorage\audio\it-arcaico\presentation.mp3
```

Il metodo non sintetizza direttamente il testo `sentence`: usa una frase hardcoded in base a `language`, per esempio una frase di presentazione dell'AI-Talker. Se la lingua/stile non e riconosciuta, ritorna `null`.

### Audio evento

Metodo:

```csharp
GetAudioEventAsync(string language, string eventId)
```

Passi:

- Recupera il `MatchEvent` tramite `IMatchEventRepository.GetByIdAsync(eventId)`.
- Se evento o `MatchId` sono assenti, ritorna `null`.
- Cerca il messaggio con:

```text
Code = MatchEventType-{eventType}
Language = language.ToUpperInvariant()
Version = e.TypeVersion
```

- Se il messaggio non esiste o non ha `Message`, ritorna `null`.
- Calcola il path del file.

Path per messaggi senza player:

```text
D:\Web\RugbyRadioStorage\audio\{language}\matcheventtype-{type}-{version}.mp3
```

Path per messaggi con player:

```text
D:\Web\RugbyRadioStorage\audio\{language}\events\{eventId}.mp3
```

Se `FlagPlayer` e valorizzato, il servizio recupera la partita con `IMatchService.GetMatchAsync(e.MatchId, language, null)` e usa la `EventDescription` dell'evento renderizzato, cosi i placeholder giocatore sono gia risolti.

### Scrittura MP3

Metodo interno:

```csharp
WriteFileAsync(string filePath, string language, string text)
```

Comportamento:

- Recupera la voce con `GetVoice(language)`.
- Se la voce non esiste, ritorna `false`.
- Rimuove surrogate Unicode (`\p{Cs}`).
- Rimuove tag HTML con regex `<.*?>`.
- Chiama Azure Speech.
- Crea la directory di destinazione se manca.
- Scrive il file con `File.WriteAllBytesAsync(filePath, response)`.

Non risultano retry o fallback applicativi. Se la lingua/stile non e supportata o la generazione fallisce, il flusso arriva a `null`/`NotFound`.

### Azure Speech

Provider:

```text
Microsoft Azure Cognitive Services Speech SDK
```

Package:

```text
Microsoft.CognitiveServices.Speech 1.43.0
```

Metodo:

```csharp
AzureTextToSpeechAsync(string text, string voiceName)
```

Configurazione nel codice:

- `SpeechConfig.FromSubscription(...)`
- Regione hardcoded: `swedencentral`
- Voce impostata con `speechConfig.SpeechSynthesisVoiceName`
- Formato output: `Audio16Khz32KBitRateMonoMp3`
- Sintesi: `SpeechSynthesizer(...).SpeakTextAsync(text)`
- Output usato: `result.AudioData`

Nota sicurezza: la subscription key Azure Speech e hardcoded nel codice sorgente. Non viene riportata in questo documento; va spostata in configurazione/segreti.

### Storage backend

Root filesystem hardcoded:

```text
D:\Web\RugbyRadioStorage\audio\
```

I path backend sono poi trasformati in path relativi dal controller e pubblicati via storage/CDN:

```text
https://storage-sh.rugbyradiolive.com/audio/
```

Esempi path relativi restituiti:

```text
events/file.mp3
it-arcaico/presentation.mp3
it/matcheventtype-100-1.mp3
it/events/{eventId}.mp3
```

## Mapping voci TTS backend

La funzione `GetVoice(language)` supporta i seguenti codici.

### Voce base: Vox

| Codice | Azure voice |
|---|---|
| `IT` | `AvaMultilingualNeural` |
| `EN` | `AvaMultilingualNeural` |
| `ES` | `AvaMultilingualNeural` |
| `FR` | `AvaMultilingualNeural` |
| `JA` | `AvaMultilingualNeural` |

### Arcaico / Orfeo

| Codice | Azure voice |
|---|---|
| `IT-ARCAICO` | `MarcelloMultilingualNeural` |
| `EN-ARCAICO` | `MarcelloMultilingualNeural` |
| `ES-ARCAICO` | `MarcelloMultilingualNeural` |
| `FR-ARCAICO` | `MarcelloMultilingualNeural` |
| `JA-ARCAICO` | `MarcelloMultilingualNeural` |

### Influencer / Zoe

| Codice | Azure voice |
|---|---|
| `IT-INFLUENCER` | `NovaTurboMultilingualNeural` |
| `EN-INFLUENCER` | `NovaTurboMultilingualNeural` |
| `ES-INFLUENCER` | `NovaTurboMultilingualNeural` |
| `FR-INFLUENCER` | `NovaTurboMultilingualNeural` |
| `JA-INFLUENCER` | `NovaTurboMultilingualNeural` |

### Adolescente / Nitro

| Codice | Azure voice |
|---|---|
| `IT-ADOLESCENTE` | `BrianMultilingualNeural` |
| `EN-ADOLESCENTE` | `BrianMultilingualNeural` |
| `ES-ADOLESCENTE` | `BrianMultilingualNeural` |
| `FR-ADOLESCENTE` | `BrianMultilingualNeural` |
| `JA-ADOLESCENTE` | `BrianMultilingualNeural` |

### Alieno / Zorblax

| Codice | Azure voice |
|---|---|
| `IT-ALIENO` | `JennyMultilingualNeural` |
| `EN-ALIENO` | `JennyMultilingualNeural` |
| `ES-ALIENO` | `JennyMultilingualNeural` |
| `FR-ALIENO` | `JennyMultilingualNeural` |
| `JA-ALIENO` | `JennyMultilingualNeural` |

### Chef / Elixir

| Codice | Azure voice |
|---|---|
| `IT-CHEF` | `IsabellaMultilingualNeural` |
| `EN-CHEF` | `IsabellaMultilingualNeural` |
| `ES-CHEF` | `IsabellaMultilingualNeural` |
| `FR-CHEF` | `IsabellaMultilingualNeural` |
| `JA-CHEF` | `IsabellaMultilingualNeural` |

### ExPlayer / Bulldog

| Codice | Azure voice |
|---|---|
| `IT-EXPLAYER` | `AlessioMultilingualNeural` |
| `EN-EXPLAYER` | `AlessioMultilingualNeural` |
| `ES-EXPLAYER` | `AlessioMultilingualNeural` |
| `FR-EXPLAYER` | `AlessioMultilingualNeural` |
| `JA-EXPLAYER` | `AlessioMultilingualNeural` |

## AI-Talker e messaggi generati offline

Il job core `CreateMatchEventCoreJob` gestisce la generazione dei messaggi per eventi e talker.

Talker gestiti nel job:

- `Default`
- `Adolescente`
- `Alieno`
- `Arcaico`
- `Chef`
- `ExPlayer`
- `Influencer`
- `Milanese`
- `Rapper`
- `Romano`
- `Telecronista`

Lingue gestite:

- `IT`
- `EN`
- `FR`
- `JA`
- `ES`

Regola codice lingua:

- Per `Default`: `IT`, `EN`, `FR`, `JA`, `ES`.
- Per gli altri talker: `{LANGUAGE}-{TALKER}`, per esempio `IT-ARCAICO`.

Il job usa prompt da:

```text
src/RugbyRadio/HF/Prompts/Talkers/{talker}/{language}.txt
```

Usa TailoorTalker per generare/trasformare i testi, verifica risposta e lingua, poi salva draft/messaggi. Questo riguarda il testo della telecronaca, non direttamente il TTS audio.

## Frontend

### VoiceService Angular

Classe: `src/RugbyRadioWeb/src/app/services/voice.service.ts`

Estende:

```ts
BaseService
```

Metodi:

```ts
getVoice(language: string, sentence: string): Observable<string>
getVoiceEvent(language: string, eventId: string): Observable<string>
```

Endpoint chiamati:

```text
{apiUrl}/voices?language={language}&sentence={sentence}
{apiUrl}/voices/events?language={language}&eventId={eventId}
```

La risposta e letta con:

```ts
{ responseType: 'text' }
```

Motivo: il backend risponde con una stringa plain text contenente il path relativo del file audio, non JSON.

### Configurazione ambiente

File:

- `src/RugbyRadioWeb/src/app/environments/environment.ts`
- `src/RugbyRadioWeb/src/app/environments/environment.prod.ts`

Audio base URL:

```text
https://storage-sh.rugbyradiolive.com/audio/
```

API URL:

- dev: `https://api-s1-sh.rugbyradiolive.com/v1`
- prod: `https://api-s2-sh.rugbyradiolive.com/v1`

Il frontend costruisce l'URL finale cosi:

```ts
const audioUrl = environment.audioUrl + audioBlob.replace(/"/g, '').trim();
```

### MatchCommentatorComponent

File:

- `src/RugbyRadioWeb/src/app/common/match-commentator/match-commentator.component.ts`
- `src/RugbyRadioWeb/src/app/common/match-commentator/match-commentator.component.html`

Responsabilita TTS/voce:

- Mostra un selettore telecronista in drawer.
- Organizza i talker in 5 tab lingua: italiano, inglese, francese, spagnolo, giapponese.
- Mostra avatar, nome, titolo e descrizione.
- Permette la preview audio del talker se `commentator.voice !== ''`.
- Quando si seleziona un talker, chiama `UserService.setCommentatorId(id)`.
- Emette `commentatorChanged`.

Preview audio:

```ts
playAudio(language: string, sentence: string) {
  this.isPlayingAudio = language;
  this.voiceService.getVoice(language, sentence).subscribe((audioBlob: string) => {
    const audioUrl = environment.audioUrl + audioBlob.replace(/"/g, '').trim();
    const audio = new Audio(audioUrl);
    audio.addEventListener('ended', () => {
      this.isPlayingAudio = '';
    });
    audio.play().catch(() => {
      this.isPlayingAudio = '';
    });
  });
}
```

Nel template:

```text
(click)="playAudio(commentator.voice, 'presentation')"
```

Se `voice` e vuota viene mostrato un pulsante disabilitato.

### MatchEventsComponent

File:

- `src/RugbyRadioWeb/src/app/common/match-events/match-events.component.ts`
- `src/RugbyRadioWeb/src/app/common/match-events/match-events.component.html`

Responsabilita TTS/voce:

- Visualizza il feed degli eventi partita.
- Determina se mostrare il pulsante audio tramite `UserService.isCommentatorAudioAvailable()`.
- Riproduce audio TTS per singolo evento.

Logica:

```ts
private updateCommentatorAudioAvailability(): void {
  this.isCommentatorAudioAvailable = this.userService.isCommentatorAudioAvailable();
}
```

Riproduzione audio evento:

```ts
playAudio(eventId: string): void {
  this.isPlayingAudio = eventId;
  this.voiceService.getVoiceEvent(this.userService.getCommentatorId(), eventId).subscribe((audioBlob: string) => {
    const audioUrl = environment.audioUrl + audioBlob.replace(/"/g, '').trim();
    const audio = new Audio(audioUrl);
    audio.addEventListener('ended', () => {
      this.isPlayingAudio = '';
    });
    audio.play().catch(() => {
      this.isPlayingAudio = '';
    });
  });
}
```

Template:

```html
@if (isCommentatorAudioAvailable) {
  <button type="button" class="match-events__audio-btn match-events__audio-btn--header" (click)="playAudio(event.id)" [class.is-playing]="isPlayingAudio === event.id" [attr.aria-label]="'Play audio commentary'">
    <span class="match-events__audio-glyph" aria-hidden="true">...</span>
  </button>
}
```

Nota: l'icona nel template e un glifo unicode, non un componente `IconComponent`.

### UserService e selezione commentatore

File: `src/RugbyRadioWeb/src/app/services/user.service.ts`

Chiavi `localStorage`:

```text
user_language
commentator_id
```

Lingua utente:

- Se assente, default `EN`.
- `setUserLanguage(language)` salva la lingua e, se l'utente e loggato, aggiorna il profilo.

Commentator ID:

- `getCommentatorId()` legge `commentator_id`.
- Se assente, ritorna `getUserLanguage()`.
- `setCommentatorId(id)` salva `commentator_id`.
- Se l'utente e loggato, aggiorna il profilo con `commentaryLanguage: id`.

Disponibilita audio:

```ts
isCommentatorAudioAvailable(): boolean
```

Ritorna `true` solo per:

- Base: `IT`, `EN`, `FR`, `ES`, `JA`
- `ARCAICO` in 5 lingue
- `INFLUENCER` in 5 lingue
- `ADOLESCENTE` in 5 lingue
- `CHEF` in 5 lingue
- `ALIENO` in 5 lingue
- `EXPLAYER` in 5 lingue

Ritorna `false` per altri talker, ad esempio `RAPPER`, `TELECRONISTA`, `MILANESE`, `ROMANO`.

## Talker frontend e audio disponibile

Il componente frontend espone piu AI-Talker di quelli effettivamente coperti dal TTS Azure.

### Lingua italiana

| ID | Nome | Voice preview | Audio evento |
|---|---|---|---|
| `IT` | Vox | `it` | si |
| `IT-ADOLESCENTE` | Nitro | `it-adolescente` | si |
| `IT-RAPPER` | Beat Breaker | vuota | no |
| `IT-ARCAICO` | Orfeo | `it-arcaico` | si |
| `IT-INFLUENCER` | Zoe | `it-influencer` | si |
| `IT-TELECRONISTA` | Maul | vuota | no |
| `IT-ALIENO` | Zorblax | `it-alieno` | si |
| `IT-CHEF` | Elixir | `it-chef` | si |
| `IT-EXPLAYER` | Bulldog | `it-explayer` | si |
| `IT-MILANESE` | El Mangiapolenta | vuota | no |
| `IT-ROMANO` | Trasteverino | vuota | no |

### Lingua inglese

| ID | Nome | Voice preview | Audio evento |
|---|---|---|---|
| `EN` | Vox | `en` | si |
| `EN-ADOLESCENTE` | Nitro | `en-adolescente` | si |
| `EN-ARCAICO` | Orfeo | `en-arcaico` | si |
| `EN-INFLUENCER` | Zoe | `en-influencer` | si |
| `EN-TELECRONISTA` | Maul | vuota | no |
| `EN-ALIENO` | Zorblax | `en-alieno` | si |
| `EN-CHEF` | Elixir | `en-chef` | si |
| `EN-EXPLAYER` | Bulldog | `en-explayer` | si |

Il rapper inglese e presente nel codice come blocco commentato, quindi non e attivo.

### Lingua francese

| ID | Nome | Voice preview | Audio evento |
|---|---|---|---|
| `FR` | Vox | `fr` | si |
| `FR-ADOLESCENTE` | Nitro | `fr-adolescente` | si |
| `FR-ARCAICO` | Orfeo | `fr-arcaico` | si |
| `FR-INFLUENCER` | Zoe | `fr-influencer` | si |
| `FR-TELECRONISTA` | Maul | vuota | no |
| `FR-ALIENO` | Zorblax | `fr-alieno` | si |
| `FR-CHEF` | Elixir | `fr-chef` | si |
| `FR-EXPLAYER` | Bulldog | `fr-explayer` | si |

Il rapper francese e presente nel codice come blocco commentato, quindi non e attivo.

### Lingua spagnola

| ID | Nome | Voice preview | Audio evento |
|---|---|---|---|
| `ES` | Vox | `es` | si |
| `ES-ADOLESCENTE` | Nitro | `es-adolescente` | si |
| `ES-ARCAICO` | Orfeo | `es-arcaico` | si |
| `ES-INFLUENCER` | Zoe | `es-influencer` | si |
| `ES-TELECRONISTA` | Maul | vuota | no |
| `ES-ALIENO` | Zorblax | `es-alieno` | si |
| `ES-CHEF` | Elixir | `es-chef` | si |
| `ES-EXPLAYER` | Bulldog | `es-explayer` | si |

Il rapper spagnolo e presente nel codice come blocco commentato, quindi non e attivo.

### Lingua giapponese

| ID | Nome | Voice preview | Audio evento |
|---|---|---|---|
| `JA` | Vox | `ja` | si |
| `JA-ADOLESCENTE` | Nitro | `ja-adolescente` | si |
| `JA-ARCAICO` | Orfeo | `ja-arcaico` | si |
| `JA-INFLUENCER` | Zoe | `ja-influencer` | si |
| `JA-TELECRONISTA` | Maul | vuota | no |
| `JA-ALIENO` | Zorblax | `ja-alieno` | si |
| `JA-CHEF` | Elixir | `ja-chef` | si |
| `JA-EXPLAYER` | Bulldog | `ja-explayer` | si |

Il rapper giapponese e presente nel codice come blocco commentato, quindi non e attivo.

## Differenza tra AI-Talker, voce e audio

Nel progetto i termini sono collegati ma non equivalenti:

- AI-Talker: personaggio/stile/lingua usato per generare o selezionare il testo della telecronaca.
- Voice code: valore come `IT-ARCAICO`, `EN-CHEF`, `JA` che identifica lingua/stile lato backend e frontend.
- Azure voice: voce neurale Microsoft usata per sintetizzare l'audio.
- Audio preview: MP3 generato da una frase di presentazione hardcoded.
- Audio evento: MP3 generato dal testo dell'evento partita.

Alcuni AI-Talker esistono come stile testuale ma non hanno TTS disponibile nel frontend/backend.

## Test

File: `src/RugbyRadio/Tests/Controllers/VoicesV1ControllerTests.cs`

Coperture rilevate:

- `GetAudio_WhenServiceReturnsNull_ReturnsNotFound`: verifica che `GetAudio` risponda `NotFoundResult` quando `IVoiceService.GetAudioAsync` ritorna `null`.
- `GetEventAudio_WhenServiceReturnsPath_ReturnsOkWithFileName`: verifica che `GetEventAudio` ritorni `OkObjectResult` con path relativo normalizzato, ad esempio `events/file.mp3`.

Non risultano test diretti sulla generazione Azure Speech, sul mapping completo delle voci o sulla riproduzione frontend.

## Failure point e gap

- Il TTS puo fallire se sintesi o file non sono disponibili.
- Nessun retry/fallback documentato o visibile nel servizio TTS.
- La subscription key Azure Speech e hardcoded nel codice sorgente.
- Regione Azure Speech hardcoded: `swedencentral`.
- Path storage hardcoded: `D:\Web\RugbyRadioStorage\audio\`.
- Endpoint VOC-02 nel wiki non allineato al codice: wiki indica `GET /v1/voices/{eventId}`, codice indica `GET /v1/voices/events?language=...&eventId=...`.
- `GetAudioAsync` usa il parametro `sentence` come nome file/cache key, ma il testo sintetizzato e scelto da switch hardcoded per lingua/stile.
- Le stringhe query `language` e `sentence` sono interpolate direttamente dal frontend senza encoding esplicito.
- La pulizia HTML del testo TTS avviene con regex semplice `<.*?>`.
- Il metodo backend `GetStreamAsync` esiste ma non risulta usato dagli endpoint: gli endpoint restituiscono path testuale, non stream MP3.
- Alcuni talker hanno testi/stili e profili UI ma non TTS: Rapper, Telecronista, Milanese, Romano.
- Il pulsante audio evento usa aria-label hardcoded in inglese (`Play audio commentary`) invece di una chiave i18n.

## Sintesi operativa

Il TTS di RRL e un layer opzionale di sintesi vocale su una telecronaca principalmente testuale. Il backend genera MP3 con Azure Speech e li cachea su filesystem/CDN; il frontend riceve solo il path relativo e riproduce il file via browser. La scelta dell'AI-Talker influenza sia il testo della telecronaca, tramite messaggi generati offline, sia la possibilita di ascoltare l'audio, ma solo per il sottoinsieme di talker mappato in `GetVoice` e `UserService.isCommentatorAudioAvailable`.
