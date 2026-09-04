---
title: "FakeLastYearAgentJob (api)"
type: backend-job
layer: backend
---

# FakeLastYearAgentJob (api)

## Sintesi

Simula partite dell'anno scorso generando dati fake (canali, squadre, giocatori, eventi). Estende la classe base `FakeAgent`. Corpo specifico non letto nel dettaglio.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Creazione dati fake per partite storicizzate
- Generazione testi eventi tramite Tailoor Talker

## Services usati

- [[UserService (api)]]
- [[MatchService (api)]]

## Entities coinvolte

- [[User (api)]], [[Channel (api)]], [[Team (api)]], [[Match (api)]], [[Player (api)]], [[LineupPlayer (api)]], [[MatchEvent (api)]] — lettura/scrittura

## Side effects

- Creazione dati fake in DB
- Chiamata HTTP esterna a Tailoor Talker

## Failure points

- `[AutomaticRetry(Attempts = 0)]` — nessun retry
- Corpo specifico parzialmente dedotto

## Nome nel codice

`FakeLastYearAgentJob` — `src/RugbyRadio/HF/Jobs/FakeAgents/FakeLastYearAgentJob.cs`
