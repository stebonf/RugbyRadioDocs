---
title: "Mappatura Account e Profilo Utente (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Account e Profilo Utente (comparison)

## Sintesi

Mappa il ciclo account e profilo utente tra frontend, API, servizi backend, integrazioni e dati. Il dominio utente collega registrazione, login, reset password OTP, sessione JWT, preferenze, notifiche push, feedback e cancellazione account.

## Scope

La pagina confronta le superfici documentate intorno a [[Utente (concept)]], senza introdurre regole di sicurezza non presenti nella wiki.

## Flussi account

| Flusso | Frontend | API | Servizio backend | Dati/Integrazioni |
|---|---|---|---|---|
| Registrazione email/password | [[RegistrationPage (web)]] | [[AuthV1Controller (api)]] | [[UserService (api)]] | [[User (api)]], [[UserToken (api)]] |
| Login email/password | [[LoginPage (web)]] | [[AuthV1Controller (api)]] | [[UserService (api)]] | JWT, [[UserToken (api)]], [[JwtBearerAuthentication (api)]] |
| Login Google | [[LoginPage (web)]] | [[AuthV1Controller (api)]] | [[UserService (api)]] | [[GoogleOAuth (api)]], [[User (api)]] |
| Reset password OTP | [[LoginPage (web)]], [[ResetPasswordPage (web)]] | [[AuthV1Controller (api)]] | [[UserService (api)]], [[EmailService (api)]] | [[UserOtpCode (api)]], [[SmtpEmail (api)]] |
| Profilo e preferenze | [[ProfilePage (web)]] | [[UserV1Controller (api)]] | [[UserService (api)]] | [[User (api)]], localStorage frontend |
| Token notifiche | [[ProfilePage (web)]], [[UserService (web)]] | [[UserV1Controller (api)]] | [[UserService (api)]] | [[UserToken (api)]], [[FirebaseFCM (api)]] |
| Feedback | [[GFeedbackPage (web)]] | [[UserV1Controller (api)]] | [[EmailService (api)]] | [[SmtpEmail (api)]] |
| Cancellazione account | [[DangerPage (web)]] | [[UserV1Controller (api)]] | [[UserService (api)]] | Pseudonimizzazione email in [[User (api)]] |

## Confini di accesso

- [[AuthV1Controller (api)]] espone endpoint pubblici per registrazione, attivazione, login, login Google, forgot password e cambio password OTP.
- [[UserV1Controller (api)]] protegge profilo, aggiornamento, cancellazione, token notifiche e feedback con `[Authorize]`; la lista avatar e pubblica.
- [[AuthGuardService (web)]] protegge le pagine `/user-*` che richiedono sessione.
- [[UserService (web)]] persiste il JWT in localStorage e ripristina la sessione all'avvio dell'app.
- [[LoginCallbackService (web)]] gestisce il ritorno dopo login, registrazione o cambio password.

## Preferenze e stato locale

[[UserService (web)]] mantiene `isLoggedIn$`, `userNickname$` e `isSplashVisible$`, oltre a token JWT, dati profilo, lingua e commentator selezionato. La wiki distingue le preferenze salvate sul profilo utente da quelle gestite in localStorage, come il commentator per la telecronaca.

## Rischi e limiti documentati

- [[Utente (concept)]] segnala token JWT con scadenza lunga, secret key in chiaro, CORS aperto e `RequireHttpsMetadata: false`.
- Criteri password, rate limiting su login/OTP e politiche di refresh token non sono deducibili.
- Il feedback e documentato come pagina pubblica, ma l'endpoint wiki di [[UserV1Controller (api)]] riporta `[Authorize]`: questa discrepanza richiede verifica implementativa prima di modifiche funzionali.

## Workflow correlati

- [[Autenticazione Utente (workflow)]]
- [[Spettatore Partita (workflow)]]
- [[Cronista Telecronaca (workflow)]]
- [[Gestione Canale (workflow)]]

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`. Non sono state lette fonti RAW.
