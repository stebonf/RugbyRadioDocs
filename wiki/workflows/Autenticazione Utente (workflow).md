---
title: "Autenticazione Utente (workflow)"
type: workflow
layer: workflow
---

# Autenticazione Utente (workflow)

## Obiettivo

Permettere a un utente di registrarsi, autenticarsi, recuperare la password e gestire il profilo autenticato.

## Trigger

L'utente apre una pagina di login, registrazione, reset password o profilo.

## Attori

- [[Cronista (actor)]]
- [[Spettatore (actor)]]

## Frontend coinvolto

- [[LoginPage (web)]]
- [[RegistrationPage (web)]]
- [[ResetPasswordPage (web)]]
- [[ProfilePage (web)]]
- [[UserService (web)]]

## Backend coinvolto

- [[AuthV1Controller (api)]]
- [[UserV1Controller (api)]]
- [[UserService (api)]]
- [[GoogleOAuth (api)]]
- [[SmtpEmail (api)]]
- [[JwtBearerAuthentication (api)]]

## Data coinvolti

- [[User (api)]]
- [[UserToken (api)]]
- [[UserOtpCode (api)]]

## Analytics tracking

- [[Platform Stats 2026-05-13 (analytic)]]

## Failure points

- Credenziali email e password non valide.
- Google ID Token non valido.
- Codice OTP non valido, scaduto o gia usato.
- Invio email OTP non riuscito.
- Token JWT assente o non valido per le pagine protette.

## Gap noti

- Dettaglio completo degli eventi analytics del workflow non deducibile dalla wiki.
- Politiche esatte di validazione password e registrazione non deducibili dalla wiki.

## Note

Workflow creato da pagine wiki esistenti e suggerimento lint. Lo spettatore puo seguire una partita anche senza account, ma alcune interazioni sono documentate come disponibili quando autenticato.
