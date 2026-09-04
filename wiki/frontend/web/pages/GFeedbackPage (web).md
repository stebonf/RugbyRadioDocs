---
title: "GFeedbackPage (web)"
type: frontend-page
layer: frontend
---

# GFeedbackPage (web)

## Sintesi

Form feedback utente con rating 1–5 e messaggio libero. Mostra schermata di successo post-invio.

## Route

`/g-feedback` — Pubblica

## Responsabilità

Permette a qualsiasi utente (autenticato o anonimo) di inviare un feedback alla piattaforma. Il form include una valutazione a stelle da 1 a 5 e un campo testo libero per il messaggio. Dopo l'invio mostra una schermata di conferma del successo.

## Componenti usati

- [[EntityAlertComponent (web)]]
- [[EntityButtonComponent (web)]]
- EntityFieldComponent (web)
- [[IconComponent (web)]]

## Servizi FE usati

- [[UserService (web)]]
- [[BusService (web)]]
- [[ToastService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- userFeedbackDto (web)

## API dipendenti

- [[UserV1Controller (api)]]

## Workflow correlati

Non deducibile

## Stati UI

- Loading
- Submitting
- Successo
- Errore

## Note

Pagina pubblica, non richiede autenticazione. La schermata di successo sostituisce il form dopo l'invio.

