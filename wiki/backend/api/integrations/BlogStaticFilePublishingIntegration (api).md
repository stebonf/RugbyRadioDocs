---
title: "BlogStaticFilePublishingIntegration (api)"
type: backend-integration
layer: backend
---

# BlogStaticFilePublishingIntegration (api)

## Sintesi

Integrazione filesystem per pubblicazione statica del blog generato da job backend.

## Provider esterno

Filesystem/cartella pubblica configurata da `BlogSettings.OutputPath`.

## Responsabilità

Scrive HTML statico, landing root, indici paginati e sitemap blog a partire da template e dati applicativi.

## Services consumer

- [[CreateMatchBlogHtmlJob (api)]]

## Payload rilevanti

- HTML statico.
- XML sitemap blog.

## Retry/fallback

- `[AutomaticRetry(Attempts = 0)]` sul job consumer.
- Template mancante gestito con stringa vuota.

## Side effects

- Scrittura file HTML e XML.
- Cancellazione file HTML legacy o esistenti prima della riscrittura.

## Note

Fonte: `llm-wiki/raw/backend/api/integration-map-20260519.md`.
