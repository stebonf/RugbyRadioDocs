---
title: "EventReaction (api)"
type: backend-entity
layer: backend
---

# EventReaction (api)

## Sintesi

Rappresenta la reazione di un utente a un evento di partita. Contiene riferimento all'evento, all'utente e al tipo di reazione (stringa libera; valori ammessi non deducibili dal codice entity).

## Proprietà

- `Id`, `IsDeleted`, `Ts` (da EntityBase)
- `EventId` (`string?`) — FK verso `MatchEvent`
- `UserId` (`string?`) — FK verso `User`
- `ReactionType` (`string?`)

## Relazioni entity

- `MatchEvent` — molti-a-uno → FK `EventId`

## Repository correlati

- `EventReactionRepository`

## Services correlati

- [[MatchService (api)]]

## Workflow correlati

- [[ReactionAdded]] — evento generato all'aggiunta di una reazione

## Tabella DB

`[Table("EventReactions")]`

## Nome nel codice

`EventReaction` — `src/RugbyRadio/Lib/Repositories/EventReactionBox/EventReaction.cs`
