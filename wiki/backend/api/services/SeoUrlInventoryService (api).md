---
title: "SeoUrlInventoryService (api)"
type: backend-service
layer: backend
---

# SeoUrlInventoryService (api)

## Sintesi

Servizio backend HF che costruisce candidati URL pubblici canonici per sitemap SEO leggendo repository applicativi e configurazione blog, senza persistere righe di inventory.

## Responsabilità

- Produce URL statici pubblici.
- Produce URL match, canali, team e blog.
- Applica policy di indexability per i match.
- Produce riferimento alla sitemap blog.

## Consumer

- [[GenerateSeoSitemapJob (api)]]

## Repository usati

- [[MatchRepository (api)]]
- [[ChannelRepository (api)]]
- [[TeamRepository (api)]]
- [[BlogRepository (api)]]

## Integrazioni usate

- [[BlogSitemapReferenceIntegration (api)]]

## Jobs usati

Nessuno deducibile.

## Entities coinvolte

- [[Match (api)]]
- [[Channel (api)]]
- [[Team (api)]]
- [[Blog (api)]]

## Workflow correlati

- [[Pubblicazione Blog Statico (workflow)]]

## Modelli interni usati

- `SeoPublicUrl` — DTO interno per URL pubbliche SEO con campi: `Loc`, `CanonicalLoc`, `Type`, `Source`, `LastMod`, `ChangeFrequency`, `Priority`, `IsIndexable`, `IsCanonical`, `ExclusionReason`.
- `SeoPublicUrlRules` — Regole per host canonico (`https://rugbyradiolive.com`), blog sitemap (`https://blog.rugbyradiolive.com/sitemap.xml`), path statici indicizzabili e soglia minima eventi match (10).

## Side effects

Nessuno deducibile: il servizio compone DTO/candidati URL e non scrive dati.

## Note

Fonti: `llm-wiki/raw/backend/api/service-map-20260519.md`, `llm-wiki/raw/dev/seo-20260519.md`. Servizio in `src/RugbyRadio/HF/Services/SeoUrlInventoryService.cs`, registrato in DI nel progetto Hangfire. Query repository SEO-specifiche aggiunte per canonical, lastmod e policy indicizzabilita.
