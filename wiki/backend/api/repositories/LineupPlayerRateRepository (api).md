---
title: "LineupPlayerRateRepository (api)"
type: backend-repository
layer: backend
---

# LineupPlayerRateRepository (api)

## Sintesi

Repository per le votazioni giocatori in formazione. Gestisce la persistenza dei voti utente per giocatore/partita.

## Responsabilità

- Inserimento votazione giocatore
- Verifica esistenza voto per utente/formazione

## Entities gestite

- [[LineupPlayerRate (api)]]

## Query rilevanti

Dettaglio query non verificato integralmente dal RAW.

## Consumer

- [[MatchService (api)]]

## Nome nel codice

`LineupPlayerRateRepository` — `src/RugbyRadio/Lib/Repositories/LineupPlayerRateBox/LineupPlayerRateRepository.cs`
