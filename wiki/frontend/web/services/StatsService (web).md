---
title: "StatsService (web)"
type: frontend-service
layer: frontend
---

# StatsService (web)

## Sintesi

API client per il recupero delle statistiche globali della piattaforma.

## Responsabilità

- Recupero delle statistiche aggregate a livello di piattaforma (utenti, partite, canali, ecc.)

## Consumer FE

- [[GStatsPage (web)]]

## API chiamate

- [[StatsV1Controller (api)]]

## DTO o modelli usati

- [[statsDto (web)]]

## Side effects

- Chiamata HTTP verso le API backend

## Note

Service semplice con una singola responsabilità. I dati vengono esposti nella pagina statistiche pubblica della piattaforma.
