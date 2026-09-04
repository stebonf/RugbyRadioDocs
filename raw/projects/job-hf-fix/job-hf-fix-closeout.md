---
title: "Job HF Fix Closeout"
type: project-closeout
project: "job-hf-fix"
status: completed
created: "2026-07-28"
source: "projects/job-hf-fix"
---

# Job HF Fix Closeout

## Executive Summary

Il progetto `job-hf-fix` ha consolidato idea, analisi funzionale e analisi architetturale per un nuovo job Hangfire di bonifica dati per Rugby Radio Live.

Il risultato non e una modifica applicativa gia implementata, ma un pacchetto pronto per la fase tecnica: requisiti, regole di business, componenti da creare o estendere, rischi, decisioni aperte gia risolte dove possibile, piano di test e note di ingestione wiki.

## Original Goal

Creare un job schedulato ogni ora che verifichi lo stato dei dati RRL e applichi misure correttive collettive quando vengono rilevate anomalie note.

Le anomalie originarie erano:

- partite mai terminate;
- team senza nome;
- partite senza immagine;
- radio/canali senza immagine;
- radio/canali senza nome;
- utenti senza nickname.

## Final Outcome

Il progetto ha prodotto:

- una nota iniziale di idea;
- un'analisi funzionale completa con requisiti `FR-01` - `FR-35`, regole di business, flussi, criteri di accettazione e rischi;
- un'analisi architetturale che propone un nuovo `HfFixJob`, nuovi metodi repository, servizi riusabili per logiche Fake Agent e servizi di assegnazione immagini;
- risposte alle principali open question architetturali, sufficienti per avviare l'implementazione MVP.

Non risultano modifiche al codice sorgente associate a questo progetto. La chiusura formalizza quindi la fine della fase di analisi e progettazione.

## Scope Completed

- Definito il comportamento del job ricorrente Hangfire orario.
- Definita la chiusura forzata delle partite `InProgress` oltre 5 giorni con stato target `FullTime`.
- Definite le regole per correggere `Team.Name`, `Channel.Name`, `User.Nickname`, `Match.ImageUrl` e `Channel.ImageUrl`.
- Definita la regola di resilienza: errore puntuale su singola riga = skip e log, non fallimento dell'intero job.
- Definita l'idempotenza come requisito centrale.
- Definiti attori, stakeholder, impatti e out of scope.
- Definita una proposta architetturale per backend `src/RugbyRadio/HF`.
- Definiti repository, servizi, job, transazioni, osservabilita, deployment e piano di test.
- Registrate risposte alle open question principali.

## Scope Not Completed

- Implementazione del job `HfFixJob`.
- Estensione concreta dei repository.
- Estrazione concreta delle logiche Fake Agent in servizi riusabili.
- Estrazione o centralizzazione delle logiche di assegnazione immagini.
- Test automatici.
- Validazione su database reale o UAT.
- Aggiornamento wiki canonico.

## Functional Summary

Il job deve essere eseguito ogni ora da Hangfire e deve processare controlli indipendenti in sequenza.

I controlli funzionali previsti sono:

1. recuperare partite `InProgress` oltre soglia e impostare `Status = FullTime`;
2. recuperare team con `Name` nullo, vuoto o whitespace e generare un nome usando la logica Fake Agent;
3. recuperare partite con `ImageUrl` nullo, vuoto o whitespace e associare un'immagine con logica esistente;
4. recuperare radio/canali con `ImageUrl` nullo, vuoto o whitespace e associare un'immagine con logica esistente;
5. recuperare radio/canali con `Name` nullo, vuoto o whitespace e generare un nome canale usando la logica Fake Agent;
6. recuperare utenti con `Nickname` nullo, vuoto o whitespace e generare un nickname usando la logica Fake Agent.

Le regole principali sono conservative:

- non cancellare dati;
- non rigenerare eventi, punteggi, statistiche, blog, notifiche o pubblicazioni social;
- non modificare dati non necessari alla specifica correzione;
- lasciare eleggibili alla prossima esecuzione gli elementi saltati per errori temporanei;
- distinguere nei log correzioni, skip e motivi di errore.

L'MVP deve considerare solo `InProgress` per la chiusura automatica. `Halftime` resta fuori dall'MVP come iterazione separata.

## Architectural Summary

La proposta introduce `HfFixJob` in:

```text
src/RugbyRadio/HF/Jobs/HfFixJob.cs
```

Il job deve essere un orchestratore leggero con controlli separati:

