# Giugno 2026 - Chiusura progetto Radio Live

## Scopo del documento

Questo documento chiude il progetto di introduzione della feature **Radio Live** in Rugby Radio Live e raccoglie le informazioni utili per un successivo ingest nella wiki.

La feature trasforma l'audio TTS gia disponibile sui singoli eventi partita in una modalita di ascolto continuo della telecronaca. Lo spettatore puo aprire una partita pubblica, passare alla vista di ascolto, premere Play e ascoltare gli eventi nuovi in sequenza senza dover cliccare ogni singolo evento.

Il progetto e stato realizzato con un approccio frontend-first:

- nessuna nuova API backend;
- nessuna nuova tabella o migrazione database;
- nessuno streaming audio server-side;
- nessuna generazione AI realtime;
- riuso di eventi partita, AI-Talker, TTS e file MP3 gia previsti dall'architettura esistente.

## Contesto funzionale

Prima di Radio Live l'audio partita era puntuale: lo spettatore poteva ascoltare un evento solo tramite il pulsante audio del singolo item nel feed testuale.

Con Radio Live e stata introdotta una modalita di fruizione diversa:

- lo spettatore sceglie la modalita `Ascolta`;
- vede una card dedicata alla radio live;
- preme Play;
- il player accoda gli eventi riproducibili;
- il sistema richiede il file MP3 tramite il servizio voce esistente;
- l'audio viene riprodotto in sequenza, un evento alla volta;
- nuovi eventi arrivati durante l'ascolto vengono aggiunti alla coda.

La modalita testuale resta disponibile nel tab `Leggi` e continua a essere la fonte primaria della telecronaca.

## Scope realizzato

### Incluso

- Tab locale nella sezione eventi pubblica con due modalita:
  - `Leggi`: feed eventi testuale tradizionale.
  - `Ascolta`: card Radio Live.
- Card Radio Live integrata nella pagina pubblica partita `g-match`.
- Controlli Play, Pausa/Riprendi e Stop.
- Opzione `Ascolta dall'inizio`.
- Coda audio frontend per gli eventi.
- Deduplica per evento, AI-Talker e lingua.
- Riproduzione sequenziale con un solo `HTMLAudioElement` attivo.
- Integrazione con `VoiceService.getVoiceEvent(language, eventId)`.
- Costruzione URL audio tramite `environment.audioUrl`.
- Stato radio osservabile tramite servizio.
- Persistenza locale parziale dello stato radio.
- Sanitizzazione dello stato al reload per evitare ripartenze automatiche non consentite.
- Protezione da race condition tra Stop e risposta TTS tardiva.
- Se la radio e gia attiva, il componente si posiziona automaticamente sul tab `Ascolta`.
- Cambiare tab non spegne piu la radio: lo Stop esplicito e l'unico comando di spegnimento.
- Nel tab `Ascolta` vengono nascosti:
  - feed eventi testuale;
  - accordion `Opzioni partita`.
- Nel tab `Ascolta` resta disponibile la card radio con controlli e stato evento corrente.
- Effetto visivo `on air` sulla card interna quando la radio e attiva.
- Layout mobile dedicato per controlli e opzione `Ascolta dall'inizio`.
- Route pubblica dedicata `/g-radio/:matchId` per la pagina radio evento.
- Test unitari sui servizi radio e sul comportamento del componente `GMatchEventsComponent`.
- Icone aggiunte al sistema iconografico per Play, Pausa e Stop.

### Escluso

- Streaming audio live server-side.
- Microfono o registrazione voce del cronista.
- AI realtime.
- Jingle radio.
- Multi speaker.
- Media Session API / lock screen.
- Notifiche push dedicate alla radio.
- Persistenza server-side della sessione radio.
- Sincronizzazione cross-device.
- Hardening backend specifico per endpoint TTS.

## UX finale in `g-match`

La tab eventi pubblica contiene un selettore interno:

- `Leggi`
- `Ascolta`

### Tab Leggi

Mostra il comportamento tradizionale:

