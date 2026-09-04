---
title: "HttpClientService (api)"
type: backend-service
layer: backend
---

# HttpClientService (api)

## Sintesi

Client HTTP generico basato su RestSharp. Astrae tutte le chiamate HTTP verso endpoint esterni (GET, POST form-encoded, POST JSON, PUT, PATCH, DELETE). Supporta autenticazione Bearer JWT e header custom. Deserializza automaticamente con Newtonsoft.Json.

## Responsabilità

- `DoGetAsync<T>` — GET con risposta deserializzata
- `DoPostAsync<T>` — POST body JSON
- `DoPostFormEncodedAsync<T>` — POST form-encoded
- `DoPutAsync<T>` — PUT
- `DoPatchAsync<T>` — PATCH
- `DoDeleteAsync<T>` — DELETE

## Consumer

- [[FacebookService (api)]]

## Repository usati

Nessuno

## Integrazioni usate

Nessuna diretta (è lui stesso il client di integrazione)

## Jobs usati

Nessuno diretto

## Entities coinvolte

Nessuna

## Workflow correlati

Non deducibile

## Side effects

- Chiamate HTTP esterne verso endpoint arbitrari

## Nome nel codice

`HttpClientService` — `src/RugbyRadio/Lib/Services/HttpClientService.cs`

## Note

Non deducibile dai RAW disponibili.
