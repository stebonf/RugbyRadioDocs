---
title: "User (api)"
type: backend-entity
layer: backend
---

# User (api)

## Sintesi

Rappresenta l'account di un utente registrato. Supporta email/password e Google OAuth. Contiene token di attivazione, preferenze lingua/timezone, flag di stato e riferimento ai token notifiche push.

## Proprietà

- `Id`, `IsDeleted`, `Ts` (da EntityBase)
- `Nickname` (`string?`) — max 20 caratteri
- `Email` (`string?`) — lowercase
- `Password` (`string?`) — annotata come "criptata" (meccanismo non verificabile nel layer entity)
- `AvatarUrl` (`string?`)
- `ActivationToken` (`string?`) — GUID generato alla registrazione
- `Language` (`string?`)
- `CommentaryLanguage` (`string?`)
- `Timezone` (`string?`)
- `Provider` (`string?`) — es. `"Google"`
- `ProviderUserId` (`string?`)
- `IsVerified` (`bool`)
- `IsActive` (`bool`)

## Relazioni entity

- `UserToken` — uno-a-molti → `NotificationTokens`
- `Channel` — uno-a-molti (canali di cui è owner primario) → `Channels`

## Repository correlati

- [[UserRepository (api)]]

## Services correlati

- [[UserService (api)]]

## Workflow correlati

- [[Autenticazione Utente (workflow)]]

## Tabella DB

`[Table("Users")]`

## Nome nel codice

`User` — `src/RugbyRadio/Lib/Repositories/UserBox/User.cs`
