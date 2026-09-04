---
title: "AuthV1Controller (api)"
type: backend-api
layer: backend
---

# AuthV1Controller (api)

## Sintesi

Controller per autenticazione e gestione account utente. Espone endpoint pubblici per registrazione, login email/password, login Google OAuth, attivazione account, reset password OTP.

## Base route

`/v1/auth`

## Endpoints

- POST `/v1/auth/users` — registrazione nuovo utente (ATH-01)
- PUT `/v1/auth/users` — attivazione account via token (ATH-02)
- POST `/v1/auth/user/login` — login email/password (ATH-03)
- POST `/v1/auth/users/google` — login/registrazione Google OAuth (ATH-04)
- POST `/v1/auth/users/forgot` — forgot password (ATH-05)
- POST `/v1/auth/users/password` — cambio password via OTP (ATH-06)

## DTO input

- `UserRegisterDto` (ATH-01)
- `UserLoginDto` (ATH-03)
- `UserGoogleRegisterDto` (ATH-04)

## DTO output

- `UserTokenDto` — token JWT + profilo base (ATH-01, ATH-03, ATH-04)
- `UserMinDto` (ATH-02)

## Backend services usati

- [[UserService (api)]]
- [[RugbyRadioLiveService (api)]]

## Regole auth

Tutti gli endpoint sono pubblici (nessun `[Authorize]`). Login Google OAuth richiede Google ID Token nel body.

## Consumer FE

- [[LoginPage (web)]]
- [[RegistrationPage (web)]]
- [[ResetPasswordPage (web)]]

## Workflow correlati

- [[Autenticazione Utente (workflow)]]

## Nome nel codice

`AuthV1Controller` — `src/RugbyRadio/Api/Controllers/AuthV1Controller.cs`

## Note

Non deducibile
