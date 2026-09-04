---
title: "FakeLeagueAgentJob (api)"
type: backend-job
layer: backend
---

# FakeLeagueAgentJob (api)

## Sintesi

Simula partite di una lega fake usando configurazione da `FakeAgentSetting`. Estende `FakeAgent`. Corpo specifico non letto nel dettaglio.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Legge configurazione lega da `FakeAgentSetting`
- Crea dati fake per partite di lega simulata

## Services usati

- [[UserService (api)]]
- [[MatchService (api)]]

## Entities coinvolte

- [[FakeAgentSetting (api)]] — lettura (configurazione)
- [[User (api)]], [[Channel (api)]], [[Team (api)]], [[Match (api)]], [[Player (api)]] — lettura/scrittura

## Side effects

- Creazione dati fake in DB
- Chiamata HTTP esterna a Tailoor Talker
- Chiamate HTTP verso l'API configurata in `ConnectionStrings:ApiUrl` per statistiche, eventi e reazioni match

## Failure points

- `[AutomaticRetry(Attempts = 0)]` — nessun retry
- Le chiamate interne all'API usano un retry applicativo limitato per errori di rete/transienti e risposte 5xx
- Corpo specifico parzialmente dedotto

## Nome nel codice

`FakeLeagueAgentJob` — `src/RugbyRadio/HF/Jobs/FakeAgents/FakeLeagueAgentJob.cs`
