---
title: "EntityBottomNavComponent (web)"
type: frontend-component
layer: frontend
---

# EntityBottomNavComponent (web)

## Sintesi
Bottom navigation bar per la navigazione mobile. Contiene link a home, canali e partite. Il pulsante centrale "crea" apre il drawer di creazione rapida partita tramite BusService.

## Responsabilità
- Renderizzare la barra di navigazione inferiore mobile
- Navigare verso home, canali e partite tramite router link
- Aprire il drawer MatchCreateComponent tramite BusService.setQuickMatchOpen
- Adattare le voci visibili in base allo stato di login dell'utente (UserService)

## Parent pages
- AppComponent

## Child components
- [[IconComponent (web)]]

## Servizi FE usati
- [[UserService (web)]]
- [[BusService (web)]]

## Modelli FE usati
Nessuno.

## Eventi input/output
Nessun input. Nessun output diretto (la comunicazione avviene tramite BusService).

## Note
- Visibile solo su viewport mobile.
- Il pulsante crea chiama `BusService.setQuickMatchOpen(true)` per aprire il drawer globale.
- Lo stato attivo del link viene gestito tramite routerLinkActive di Angular.
