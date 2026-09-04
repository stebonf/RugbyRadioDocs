---
title: "Utente (concept)"
type: concept
layer: concept
---

# Utente (concept)

## Sintesi

Rappresentazione digitale di una persona fisica sulla piattaforma [[Rugby Radio Live (product)]]. Un utente può essere registrato (con account) o anonimo. Gli utenti registrati si distinguono in [[Cronista (actor)]] (crea telecronate) e [[Spettatore (actor)]] (fruisce contenuti pubblici), determinati dalle autorizzazioni e dal possesso di canali.

## Scope

L'utente copre: registrazione e autenticazione, gestione profilo, token di notifica push, preferenze lingua/timezone, ciclo di vita dell'account e modalità di accesso.

## Componenti coinvolti

- Attori: [[Cronista (actor)]], [[Spettatore (actor)]]
- Workflow: [[Autenticazione Utente (workflow)]]
- Entity backend: [[User (api)]], [[UserToken (api)]], [[UserOtpCode (api)]]
- API backend: [[AuthV1Controller (api)]], [[UserV1Controller (api)]]
- Servizi backend: [[UserService (api)]]
- Servizi frontend: [[UserService (web)]], [[AuthGuardService (web)]], [[LoginCallbackService (web)]]
- Pagine frontend: [[LoginPage (web)]], [[RegistrationPage (web)]], [[ResetPasswordPage (web)]], [[ProfilePage (web)]]
- Sicurezza: [[JwtBearerAuthentication (api)]], [[GoogleOAuth (api)]], [[SmtpEmail (api)]]
- Modelli frontend: [[userProfileDto (web)]], [[userTokenDto (web)]]

## Relazioni principali

- L'utente si registra con email/password o tramite [[GoogleOAuth (api)]].
- L'account viene attivato tramite `ActivationToken` (GUID).
- L'autenticazione usa [[JwtBearerAuthentication (api)]] con firma HmacSha256; il token JWT ha scadenza configurata (~1 anno) ed è letto da header `Authorization` o cookie `Authentication`.
- Il reset password usa codice OTP a 6 cifre inviato via [[SmtpEmail (api)]], salvato in [[UserOtpCode (api)]] con scadenza 1 ora.
- Il token FCM per notifiche push è salvato in [[UserToken (api)]]; il servizio [[UserService (api)]] elimina i token non validi su errore Firebase.
- Un utente possiede uno o più canali (relazione `User.Channels`).
- Un utente segue canali e partite tramite [[Subscription (api)]].
- Lo spettatore può interagire su partite e eventi tramite [[Comment (api)]], [[EventReaction (api)]], [[MatchLike (api)]], [[LineupPlayerRate (api)]] (cfr. [[Interazione (concept)]]).
- La cancellazione account pseudonimizza l'email in `{id}@deleted.rrl`.
- [[AuthGuardService (web)]] protegge le pagine che richiedono autenticazione; [[LoginCallbackService (web)]] gestisce il reindirizzamento post-login.
- [[UserService (web)]] mantiene lo stato reattivo dell'utente (`isLoggedIn$`, `userNickname$`, `isSplashVisible$`) e persiste il token JWT in localStorage.

## Decisioni architetturali

- Due modalità di accesso: email/password (con attivazione via token) e Google OAuth (con validazione ID Token tramite `GoogleJsonWebSignature.ValidateAsync`).
- Il token JWT usa chiave simmetrica (`Security:SecretKey` in `appsettings.json` in chiaro).
- Il reset password è passwordless (solo OTP via email), senza richiesta vecchia password.
- I token FCM sono salvati nella tabella `UserTokens` con relazione molti-a-uno verso `User`; un utente può avere più dispositivi.
- Le preferenze lingua e timezone sono persistite sul profilo utente; il commentator per la telecronaca è salvato in localStorage dal frontend.
- L'account cancellato viene pseudonimizzato ma i dati relazionali (canali, partite, commenti) restano invariati.

## Rischi

- `Security:SecretKey` in `appsettings.json` in chiaro (valore sensibile non protetto).
- CORS completamente aperto (`AllowAllOrigins`) espone l'API.
- `RequireHttpsMetadata: false` permette token JWT su HTTP.
- Scadenza token molto lunga (~1 anno) aumenta la finestra di rischio in caso di furto token.
- Validazione password e criteri di sicurezza della registrazione non deducibili dalla wiki.
- Meccanismi di rate limiting su login/OTP non deducibili.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`. Le entity backend, i servizi, le API, le pagine frontend e i componenti di autenticazione sono documentati nelle rispettive pagine canoniche. I dettagli implementativi specifici (validazione password, rate limiting, politiche di refresh token) non sono ricostruibili dalla wiki attuale.
