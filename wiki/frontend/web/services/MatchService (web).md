---
title: "MatchService (web)"
type: frontend-service
layer: frontend
---

# MatchService (web)

## Sintesi

API client completo per la gestione delle partite. Copre CRUD partite, eventi di partita, reazioni, commenti, like, follow, voti, notifiche e ricerca.

## Responsabilità

- Creazione, lettura, aggiornamento ed eliminazione di partite
- Gestione eventi di partita (gol, ammonizioni, ecc.)
- Gestione reazioni, commenti, like e follow su partite
- Invio e recupero voti partita
- Gestione notifiche associate a partite
- Ricerca partite

## Consumer FE

- [[GMatchPage (web)]]
- [[MatchPage (web)]]
- [[GMatchesPage (web)]]
- [[GChannelPage (web)]]
- [[GTeamPage (web)]]
- HomeLastMatchesComponent (web)

## API chiamate

- [[MatchesV1Controller (api)]]
- [[MatchEventsV1Controllers (api)]]
- [[MatchLineupsV1Controller (api)]]

## DTO o modelli usati

- [[matchDto (web)]]
- [[matchMinDto (web)]]
- [[matchEventAddDto (web)]]

## Side effects

- Chiamate HTTP verso le API backend

## Note

Service centrale del dominio partite. Aggrega le chiamate a più controller API in un unico punto di accesso per i componenti frontend.

