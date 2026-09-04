---
title: "Subscription (api)"
type: backend-entity
layer: backend
---

# Subscription (api)

## Sintesi

Rappresenta la sottoscrizione di un utente a un canale (follow canale) o a una partita (follow partita per notifiche push). I due casi sono distinti dai FK `ChannelId` / `MatchId`.

## Proprietà

- `Id` (`string`) — max 20 caratteri (validator)
- `UserId` (`string?`) — FK verso `User`, NotNull MaxLength 20
- `ChannelId` (`string?`) — FK verso `Channel`, MaxLength 20; valorizzato per follow canale
- `MatchId` (`string?`) — FK verso `Match`; valorizzato per follow partita
- `IsDeleted`, `Ts` (da EntityBase)

## Relazioni entity

- `Channel` — molti-a-uno → FK `ChannelId`
- `Match` — molti-a-uno → FK `MatchId`
- `User` — molti-a-uno → FK `UserId`

## Repository correlati

- [[SubscriptionRepository (api)]]

## Services correlati

- [[ChannelService (api)]] — follow canale
- [[MatchService (api)]] — follow partita

## Workflow correlati

Non deducibile

## Tabella DB

`[Table("Subscriptions")]`

## Nome nel codice

`Subscription` — `src/RugbyRadio/Lib/Repositories/SubscriptionBox/Subscription.cs`