- opzioni partita;
- feed eventi testuale;
- pulsanti e interazioni gia esistenti;
- floating button AI-Talker quando applicabile.

La radio non viene spenta quando l'utente passa a `Leggi`. Questa scelta consente allo spettatore di continuare ad ascoltare mentre consulta il feed testuale.

### Tab Ascolta

Mostra solo l'esperienza radio:

- card Radio Live;
- blocco interno con icona e descrizione evento/stato;
- Play/Pausa/Riprendi;
- Stop;
- opzione `Ascolta dall'inizio`;
- reazioni rapide sull'evento corrente quando applicabile.

Nel tab `Ascolta` non vengono renderizzati:

- feed eventi testuale;
- accordion `Opzioni partita`;
- link `Apri pagina radio`;
- badge testuale di stato tipo `in attesa di nuovi eventi`;
- pulsante AI-Talker dentro la card radio.

### Aspetto della card

La card Radio Live e stata adeguata al layout visuale fornito come riferimento:

- contenitore bianco;
- bordo verde tenue;
- nessuna ombra sulla card principale;
- icona radio teal nel blocco superiore;
- blocco interno con sfondo pieno verde chiaro;
- icona outline a sinistra nel blocco interno;
- testo evento/stato a destra;
- effetto pulse lento sul bordo del blocco interno quando la radio e attiva.

L'effetto pulse viene applicato solo negli stati attivi:

- `playing`;
- `loadingAudio`;
- `waitingForEvents`.

Lo stato `paused` mantiene il contesto radio ma non usa il pulse attivo.

### Mobile

Su mobile il pannello dei controlli della card segue questa disposizione:

- pulsanti Play/Pausa/Stop allineati a destra;
- opzione `Ascolta dall'inizio` sotto i pulsanti;
- opzione allineata a sinistra;
- la card mantiene proporzioni compatte e leggibili.

## Componenti e file principali

### `GMatchEventsComponent`

Path:

```text
src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.ts
src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.html
src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.css
```

Responsabilita:

- ospita il selettore `Leggi` / `Ascolta`;
- mostra la card Radio Live;
- passa contesto partita al player;
- sincronizza AI-Talker/lingua con il player;
- invoca Play/Pausa/Riprendi/Stop;
- nasconde feed e opzioni quando e attivo `Ascolta`;
- si porta automaticamente sul tab `Ascolta` quando lo stato radio e gia attivo;
- non avvia piu la radio al semplice click sul tab `Ascolta`;
- non spegne piu la radio al click sul tab `Leggi`.

Decisioni UX chiuse:

- Il tab `Ascolta` mostra la card ma non avvia l'audio.
- L'audio parte solo con gesto esplicito sul pulsante Play.
- Lo Stop esplicito e l'unico comando di spegnimento.
- Cambiare tab e una scelta di visualizzazione, non un comando audio.

### `MatchRadioPlayerService`

Path:

```text
src/RugbyRadioWeb/src/app/services/match-radio-player.service.ts
```

Responsabilita:

- mantiene lo stato radio;
- gestisce coda e deduplica;
- riceve snapshot match aggiornati;
- accoda eventi live o passati;
- richiede audio TTS;
- crea e controlla un solo `HTMLAudioElement`;
- emette stato osservabile;
- traccia eventi analytics;
- salva stato locale tramite storage service;
- ignora risposte audio tardive dopo Stop;
- normalizza lo stato al reload.

Metodi pubblici principali:

```typescript
configure(context: MatchRadioContext): void;
syncMatch(match: matchDto): void;
play(options?: { includePastEvents?: boolean }): void;
pause(): void;
resume(): void;
stop(): void;
changeCommentator(selection: RadioCommentatorSelection): void;
enqueueEvent(event: matchEventDto, source: MatchRadioSource): void;
playSingleEvent(event: matchEventDto): void;
getSnapshot(): MatchRadioState;
```

### `MatchRadioStorageService`

Path:

```text
src/RugbyRadioWeb/src/app/services/match-radio-storage.service.ts
```

Responsabilita:

- incapsula `localStorage`;
- salva stato, coda, preferenze e ultimo evento ascoltato;
- limita la coda persistita agli ultimi 5 item;
- pulisce stati obsoleti dopo 10 giorni dall'ultimo item persistito;
- degrada senza errori se `localStorage` non e disponibile.

Chiavi locali:

```text
rrl_radio_v1:{matchId}:state
rrl_radio_v1:{matchId}:queue
rrl_radio_v1:{matchId}:preferences
rrl_radio_v1:{matchId}:last_event
```

### DTO radio

Path:

```text
src/RugbyRadioWeb/src/app/dto/matchRadioDto.ts
```

Contiene:

- `MatchRadioSource`
- `MatchRadioQueueStatus`
- `MatchRadioStatus`
- `MatchRadioContext`
- `RadioCommentatorSelection`
- `RadioQueueItem`
- `MatchRadioState`

### Pagina radio pubblica

Path:

```text
src/RugbyRadioWeb/src/app/global/g-match-radio/
src/RugbyRadioWeb/src/app/app.routes.ts
```

Route:

```text
/g-radio/:matchId
```

La pagina dedicata carica il match, configura il player con source view `g_radio` e offre una vista essenziale da player radio. La card integrata in `g-match` resta comunque il punto principale della feature nel flusso partita.

### Sistema icone

Path:

```text
src/RugbyRadioWeb/src/app/common/icon/icon.map.ts
```

Icone aggiunte:

- `play`
- `pause`
- `square`

Queste icone permettono ai pulsanti radio di mostrare simboli coerenti con il componente `EntityButtonComponent`.

## Stati del player

Gli stati gestiti sono:

| Stato | Significato |
|---|---|
| `idle` | Radio spenta. |
| `loadingAudio` | Recupero o preparazione audio in corso. |
| `playing` | Audio in riproduzione. |
| `paused` | Audio sospeso dall'utente. |
| `waitingForEvents` | Radio accesa, nessun evento in coda. |
| `errorRecoverable` | Errore audio non bloccante. |
| `ended` | Partita terminata e coda esaurita. |

Nel comportamento finale:

- `idle` non deve mostrare radio come accesa;
- `playing`, `loadingAudio`, `paused`, `waitingForEvents` sono considerati stati radio attivi ai fini della selezione automatica del tab `Ascolta`;
- solo `playing`, `loadingAudio`, `waitingForEvents` attivano il pulse visivo `on air`;
- `paused` mantiene il tab radio ma senza effetto `on air`.

## Regole funzionali finali

### Avvio

- La radio parte solo premendo Play.
- Cliccare il tab `Ascolta` non avvia la radio.
- Il Play e necessario per rispettare le policy browser sull'audio.

### Cambio tab

- Cambiare da `Ascolta` a `Leggi` non spegne l'audio.
- Cambiare da `Leggi` ad `Ascolta` non avvia l'audio.
- Se la radio e gia attiva e il componente viene caricato, il tab viene impostato su `Ascolta`.

### Stop

- Lo Stop ferma l'audio corrente.
- Lo Stop azzera `currentItem`.
- Lo Stop svuota la coda runtime.
- Lo Stop salva stato `idle`.
- Risposte TTS arrivate dopo Stop vengono ignorate.

### Pausa e ripresa

- Pausa sospende l'audio corrente.
- Riprendi prova a riprendere l'audio corrente se esiste un `HTMLAudioElement`.
- Se non c'e audio corrente, la ripresa passa al prossimo item disponibile.

### Ascolta dall'inizio

- Default: disattivato.
- Se disattivato, al Play vengono marcati come gia visti gli eventi presenti in quel momento e si ascoltano solo i nuovi eventi successivi.
- Se attivato, al Play vengono accodati gli eventi gia presenti in ordine cronologico.

### AI-Talker

- La selezione AI-Talker continua a essere gestita dal componente `MatchCommentatorComponent`.
- Il player riceve `talkerId`, `language` e disponibilita audio tramite `changeCommentator`.
- Il cambio AI-Talker vale per gli eventi futuri.
- Gli item gia in coda mantengono talker e lingua con cui sono stati accodati.

