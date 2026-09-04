# Task di dettaglio - Implementazione Modalita Radio Evento

## Fonte

- Analisi funzionale: `projects/radio-evento/analysis/analisi-funzionale-radio-evento.md`
- Analisi architetturale: `projects/radio-evento/architecture/analisi-architetturale-radio-evento.md`

## Obiettivo operativo

Implementare la Modalita Radio Evento in modo incrementale:

- MVP Auto Play nella pagina partita pubblica;
- coda audio frontend in ordine cronologico;
- default "solo nuovi eventi" con opzione "ascolta dall'inizio";
- un solo audio alla volta;
- riuso del TTS esistente tramite `VoiceService`;
- persistenza locale di preferenze, ultimi 5 item di coda e ultimo evento ascoltato;
- nessuna nuova API, tabella, stream server-side o AI realtime;
- Pagina Radio pubblica `/g-radio/:matchId` come seconda slice.

## Milestone

| Milestone | Risultato |
|---|---|
| M1 - Radio engine | Servizi frontend per stato, coda, storage locale e riproduzione audio condivisa |
| M2 - Auto Play su partita | Controlli radio integrati in `GMatchEventsComponent` e polling collegato alla coda |
| M3 - Refactor audio manuale | Click audio evento riusa il player service, senza doppio player concorrente |
| M4 - Analytics e resilienza | Eventi analytics, errori recuperabili, localStorage robusto |
| M5 - Pagina Radio pubblica | Route `/g-radio/:matchId` con vista dedicata e condivisibile |
| M6 - Verifica release | Build, test manuali desktop/mobile, regressione feed e audio TTS |

## Scope MVP

In scope:

- frontend Angular in `src/RugbyRadioWeb`;
- nuovi servizi radio frontend;
- modifiche a componenti pubblici match;
- persistenza su `localStorage`;
- analytics Firebase esistente;
- test/build frontend.

Out of scope:

- modifiche backend/API/database;
- rate limiting o hardening backend dedicato;
- jingle;
- multi speaker;
- notifiche push radio;
- Media Session API / lock screen avanzato;
- Radio Canale.

## Task

### RAD-T01 - Definire modelli TypeScript Radio Evento

**Tipo:** frontend / modello  
**Milestone:** M1  
**Dipendenze:** nessuna  
**File previsti:**

- `src/RugbyRadioWeb/src/app/dto` oppure nuova cartella coerente con pattern locale per modelli radio

Creare i modelli minimi:

- `MatchRadioContext`
- `RadioCommentatorSelection`
- `RadioQueueItem`
- `MatchRadioState`

Vincoli:

- `RadioQueueItem.queueKey = eventId + talkerId + language`;
- `source`: `past`, `live`, `manual`;
- `status`: `pending`, `loading`, `ready`, `playing`, `played`, `skipped`, `failed`;
- includere `persistedAt` e `lastPersistedQueueItemAt` per cleanup locale.

**Acceptance criteria**

- I modelli compilano senza introdurre dipendenze backend.
- I campi coprono coda, stato player, preferenze, ultimo evento ascoltato ed errori.
- I nomi sono coerenti con lo stile TypeScript esistente del progetto.

**Validazione**

- `npm run build` da `src/RugbyRadioWeb`.

### RAD-T02 - Implementare `MatchRadioStorageService`

**Tipo:** frontend / servizio  
**Milestone:** M1  
**Dipendenze:** RAD-T01  
**File previsti:**

- `src/RugbyRadioWeb/src/app/services/match-radio-storage.service.ts`

Implementare un wrapper di `localStorage` con namespace:

```text
rrl_radio_v1:{matchId}:preferences
rrl_radio_v1:{matchId}:queue
rrl_radio_v1:{matchId}:last_event
rrl_radio_v1:{matchId}:state
```

Regole:

- persistere solo dati locali non sensibili;
- salvare massimo gli ultimi 5 item di coda per match;
- memorizzare la data dell'ultimo item persistito;
- ripulire stato radio dopo 10 giorni dall'ultimo item persistito;
- gestire localStorage non disponibile, JSON corrotto e quota superata senza rompere la pagina.

**Acceptance criteria**

- Lettura e scrittura non lanciano eccezioni verso i componenti.
- La coda salvata non supera 5 item.
- Stati con ultimo item piu vecchio di 10 giorni vengono ignorati o cancellati.
- Stop non svuota lo storage; lo stato resta disponibile fino a nuovo Play o cleanup.

