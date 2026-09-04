---
title: "CreateMatchImageJob (api)"
type: backend-job
layer: backend
---

# CreateMatchImageJob (api)

## Sintesi

Genera immagini WebP per le partite tramite Tailoor Painter AI. Output in `D:\Web\RugbyRadioStorage\Matches-New\` (1200×630, qualità 75, lossy). Ferma la generazione se già presenti ≥ 10.000 immagini.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Chiama Tailoor Painter per generare immagine
- Elabora con ImageSharp (resize, encoding WebP)
- Salva su filesystem nella cartella pool `MatchImageNewUrl`

## Services usati

Nessuna dipendenza iniettata (costruttore vuoto)

## Entities coinvolte

Nessuna da DB (scrittura solo su filesystem)

## Side effects

- Generazione e scrittura file WebP su filesystem
- Chiamata HTTP esterna a Tailoor Painter

## Failure points

- Risposta null da Tailoor Painter → early return
- `[AutomaticRetry(Attempts = 0)]` — nessun retry

## Note

Painter ID hardcoded: `5382e0a5-700c-4e6b-ba85-e0d842806200`.

## Nome nel codice

`CreateMatchImageJob` — `src/RugbyRadio/HF/Jobs/CreateMatchImageJob.cs`
