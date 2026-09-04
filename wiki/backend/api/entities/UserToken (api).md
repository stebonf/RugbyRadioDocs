---
title: "UserToken (api)"
type: backend-entity
layer: backend
---

# UserToken (api)

## Sintesi

Rappresenta un token per le notifiche push (FCM) associato a un utente. Un utente può avere più token (dispositivi multipli).

## Proprietà

- `Id` (`string`) — max 20 caratteri, NotNull
- `UserId` (`string?`) — FK verso `User`, NotNull MaxLength 20
- `Token` (`string?`) — token notifica push, NotNull
- `IsDeleted`, `Ts` (da EntityBase)

## Relazioni entity

- `User` — molti-a-uno → FK `UserId` (navigation inversa `User.NotificationTokens`)

## Repository correlati

- [[UserTokenRepository (api)]]

## Services correlati

- [[UserService (api)]]

## Workflow correlati

- [[Autenticazione Utente (workflow)]]

## Tabella DB

`[Table("UserTokens")]`

## Nome nel codice

`UserToken` — `src/RugbyRadio/Lib/Repositories/UserTokens/UserToken.cs`
