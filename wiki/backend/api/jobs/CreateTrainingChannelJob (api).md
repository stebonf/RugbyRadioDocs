---
title: "CreateTrainingChannelJob (api)"
type: backend-job
layer: backend
---

# CreateTrainingChannelJob (api)

## Sintesi

Crea il canale di training per gli utenti che non lo hanno ancora. Itera su tutti gli utenti, verifica se hanno già un canale di test e, in caso contrario, crea un canale training con una partita di allenamento di default.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Itera su tutti gli utenti attivi
- Skip se l'utente ha già almeno un canale con `IsTestChannel == true`
- Crea canale training + partita via `WizardFastAddChannelAsync`
- Dati fissi: channel `"Training Channel"`, HomeTeam `"Blue Sharks"`, AwayTeam `"Red Lions"`

## Services usati

- [[RugbyRadioLiveService (api)]]

## Entities coinvolte

- [[User (api)]] — lettura
- [[Channel (api)]] — lettura/scrittura
- [[Match (api)]] — scrittura (via wizard)
- [[Team (api)]] — scrittura (via wizard)

## Side effects

- Creazione canale, partita e squadre di training in DB

## Failure points

- `[AutomaticRetry(Attempts = 0)]` — nessun retry

## Nome nel codice

`CreateTrainingChannelJob` — `src/RugbyRadio/HF/Jobs/CreateTrainingChannelJob.cs`