**Validazione**

- Unit test del servizio se il progetto ha test frontend attivi.
- In alternativa build + test manuale localStorage nel browser.

### RAD-T03 - Implementare `MatchRadioPlayerService`

**Tipo:** frontend / servizio  
**Milestone:** M1  
**Dipendenze:** RAD-T01, RAD-T02  
**File previsti:**

- `src/RugbyRadioWeb/src/app/services/match-radio-player.service.ts`

Responsabilita:

- stato player osservabile;
- `configure(context)`;
- `syncMatch(match)`;
- `play({ includePastEvents })`;
- `pause()`;
- `resume()`;
- `stop()`;
- `changeCommentator(selection)`;
- `enqueueEvent(event, source)`;
- `playSingleEvent(event)`;
- uso di `VoiceService.getVoiceEvent(language, eventId)`;
- costruzione URL finale con `environment.audioUrl`;
- gestione di un solo `HTMLAudioElement`;
- skip non bloccante su errore audio;
- analytics base.

Regole:

- default solo eventi nuovi;
- se `includePastEvents = true`, accodare gli eventi gia presenti in ordine cronologico;
- la coda segue l'ordine percepito dallo spettatore;
- cambio AI-Talker/lingua solo per eventi futuri;
- eventi accodati poi eliminati/corretti non ricostruiscono la coda;
- Stop conserva ultimo stato fino a nuovo Play;
- nessun mapping lingua/talker parallelo: usare codifica esistente.

**Acceptance criteria**

- Play avviato da gesture utente porta a `waitingForEvents` se non ci sono item.
- Nuovi eventi da `syncMatch` vengono accodati una sola volta.
- Due audio non possono sovrapporsi.
- Un errore TTS marca l'item `failed` e passa al successivo.
- `pause/resume/stop` aggiornano stato e storage.
- `playSingleEvent` usa la stessa pipeline audio della radio.

**Validazione**

- Test unitari consigliati per deduplica, includePastEvents, stop, cleanup e cambio talker.
- `npm run build`.

### RAD-T04 - Collegare selezione AI-Talker al player

**Tipo:** frontend / integrazione componenti  
**Milestone:** M2  
**Dipendenze:** RAD-T03  
**File previsti:**

- `src/RugbyRadioWeb/src/app/common/match-commentator/match-commentator.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.ts`

Aggiornare il flusso di selezione:

- `MatchCommentatorComponent` continua a essere owner della UI talker/lingua;
- `GMatchEventsComponent` legge la selezione corrente;
- al cambio selezione chiama `MatchRadioPlayerService.changeCommentator`;
- la nuova selezione vale solo per eventi futuri.

**Acceptance criteria**

- La preview audio del talker continua a funzionare.
- Cambiare talker durante la radio non interrompe l'audio corrente.
- Gli item gia in coda mantengono talker/lingua con cui sono stati accodati.
- I nuovi eventi usano la nuova selezione.

**Validazione**

- Test manuale con cambio talker durante riproduzione.
- `npm run build`.

### RAD-T05 - Aggiungere controlli Auto Play in `GMatchEventsComponent`

**Tipo:** frontend / UI  
**Milestone:** M2  
**Dipendenze:** RAD-T03, RAD-T04  
**File previsti:**

- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.html`
- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.css`
- eventuali chiavi i18n in `src/RugbyRadioWeb/src/assets/i18n/*.json`

UI minima:

- Play/Pause/Resume/Stop;
- opzione "ascolta dall'inizio" default off;
- stato sintetico: in attesa eventi, in riproduzione, pausa, errore recuperabile;
- indicazione coda/ultimo evento se utile;
- controlli visibili solo quando partita e iniziata o terminata secondo comportamento FAB attuale.

**Acceptance criteria**

- Play richiede click esplicito utente.
- Default: non riproduce eventi precedenti.
- Opzione "ascolta dall'inizio" accoda gli eventi presenti in ordine cronologico.
- UI mobile non sovrappone feed, FAB e drawer talker.
- Talker senza TTS non permette avvio radio o chiede selezione compatibile.

**Validazione**

- Test manuale desktop e mobile viewport.
- `npm run build`.

