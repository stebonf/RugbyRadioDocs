---
title: "BaseService (web)"
type: frontend-service
layer: frontend
---

# BaseService (web)

## Sintesi

Classe base HTTP da cui estendono tutti gli altri API service del frontend. Fornisce i metodi doGet, doPost, doPut e doDelete con logging integrato, e legge la base URL dall'environment tramite `environment.apiUrl`.

## Responsabilità

Centralizza la costruzione delle richieste HTTP (headers, base URL, gestione errori comuni) e il logging di ogni chiamata. Non effettua chiamate dirette alle API di dominio.

## Consumer FE

- Esteso da tutti gli altri API service (UserService, MatchService, ChannelService, TeamService, ecc.)

## API chiamate

- Nessuna diretta

## DTO o modelli usati

- Nessuno diretto

## Side effects

- Logging via [[LoggingService (web)]] per ogni richiesta HTTP in uscita e risposta ricevuta

## Note

Il valore di base URL è configurato per ambiente tramite `environment.apiUrl`. Tutti i service che estendono BaseService ereditano automaticamente il logging e la gestione della base URL.
