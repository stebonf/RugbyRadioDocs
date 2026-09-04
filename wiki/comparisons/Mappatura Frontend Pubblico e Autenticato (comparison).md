---
title: "Mappatura Frontend Pubblico e Autenticato (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Frontend Pubblico e Autenticato (comparison)

## Sintesi

Mappa le superfici frontend pubbliche, ibride e autenticate della web app, collegando pagine, guard, servizi di sessione e workflow principali. La distinzione centrale e tra pagine `g-*` fruibili pubblicamente, pagine `/user-*` protette da [[AuthGuardService (web)]] e flussi pubblici di autenticazione gestiti da [[AuthV1Controller (api)]].

## Scope

La pagina copre solo relazioni gia presenti nella wiki tra pagine frontend, servizi frontend, API e workflow. Non ricostruisce l'intero file di routing Angular.

## Superfici frontend

| Area | Accesso | Pagine principali | Backend/API collegate | Note |
|---|---|---|---|---|
| Discovery pubblica | Pubblico | [[HomePage (web)]], [[GMatchPage (web)]], [[GFeedbackPage (web)]] | [[MatchesV1Controller (api)]], [[BlogV1Controller (api)]], [[UserV1Controller (api)]] | La home ha anche variante dashboard per utente autenticato; GMatch consente fruizione pubblica della partita. |
| Interazioni pubbliche con login opzionale | Ibrido | [[GMatchPage (web)]] | [[MatchesV1Controller (api)]], [[BlogV1Controller (api)]] | Follow, like e altre azioni richiedono login e usano [[LoginCallbackService (web)]] per rientrare nel contesto originario. |
| Autenticazione | Pubblico | [[LoginPage (web)]], [[RegistrationPage (web)]], [[ResetPasswordPage (web)]] | [[AuthV1Controller (api)]] | Login email/password, Google OAuth, registrazione e reset password OTP sono endpoint pubblici. |
| Profilo e account | Autenticato | [[ProfilePage (web)]], [[DangerPage (web)]] | [[UserV1Controller (api)]] | Profilo, preferenze, token FCM e cancellazione account dipendono dallo stato utente. |
| Telecronaca e gestione contenuti | Autenticato | [[MatchPage (web)]], [[ChannelPage (web)]], [[ChannelsPage (web)]] | [[MatchesV1Controller (api)]], [[ChannelsV1Controller (api)]] | Le pagine operative per cronisti e canali sono protette e orientate alla creazione o gestione contenuti. |

## Relazioni principali

- [[UserService (web)]] mantiene token JWT, stato reattivo della sessione e preferenze locali.
- [[AuthGuardService (web)]] protegge le route autenticate osservando `UserService.isLoggedIn$`.
- [[LoginCallbackService (web)]] conserva il ritorno post-login per flussi avviati da pagine pubbliche.
- [[AnalyticsService (web)]] traccia eventi e page view nelle pagine principali senza bloccare l'app se Firebase non e configurato.
- [[ToastService (web)]] fornisce feedback UI trasversale durante login, registrazione, reset, profilo e feedback.

## Workflow correlati

- [[Autenticazione Utente (workflow)]] copre registrazione, login, reset password, JWT e guard frontend.
- [[Spettatore Partita (workflow)]] usa pagine pubbliche con interazioni che possono richiedere login.
- [[Cronista Telecronaca (workflow)]] richiede superfici autenticate per gestione partita e telecronaca.
- [[Gestione Canale (workflow)]] richiede superfici autenticate per canali, co-proprieta e contenuti.

## Gap noti

- La matrice completa di tutte le route Angular non e deducibile dalle sole pagine wiki lette.
- Le policy esatte per ogni endpoint consumato da pagine ibride non sono sempre esplicitate.
- Il comportamento completo di redirect per pagine protette non e documentato oltre al blocco di [[AuthGuardService (web)]] e al callback post-login.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`. Non sono state lette fonti RAW.
