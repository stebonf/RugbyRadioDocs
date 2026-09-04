---
title: "StatsV1Controller (api)"
type: backend-api
layer: backend
---

# StatsV1Controller (api)

## Sintesi

Controller per le statistiche globali della piattaforma. Singolo endpoint pubblico che restituisce statistiche aggregate. Accede direttamente a `IStatsRepository` senza service layer.

## Base route

`/v1/stats`

## Endpoints

- GET `/v1/stats` — statistiche globali piattaforma (STS-01) — `[AllowAnonymous]`

## DTO input

Nessuno

## DTO output

Non deducibile (ritorna risultato diretto da `StatsRepository`)

## Backend services usati

Accesso diretto a repository (nessun service layer):

- `IStatsRepository`

## Regole auth

Endpoint pubblico `[AllowAnonymous]`.

## Consumer FE

Non deducibile

## Workflow correlati

Non deducibile

## Nome nel codice

`StatsV1Controller` — `src/RugbyRadio/Api/Controllers/StatsV1Controller.cs`

## Note

Non deducibile dai RAW disponibili.