### RAD-T06 - Collegare polling partita a `syncMatch`

**Tipo:** frontend / integrazione dati  
**Milestone:** M2  
**Dipendenze:** RAD-T05  
**File previsti:**

- `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.ts`

Assicurare che ogni aggiornamento `matchDto` da polling arrivi al player service:

- `GMatchPage` continua a gestire polling;
- `GMatchEventsComponent` riceve `match` aggiornato;
- `syncMatch(match)` rileva nuovi eventi;
- la coda non viene ricostruita se eventi gia accodati spariscono o cambiano.

**Acceptance criteria**

- Nuovi eventi arrivati dopo Play vengono accodati.
- Eventi presenti prima del Play non vengono accodati con default off.
- Eventi gia accodati non vengono rimossi se lo snapshot successivo non li contiene.
- Nessun impatto su feed, commenti, reazioni e tab partita.

**Validazione**

- Test manuale simulando aggiornamento match/eventi.
- `npm run build`.

### RAD-T07 - Migrare audio manuale a `MatchRadioPlayerService`

**Tipo:** frontend / refactor controllato  
**Milestone:** M3  
**Dipendenze:** RAD-T03  
**File previsti:**

- `src/RugbyRadioWeb/src/app/common/match-events/match-events.component.ts`
- `src/RugbyRadioWeb/src/app/common/match-events/match-events.component.html`

Sostituire la creazione diretta di `new Audio(...)` dentro `playAudio(eventId)` con delega a `MatchRadioPlayerService.playSingleEvent`.

Preservare:

- pulsante audio evento esistente;
- disponibilita audio via `UserService.isCommentatorAudioAvailable()`;
- stato visuale evento in riproduzione;
- gestione errori non bloccante.

**Acceptance criteria**

- Il click manuale su un evento riproduce l'audio come prima.
- Se la radio e attiva, il click manuale non crea un secondo audio concorrente.
- Lo stato `isPlayingAudio` o equivalente resta coerente.
- Non cambiano commenti, emoji, ads e delete event.

**Validazione**

- Test manuale audio singolo evento.
- Test manuale audio singolo mentre radio attiva.
- `npm run build`.

### RAD-T08 - Integrare analytics radio

**Tipo:** frontend / analytics  
**Milestone:** M4  
**Dipendenze:** RAD-T03, RAD-T05  
**File previsti:**

- `src/RugbyRadioWeb/src/app/services/match-radio-player.service.ts`
- eventuali punti UI in `GMatchEventsComponent`

Tracciare:

- `radio_play`
- `radio_play_from_start_enabled`
- `radio_pause`
- `radio_resume`
- `radio_stop`
- `radio_event_play_start`
- `radio_event_play_complete`
- `radio_event_audio_error`
- `radio_queue_lag`

Parametri minimi:

- `match_id`
- `channel_id`
- `event_id`
- `event_type`
- `talker`
- `language`
- `source_view`
- `queue_length`
- `duration_seconds`
- `error_reason`

**Acceptance criteria**

- Le chiamate usano `AnalyticsService.track`.
- L'assenza di Firebase Analytics non rompe la radio.
- Errori audio vengono tracciati senza bloccare la coda.

**Validazione**

- Test manuale in ambiente con analytics opzionale/non configurato.
- `npm run build`.

### RAD-T09 - Gestire stati di errore e degradazione

**Tipo:** frontend / resilienza  
**Milestone:** M4  
**Dipendenze:** RAD-T03, RAD-T05  
**File previsti:**

