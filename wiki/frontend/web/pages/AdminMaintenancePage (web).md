---
title: "AdminMaintenancePage (web)"
type: frontend-page
layer: frontend
---

# AdminMaintenancePage (web)

## Sintesi

Pagina statica di manutenzione. Attiva solo quando `environment.maintenance = true`; in quel caso tutte le route redirectano qui.

## Route

`/admin-maintenance` — Solo in modalità maintenance (`environment.maintenance = true`)

## Responsabilità

Mostra una pagina statica di manutenzione agli utenti quando la piattaforma è in modalità manutenzione. Quando `environment.maintenance = true` tutte le route dell'applicazione vengono redirezionate a questa pagina.

## Componenti usati

Nessuno deducibile

## Servizi FE usati

Nessuno

## Modelli FE usati

Nessuno

## API dipendenti

Nessuna

## Workflow correlati

Non deducibile

## Stati UI

Nessuno deducibile

## Note

Attivata esclusivamente tramite flag `environment.maintenance = true` nella configurazione dell'ambiente. Funge da catch-all redirect quando la piattaforma è offline per manutenzione.
