---
title: "SeoSitemapFilePublishingIntegration (api)"
type: backend-integration
layer: backend
---

# SeoSitemapFilePublishingIntegration (api)

## Sintesi

Integrazione filesystem per pubblicazione delle sitemap SEO principali generate dal backend HF.

## Provider esterno

Filesystem/cartella pubblica configurata da `SeoSitemap.OutputPath`.

## Responsabilità

Scrive sitemap XML e sitemap index per URL statici, match, canali, team e blog.

## Services consumer

- [[GenerateSeoSitemapJob (api)]]

## Payload rilevanti

- `SeoPublicUrl`
- `SeoSitemapReference`
- XML sitemap.

## Retry/fallback

- Fallback da `File.Replace` a `File.Move(..., overwrite: true)`.
- Fallback `StaticFilesPath` a `OutputPath`.
- Fallback `lastmod` a data generazione.

## Side effects

- Creazione directory output.
- Scrittura file temporanei.
- Sostituzione o overwrite dei file XML target.

## Note

Fonte: `llm-wiki/raw/backend/api/integration-map-20260519.md`.