- `src/RugbyRadioWeb/src/app/services/match-radio-player.service.ts`
- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.*`

Coprire:

- `Audio.play()` rifiutato dal browser;
- path audio vuoto o nullo;
- errore HTTP `VoiceService`;
- localStorage non disponibile;
- talker senza TTS;
- coda vuota;
- partita terminata con coda residua.

**Acceptance criteria**

- Ogni errore audio produce stato recuperabile.
- La pagina partita resta consultabile.
- La radio passa al prossimo item quando possibile.
- A partita terminata, la coda residua viene completata e poi lo stato diventa `ended`.

**Validazione**

- Test manuale disabilitando storage o simulando errore audio.
- `npm run build`.

### RAD-T10 - Aggiungere feature flag frontend opzionale

**Tipo:** frontend / configurazione  
**Milestone:** M4  
**Dipendenze:** RAD-T05  
**File previsti:**

- `src/RugbyRadioWeb/src/app/environments/environment.ts`
- `src/RugbyRadioWeb/src/app/environments/environment.prod.ts`
- componenti radio interessati

Introdurre `enableRadioEvent` se si vuole rilasciare in modo controllato.

**Acceptance criteria**

- Con flag off la UI radio non appare.
- Con flag on la radio funziona.
- Default deciso esplicitamente per dev/prod.

**Validazione**

- Build con entrambe le configurazioni.

### RAD-T11 - Creare `GMatchRadioComponent`

**Tipo:** frontend / pagina pubblica  
**Milestone:** M5  
**Dipendenze:** RAD-T03, RAD-T05  
**File previsti:**

- `src/RugbyRadioWeb/src/app/global/g-match-radio/g-match-radio.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-match-radio/g-match-radio.component.html`
- `src/RugbyRadioWeb/src/app/global/g-match-radio/g-match-radio.component.css`

Creare vista dedicata alla radio:

- carica `matchDto` con `MatchService`;
- riusa `MatchRadioPlayerService`;
- mostra squadre, punteggio, minuto, stato partita, AI-Talker, Play/Pause;
- include opzione "ascolta dall'inizio";
- link di ritorno a `/g-match/:matchId`;
- layout mobile-first, essenziale.

**Acceptance criteria**

- La pagina e pubblica e non richiede login.
- La radio funziona anche arrivando direttamente su URL condiviso.
- Il player e lo stato sono condivisi con la logica dell'MVP.
- La pagina non duplica logica TTS.

**Validazione**

- Test manuale route diretta.
- `npm run build`.

### RAD-T12 - Aggiungere route pubblica `/g-radio/:matchId`

**Tipo:** frontend / routing  
**Milestone:** M5  
**Dipendenze:** RAD-T11  
**File previsti:**

- `src/RugbyRadioWeb/src/app/app.routes.ts`

Aggiungere:

```typescript
{ path: 'g-radio/:matchId', component: GMatchRadioComponent }
```

La route deve precedere il wildcard finale.

**Acceptance criteria**

- `/g-radio/:matchId` apre `GMatchRadioComponent`.
- `/g-match/:matchId` continua a funzionare.
- Il wildcard non intercetta la nuova route.

**Validazione**

- Test manuale URL.
- `npm run build`.

### RAD-T13 - Collegare pagina partita e Pagina Radio

**Tipo:** frontend / navigazione  
**Milestone:** M5  
**Dipendenze:** RAD-T11, RAD-T12  
**File previsti:**

- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.html`
- `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.html`
- eventuali componenti share/link esistenti

Aggiungere accesso alla pagina radio:

- link/button da partita pubblica verso `/g-radio/:matchId`;
- ritorno da pagina radio verso `/g-match/:matchId`;
- eventuale link condivisibile nella UI radio.

**Acceptance criteria**

- Lo spettatore puo aprire la Pagina Radio dalla partita.
- Lo spettatore puo tornare alla partita completa.
- Il link e copiabile/condivisibile.

**Validazione**

- Test manuale navigazione avanti/indietro.
- `npm run build`.

### RAD-T14 - Verificare i18n e testi UI

**Tipo:** frontend / contenuto  
**Milestone:** M6  
**Dipendenze:** RAD-T05, RAD-T11  
**File previsti:**

- `src/RugbyRadioWeb/src/assets/i18n/it.json`
- `src/RugbyRadioWeb/src/assets/i18n/en.json`
- `src/RugbyRadioWeb/src/assets/i18n/fr.json`
- `src/RugbyRadioWeb/src/assets/i18n/es.json`
- `src/RugbyRadioWeb/src/assets/i18n/ja.json`

Aggiungere chiavi per:

- Play Radio;
- Pausa/Riprendi/Stop;
- Ascolta dall'inizio;
- In attesa di nuovi eventi;
- Audio non disponibile;
- Talker non compatibile;
- Apri pagina radio;
- Torna alla partita.

**Acceptance criteria**

- Nessuna chiave i18n mancante nelle lingue supportate.
- I testi sono brevi e adatti a mobile.
- Non compaiono testi tecnici come "queue" o "debug".

**Validazione**

- Test manuale cambio lingua se disponibile.
- `npm run build`.

