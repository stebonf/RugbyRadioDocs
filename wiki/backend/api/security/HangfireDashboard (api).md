---
title: "HangfireDashboard (api)"
type: backend-security
layer: backend
---

# HangfireDashboard (api)

## Sintesi

Superficie operativa Hangfire esposta tramite `UseHangfireDashboard()` nel bootstrap HF.

## Responsabilità

Rende disponibile la dashboard Hangfire per osservare o gestire job, secondo configurazione runtime non completamente deducibile dai RAW letti.

## Regole auth

Non deducibile dai soli file modificati dopo il 2026-05-14. Nel RAW letto non risultano filtri autorizzativi espliciti collegati a `UseHangfireDashboard()`.

## Policies

Non deducibile.

## Consumer

- [[GenerateSeoSitemapJob (api)]]
- [[CreateMatchBlogHtmlJob (api)]]

## Note

Fonte: `llm-wiki/raw/backend/api/auth-security-map-20260519.md`. Non classificato come endpoint API pubblico/protetto per assenza di attributi endpoint/API nei RAW letti.
