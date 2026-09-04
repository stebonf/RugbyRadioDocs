---
title: "FacebookJob (api)"
type: backend-job
layer: backend
---

# FacebookJob (api)

## Sintesi

Job per la pubblicazione su Facebook ([[Pubblicazione Social (concept)]]). Genera immagine tramite Tailoor Painter, compone il tabellino visuale della partita e pubblica il post su pagina Facebook. Flusso completo parzialmente dedotto.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Genera immagine partita via Tailoor Painter
- Compone tabellino visuale con ImageSharp
- Pubblica post con immagine su pagina Facebook via `FacebookService.PostAsync`
- Aggiorna `Blog.IsFacebookPosted` (probabile, non verificato)

## Services usati

- [[FacebookService (api)]]

## Entities coinvolte

- [[Blog (api)]] — lettura/scrittura (probabile)
- [[Match (api)]] — lettura (deducibile)

## Side effects

- Generazione immagine tramite Tailoor Painter
- Pubblicazione post su pagina Facebook (Graph API)
- Chiamata HTTP esterna a Tailoor Painter e Facebook

## Failure points

- Immagine null → return
- `[AutomaticRetry(Attempts = 0)]` — nessun retry
- Flusso `RunAsync` parzialmente letto

## Nome nel codice

`FacebookJob` — `src/RugbyRadio/HF/Jobs/Social/FacebookJob.cs`
