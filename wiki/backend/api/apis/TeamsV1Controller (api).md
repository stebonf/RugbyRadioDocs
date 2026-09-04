---
title: "TeamsV1Controller (api)"
type: backend-api
layer: backend
---

# TeamsV1Controller (api)

## Sintesi

Controller per la gestione delle squadre associate ai canali. Espone CRUD squadra e recupero loghi disponibili.

## Base route

`/v1` (route completa: `/v1/channels/{channelId}/teams/...`)

## Endpoints

- GET `/v1/channels/{channelId}/teams` — lista squadre del canale (TMS-01) — `[Authorize]`
- POST `/v1/channels/{channelId}/teams` — crea squadra (TMS-02) — `[Authorize]`
- PUT `/v1/channels/{channelId}/teams/{teamId}` — aggiorna squadra (TMS-03) — `[Authorize]`
- GET `/v1/teams/logos` — lista loghi disponibili (TMS-04) — pubblico
- GET `/v1/teams/{teamId}` — profilo pubblico squadra (TMS-05) — pubblico

## DTO input

- `TeamAddDto`
- `TeamUpdateDto`

## DTO output

- `IList<TeamChannelDto>`
- `Team`
- `TeamPublicDto`
- `IDictionary<long, string>` (loghi)

## Backend services usati

- [[TeamService (api)]]

## Regole auth

Endpoint di gestione `[Authorize]` + `VerifyAuthAsync`. Endpoint di lettura pubblica accessibili senza token.

## Consumer FE

- [[GTeamPage (web)]]
- [[TeamService (web)]]

## Workflow correlati

Non deducibile

## Nome nel codice

`TeamsV1Controller` — `src/RugbyRadio/Api/Controllers/TeamsV1Controller.cs`

## Note

Consumer FE dedotto da `llm-wiki/raw/docs/rrl-team.md`.
