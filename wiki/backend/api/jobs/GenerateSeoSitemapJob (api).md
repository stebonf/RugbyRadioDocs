---
title: "GenerateSeoSitemapJob (api)"
type: backend-job
layer: backend
---

# GenerateSeoSitemapJob (api)

## Sintesi

Job Hangfire che genera sitemap XML pubbliche per URL statici, match, canali, squadre e sitemap index principale.

## Trigger

Hangfire runtime; cron o origine esatta non deducibile dai RAW letti.

## Responsabilità

- Legge candidati URL da [[SeoUrlInventoryService (api)]].
- Scrive sitemap static, matches, channels, teams.
- Scrive sitemap index root.
- Aggiunge riferimento alla sitemap blog.
- Valida XML prima della scrittura.

## Services usati

- [[SeoUrlInventoryService (api)]]
- [[SitemapXmlWriter (api)]]

## Entities coinvolte

Non deducibile direttamente dal job. Le entity sono lette dal service consumer.

## Side effects

- Generazione file XML sitemap su filesystem configurato.
- Output root: `sitemap.xml` (sitemap index).
- Output sezionali: `sitemap-static.xml`, `sitemap-matches.xml`, `sitemap-channels.xml`, `sitemap-teams.xml`.
- Include riferimento a sitemap blog.
- Creazione directory output.
- Scrittura atomica con file temporaneo e replace.
- Validazione XML prima del publish.
- Log su logger e console Hangfire.

## Configurazione

- Nodo config: `SeoSitemap` (classe `SeoSitemapSettings` in `src/RugbyRadio/Lib/Settings/`).
- Campo richiesto: `OutputPath`.

## Failure points

- `SeoSitemap:OutputPath` mancante genera errore.
- XML non valido genera errore in validazione.
- Fallback da `File.Replace` a `File.Move` per eccezioni di filesystem gestite.
- `[AutomaticRetry(Attempts = 0)]`: nessun retry automatico.
- `[DisableConcurrentExecution(timeoutInSeconds: 3600)]`: esecuzione concorrente disabilitata.

## Note

Fonti: `llm-wiki/raw/backend/api/job-map-20260519.md`, `llm-wiki/raw/dev/seo-20260519.md`. Job in `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs`.
