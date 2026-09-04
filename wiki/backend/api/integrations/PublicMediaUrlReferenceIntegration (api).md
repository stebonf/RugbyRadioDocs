---
title: "PublicMediaUrlReferenceIntegration (api)"
type: backend-integration
layer: backend
---

# PublicMediaUrlReferenceIntegration (api)

## Sintesi

Integrazione di URL media pubblici scritti negli HTML statici del blog.

## Provider esterno

`storage-sh.rugbyradiolive.com`

## Responsabilità

Inserisce URL assoluti a immagini cover e loghi team nei file HTML statici generati.

## Services consumer

- [[CreateMatchBlogHtmlJob (api)]]

## Payload rilevanti

URL immagini pubbliche.

## Retry/fallback

Non deducibile.

## Side effects

Scrittura HTML contenente riferimenti media esterni.

## Note

Fonte: `llm-wiki/raw/backend/api/integration-map-20260519.md`. Non risultano upload o chiamate HTTP runtime nel RAW letto.
