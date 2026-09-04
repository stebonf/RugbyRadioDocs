---
title: "PlayerService (web)"
type: frontend-service
layer: frontend
---

# PlayerService (web)

## Sintesi

API client per la gestione dei giocatori di una squadra. Supporta le operazioni CRUD scoped per squadra.

## Responsabilità

- Recupero della lista giocatori di una squadra
- Aggiunta di nuovi giocatori a una squadra
- Aggiornamento dei dati di un giocatore
- Eliminazione di un giocatore da una squadra

## Consumer FE

- [[MatchPage (web)]]

## API chiamate

- [[PlayersV1Controller (api)]]

## DTO o modelli usati

- [[playerDto (web)]]
- playerSaveDto (web)

## Side effects

- Chiamate HTTP verso le API backend

## Note

Le operazioni sono sempre scoped a una squadra specifica. Utilizzato principalmente nel contesto della gestione della formazione di partita.

