---
title: "MatchEventsV1Controllers (api)"
type: backend-api
layer: backend
---

# MatchEventsV1Controllers (api)

## Sintesi

Controller per creazione e cancellazione degli eventi di una partita.

## Base route

`/v1/matches/{matchId}/events`

## Endpoints

- POST `/v1/matches/{matchId}/events` - crea evento partita
- DELETE `/v1/matches/{matchId}/events/{eventId}` - elimina evento partita

## DTO input

- `MatchEventAddDto`

## DTO output

- `MatchDto`

## Backend services usati

- [[MatchService (api)]]

## Regole auth

Entrambi gli endpoint sono protetti con `[Authorize]` e verificano ownership tramite `MatchService.VerifyAuthAsync`.

## Consumer FE

- [[MatchService (web)]]

## Workflow correlati

- [[Cronista Telecronaca (workflow)]]

## Note

Nome nel codice: `MatchEventsV1Controllers`. Evidenza da `api-map-20260514.md` e `auth-security-map-20260514.md`.