### Eventi e coda

- La chiave di deduplica e:

```text
eventId:talkerId:language
```

- La coda segue ordine cronologico per minuto evento.
- La radio riproduce un solo audio alla volta.
- Gli eventi arrivati mentre un audio e in riproduzione vengono aggiunti in fondo alla coda.
- Se un audio fallisce, la radio marca errore recuperabile e prova a proseguire.

## Bug corretti durante la chiusura

### Reload con radio apparentemente accesa

Problema:

- Lo stato persistito poteva contenere `playing`, `loadingAudio` o `waitingForEvents`.
- Al reload il componente poteva ripristinare uno stato visivamente attivo senza una nuova gesture utente.

Correzione:

- `configure()` normalizza lo stato ripristinato con `toReloadSafeState`.
- Gli stati runtime attivi non vengono ripristinati come riproduzione automatica.

### Stop seguito da risposta TTS tardiva

Problema:

- Se l'utente premeva Stop mentre `VoiceService.getVoiceEvent` era ancora in corso, la risposta successiva poteva chiamare `playAudioPath`, creare un audio e salvare di nuovo `playing`.

Correzione:

- Aggiunte guardie su callback asincrone:
  - `startItem`;
  - `playAudioPath`;
  - `completeCurrentItem`;
  - `failCurrentItem`;
  - `playNext`.
- La funzione `canHandleItem` verifica che la radio sia ancora attiva e che l'item corrente coincida.

### Tab Ascolta che avviava automaticamente la radio

Problema:

- `selectExperience('radio')` chiamava `playRadio()`.
- Entrare nel tab `Ascolta` riaccendeva la radio anche dopo Stop.

Correzione:

- Il tab `Ascolta` cambia solo la vista.
- Play resta un comando esplicito.

### Tab Leggi che spegneva la radio

Problema:

- `selectExperience('text')` chiamava `stopRadio()`.
- Dopo Play, cambiare tab spegneva la radio.

Correzione:

- Cambiare tab non spegne piu il player.
- Stop esplicito resta l'unico comando di spegnimento.

### Feed testuale visibile in Ascolta

Problema:

- Nel tab `Ascolta` il feed testuale restava sotto la card radio.

Correzione:

- `app-match-events` viene renderizzato solo nel tab `Leggi`.

### Opzioni partita visibili in Ascolta

Problema:

- L'accordion `Opzioni partita` restava visibile nel tab radio.

Correzione:

- L'accordion e renderizzato solo nel tab `Leggi`.

## Test aggiunti o aggiornati

### `MatchRadioPlayerService`

Path:

```text
src/RugbyRadioWeb/src/app/services/match-radio-player.service.spec.ts
```

Casi coperti:

- default: accodare solo eventi successivi al Play;
- `includePastEvents`: accodare eventi gia presenti in ordine cronologico;
- deduplica evento/talker/lingua;
- cambio AI-Talker applicato solo agli eventi futuri;
- Stop salva stato `idle` senza `currentItem`;
- reload non ripristina stato attivo;
- risposta audio tardiva dopo Stop viene ignorata;
- pausa/ripresa dell'item corrente.

### `GMatchEventsComponent`

Path:

```text
src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.spec.ts
```

Casi coperti:

- selezionare il tab `Ascolta` non avvia automaticamente la radio;
- se lo stato radio e gia attivo, il tab si porta su `Ascolta`;
- selezionare il tab `Leggi` non spegne la radio.

## Validazioni eseguite

Comandi usati durante la chiusura:

```text
npx ng test --watch=false --browsers=ChromeHeadlessNoSandbox --include='src/app/global/g-match/g-match-events/g-match-events.component.spec.ts'
npx ng test --watch=false --browsers=ChromeHeadlessNoSandbox --include='src/app/services/match-radio-player.service.spec.ts'
npm run -s build
```

Esito:

- test `GMatchEventsComponent`: passati;
- test `MatchRadioPlayerService`: passati;
- build Angular: completata con successo;
- restano warning di budget CSS/bundle gia presenti o coerenti con lo stato attuale del progetto.

