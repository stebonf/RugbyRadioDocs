---
title: "PlayersV1Controller (api)"
type: backend-api
layer: backend
---

# PlayersV1Controller (api)

## Sintesi

Controller per la gestione dell'anagrafica giocatori. Tutti gli endpoint richiedono autenticazione. Solo l'owner primario del canale può gestire i giocatori (non i co-owner).

## Base route

`/v1` (route completa: `/v1/channels/{channelId}/teams/{teamId}/players/...`)

## Endpoints

- GET `/v1/channels/{channelId}/teams/{teamId}/players` — lista giocatori squadra
- POST `/v1/channels/{channelId}/teams/{teamId}/players` — crea giocatore
- PUT `/v1/channels/{channelId}/teams/{teamId}/players/{playerId}` — aggiorna giocatore
- DELETE `/v1/channels/{channelId}/teams/{teamId}/players/{playerId}` — elimina giocatore

## DTO input

- `PlayerSaveDto`

## DTO output

- `IList<Player>` / `Player`

## Backend services usati

- [[PlayerService (api)]]

## Regole auth

Tutti gli endpoint `[Authorize]`. `PlayerService.VerifyAuthAsync` verifica ownership primario (solo `channel.UserId`, non co-owner).
La cancellazione `DELETE /v1/channels/{channelId}/teams/{teamId}/players/{playerId}` verifica anche che il `playerId` appartenga al `teamId` della route prima del soft-delete.

## Consumer FE

Non deducibile

## Workflow correlati

Non deducibile

## Nome nel codice

`PlayersV1Controller` — `src/RugbyRadio/Api/Controllers/PlayersV1Controller.cs`

## Note

Non deducibile dai RAW disponibili.
