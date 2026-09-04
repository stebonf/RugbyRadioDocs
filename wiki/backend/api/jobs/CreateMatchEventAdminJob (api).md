---
title: "CreateMatchEventAdminJob (api)"
type: backend-job
layer: backend
---

# CreateMatchEventAdminJob (api)

## Sintesi

Gestione amministrativa dei draft messaggi di telecronaca. Recupera gruppi di draft incompleti, li completa e approva automaticamente i gruppi con 39 draft verificati. Genera messaggi per tutti i `MatchEventType` non ancora coperti.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Recupera gruppi draft incompleti
- Se gruppo con esattamente 39 draft verificati → `ApproveMessages` (promuove a `SystemMessage`)
- Genera messaggi per tutti i `MatchEventType` mancanti

## Services usati

- [[SystemMessageService (api)]]

## Entities coinvolte

- [[SystemMessageDraft (api)]] — lettura/scrittura
- [[SystemMessage (api)]] — lettura/scrittura

## Side effects

- Scrittura DB: `SystemMessageDraft`, `SystemMessage`
- Chiamata HTTP esterna a Tailoor Talker

## Failure points

- `[AutomaticRetry(Attempts = 0)]` — nessun retry

## Nome nel codice

`CreateMatchEventAdminJob` — `src/RugbyRadio/HF/Jobs/CreateMatchEventAdminJob.cs`
