---
title: "ChannelUser (api)"
type: backend-entity
layer: backend
---

# ChannelUser (api)

## Sintesi

Rappresenta l'associazione tra un utente co-owner e un canale. Usata per gestire la lista di co-editor. `Channel.IsOwner(userId)` la interroga per autorizzazione.

## Proprietà

- `Id`, `IsDeleted`, `Ts` (da EntityBase)
- `ChannelId` (`string?`) — FK verso `Channel`
- `UserId` (`string?`) — FK verso `User` (co-owner)

## Relazioni entity

- `Channel` — molti-a-uno → FK `ChannelId`
- `User` — molti-a-uno → FK `UserId`

## Repository correlati

- [[ChannelRepository (api)]] — include `Owners` nelle query
- [[ChannelUserRepository (api)]] — persistenza diretta

## Services correlati

- [[ChannelService (api)]]

## Workflow correlati

- [[Gestione Canale (workflow)]]

## Tabella DB

`[Table("ChannelUsers")]`

## Nome nel codice

`ChannelUser` — `src/RugbyRadio/Lib/Repositories/ChannelUserBox/ChannelUser.cs`
