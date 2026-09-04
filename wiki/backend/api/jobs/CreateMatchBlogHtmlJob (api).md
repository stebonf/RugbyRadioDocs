---
title: "CreateMatchBlogHtmlJob (api)"
type: backend-job
layer: backend
---

# CreateMatchBlogHtmlJob (api)

## Sintesi

Genera file HTML statici del blog per le partite. Per ogni lingua (IT, EN, FR, ES, JA) genera pagine di dettaglio post, indici paginati, landing page e sitemap XML.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- Genera HTML statici per post blog non ancora staticizzati
- Genera indice paginato (20 post per pagina) e landing root
- Genera sitemap XML
- Aggiorna `Blog.IsBlogStatic = true` dopo staticizzazione

## Services usati

Nessun service applicativo diretto (accesso diretto ai repository)

## Entities coinvolte

- [[Match (api)]] — lettura
- [[Blog (api)]] — lettura/scrittura (`IsBlogStatic`)

## Side effects

- Generazione file HTML statici su filesystem (path configurato via `BlogSettings`)
- Aggiornamento `Blog.IsBlogStatic` in DB
- Generazione sitemap XML
- URL lingua generate lowercase
- URL post blog generate con `matchId` lowercase
- Canonical blog post usa URL lowercase
- Hreflang coerenti tra varianti lingua
- Sitemap blog lingua usa URL lowercase
- Link dal blog verso pagina partita canonica: `https://rugbyradiolive.com/g-match/{matchIdLowercase}`
- JSON-LD `Article` nel template del post blog

## Failure points

- `[AutomaticRetry(Attempts = 0)]` — nessun retry

## Note

URL social hardcoded nel template (Instagram, YouTube). Funzioni rilevanti: `BuildBlogPostUrl`, `BuildMatchUrl`, `ToLowerUrlToken`. Footer template allineato al dominio canonico.

## Nome nel codice

`CreateMatchBlogHtmlJob` — `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs`
