---
title: "AuthGuardService (web)"
type: frontend-service
layer: frontend
---

# AuthGuardService (web)

## Sintesi

Route guard Angular che implementa `CanActivate`. Blocca l'accesso alle route protette se l'utente non è autenticato, osservando lo stream reattivo `UserService.isLoggedIn$`.

## Responsabilità

- Intercettazione delle richieste di navigazione verso route protette
- Verifica dello stato di autenticazione tramite `UserService.isLoggedIn$`
- Blocco dell'accesso alle route non autorizzate

## Consumer FE

- `app.routes.ts` (route con prefisso `/user-*`)

## API chiamate

- Nessuna

## DTO o modelli usati

- Nessuno

## Side effects

- Nessuno (non redirige automaticamente; il blocco dell'accesso è gestito senza navigazione forzata)

## Note

Il guard osserva `isLoggedIn$` in modo reattivo. La scelta di non redirigere automaticamente alla pagina di login lascia al chiamante (tipicamente [[LoginCallbackService (web)]]) la responsabilità di gestire il redirect e salvare l'URL di ritorno.
