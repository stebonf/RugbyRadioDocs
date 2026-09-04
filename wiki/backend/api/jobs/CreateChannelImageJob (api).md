---
title: "CreateChannelImageJob (api)"
type: backend-job
layer: backend
---

# CreateChannelImageJob (api)

## Sintesi

Genera immagini WebP per i canali tramite Tailoor Painter AI. Struttura analoga a `CreateMatchImageJob` ma con prompt da `Prompts/Painters/Channel/` e output in `ChannelImageNewUrl`.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Chiama Tailoor Painter per generare immagine canale
- Elabora con ImageSharp e salva come WebP
- Ferma generazione se ≥ 10.000 immagini già presenti

## Services usati

Nessuna dipendenza iniettata (costruttore vuoto)

## Entities coinvolte

Nessuna da DB

## Side effects

- Generazione file WebP su filesystem
- Chiamata HTTP esterna a Tailoor Painter

## Failure points

- `[AutomaticRetry(Attempts = 0)]` — nessun retry

## Nome nel codice

`CreateChannelImageJob` — `src/RugbyRadio/HF/Jobs/CreateChannelImageJob.cs`
