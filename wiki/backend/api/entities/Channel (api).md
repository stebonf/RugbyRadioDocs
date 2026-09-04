---
title: "Channel (api)"
type: backend-entity
layer: backend
---

# Channel (api)

## Sintesi

Rappresenta un canale di telecronaca creato da un utente. Aggregate root: espone `IsOwner(userId)` usato nei controlli di accesso. Contiene owner primario, co-owner, personalizzazione layout e flag canale di test.

## Proprietà

- `Id`, `IsDeleted`, `Ts` (da EntityBase)
- `PublicId` (`string?`) — identificativo pubblico per URL
- `UserId` (`string?`) — FK owner primario
- `Name` (`string?`)
- `HeaderBgColor`, `HeaderFtColor`, `HeaderTitle`, `HeaderSubtitle` (`string?`) — layout
- `ImageUrl` (`string?`)
- `IsTestChannel` (`bool?`)

## Relazioni entity

- `User` — molti-a-uno (owner primario) → FK `UserId`
- `ChannelUser` — uno-a-molti (co-owner) → `Owners`
- `Match` — uno-a-molti → `Matches`

## Repository correlati

- [[ChannelRepository (api)]]

## Services correlati

- [[ChannelService (api)]]

## Workflow correlati

- [[Gestione Canale (workflow)]]

## Tabella DB

`[Table("Channels")]`

## Nome nel codice

`Channel` — `src/RugbyRadio/Lib/Repositories/ChannelBox/Channel.cs`
