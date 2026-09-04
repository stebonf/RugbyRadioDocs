---
title: "CreateMatchBlogJob (api)"
type: backend-job
layer: backend
---

# CreateMatchBlogJob (api)

## Sintesi

Genera post di blog in testo per le partite terminate senza blog. Genera prima EN via Tailoor Talker, poi traduce in IT, FR, ES, JA. Salva ogni post come record `Blog`.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Recupera partite `FullTime` con meno di 5 post blog
- Genera post EN tramite AI (Tailoor Talker)
- Traduce in IT, FR, ES, JA sequenzialmente
- Salva ogni versione come record `Blog`

## Services usati

- [[MatchService (api)]]

## Entities coinvolte

- [[Match (api)]] — lettura
- [[Blog (api)]] — scrittura

## Side effects

- Scrittura DB: `Blog` (N record per lingua)
- Chiamata HTTP esterna a Tailoor Talker

## Failure points

- Risposta AI vuota → skip partita
- Eccezione nel body principale → log + rethrow (propagata a Hangfire)
- `[AutomaticRetry(Attempts = 0)]` — nessun retry

## Nome nel codice

`CreateMatchBlogJob` — `src/RugbyRadio/HF/Jobs/CreateMatchBlogJob.cs`

## Note

Non deducibile
