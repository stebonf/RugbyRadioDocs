---
title: "TeamRepository (api)"
type: backend-repository
layer: backend
---

# TeamRepository (api)

## Sintesi

Repository per le squadre. Supporta ricerca per canale e lookup per ID.

## Responsabilità

- Ricerca squadre per canale
- Lookup squadra per ID

## Entities gestite

- [[Team (api)]]

## Query rilevanti

- `FindByChannelAsync(channelId)` — squadre di un canale
- `GetByIdAsync(teamId)` — squadra singola

## Consumer

- [[TeamService (api)]]
- [[ChannelService (api)]]

## Nome nel codice

`TeamRepository` — `src/RugbyRadio/Lib/Repositories/TeamBox/TeamRepository.cs`
