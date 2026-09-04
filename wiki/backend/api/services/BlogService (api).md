---
title: "BlogService (api)"
type: backend-service
layer: backend
---

# BlogService (api)

## Sintesi

Espone le query del blog verso i controller: lista paginata con dettaglio partita e squadre, post singolo per partita e lingua. Thin service che delega a [[BlogRepository (api)]].

## Responsabilità

- Lista paginata post blog filtrata per lingua (`PageDto<BlogDto>`)
- Recupero post singolo per `matchId` e lingua

## Consumer

- [[BlogV1Controller (api)]]

## Repository usati

- [[BlogRepository (api)]]

## Integrazioni usate

Nessuna

## Jobs usati

Nessuno diretto

## Entities coinvolte

- [[Blog (api)]]

## Workflow correlati

Non deducibile

## Side effects

Nessuno (solo lettura)

## Nome nel codice

`BlogService` — `src/RugbyRadio/Lib/Repositories/BlogBox/BlogService.cs`

## Note

Non deducibile dai RAW disponibili.
