---
title: "SocialShareUrlIntegration (api)"
type: backend-integration
layer: backend
---

# SocialShareUrlIntegration (api)

## Sintesi

Integrazione di URL social inseriti negli HTML statici generati dal backend per il blog.

## Provider esterno

WhatsApp, X/Twitter, Facebook, Instagram, YouTube.

## Responsabilità

Inserisce link di condivisione e link social nei file HTML statici.

## Services consumer

- [[CreateMatchBlogHtmlJob (api)]]

## Payload rilevanti

URL di share e URL profili social.

## Retry/fallback

Non deducibile.

## Side effects

Scrittura HTML contenente link social esterni.

## Note

Fonte: `llm-wiki/raw/backend/api/integration-map-20260519.md`. Non risultano chiamate HTTP runtime server-side per questi provider nel RAW letto.
