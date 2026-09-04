---
title: "RepairMatchImageJob (api)"
type: backend-job
layer: backend
---

# RepairMatchImageJob (api)

## Sintesi

Assegna un'immagine WebP alle partite che ne sono prive. Seleziona immagine casuale dal pool, la copia come originale, la sposta come definitiva, aggiorna `Match.ImageUrl` in DB e sovrascrive l'immagine con il tabellino visuale (squadre, punteggio, font).

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Processa partite con `ImageUrl` nullo o vuoto
- Seleziona immagine random da `MatchImageNewUrl`
- Copia come `-original`, sposta come definitiva
- Aggiorna `Match.ImageUrl` in DB
- Sovrascrive immagine con compositing testo (squadre, punteggio) via ImageSharp + SixLabors.Fonts

## Services usati

Accesso diretto a `IMatchRepository` e `IUnitOfWork`

## Entities coinvolte

- [[Match (api)]] — lettura/scrittura (`ImageUrl`)

## Side effects

- Copia e spostamento file WebP su filesystem
- Aggiornamento `Match.ImageUrl` in DB
- Compositing immagine con tabellino

## Failure points

- Se partita o dati canale non trovati dopo reload → early return
- `[AutomaticRetry(Attempts = 0)]` — nessun retry

## Nome nel codice

`RepairMatchImageJob` — `src/RugbyRadio/HF/Jobs/RepairMatchImageJob.cs`
