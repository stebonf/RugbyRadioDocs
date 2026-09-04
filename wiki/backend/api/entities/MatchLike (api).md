---
title: "MatchLike (api)"
type: backend-entity
layer: backend
---

# MatchLike (api)

## Sintesi

Rappresenta il like assegnato da un utente a una partita.

## Proprietà

- `Id` (`string`) — max 20 caratteri, NotNull
- `MatchId` (`string?`) — FK verso `Match`, NotNull MaxLength 20
- `UserId` (`string?`) — FK verso `User`, NotNull MaxLength 20
- `IsDeleted`, `Ts` (da EntityBase)

## Relazioni entity

- `Match` — molti-a-uno → FK `MatchId`
- `User` — molti-a-uno → FK `UserId`

## Repository correlati

- [[MatchLikeRepository (api)]]

## Services correlati

- [[MatchService (api)]]

## Workflow correlati

Non deducibile

## Tabella DB

Attributo `[Table]` assente nel codice letto. Probabile `MatchLikes` per convenzione EF Core.

## Nome nel codice

`MatchLike` — `src/RugbyRadio/Lib/Repositories/MatchLikeBox/MatchLike.cs`
