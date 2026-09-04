---
title: "LoggingService (web)"
type: frontend-service
layer: frontend
---

# LoggingService (web)

## Sintesi

Servizio di logging con persistenza a sessionStorage tramite un rolling buffer di 100 entry. In ambiente di sviluppo, i log vengono anche emessi su `console.log`.

## Responsabilità

- Scrittura dei log in un rolling buffer su sessionStorage (max 100 entry)
- Emissione dei log su console in ambiente di sviluppo
- Messa a disposizione dei log per debugging e diagnostica

## Consumer FE

- [[BaseService (web)]] (e per estensione tutti gli API service)
- Tutti i componenti che necessitano di logging

## API chiamate

- Nessuna

## DTO o modelli usati

- Nessuno

## Side effects

- Scrittura su sessionStorage (rolling buffer, le entry più vecchie vengono eliminate al raggiungimento del limite di 100)

## Note

Il rolling buffer garantisce che sessionStorage non cresca indefinitamente. I log in sessionStorage sono accessibili per tutta la durata della sessione del browser e vengono cancellati alla chiusura della tab.
