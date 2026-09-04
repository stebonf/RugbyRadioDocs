---
title: "ChannelsV1Controller (api)"
type: backend-api
layer: backend
---

# ChannelsV1Controller (api)

## Sintesi

Controller principale per la gestione dei canali di telecronaca. Espone endpoint per CRUD canale, gestione iscrizioni (follow/unfollow) e ricerca pubblica.

## Base route

`/v1/channels`

## Endpoints

- GET `/v1/channels` — lista canali dell'utente autenticato
- GET `/v1/channels/{channelId}` — dettaglio canale (owner)
- POST `/v1/channels` — crea canale
- PUT `/v1/channels/{channelId}` — aggiorna canale
- PUT `/v1/channels/{channelId}/layout` — aggiorna layout canale
- POST `/v1/channels/{channelId}/subscription` — toggle follow canale
- GET `/v1/channels/favorites` — canali seguiti dall'utente
- GET `/v1/channels/{publicId}/public` — profilo pubblico canale
- GET `/v1/channels/search` — ricerca canali pubblici (paginata)

## DTO input

- `ChannelAddDto`
- `ChannelUpdateDto`
- `ChannelLayoutUpdateDto`
- `ChannelSearchDto` (query params)

## DTO output

- `ChannelDto`
- `ChannelPublicDto` (con classifica, statistiche, follow count)
- `PageDto<ChannelPublicDto>`

## Backend services usati

- [[ChannelService (api)]]

## Regole auth

Endpoint di gestione richiedono autenticazione + verifica ownership (`VerifyAuthAsync`). Endpoint pubblico (`/public`, `/search`) accessibili senza token.

## Consumer FE

- [[ChannelsPage (web)]]
- [[ChannelPage (web)]]

## Workflow correlati

- [[Gestione Canale (workflow)]]

## Nome nel codice

`ChannelsV1Controller` — `src/RugbyRadio/Api/Controllers/ChannelsV1Controller.cs`

## Note

Non deducibile dai RAW disponibili.
