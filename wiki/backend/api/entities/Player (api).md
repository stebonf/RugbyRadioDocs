---
title: "Player (api)"
type: backend-entity
layer: backend
---

# Player (api)

## Sintesi

Rappresenta un giocatore anagrafico associato a una squadra. Contiene nome, soprannome, avatar e numero di maglia di default. Viene associato alle formazioni tramite `LineupPlayer`.

## Proprietà

- `Id`, `IsDeleted`, `Ts` (da EntityBase)
- `TeamId` (`string?`) — FK verso `Team`
- `Name` (`string?`)
- `Nickname` (`string?`)
- `AvatarUrl` (`string?`)
- `DefaultNumber` (`int?`) — numero maglia di default in formazione

## Relazioni entity

- `Team` — molti-a-uno → FK `TeamId`

## Repository correlati

- [[PlayerRepository (api)]]

## Services correlati

- [[PlayerService (api)]]

## Workflow correlati

Non deducibile

## Tabella DB

`[Table("Players")]`

## Nome nel codice

`Player` — `src/RugbyRadio/Lib/Repositories/PlayerBox/Player.cs`
