---
title: "Radio Evento Closeout"
type: project-closeout
project: "radio-evento"
status: completed
created: "2026-07-29"
source: "projects/radio-evento"
---

# Radio Evento Closeout

## Executive Summary

Il progetto `radio-evento` ha trasformato un'idea di evoluzione prodotto in un pacchetto completo di analisi, architettura e piano operativo per introdurre una Modalita Radio Evento in Rugby Radio Live.

Il risultato non e una modifica applicativa gia implementata, ma una specifica pronta per una successiva fase tecnica: obiettivi funzionali, requisiti MVP, regole di business, architettura frontend-first, servizi da creare, route pubblica proposta, task di implementazione, rischi e validazione.

La direzione decisa e conservativa: riusare il TTS evento gia esistente, mantenere invariato il workflow del cronista, non introdurre backend aggiuntivo, database, stream server-side o AI realtime nella prima release.

## Original Goal

Analizzare, progettare e pianificare l'iniziativa Radio Evento.

L'idea iniziale era evolvere Rugby Radio Live da telecronaca testuale con audio TTS on demand a esperienza di ascolto continuo: lo spettatore apre una partita, seleziona un AI-Talker, preme Play e ascolta automaticamente gli eventi della partita come una radiocronaca.

Principi originari:

- nessun impatto operativo sul cronista;
- nessun microfono;
- nessuna registrazione audio;
- nessuna AI realtime;
- compatibilita con architettura web attuale;
- fruizione da browser desktop, mobile, PWA e TWA dove consentito dalle policy browser.

## Final Outcome

Il progetto ha prodotto:

- una nota iniziale di idea;
- un'analisi funzionale completa per MVP e roadmap evolutiva;
- un'analisi architetturale frontend-first;
- una task list di implementazione dettagliata da `RAD-T01` a `RAD-T17`;
- decisioni funzionali e tecniche chiuse sufficienti per avviare una fase implementativa.

Non risultano modifiche al codice sorgente associate a questa chiusura. La chiusura formalizza quindi il completamento della fase di analisi, progettazione e pianificazione.

## Scope Completed

- Definita la visione di Radio Evento come player audio continuo sopra eventi partita esistenti.
- Definito l'MVP "Auto Play Telecronaca" integrato nella pagina partita pubblica.
- Definita l'opzione "ascolta dall'inizio", con default disattivato.
- Definita la coda audio frontend, sequenziale e senza sovrapposizione.
- Definito il riuso di `VoiceService` e dell'endpoint TTS evento esistente.
- Definita la persistenza locale su dispositivo di preferenze, ultimi item di coda e ultimo evento ascoltato.
- Definito il comportamento del cambio AI-Talker o lingua: applicazione solo agli eventi futuri.
- Definito il comportamento su eventi gia accodati poi eliminati o corretti: nessuna ricostruzione retroattiva della coda.
- Definita la Pagina Radio pubblica come seconda slice, con route proposta `/g-radio/:matchId`.
- Definiti analytics minimi per misurare uso, errore audio e ritardo di coda.
- Definiti rischi, trade-off, alternative scartate e validazione minima release.
- Definita una task list implementativa incrementale.

## Scope Not Completed

- Implementazione Angular dei nuovi modelli e servizi radio.
- Integrazione dei controlli Auto Play in `GMatchEventsComponent`.
- Refactor del click audio manuale verso un player condiviso.
- Creazione della route e pagina pubblica `/g-radio/:matchId`.
- Test automatici o manuali su browser reali.
- Validazione audio in background, lock screen, PWA e TWA.
- Notifiche audio, jingle, multi speaker e Radio Canale.
- Aggiornamento della wiki canonica.

## Functional Summary

La Modalita Radio Evento e una modalita spettatore. Il cronista continua a creare la partita e premere eventi come oggi; la piattaforma trasforma gli eventi gia esistenti in audio TTS accodato lato frontend.

Flusso MVP:

