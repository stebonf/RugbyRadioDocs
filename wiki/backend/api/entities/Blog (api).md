---
title: "Blog (api)"
type: backend-entity
layer: backend
---

# Blog (api)

## Sintesi

Rappresenta un post di blog generato per una partita terminata. Ogni partita può avere più post (uno per lingua). Contiene titolo, corpo, lingua e flag di stato (staticizzato, pubblicato su Facebook).

## Proprietà

- `Id` (`string`) — max 20 caratteri
- `MatchId` (`string?`) — FK verso `Match`, NotNull MaxLength 20
- `Language` (`string?`) — codice ISO 2 caratteri (IT, EN, FR, ES, JA), NotNull MaxLength 2
- `Title` (`string?`) — NotNull MaxLength 100
- `Body` (`string?`) — NotNull
- `IsBlogStatic` (`bool?`) — `true` se staticizzato come HTML
- `IsFacebookPosted` (`bool?`) — `true` se pubblicato su Facebook
- `IsDeleted`, `Ts` (da EntityBase)

## Relazioni entity

- `Match` — molti-a-uno → FK `MatchId`

## Repository correlati

- [[BlogRepository (api)]]

## Services correlati

- [[BlogService (api)]]
- [[AiOllamaService (api)]]

## Workflow correlati

- [[Pubblicazione Blog Statico (workflow)]]

## Tabella DB

`[Table("Blog")]`

## Nome nel codice

`Blog` — `src/RugbyRadio/Lib/Repositories/BlogBox/Blog.cs`
