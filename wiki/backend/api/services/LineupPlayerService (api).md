---
title: "LineupPlayerService (api)"
type: backend-service
layer: backend
---

# LineupPlayerService (api)

## Sintesi

Crea la formazione di default per una partita: genera 23 slot `LineupPlayer` (ruoli 1..23) assegnando i giocatori per numero di maglia. Se per un ruolo non esiste giocatore con quel numero → `PlayerId = null`.

## Responsabilità

- Creazione batch di 23 slot `LineupPlayer` per una partita e una squadra
- Assegnazione giocatore per `DefaultNumber` corrispondente al ruolo

## Consumer

- [[MatchesV1Controller (api)]]
- [[RugbyRadioLiveService (api)]]

## Repository usati

- `ILineupPlayerRepository`
- `IPlayerRepository`
- `IUnitOfWork`

## Integrazioni usate

Nessuna

## Jobs usati

Nessuno diretto

## Entities coinvolte

- [[LineupPlayer (api)]]
- [[Player (api)]]

## Workflow correlati

Non deducibile

## Side effects

- Scrittura DB: 23 record `LineupPlayer` per esecuzione

## Nome nel codice

`LineupPlayerService` — `src/RugbyRadio/Lib/Repositories/LineupPlayerBox/LineupPlayerService.cs`

## Note

Non deducibile dai RAW disponibili.
