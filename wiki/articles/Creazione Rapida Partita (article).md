---
title: "Creazione Rapida Partita (article)"
type: article
layer: concept
---

# Creazione Rapida Partita (article)

## Sintesi

La creazione rapida partita e il flusso wizard che consente di creare in una sola operazione canale, squadre, partita e formazioni iniziali. Il flusso collega drawer frontend, DTO quick, endpoint MTC-17 e orchestrazione backend tramite [[RugbyRadioLiveService (api)]].

## Scope

Questa pagina descrive il funzionamento end-to-end della creazione rapida partita usando le pagine canoniche gia presenti nella wiki. Copre apertura del drawer, raccolta dati, chiamata API, creazione contestuale di canale e squadre, side effect backend e riuso del wizard per canali di training.

## Componenti coinvolti

- [[EntityBottomNavComponent (web)]] — pulsante mobile "crea" che apre il drawer globale.
- [[BusService (web)]] — stato condiviso `quickMatchOpen` per aprire il pannello quick match.
- [[MatchCreateComponent (web)]] — drawer full-screen a tre step.
- [[MatchService (web)]] — client frontend che invia la richiesta di creazione rapida.
- [[matchQuickAddDto (web)]] — DTO di richiesta con canale e squadre in formato quick.
- [[MatchesV1Controller (api)]] — endpoint MTC-17 per la creazione rapida partita.
- [[RugbyRadioLiveService (api)]] — orchestratore di canale, squadre, partita e formazioni.
- [[Channel (api)]], [[Team (api)]], [[Match (api)]], [[LineupPlayer (api)]] — entita scritte dal flusso.
- [[CreateTrainingChannelJob (api)]] — consumer backend che riusa il wizard per canali di training.
- [[Ciclo di Vita Partita (concept)]] — contesto di stato iniziale e ciclo partita.

## Relazioni principali

1. L'utente apre il drawer tramite [[EntityBottomNavComponent (web)]], che usa [[BusService (web)]] per impostare lo stato `quickMatchOpen`.
2. [[MatchCreateComponent (web)]] guida la creazione in tre step: selezione canale, selezione squadre e riepilogo/conferma.
3. Il wizard costruisce [[matchQuickAddDto (web)]], che include `dateDay`, `channel`, `homeTeam` e `awayTeam`.
4. Ogni elemento quick usa il pattern create-or-reference: puo contenere un `id` per entita esistente oppure un `name` per creazione inline.
5. [[MatchService (web)]] invia la richiesta a [[MatchesV1Controller (api)]].
6. [[MatchesV1Controller (api)]] espone MTC-17 come creazione rapida partita e delega a [[RugbyRadioLiveService (api)]].
7. [[RugbyRadioLiveService (api)]] esegue `WizardFastAddChannelAsync`, creando o recuperando canale, due squadre, partita e 46 record [[LineupPlayer (api)]].
8. Alla fine del flusso frontend, [[MatchCreateComponent (web)]] emette eventi come `matchCreated` e `dataRefreshNeeded` per aggiornare il parent.

## Dettaglio Funzionamento

Il drawer frontend e progettato per evitare che l'utente debba prima creare manualmente tutte le entita di contesto. La selezione canale e squadre supporta entita esistenti o nuove; questa scelta viene codificata in [[matchQuickAddDto (web)]] tramite `matchQuickItemAddDto`.

Sul backend, il punto centrale non e il controller ma [[RugbyRadioLiveService (api)]]. Il service orchestra una scrittura composta: [[Channel (api)]], due [[Team (api)]], [[Match (api)]] e due formazioni da 23 slot ciascuna. La pagina [[Ciclo di Vita Partita (concept)]] documenta che la creazione wizard MTC-17 crea canale, squadre, partita e formazioni in un'unica operazione atomica.

Lo stesso orchestratore viene riusato anche da [[CreateTrainingChannelJob (api)]], che crea un canale training con partita di allenamento per utenti che non hanno ancora un canale di test.

## Decisioni architetturali

- Il flusso rapido usa un wizard frontend dedicato invece di esporre separatamente i passaggi canale, squadra e partita.
- Il DTO quick include il canale, a differenza di `matchAddDto`, perche la partita puo essere creata anche senza essere gia dentro il contesto di un canale esistente.
- La creazione contestuale usa pattern create-or-reference per canale e squadre.
- La logica di orchestrazione vive in [[RugbyRadioLiveService (api)]], cosi puo essere riusata da endpoint autenticati, registrazione utente e job di training.
- Il drawer e aperto tramite [[BusService (web)]], evitando accoppiamento diretto tra bottom nav e componente di creazione.

## Rischi

- Validazioni complete su nomi canale, nomi squadra, duplicati e conflitti owner/co-owner non sono deducibili.
- Dettaglio transazionale effettivo non e esplicitato oltre alla descrizione di operazione atomica nella wiki.
- La wiki non dettaglia tutte le risposte di errore del wizard o gli stati UI successivi a fallimento parziale.
- L'eventuale spostamento file immagine su filesystem e citato come side effect di [[RugbyRadioLiveService (api)]], ma non e dettagliato in questo flusso.

## Note

Articolo creato usando solo pagine gia presenti in `llm-wiki/wiki`. I RAW individuati hanno guidato la scelta del tema, ma il contenuto canonico deriva dalle pagine wiki: [[MatchCreateComponent (web)]], [[matchQuickAddDto (web)]], [[MatchesV1Controller (api)]], [[RugbyRadioLiveService (api)]], [[BusService (web)]], [[EntityBottomNavComponent (web)]], [[CreateTrainingChannelJob (api)]] e [[Ciclo di Vita Partita (concept)]].

