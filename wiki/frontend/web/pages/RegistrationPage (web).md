---
title: "RegistrationPage (web)"
type: frontend-page
layer: frontend
---

# RegistrationPage (web)

## Sintesi

Registrazione nuovo utente tramite email+password con form reattivo e validazione. Traccia analytics `signup_started`.

## Route

`/user-registration`

## Responsabilità

Gestisce la registrazione di nuovi utenti con form reattivo e validazione lato client. Redirect automatico alla dashboard se l'utente è già loggato. Traccia l'evento analytics `signup_started` all'apertura della pagina.

## Componenti usati

- [[EntityAlertComponent (web)]]
- EntityFieldComponent (web)
- [[EntityButtonComponent (web)]]

## Servizi FE usati

- [[UserService (web)]]
- [[LoginCallbackService (web)]]
- [[ToastService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- userRegisterDto (web)
- [[userTokenDto (web)]]

## API dipendenti

- [[AuthV1Controller (api)]]

## Workflow correlati

- [[Autenticazione Utente (workflow)]]

## Stati UI

- Loading
- Errore
- Register disabilitato

## Note

Il form è reattivo con validazione integrata. Post-registrazione il redirect è gestito da LoginCallbackService.

