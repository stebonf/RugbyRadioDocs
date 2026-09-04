---
title: "MatchEvent (api)"
type: backend-entity
layer: backend
---

# MatchEvent (api)

## Sintesi

Rappresenta un singolo evento di telecronaca in una partita (meta, punizione, calcio d'inizio, segnali arbitro, ecc.). Contiene tipo evento, minuto, zona campo, riferimento ai giocatori coinvolti e commento libero.

## Proprietà

- `Id`, `IsDeleted`, `Ts` (da EntityBase)
- `MatchId` (`string?`) — FK verso `Match`
- `TeamId` (`string?`) — FK verso `Team`
- `LineupPlayerId` (`string?`) — FK giocatore principale
- `LineupPlayer2Id` (`string?`) — FK secondo giocatore
- `Territory` (`TerritoryType?`) — zona campo (enum, stored as int)
- `Type` (`MatchEventType`) — tipo evento (enum, stored as int)
- `Minute` (`int`)
- `TypeVersion` (`int`) — versione messaggio per l'evento
- `Comment` (`string?`) — commento libero

## Relazioni entity

- `Match` — molti-a-uno → FK `MatchId`
- `LineupPlayer` — molti-a-uno (giocatore principale) → FK `LineupPlayerId`

## Repository correlati

- [[MatchEventRepository (api)]]

## Services correlati

- [[MatchService (api)]]

## Workflow correlati

Non deducibile

## Tabella DB

`[Table("Events")]`

## Nome nel codice

`MatchEvent` — `src/RugbyRadio/Lib/Repositories/MatchEventBox/MatchEvent.cs`
