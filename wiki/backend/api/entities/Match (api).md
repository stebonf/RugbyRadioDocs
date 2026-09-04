---
title: "Match (api)"
type: backend-entity
layer: backend
---

# Match (api)

## Sintesi

Aggregate root del contesto di telecronaca. Rappresenta una partita con dati anagrafici (canale, squadre, data, stadio), statistiche aggregate (punteggio, possesso, zone campo), stato e flag di archiviazione.

## Proprietà

- `Id`, `IsDeleted`, `Ts` (da EntityBase)
- `ChannelId`, `HomeTeamId`, `AwayTeamId`, `StadiumId` (`string?`) — FK
- `Timezone`, `ImageUrl`, `Gender` (`string?`)
- `Date` (`DateTime`), `DateUtc` (`DateTime`)
- `Status` (`MatchStatus?`) — `Scheduled=10`, `InProgress=20`, `Halftime=25`, `FullTime=30`
- `HomeScore`, `AwayScore`, `Minute`, `HalfMinutes` (`int`)
- `HomePossession`, `AwayPossession` (`int`)
- `Zone1`, `Zone2`, `Zone3`, `Zone4` (`int`) — zone campo
- `IsArchived` (`bool?`)

## Relazioni entity

- `Channel` — molti-a-uno → FK `ChannelId`
- `Team` (HomeTeam) — molti-a-uno → FK `HomeTeamId`
- `Team` (AwayTeam) — molti-a-uno → FK `AwayTeamId`
- `Comment` — uno-a-molti → `Comments`
- `MatchEvent` — uno-a-molti → `Events`
- `LineupPlayer` — uno-a-molti → `LineupPlayers`
- `Blog` — uno-a-molti → `Blogs`

## Repository correlati

- [[MatchRepository (api)]]

## Services correlati

- [[MatchService (api)]]

## Workflow correlati

Non deducibile

## Tabella DB

`[Table("Matches")]`

## Nome nel codice

`Match` — `src/RugbyRadio/Lib/Repositories/MatchBox/Match.cs`

## Note

Non deducibile
