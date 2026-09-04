---
title: "StatsRepository (api)"
type: backend-repository
layer: backend
---

# StatsRepository (api)

## Sintesi

Repository per le statistiche aggregate della piattaforma. Acceduto direttamente da `StatsV1Controller` senza service layer intermedio.

## Responsabilità

- Recupero statistiche globali piattaforma (conteggi, aggregati)

## Entities gestite

Non deducibile (probabilmente query SQL aggregate su più tabelle)

## Query rilevanti

Dettaglio query non verificato dal RAW.

## Consumer

- [[StatsV1Controller (api)]]

## Nome nel codice

`StatsRepository` — `src/RugbyRadio/Lib/Repositories/StatsRepository.cs`
