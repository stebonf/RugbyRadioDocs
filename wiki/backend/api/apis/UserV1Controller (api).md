---
title: "UserV1Controller (api)"
type: backend-api
layer: backend
---

# UserV1Controller (api)

## Sintesi

Controller per la gestione del profilo utente autenticato. Copre: recupero/aggiornamento profilo, avatar, timezone, token notifiche push, cancellazione account, feedback.

## Base route

`/v1/user`

## Endpoints

- GET `/v1/user/avatars` — lista avatar disponibili
- GET `/v1/user` — profilo utente corrente — `[Authorize]`
- PUT `/v1/user` — aggiorna profilo — `[Authorize]`
- DELETE `/v1/user` — cancella account (pseudonimizzazione) — `[Authorize]`
- POST `/v1/user/notification-token` — salva token FCM — `[Authorize]`
- POST `/v1/user/feedback` — invia email di feedback — `[Authorize]`

## DTO input

- `UserUpdateDto`
- `UserNotificationTokenDto`
- `UserFeedbackDto`

## DTO output

- `IDictionary<long, string>` (avatar)
- `UserProfileDto`

## Backend services usati

- [[UserService (api)]]
- [[EmailService (api)]]

## Regole auth

Endpoint di modifica richiedono `[Authorize]`. Avatar pubblici.

## Consumer FE

- [[ProfilePage (web)]]

## Workflow correlati

- [[Autenticazione Utente (workflow)]]

## Nome nel codice

`UserV1Controller` — `src/RugbyRadio/Api/Controllers/UserV1Controller.cs`

## Note

Non deducibile dai RAW disponibili.
