---
title: "MatchEventRepository (api)"
type: backend-repository
layer: backend
---

# MatchEventRepository (api)

## Sintesi

Repository per gli eventi di telecronaca. Supporta ricerca per partita, per data (finestra temporale) e recupero singolo evento.

## Responsabilità

- Ricerca eventi per partita
- Ricerca eventi per finestra temporale (`FindByTsAsync`)
- Lookup evento per ID

## Entities gestite

- [[MatchEvent (api)]]

## Query rilevanti

- `FindByMatchIdAsync(matchId)` — tutti gli eventi di una partita
- `FindByTsAsync(ts)` — eventi da una data in poi (usato da job AI)
- `GetByIdAsync(eventId)` — evento singolo

## Consumer

- [[MatchService (api)]]
- [[AdminV1Controller (api)]]
- [[CreateMatchEventJob (api)]]
- [[VoiceService (api)]]

## Nome nel codice

`MatchEventRepository` — `src/RugbyRadio/Lib/Repositories/MatchEventBox/MatchEventRepository.cs`
