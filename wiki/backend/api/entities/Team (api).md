---
title: "Team (api)"
type: backend-entity
layer: backend
---

# Team (api)

## Sintesi

Rappresenta una squadra di rugby associata a un canale. Usata come `HomeTeam` e `AwayTeam` nelle partite. Contiene nome, logo e soprannome.

## Proprietà

- `Id`, `IsDeleted`, `Ts` (da EntityBase)
- `ChannelId` (`string?`) — FK verso `Channel`
- `Name` (`string?`)
- `LogoUrl` (`string?`)
- `Nickname` (`string?`)

## Relazioni entity

- `Channel` — molti-a-uno → FK `ChannelId`

## Repository correlati

- [[TeamRepository (api)]]

## Services correlati

- [[TeamService (api)]]

## Workflow correlati

Non deducibile

## Tabella DB

`[Table("Teams")]`

## Nome nel codice

`Team` — `src/RugbyRadio/Lib/Repositories/TeamBox/Team.cs`