### RAD-T15 - QA manuale MVP Auto Play

**Tipo:** QA  
**Milestone:** M6  
**Dipendenze:** RAD-T01..RAD-T10  
**File previsti:** nessuno, eventuale checklist di esecuzione

Scenari:

1. Apri partita pubblica, seleziona talker con TTS, premi Play con default off.
2. Verifica che eventi gia presenti non vengano riprodotti.
3. Aggiungi/simula nuovo evento, verifica accodamento e riproduzione.
4. Attiva "ascolta dall'inizio", verifica ordine cronologico.
5. Metti in pausa, riprendi, stoppa, ricarica pagina.
6. Verifica persistenza ultimi 5 item e ultimo evento ascoltato.
7. Cambia talker durante riproduzione, verifica applicazione solo ai futuri eventi.
8. Simula errore TTS, verifica skip e stato recuperabile.
9. Verifica click manuale audio evento.
10. Verifica mobile viewport.

**Acceptance criteria**

- Tutti gli scenari MVP passano.
- Nessuna regressione evidente sul feed eventi.
- Nessuna sovrapposizione audio.

**Validazione**

- Annotare browser e device usati.

### RAD-T16 - QA manuale Pagina Radio

**Tipo:** QA  
**Milestone:** M6  
**Dipendenze:** RAD-T11..RAD-T14  
**File previsti:** nessuno, eventuale checklist di esecuzione

Scenari:

1. Apri `/g-radio/:matchId` direttamente.
2. Avvia radio da pagina dedicata.
3. Verifica ritorno a `/g-match/:matchId`.
4. Verifica link condivisibile.
5. Verifica mobile viewport.
6. Verifica partita terminata con coda residua.

**Acceptance criteria**

- Route pubblica funzionante.
- UI essenziale e leggibile.
- Nessuna duplicazione di audio player.

**Validazione**

- `npm run build`.
- Test manuale desktop/mobile.

### RAD-T17 - Aggiornare wiki tecnica dopo implementazione

**Tipo:** documentazione  
**Milestone:** M6  
**Dipendenze:** implementazione completata  
**File previsti:**

- pagine wiki correlate sotto `llm-wiki/wiki/frontend`
- eventuale aggiornamento di `llm-wiki/wiki/workflows/Riproduzione Audio Telecronaca (workflow).md`
- eventuale aggiornamento di `llm-wiki/wiki/concepts/TTS Audio (concept).md`

Aggiornare la wiki per riflettere:

- nuovo player radio;
- nuovi servizi frontend;
- route `/g-radio/:matchId`;
- persistenza locale;
- invarianti backend.

**Acceptance criteria**

- La wiki non descrive piu solo audio on demand se Auto Play e rilasciato.
- Le pagine frontend elencano i nuovi consumer/servizi.
- Le decisioni "nessun backend" e "localStorage ultimi 5 item/10 giorni" sono documentate.

**Validazione**

- Review manuale dei link wiki aggiornati.

## Sequenza consigliata

1. RAD-T01
2. RAD-T02
3. RAD-T03
4. RAD-T04
5. RAD-T05
6. RAD-T06
7. RAD-T07
8. RAD-T08
9. RAD-T09
10. RAD-T10 opzionale
11. RAD-T15
12. RAD-T11
13. RAD-T12
14. RAD-T13
15. RAD-T14
16. RAD-T16
17. RAD-T17

## Validazione minima release

Da `src/RugbyRadioWeb`:

```bash
npm run build
```

Test manuali obbligatori:

- partita pubblica con default solo nuovi eventi;
- partita pubblica con "ascolta dall'inizio";
- pausa/riprendi/stop;
- refresh con localStorage;
- cambio talker durante radio;
- errore audio recuperabile;
- click manuale audio evento;
- route `/g-radio/:matchId`;
- mobile viewport moderno.

## Note di implementazione

- Evitare modifiche backend nella prima release.
- Evitare mapping paralleli per lingua/talker.
- Non salvare audio binario o dati sensibili in localStorage.
- Non introdurre stream server-side.
- Non svuotare lo storage su Stop: conservare ultimo stato fino a nuovo Play.
- Limitare sempre la coda persistita agli ultimi 5 item per match.
- Pulire stati radio locali dopo 10 giorni dall'ultimo item persistito.