1. lo spettatore apre una partita pubblica;
2. seleziona AI-Talker e lingua;
3. lascia il default "solo nuovi eventi" oppure abilita "ascolta dall'inizio";
4. preme Play Radio;
5. il sistema accoda gli eventi riproducibili secondo l'opzione scelta;
6. il sistema richiede o riusa gli MP3 TTS tramite il flusso audio esistente;
7. il player riproduce un audio alla volta;
8. i nuovi eventi arrivati durante la partita vengono accodati in ordine cronologico;
9. errori audio o MP3 non disponibili vengono gestiti come errori recuperabili;
10. a partita terminata, la radio completa la coda residua e poi passa allo stato finale.

Regole funzionali principali:

- Play esplicito obbligatorio per rispettare le policy autoplay browser.
- Default: non riprodurre eventi precedenti all'attivazione.
- Con "ascolta dall'inizio", accodare gli eventi gia presenti in ordine cronologico.
- Nessuna priorita o esclusione per tipo evento nel primo MVP: tutti gli eventi partita sono rilevanti.
- Nessuna soglia funzionale massima di ritardo audio rispetto al live.
- Talker senza TTS non selezionabile per la radio o trattato come non compatibile.
- Cambio AI-Talker o lingua non interrompe audio corrente e non ricostruisce la coda gia pronta.
- Preferenze, coda e ultimo evento ascoltato restano locali al dispositivo.

Roadmap funzionale proposta:

- Slice 1: Auto Play Telecronaca nella pagina partita.
- Slice 2: Pagina Radio pubblica condivisibile.
- Slice 3: compatibilita background e Media Session API progressiva.
- Slice 4: notifiche audio e deep link.
- Slice 5: jingle statici globali RRL.
- Slice 6: multi speaker.
- Slice 7: Radio Canale.

## Architectural Summary

La proposta architetturale e frontend-first.

Per MVP e Pagina Radio non sono richieste nuove API, nuove tabelle, nuove sessioni server-side, stream audio backend o AI realtime. La soluzione riusa:

- `matchDto.events` come fonte eventi;
- polling esistente della pagina partita;
- `VoiceService.getVoiceEvent(language, eventId)` lato frontend;
- `GET /v1/voices/events?language={language}&eventId={eventId}` lato backend;
- `environment.audioUrl` per costruire l'URL MP3 finale;
- `AnalyticsService.track` per eventi di utilizzo.

Nuovi servizi frontend consigliati:

- `MatchRadioPlayerService`: owner di stato runtime, coda, deduplica, riproduzione sequenziale, recupero audio, analytics e gestione errori.
- `MatchRadioStorageService`: wrapper robusto di `localStorage`, con namespace per match, coda limitata, cleanup e gestione errori storage.

Componenti coinvolti:

- `GMatchEventsComponent`: punto naturale per orchestrare selezione AI-Talker, feed eventi e controlli radio nella Slice 1.
- `MatchEventsComponent`: deve continuare a mostrare il feed e delegare il click audio manuale al player condiviso.
- `MatchCommentatorComponent`: resta owner della UI di selezione talker/lingua, ma non gestisce la coda.
- `GMatchRadioComponent`: nuova pagina pubblica consigliata per la Slice 2.

Route pubblica proposta:

```text
/g-radio/:matchId
```

Motivazione: coerente con il prefisso pubblico `g-*`, breve, condivisibile e non conflittuale con `g-match/:matchId`.

## Implementation Summary

La task list prevede un'implementazione incrementale:

1. definire modelli TypeScript Radio Evento;
2. implementare `MatchRadioStorageService`;
3. implementare `MatchRadioPlayerService`;
4. collegare selezione AI-Talker al player;
5. aggiungere controlli Auto Play in `GMatchEventsComponent`;
6. collegare polling partita a `syncMatch`;
7. migrare audio manuale a `MatchRadioPlayerService`;
8. integrare analytics radio;
9. gestire stati di errore e degradazione;
10. valutare feature flag frontend;
11. creare `GMatchRadioComponent`;
12. aggiungere route pubblica `/g-radio/:matchId`;
13. collegare pagina partita e Pagina Radio;
14. completare i18n;
15. eseguire QA manuale MVP;
16. eseguire QA manuale Pagina Radio;
17. aggiornare la wiki tecnica dopo implementazione.

La validazione minima release proposta e `npm run build` da `src/RugbyRadioWeb`, piu test manuali su partita pubblica, coda, pausa/riprendi/stop, storage locale, cambio talker, errori audio, click manuale, route dedicata e viewport mobile.