- `CloseStaleInProgressMatchesAsync`;
- `FixUnnamedTeamsAsync`;
- `FixMatchImagesAsync`;
- `FixChannelImagesAsync`;
- `FixUnnamedChannelsAsync`;
- `FixUsersWithoutNicknameAsync`.

Pattern raccomandati:

- ereditarieta da `BaseCoreJob`;
- `[AutomaticRetry(Attempts = 0)]`;
- `[DisableConcurrentExecution(timeoutInSeconds: 3600)]`;
- schedulazione oraria configurata manualmente da dashboard Hangfire;
- batch limit con costanti nel primo MVP;
- salvataggi per singola riga o piccoli batch per preservare le correzioni gia riuscite.

Repository da estendere:

- `IMatchRepository` / `MatchRepository`: `FindStaleInProgressAsync(DateTime thresholdUtc, int take)` e `FindWithoutImageAsync(int take)`;
- `ITeamRepository` / `TeamRepository`: `FindUnnamedIncludeChannelAsync(int take)`;
- `IChannelRepository` / `ChannelRepository`: `FindWithoutImageAsync(int take)` e `FindUnnamedAsync(int take)`;
- `IUserRepository` / `UserRepository`: `FindWithoutNicknameAsync(int take)`.

Servizi consigliati:

- `IFakeTeamNameGenerator`;
- `IFakeChannelNameGenerator`;
- `IFakeUserNicknameGenerator`;
- `IMatchImageAssigner`;
- `IChannelImageAssigner`.

## Implementation Summary

Non e stata rilevata implementazione codice in questa fase.

La fase successiva dovrebbe partire dalla proposta architetturale e implementare in ordine:

1. metodi repository e relativi test;
2. servizi generator per nomi e nickname Fake Agent;
3. servizi condivisi per assegnazione immagini;
4. `HfFixJob` orchestratore;
5. registrazione/configurazione Hangfire;
6. test unitari e test di integrazione leggero;
7. rollout UAT con batch ridotto;
8. verifica Hangfire, log, file immagine e righe corrette.

## Decisions

- Usare `Match.DateUtc` come riferimento temporale per la soglia dei 5 giorni.
- La chiusura forzata deve limitarsi al cambio `Status = FullTime`.
- I record senza testo valido includono valori `null`, stringa vuota e whitespace.
- I team senza canale valido devono essere solo loggati.
- Il nome team non deve superare il massimo previsto per il campo `Name`.
- La schedulazione oraria deve essere configurata manualmente da dashboard Hangfire.
- Batch size e soglia possono partire come costanti.
- Gli skip attesi non devono generare rumore Sentry; Sentry va usato per errori infrastrutturali o inattesi aggregati.
- Se il pool immagini e vuoto, raccomandazione MVP: skip invece di generare nuove immagini.
- Per canali senza team di contesto, usare fallback generico `Rugby` nel prompt e saltare solo se la risposta non e valida.
- Per utenti senza nickname, primo MVP solo con generazione Fake Agent, senza fallback deterministico locale.
- L'ordine dei controlli resta quello dell'idea aggiornata: canali senza nome dopo canali senza immagine, utenti senza nickname per ultimo.

## Changed Files or Components

Documenti prodotti o consolidati:

- `projects/job-hf-fix/notes/idea-job-hf-fix.md`;
- `projects/job-hf-fix/analysis/analisi-funzionale-job-hf-fix.md`;
- `projects/job-hf-fix/architecture/analisi-architetturale-job-hf-fix.md`;
- `raw/projects/job-hf-fix/job-hf-fix-closeout.md`.

Componenti applicativi da creare o modificare nella prossima fase:

- `src/RugbyRadio/HF/Jobs/HfFixJob.cs`;
- `IMatchRepository` / `MatchRepository`;
- `ITeamRepository` / `TeamRepository`;
- `IChannelRepository` / `ChannelRepository`;
- `IUserRepository` / `UserRepository`;
- servizi HF o libreria condivisa per generator Fake Agent;
- servizi HF o libreria condivisa per assegnazione immagini partita e canale;
- configurazione Hangfire/RecurringJobAdmin se necessaria.

## Data, Analytics, or Operational Impact

Impatto dati previsto:

- aggiornamento conservativo di `Match.Status`;
- aggiornamento conservativo di `Team.Name`;
- aggiornamento conservativo di `Match.ImageUrl`;
- aggiornamento conservativo di `Channel.ImageUrl`;
- aggiornamento conservativo di `Channel.Name`;
- aggiornamento conservativo di `User.Nickname`.

Impatto operativo:

