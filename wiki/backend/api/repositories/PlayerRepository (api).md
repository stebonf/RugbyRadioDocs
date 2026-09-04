---
title: "PlayerRepository (api)"
type: backend-repository
layer: backend
---

# PlayerRepository (api)

## Sintesi

Repository per i giocatori. Supporta ricerca per squadra e lookup per ID.

## Responsabilità

- Ricerca giocatori per squadra
- Lookup giocatore per ID

## Entities gestite

- [[Player (api)]]

## Query rilevanti

- `FindByTeamAsync(teamId)` — giocatori di una squadra
- `GetByIdAsync(playerId)` — giocatore singolo

## Consumer

- [[PlayerService (api)]]
- [[LineupPlayerService (api)]]

## Nome nel codice

`PlayerRepository` — `src/RugbyRadio/Lib/Repositories/PlayerBox/PlayerRepository.cs`
