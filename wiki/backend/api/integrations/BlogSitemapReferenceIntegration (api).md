---
title: "BlogSitemapReferenceIntegration (api)"
type: backend-integration
layer: backend
---

# BlogSitemapReferenceIntegration (api)

## Sintesi

Integrazione logica che produce riferimenti alla sitemap del blog pubblico per includerli nel sitemap index principale.

## Provider esterno

Blog pubblico Rugby Radio Live.

## Responsabilità

Costruisce URL della sitemap blog da `BlogSettings.BlogDomain`, con fallback a `SeoPublicUrlRules.BlogSitemapLoc`.

## Services consumer

- [[SeoUrlInventoryService (api)]]
- [[GenerateSeoSitemapJob (api)]]

## Payload rilevanti

- `SeoSitemapReference`

## Retry/fallback

Fallback a URL sitemap blog canonico se il blog root configurato non è valorizzato.

## Side effects

Nessuno deducibile direttamente; il riferimento viene scritto dal job sitemap.

## Note

Fonte: `llm-wiki/raw/backend/api/integration-map-20260519.md`.
