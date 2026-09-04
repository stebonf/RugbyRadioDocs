---
title: "ResetPasswordPage (web)"
type: frontend-page
layer: frontend
---

# ResetPasswordPage (web)

## Sintesi

Cambio password tramite OTP a 6 cifre. Form con 6 campi separati più campo nuova password.

## Route

`/user-reset-password`

## Responsabilità

Permette all'utente di impostare una nuova password inserendo il codice OTP a 6 cifre ricevuto (gestito con 6 campi separati) e la nuova password desiderata. Post-cambio password usa LoginCallbackService per il redirect.

## Componenti usati

- [[EntityButtonComponent (web)]]
- [[IconComponent (web)]]

## Servizi FE usati

- [[UserService (web)]]
- [[LoginCallbackService (web)]]
- [[ToastService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- userChangePasswordDto (web)
- [[userTokenDto (web)]]

## API dipendenti

- [[AuthV1Controller (api)]]

## Workflow correlati

- [[Autenticazione Utente (workflow)]]

## Stati UI

- Loading
- Errore

## Note

Il codice OTP è distribuito su 6 campi input separati per una migliore UX. Il redirect post-cambio è gestito da LoginCallbackService.

