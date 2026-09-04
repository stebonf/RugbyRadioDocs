---
title: "LoginPage (web)"
type: frontend-page
layer: frontend
---

# LoginPage (web)

## Sintesi

Login email+password e Google OAuth con recupero password tramite OTP. Redirect automatico a dashboard se già loggato.

## Route

`/user-login`

## Responsabilità

Gestisce il login tramite email+password e Google OAuth. Include il flusso di recupero password con codice OTP. Se l'utente è già autenticato, esegue redirect alla dashboard. Post-login utilizza LoginCallbackService per redirigere all'URL di ritorno configurato.

## Componenti usati

- [[EntityAlertComponent (web)]]
- EntityFieldComponent (web)
- [[EntityButtonComponent (web)]]

## Servizi FE usati

- [[UserService (web)]]
- [[LoginCallbackService (web)]]
- [[BusService (web)]]
- [[ToastService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- userLoginDto (web)
- [[userTokenDto (web)]]
- userForgotPasswordDto (web)

## API dipendenti

- [[AuthV1Controller (api)]]

## Workflow correlati

- [[Autenticazione Utente (workflow)]]

## Stati UI

- Loading
- Errore
- Forgot password successo
- Login disabilitato

## Note

Il redirect post-login è gestito da LoginCallbackService che memorizza e ripristina l'URL di ritorno.

