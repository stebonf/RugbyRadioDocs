---
title: "LineupPlayer (api)"
type: backend-entity
layer: backend
---

# LineupPlayer (api)

## Sintesi

Rappresenta la posizione di un giocatore in formazione per una partita. Collega `Match`, `Team` e `Player` con un numero di ruolo (1..23). Referenziata dagli eventi per indicare i giocatori coinvolti.

## Proprietà

- `Id`, `IsDeleted`, `Ts` (da EntityBase)
- `MatchId` (`string?`) — FK verso `Match`
- `TeamId` (`string?`) — FK verso `Team`
- `PlayerId` (`string?`) — FK verso `Player` (può essere null se ruolo vuoto)
- `Number` (`int`) — numero ruolo in formazione

## Relazioni entity

- `Player` — molti-a-uno → FK `PlayerId`
- `Match` — molti-a-uno → FK `MatchId` (navigation inversa `Match.LineupPlayers`)
- `Team` — molti-a-uno → FK `TeamId`

## Repository correlati

- [[LineupPlayerRepository (api)]]

## Services correlati

- [[LineupPlayerService (api)]]
- [[MatchService (api)]]

## Workflow correlati

Non deducibile

## Tabella DB

`[Table("LineupPlayers")]`

## Nome nel codice

`LineupPlayer` — `src/RugbyRadio/Lib/Repositories/LineupPlayerBox/LineupPlayer.cs`
