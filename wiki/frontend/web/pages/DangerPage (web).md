---
title: "DangerPage (web)"
type: frontend-page
layer: frontend
---

# DangerPage (web)

## Sintesi

Cancellazione account a due step. Step 1: conferma intenzione; Step 2: conferma definitiva. Logout e redirect a home dopo cancellazione.

## Route

`/user-danger` — Guard: AuthGuardService

## Responsabilità

Gestisce il flusso di cancellazione account in due step per prevenire eliminazioni accidentali. Step 1: l'utente conferma l'intenzione di cancellare. Step 2: conferma definitiva e irreversibile. Dopo la cancellazione esegue logout automatico e redirect alla home.

## Componenti usati

- [[EntityPageHeaderComponent (web)]]
- [[EntityAlertComponent (web)]]
- [[EntityButtonComponent (web)]]

## Servizi FE usati

- [[UserService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

Nessuno diretto

## API dipendenti

- [[UserV1Controller (api)]]

## Workflow correlati

Non deducibile

## Stati UI

- Step 1
- Step 2
- Delete in corso

## Note

Protetta da AuthGuardService. Il flusso a due step è obbligatorio per prevenire cancellazioni accidentali. L'operazione è irreversibile.
