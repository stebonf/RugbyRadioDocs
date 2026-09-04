---
title: "BlogV1Controller (api)"
type: backend-api
layer: backend
---

# BlogV1Controller (api)

## Sintesi

Controller per la lettura del blog di partita. Espone endpoint pubblici per lista paginata e post singolo. La lingua viene letta dall'header HTTP tramite `HeaderHelper.GetLanguage`.

## Base route

`/v1/blog`

## Endpoints

- GET `/v1/blog` — lista paginata post blog, filtrata per lingua (BLOG-01) — `[AllowAnonymous]`
- GET `/v1/blog/{matchId}` — post blog per partita e lingua (BLOG-02) — `[AllowAnonymous]`

## DTO input

- `page` (query param int) — BLOG-01

## DTO output

- `PageDto<BlogDto>` — BLOG-01
- `BlogDto` — BLOG-02

## Backend services usati

- [[BlogService (api)]]

## Regole auth

Entrambi gli endpoint `[AllowAnonymous]`. Accesso pubblico.

## Consumer FE

Non deducibile

## Workflow correlati

- [[Pubblicazione Blog Statico (workflow)]]

## Nome nel codice

`BlogV1Controller` — `src/RugbyRadio/Api/Controllers/BlogV1Controller.cs`

## Note

Non deducibile dai RAW disponibili.
