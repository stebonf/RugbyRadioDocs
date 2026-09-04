---
title: "CreateChannelImageInstagramJob (api)"
type: backend-job
layer: backend
---

# CreateChannelImageInstagramJob (api)

## Sintesi

Converte immagini WebP dei canali in formato JPG (1080×1350) per Instagram. Analoga a `CreateMatchImageInstagramJob` ma per i canali.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Converte WebP → JPG (1080×1350)
- Skip file con `-original` nel nome
- Skip se JPG già esiste
- Invoca `WritePost(channel)` — side effects non deducibili

## Services usati

Accesso diretto a `IChannelRepository`

## Entities coinvolte

- [[Channel (api)]] — lettura

## Side effects

- Scrittura file JPG su filesystem
- Side effects `WritePost` non deducibili

## Failure points

- `[AutomaticRetry(Attempts = 0)]` — nessun retry

## Nome nel codice

`CreateChannelImageInstagramJob` — `src/RugbyRadio/HF/Jobs/CreateChannelImageInstagramJob.cs`
