---
title: "PlayerService (api)"
type: backend-service
layer: backend
---

# PlayerService (api)

## Sintesi

Gestisce il ciclo di vita dei giocatori. Verifica ownership solo per owner primario del canale (non co-owner). Supporta CRUD giocatore e assegnazione avatar di default.

## Responsabilità

- Creazione giocatore con avatar di default (`/images/avatars/players/{n}.png`)
- Aggiornamento ed eliminazione giocatore
- Eliminazione giocatore vincolata alla squadra richiesta: `DeletePlayerAsync(teamId, playerId)` rifiuta giocatori appartenenti ad altro team
- Ricerca giocatori per squadra
- `VerifyAuthAsync`: verifica `channel.UserId == userId` (solo owner primario)

## Consumer

- [[PlayersV1Controller (api)]]

## Repository usati

- `IPlayerRepository`
- `ITeamRepository`
- `IChannelRepository`
- `IUnitOfWork`

## Integrazioni usate

Nessuna

## Jobs usati

Nessuno diretto

## Entities coinvolte

- [[Player (api)]]
- [[Team (api)]]

## Workflow correlati

Non deducibile

## Side effects

- Scrittura DB: `Player`

## Nome nel codice

`PlayerService` — `src/RugbyRadio/Lib/Repositories/PlayerBox/PlayerService.cs`

## Note

Non deducibile dai RAW disponibili.
