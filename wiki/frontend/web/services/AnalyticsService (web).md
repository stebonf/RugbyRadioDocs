---
title: "AnalyticsService (web)"
type: frontend-service
layer: frontend
---

# AnalyticsService (web)

## Sintesi

Wrapper attorno a Firebase Analytics. Espone i metodi `track(eventName, params)` e `trackPageView` per il tracciamento degli eventi e delle visualizzazioni di pagina. Viene iniettato con `optional: true` per non bloccare l'app se non configurato.

## Responsabilità

- Tracciamento di eventi personalizzati tramite `track(eventName, params)`
- Tracciamento delle visualizzazioni di pagina tramite `trackPageView`
- Wrapping dell'SDK Firebase Analytics per isolare le dipendenze

## Consumer FE

- Tutte le pagine principali dell'applicazione

## API chiamate

- Nessuna (comunicazione diretta con Firebase Analytics SDK)

## DTO o modelli usati

- Nessuno

## Side effects

- Invio di eventi tramite `logEvent` di Firebase Analytics verso Google Analytics

## Note

L'iniezione con `optional: true` garantisce che l'assenza di configurazione Firebase non causi errori a runtime. In ambienti dove Firebase non è configurato (es. sviluppo locale), le chiamate al service vengono silenziosamente ignorate.
