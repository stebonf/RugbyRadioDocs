---
title: "CreateMatchImageInstagramJob (api)"
type: backend-job
layer: backend
---

# CreateMatchImageInstagramJob (api)

## Sintesi

Converte immagini WebP delle partite in formato JPG (1080×1350) per Instagram. Legge `.webp` da `MatchImageUrl`, genera JPG in `MatchImageInstagramUrl`. Contiene metodo `WritePost` (pubblicazione social) non letto nel dettaglio.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Converte WebP → JPG (1080×1350, qualità 90)
- Skip file con `-original` nel nome
- Skip se JPG già esiste
- Invoca `WritePost(match)` — side effects non deducibili

## Services usati

Accesso diretto a `IMatchRepository`

## Entities coinvolte

- [[Match (api)]] — lettura

## Side effects

- Scrittura file JPG su filesystem
- Side effects `WritePost` non deducibili

## Failure points

- `[AutomaticRetry(Attempts = 0)]` — nessun retry
- Dettaglio `WritePost` parzialmente dedotto

## Nome nel codice

`CreateMatchImageInstagramJob` — `src/RugbyRadio/HF/Jobs/CreateMatchImageInstagramJob.cs`
