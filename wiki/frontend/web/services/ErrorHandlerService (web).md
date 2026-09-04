---
title: "ErrorHandlerService (web)"
type: frontend-service
layer: frontend
---

# ErrorHandlerService (web)

## Sintesi

Servizio per la persistenza dell'ultimo errore applicativo in localStorage. Permette di recuperare informazioni sull'errore anche dopo un reload della pagina.

## Responsabilità

- Salvataggio dell'ultimo errore applicativo in localStorage
- Recupero dell'ultimo errore salvato per diagnostica e recovery

## Consumer FE

- [[MatchEventsComponent (web)]]
- [[MatchLineupComponent (web)]]
- Pagine globali dell'applicazione

## API chiamate

- Nessuna

## DTO o modelli usati

- Nessuno

## Side effects

- Scrittura in localStorage dell'ultimo errore (messaggio, stack trace, timestamp)

## Note

La persistenza in localStorage (anziché sessionStorage) permette di recuperare l'ultimo errore anche dopo un refresh della pagina. Utile per implementare logiche di recovery automatico o per mostrare messaggi di errore contestuali al riavvio dell'app.
