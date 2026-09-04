---
title: "ChannelUsersV1Controller (api)"
type: backend-api
layer: backend
---

# ChannelUsersV1Controller (api)

## Sintesi

Controller per la gestione dei co-editor (co-owner) di un canale. Permette all'owner di aggiungere, listare e rimuovere utenti co-editor.

## Base route

`/v1/channels/{channelId}/users`

## Endpoints

- GET `/v1/channels/{channelId}/users` — lista co-editor del canale (CUS-01)
- POST `/v1/channels/{channelId}/users` — aggiunge co-editor per email (CUS-02)
- DELETE `/v1/channels/{channelId}/users/{userId}` — rimuove co-editor (CUS-03)

## DTO input

- `ChannelUserAddDto` — email del nuovo co-editor (CUS-02)

## DTO output

- `IList<ChannelUserDto>` (CUS-01)
- `ChannelUserDto` (CUS-02)

## Backend services usati

- [[ChannelService (api)]]

## Regole auth

Tutti gli endpoint richiedono autenticazione. `VerifyAuthAsync` verifica che l'utente corrente sia owner del canale.

## Consumer FE

Non deducibile

## Workflow correlati

Non deducibile

## Nome nel codice

`ChannelUsersV1Controller` — `src/RugbyRadio/Api/Controllers/ChannelUsersV1Controller.cs`

## Note

Non deducibile dai RAW disponibili.