## Decisions

- L'MVP e frontend-first.
- Nessuna nuova API, tabella o sessione server-side per MVP e Slice 2.
- Nessuno stream audio server-side.
- Nessuna AI realtime.
- Il cronista non riceve nuovi campi, pulsanti o responsabilita.
- Default "solo nuovi eventi" all'avvio radio.
- Opzione "ascolta dall'inizio" disponibile allo spettatore.
- La coda riproduce un solo audio alla volta.
- Deduplica coda con chiave `eventId + talkerId + language`.
- Cambio AI-Talker o lingua applicato solo agli eventi futuri.
- Eventi accodati poi eliminati o corretti non ricostruiscono retroattivamente la coda.
- Stop conserva l'ultimo stato locale fino a un nuovo Play.
- Persistenza locale limitata al dispositivo.
- LocalStorage con namespace `rrl_radio_v1:{matchId}:...`.
- Coda persistita limitata agli ultimi 5 item per match.
- Cleanup dello stato locale dopo 10 giorni dall'ultimo item persistito.
- Route pubblica consigliata: `/g-radio/:matchId`.
- I jingle futuri sono globali RRL e statici/pre-generati.
- Nessuna preferenza separata per disattivare notifiche audio-evento rispetto al follow partita/canale.
- Nessun hardening backend o rate limiting dedicato per `/v1/voices/events` nella prima fase.

## Changed Files or Components

Documenti prodotti o consolidati:

- `projects/radio-evento/README.md`;
- `projects/radio-evento/notes/idea-radio.md`;
- `projects/radio-evento/analysis/analisi-funzionale-radio-evento.md`;
- `projects/radio-evento/architecture/analisi-architetturale-radio-evento.md`;
- `projects/radio-evento/tasks/task-implementazione-radio-evento.md`;
- `raw/projects/radio-evento/radio-evento-closeout.md`.

Componenti applicativi da creare o modificare nella futura fase implementativa:

- `src/RugbyRadioWeb/src/app/services/match-radio-storage.service.ts`;
- `src/RugbyRadioWeb/src/app/services/match-radio-player.service.ts`;
- modelli DTO radio in `src/RugbyRadioWeb/src/app/dto` o cartella coerente;
- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.*`;
- `src/RugbyRadioWeb/src/app/common/match-events/match-events.component.*`;
- `src/RugbyRadioWeb/src/app/common/match-commentator/match-commentator.component.ts`;
- `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.ts`;
- `src/RugbyRadioWeb/src/app/global/g-match-radio/g-match-radio.component.*`;
- `src/RugbyRadioWeb/src/app/app.routes.ts`;
- `src/RugbyRadioWeb/src/assets/i18n/*.json`;
- eventuali `environment*.ts` se si introduce `enableRadioEvent`.

Backend e database non sono previsti come componenti modificati per MVP.

## Data, Analytics, or Operational Impact

Impatto dati applicativi:

- nessuna nuova tabella;
- nessuna migrazione database;
- nessuna persistenza server-side di sessioni radio;
- nessun salvataggio backend di coda, preferenze o ultimo evento ascoltato.

Impatto storage locale:

- preferenze radio per match;
- ultimi item di coda, massimo 5 per match;
- ultimo evento ascoltato;
- stato recuperabile del player;
- cleanup dopo 10 giorni dall'ultimo item persistito.

Impatto analytics previsto:

- `radio_play`;
- `radio_play_from_start_enabled`;
- `radio_pause`;
- `radio_resume`;
- `radio_stop`;
- `radio_event_play_start`;
- `radio_event_play_complete`;
- `radio_event_audio_error`;
- `radio_queue_lag`.

Impatto operativo:

- possibile aumento chiamate a `GET /v1/voices/events` durante partite live;
- nessun nuovo job;
- nessun nuovo deployment backend;
- necessario monitoraggio errori TTS e uso effettivo prima di investire in background, jingle o Radio Canale.

## Validation

Validazione eseguita in questa chiusura:

- lettura dei documenti sorgente in `projects/radio-evento`;
- verifica che `raw/projects/radio-evento/radio-evento-closeout.md` non esistesse prima della creazione;
- creazione del documento di closeout in `raw/projects/radio-evento`;
- aggiornamento del README del progetto per indicare la chiusura.

Non sono stati eseguiti build o test applicativi perche questa chiusura modifica solo documentazione di progetto e non codice sorgente.

Validazione richiesta nella futura fase implementativa:

- `npm run build` da `src/RugbyRadioWeb`;
- test manuale su partita pubblica con default solo nuovi eventi;
- test manuale con "ascolta dall'inizio";
- test pausa, riprendi, stop e refresh;
- test persistenza localStorage;
- test cambio AI-Talker durante riproduzione;
- test errore audio recuperabile;
- test click manuale audio evento;
- test route `/g-radio/:matchId`;
- test mobile viewport e browser moderni.

## Known Gaps and Follow-ups

- Implementare effettivamente il player radio frontend.
- Verificare nel codice Angular il miglior punto di integrazione con selezione talker e polling match.
- Confermare la codifica esistente di lingua/talker per evitare mapping paralleli.
- Validare comportamento su browser mobile, PWA e TWA prima di promettere ascolto a schermo bloccato.
- Monitorare eventuale incremento di chiamate TTS prima di decidere rate limiting o hardening dedicato.
- Decidere se usare un feature flag `enableRadioEvent` in dev/prod.
- Aggiornare la wiki canonica dopo l'implementazione, non durante questa chiusura.

## Source Documents

- `projects/radio-evento/README.md`;
- `projects/radio-evento/notes/idea-radio.md`;
- `projects/radio-evento/analysis/analisi-funzionale-radio-evento.md`;
- `projects/radio-evento/architecture/analisi-architetturale-radio-evento.md`;
- `projects/radio-evento/tasks/task-implementazione-radio-evento.md`.

Contesto wiki dichiarato nei documenti di analisi:

- `wiki/architecture/Rugby Radio Live (architecture).md`;
- `wiki/business/product/Rugby Radio Live (product).md`;
- `wiki/workflows/Riproduzione Audio Telecronaca (workflow).md`;
- `wiki/workflows/Spettatore Partita (workflow).md`;
- `wiki/concepts/TTS Audio (concept).md`;
- `wiki/concepts/AI-Talker (concept).md`;
- `wiki/concepts/Radio Canale (concept).md`;
- `wiki/concepts/Notifica (concept).md`;
- `wiki/concepts/Match Event Types (concept).md`;
- `wiki/frontend/web/components/GMatchEventsComponent (web).md`;
- `wiki/frontend/web/components/MatchEventsComponent (web).md`;
- `wiki/frontend/web/components/MatchCommentatorComponent (web).md`;
- `wiki/frontend/web/services/VoiceService (web).md`;
- `wiki/backend/api/integrations/FirebaseFCM (api).md`.

## Wiki Ingestion Notes

Questo documento puo alimentare in seguito:

- `wiki/articles/Radio Live e Audio Telecronaca (article).md`;
- `wiki/workflows/Riproduzione Audio Telecronaca (workflow).md`;
- `wiki/concepts/TTS Audio (concept).md`;
- `wiki/concepts/AI-Talker (concept).md`;
- `wiki/concepts/Radio Canale (concept).md`;
- `wiki/frontend/web/services/MatchRadioPlayerService (web).md`;
- `wiki/frontend/web/services/MatchRadioStorageService (web).md`;
- `wiki/frontend/web/pages/GMatchRadioPage (web).md`;
- `wiki/frontend/web/components/GMatchEventsComponent (web).md`;
- `wiki/frontend/web/components/MatchEventsComponent (web).md`;
- `wiki/frontend/web/components/MatchCommentatorComponent (web).md`;
- `wiki/comparisons/Mappatura Audio TTS e Localizzazione (comparison).md`;
- `wiki/comparisons/Mappatura Eventi e Workflow (comparison).md`.

Durante l'ingestione wiki, separare chiaramente:

- cio che e gia deciso per MVP;
- cio che e roadmap successiva;
- cio che richiede implementazione e validazione reale;
- il vincolo architetturale "nessun backend/database/stream per MVP";
- le regole localStorage ultimi 5 item e cleanup dopo 10 giorni.
