---
title: "LineupPlayerRepository (api)"
type: backend-repository
layer: backend
---

# LineupPlayerRepository (api)

## Sintesi

Repository per le formazioni di partita. Supporta insert batch e ricerca per partita.

## Responsabilità

- Insert batch di 23 slot formazione (`InsertRangeAsync`)
- Ricerca slot formazione per partita

## Entities gestite

- [[LineupPlayer (api)]]

## Query rilevanti

- `InsertRangeAsync(lineupPlayers)` — insert batch (23 record)
- Ricerca formazione per partita e squadra

## Consumer

- [[LineupPlayerService (api)]]
- [[MatchService (api)]]

## Nome nel codice

`LineupPlayerRepository` — `src/RugbyRadio/Lib/Repositories/LineupPlayerBox/LineupPlayerRepository.cs`
