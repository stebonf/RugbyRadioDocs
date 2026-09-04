---
title: "BlogService (web)"
type: frontend-service
layer: frontend
---

# BlogService (web)

## Sintesi

API client per il recupero dei post del blog. Supporta la lista paginata e il recupero dei post associati a una specifica partita.

## Responsabilità

- Recupero della lista paginata dei post del blog
- Recupero dei post del blog relativi a una partita specifica

## Consumer FE

- [[GMatchPage (web)]]

## API chiamate

- [[BlogV1Controller (api)]]

## DTO o modelli usati

- [[blogDto (web)]]
- [[pageDto (web)]]

## Side effects

- Chiamate HTTP verso le API backend

## Note

`pageDto` gestisce la paginazione della lista post. Utilizzato principalmente nella pagina pubblica di una partita per mostrare contenuti editoriali correlati.
