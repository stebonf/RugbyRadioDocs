---
title: "LineupService (web)"
type: frontend-service
layer: frontend
---

# LineupService (web)

## Sintesi

API client per la gestione delle formazioni di partita. Permette di aggiornare il ruolo di un giocatore in formazione e di aggiungere o rimuovere giocatori dalla lineup.

## Responsabilità

- Aggiornamento del ruolo di un giocatore nella formazione
- Aggiunta di un giocatore alla formazione
- Rimozione di un giocatore dalla formazione

## Consumer FE

- [[MatchLineupComponent (web)]]

## API chiamate

- [[MatchLineupsV1Controller (api)]]

## DTO o modelli usati

- lineupPlayerEditDto (web)
- lineupPlayerAddDto (web)
- [[playerDto (web)]]

## Side effects

- Chiamate HTTP verso le API backend

## Note

Service dedicato esclusivamente alla gestione della lineup, separato da MatchService per mantenere la separazione delle responsabilità. Utilizzato dal componente di gestione formazione nella pagina partita.

