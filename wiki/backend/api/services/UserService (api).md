---
title: "UserService (api)"
type: backend-service
layer: backend
---

# UserService (api)

## Sintesi

Gestisce il ciclo di vita completo dell'utente: registrazione email/Google OAuth, attivazione account via token, login e generazione JWT, reset password OTP, aggiornamento profilo e timezone, token notifiche push, cancellazione con pseudonimizzazione.

## Responsabilità

- Registrazione utente (email/password e Google OAuth)
- Attivazione account via `ActivationToken`
- Login e generazione token JWT (HmacSha256, scadenza da config)
- Reset password via codice OTP 6 cifre (scadenza 1 ora)
- Aggiornamento profilo (nickname, avatar, language, timezone)
- Salvataggio token FCM per notifiche push
- Cancellazione account con pseudonimizzazione (email → `{id}@deleted.rrl`)

## Consumer

- [[AuthV1Controller (api)]]
- [[UserV1Controller (api)]]
- [[MatchesV1Controller (api)]]
- [[CreateTrainingChannelJob (api)]]

## Repository usati

- `IUserRepository`
- `IChannelRepository`
- [[UserTokenRepository (api)]]
- [[UserOtpCodeRepository (api)]]
- `ISubscriptionRepository`
- `IUnitOfWork`

## Integrazioni usate

- [[GoogleOAuth (api)]] — validazione Google ID Token in `RegisterNewGoogleUserAsync`
- [[SmtpEmail (api)]] — invio OTP reset password (tramite `IEmailService`)

## Jobs usati

Nessuno diretto

## Entities coinvolte

- [[User (api)]]
- [[UserToken (api)]]
- [[UserOtpCode (api)]]

## Workflow correlati

- [[Autenticazione Utente (workflow)]]

## Side effects

- Scrittura DB: `User`, `UserToken`, `UserOtpCode`
- Invio email OTP

## Nome nel codice

`UserService` — `src/RugbyRadio/Lib/Repositories/UserBox/UserService.cs`

## Note

Non deducibile dai RAW disponibili.