Nota tecnica:

- Il launcher `ChromeHeadlessNoSandbox` e stato usato per stabilizzare l'esecuzione test su Windows, dove `ChromeHeadless` puro ha mostrato errori GPU/cache prima dell'esecuzione delle spec.

## Analytics

Il player traccia eventi tramite `AnalyticsService.track`.

Eventi previsti:

- `radio_play`
- `radio_play_from_start_enabled`
- `radio_pause`
- `radio_resume`
- `radio_stop`
- `radio_event_play_start`
- `radio_event_play_complete`
- `radio_event_audio_error`

Parametri principali:

- `match_id`
- `channel_id`
- `event_id`
- `event_type`
- `talker`
- `language`
- `source_view`
- `queue_length`
- `error_reason`

Source view:

- `g_match_events` per card integrata nella pagina partita;
- `g_radio` per pagina pubblica dedicata.

## Decisioni architetturali finali

1. La feature e frontend-first.
2. Non sono state introdotte nuove API backend.
3. Non e stato introdotto streaming server-side.
4. La sessione radio e locale al dispositivo.
5. L'audio parte solo dopo gesto esplicito dell'utente.
6. Cambiare tab non e un comando audio.
7. Stop esplicito e l'unico comando per spegnere la radio.
8. Il reload non deve ripristinare riproduzione automatica.
9. Le risposte asincrone arrivate dopo Stop devono essere ignorate.
10. La vista `Ascolta` deve essere focalizzata sulla radio e non duplicare il feed testuale.
11. La pagina `/g-radio/:matchId` resta disponibile come vista pubblica dedicata.
12. L'MVP non include background audio garantito, lock screen o Media Session API.

## Debito residuo e follow-up consigliati

### UX e accessibilita

- Valutare se il floating button AI-Talker debba restare visibile anche nel tab `Ascolta` oppure essere sostituito da un controllo piu contestuale.
- Verificare contrasto e motion del pulse `on air` su device reali.
- Aggiungere preferenza `prefers-reduced-motion` per disabilitare il pulse se necessario.

### Browser e mobile

- Test manuale su browser mobile moderni.
- Test PWA/TWA Android.
- Verifica comportamento audio con schermo bloccato o tab in background.
- Valutazione Media Session API in una fase dedicata.

### Stato e persistenza

- Chiarire se dopo reload si vuole mostrare l'ultimo evento ascoltato come informazione storica, pur senza riattivare l'audio.
- Valutare una UX di "riprendi ascolto" distinta da Play normale.
- Valutare se la coda persistita sia ancora necessaria o se sia sufficiente persistere preferenze e ultimo evento ascoltato.

### Pagina radio dedicata

- Allineare visualmente `GMatchRadioComponent` alla card Radio Live definitiva.
- Valutare se `/g-radio/:matchId` debba diventare la vista primaria per ascolto immersivo.
- Aggiungere link verso la pagina radio solo se utile al journey utente; nella card integrata il link e stato rimosso.

### Futuri ampliamenti

- Jingle statici globali RRL.
- Multi speaker.
- Radio canale.
- Deep link notifiche verso radio.
- Possibile Media Session API.

## Esito finale

La feature Radio Live e stata portata a uno stato MVP funzionante e integrato nella pagina pubblica partita.

Il risultato finale consente allo spettatore di:

1. aprire una partita pubblica;
2. entrare nel tab `Ascolta`;
3. premere Play;
4. ascoltare automaticamente gli eventi nuovi;
5. passare a `Leggi` senza interrompere l'audio;
6. tornare ad `Ascolta` mentre la radio continua;
7. fermare la radio solo con Stop.

La soluzione resta coerente con i vincoli iniziali:

- cronista invariato;
- backend invariato;
- nessuno streaming;
- nessuna AI realtime;
- riuso di TTS, eventi e AI-Talker esistenti;
- controllo utente esplicito per avvio audio.

La feature e pronta per ingest wiki come chiusura progetto e base documentale per future evoluzioni di Radio Live.
