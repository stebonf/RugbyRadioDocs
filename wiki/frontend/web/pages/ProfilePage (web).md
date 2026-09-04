---
title: "ProfilePage (web)"
type: frontend-page
layer: frontend
---

# ProfilePage (web)

## Sintesi

Pagina profilo utente con avatar, nickname, statistiche, preferenze (notifiche, telecronista, lingua, emoji AI), logout e link alla zona pericolosa.

## Route

`/user-profile` — Guard: AuthGuardService

## Responsabilità

Permette all'utente autenticato di visualizzare e modificare il proprio profilo: avatar, nickname, statistiche canali e follow, configurazione notifiche push, telecronista preferito, lingua, emoji AI. Include funzione logout e link alla pagina zona pericolosa.

## Componenti usati

- [[EntityPageHeaderComponent (web)]]
- EntityStatsGridComponent (web)
- [[EntityAlertComponent (web)]]
- [[EntityButtonComponent (web)]]
- EntityFieldComponent (web)
- EntityScrollToTopComponent (web)

## Servizi FE usati

- [[UserService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- [[userProfileDto (web)]]
- userAvatarsDto (web)
- userUpdateDto (web)

## API dipendenti

- [[UserV1Controller (api)]]

## Workflow correlati

- [[Autenticazione Utente (workflow)]]

## Stati UI

- Loading
- Saving profilo
- Errore
- Scroll to top

## Note

Protetta da AuthGuardService. Contiene il link alla DangerPage per la cancellazione dell'account.