- nuovo job Hangfire orario;
- riduzione interventi manuali di bonifica;
- logging riepilogativo per conteggi e skip;
- possibile impatto filesystem quando vengono assegnate immagini usando logiche esistenti;
- nessuna nuova API pubblica o UI amministrativa nell'MVP.

Non sono previsti impatti Analytics, GA, AdSense o SEO diretti.

## Validation

Validazione eseguita in questa chiusura:

- lettura dei documenti sorgente in `projects/job-hf-fix`;
- verifica che `raw/projects/job-hf-fix/job-hf-fix-closeout.md` non esistesse prima della creazione;
- creazione del documento di closeout in `raw/projects/job-hf-fix`.

Non sono stati eseguiti build o test applicativi perche questa fase non modifica codice sorgente.

Validazione richiesta nella fase implementativa:

- unit test repository per filtri `InProgress`, campi null/vuoti/whitespace e record cancellati;
- unit test servizi generator e servizi immagini;
- unit test job per preservazione dei dati non target;
- test di integrazione leggero su database test con generator e assigner fake;
- smoke test UAT su dashboard Hangfire, log e righe corrette.

## Known Gaps and Follow-ups

- Verificare nel codice di `RepairMatchImageJob` se estrarre subito la logica o introdurre prima un servizio condiviso usato da `HfFixJob`.
- Verificare nel codice di `ChannelService` e nei flussi di creazione canale quale logica riusare per associare immagini canale.
- Confermare su dati reali che `DateUtc` sia valorizzato correttamente anche sulle partite storiche dei Fake Agent.
- Decidere la gestione esatta del pool immagini vuoto in fase tecnica, mantenendo la raccomandazione MVP di skip.
- Valutare `IHfFixCheck` solo se l'orchestratore cresce oltre una dimensione leggibile.
- Aggiornare la wiki canonica quando il documento raw verra ingerito.

## Source Documents

- `projects/job-hf-fix/README.md`;
- `projects/job-hf-fix/notes/idea-job-hf-fix.md`;
- `projects/job-hf-fix/analysis/analisi-funzionale-job-hf-fix.md`;
- `projects/job-hf-fix/architecture/analisi-architetturale-job-hf-fix.md`.

Contesto wiki dichiarato nei documenti di analisi:

- `llm-wiki/wiki/backend/api/jobs/MaintenanceJob (api).md`;
- `llm-wiki/wiki/backend/api/jobs/FakeLeagueAgentJob (api).md`;
- `llm-wiki/wiki/backend/api/jobs/FakeLastYearAgentJob (api).md`;
- `llm-wiki/wiki/backend/api/jobs/CreateMatchImageJob (api).md`;
- `llm-wiki/wiki/backend/api/jobs/CreateChannelImageJob (api).md`;
- `llm-wiki/wiki/backend/api/jobs/RepairMatchImageJob (api).md`;
- `llm-wiki/wiki/backend/api/entities/Match (api).md`;
- `llm-wiki/wiki/backend/api/entities/Team (api).md`;
- `llm-wiki/wiki/backend/api/entities/Channel (api).md`;
- `llm-wiki/wiki/backend/api/services/MatchService (api).md`;
- `llm-wiki/wiki/backend/api/services/TeamService (api).md`;
- `llm-wiki/wiki/backend/api/services/ChannelService (api).md`;
- `llm-wiki/wiki/concepts/Fake Agent (concept).md`;
- `llm-wiki/wiki/concepts/Partita (concept).md`;
- `llm-wiki/wiki/concepts/Squadra (concept).md`;
- `llm-wiki/wiki/concepts/Radio Canale (concept).md`;
- `llm-wiki/wiki/concepts/Generazione Immagini (concept).md`;
- `llm-wiki/wiki/concepts/Operativita Backend (concept).md`;
- `llm-wiki/wiki/comparisons/Mappatura Job e Side Effects (comparison).md`.

## Wiki Ingestion Notes

Questo documento puo alimentare in seguito:

- `wiki/backend/jobs/job-hf-fix.md` o pagina equivalente sui job Hangfire;
- `wiki/backend/repositories/data-quality-queries.md` per i metodi repository di bonifica;
- `wiki/backend/services/fake-agent-generators.md` per i generator riusabili;
- `wiki/backend/services/image-assignment.md` per assegnazione immagini partita/canale;
- `wiki/workflows/data-quality-maintenance.md` per il workflow operativo;
- `wiki/architecture/hangfire-maintenance-jobs.md` per pattern architetturali e trade-off.

Durante l'ingestione wiki, separare chiaramente:

- requisiti funzionali decisi;
- raccomandazioni architetturali;
- follow-up tecnici ancora da verificare nel codice.
