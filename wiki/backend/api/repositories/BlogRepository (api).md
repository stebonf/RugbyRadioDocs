---
title: "BlogRepository (api)"
type: backend-repository
layer: backend
---

# BlogRepository (api)

## Sintesi

Repository per la persistenza e la consultazione dei post blog generati per le partite terminate.

## Responsabilità

- Fornire query blog a [[BlogService (api)]].
- Supportare la generazione dei post blog in [[AiOllamaService (api)]].
- Fornire dati blog a [[SeoUrlInventoryService (api)]] per la composizione degli URL pubblici SEO.

## Entities gestite

- [[Blog (api)]]

## Query rilevanti

Non deducibile dalla wiki attuale.

## Consumer

- [[BlogService (api)]]
- [[AiOllamaService (api)]]
- [[SeoUrlInventoryService (api)]]

## Nome nel codice

`BlogRepository` / `IBlogRepository`

## Note

Pagina creata da riferimenti gia presenti nella wiki; dettagli implementativi non deducibili dalla wiki attuale.
