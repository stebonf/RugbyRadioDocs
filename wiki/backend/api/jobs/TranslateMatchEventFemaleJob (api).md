---
title: "TranslateMatchEventFemaleJob (api)"
type: backend-job
layer: backend
---

# TranslateMatchEventFemaleJob (api)

## Sintesi

Traduce i messaggi di sistema degli eventi partita nella variante femminile (`MessageFemale`). Per ciascuna delle 5 lingue (IT, EN, FR, ES, JA), recupera i messaggi senza variante femminile (batch 20) e li traduce tramite Tailoor Talker.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Processa 20 messaggi per lingua per esecuzione
- Skip se `Message` è vuoto
- Aggiorna `SystemMessage.MessageFemale`

## Services usati

Accesso diretto a `ISystemMessageRepository` e `IUnitOfWork`

## Entities coinvolte

- [[SystemMessage (api)]] — lettura/scrittura (`MessageFemale`)

## Side effects

- Aggiornamento `SystemMessage.MessageFemale` in DB
- Chiamata HTTP esterna a Tailoor Talker

## Failure points

- `[AutomaticRetry(Attempts = 0)]` — nessun retry
- Corpo `TranslateRows` parzialmente dedotto

## Nome nel codice

`TranslateMatchEventFemaleJob` — `src/RugbyRadio/HF/Jobs/TranslateMatchEventFemaleJob.cs`
