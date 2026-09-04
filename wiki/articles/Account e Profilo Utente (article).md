---
title: "Account e Profilo Utente (article)"
type: article
layer: concept
---

# Account e Profilo Utente (article)

## Sintesi

Il ciclo account copre registrazione, login, login Google, reset password OTP, profilo, notifiche, feedback e cancellazione account.

## Scope

Questa pagina raccoglie le superfici account gia mappate in wiki senza introdurre regole di sicurezza non documentate.

## Componenti coinvolti

- [[Autenticazione Utente (workflow)]]
- [[Mappatura Account e Profilo Utente (comparison)]]
- [[LoginPage (web)]]
- [[RegistrationPage (web)]]
- [[ResetPasswordPage (web)]]
- [[ProfilePage (web)]]
- [[DangerPage (web)]]
- [[AuthV1Controller (api)]]
- [[UserV1Controller (api)]]
- [[UserService (api)]]
- [[UserService (web)]]

## Relazioni principali

- [[AuthV1Controller (api)]] espone registrazione, login, login Google e reset password OTP.
- [[UserV1Controller (api)]] copre profilo, token notifiche, feedback e cancellazione account.
- [[UserService (web)]] mantiene sessione, profilo, lingua e preferenze locali.
- [[AuthGuardService (web)]] protegge le pagine `/user-*`.

## Note

Articolo creato usando solo pagine wiki esistenti. Criteri password, rate limiting, refresh token e completa policy feedback non sono deducibili.

