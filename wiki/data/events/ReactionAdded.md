---
title: "ReactionAdded"
type: data-event
layer: data
---

# ReactionAdded

## Sintesi

Evento generato quando uno spettatore autenticato aggiunge una reazione emoji a un evento di telecronaca. La reazione e gestita da [[MatchService (api)]] e persistita come [[EventReaction (api)]] con `ReactionType` in formato stringa libera.

## Trigger

- `POST /v1/matches/{matchId}/events/{eventId}/reactions` su [[MatchesV1Controller (api)]] (endpoint MTC-10)
- Chiamata a `MatchService` in [[MatchService (api)]]

## Payload

- **Input**: `ReactionType` (stringa libera, valori ammessi non deducibili), associato a `EventId` e `UserId` (da autenticazione)
- **Output persistito**: [[EventReaction (api)]] — `Id`, `EventId`, `UserId`, `ReactionType`, `IsDeleted`, `Ts`

## Consumer

- [[MatchEventsComponent (web)]] — aggiornamento feed reazioni in tempo reale
- [[GMatchEventsComponent (web)]] — aggiornamento feed pubblico

## Side effects

- Scrittura su DB nella tabella `EventReactions` tramite `IEventReactionRepository` in [[MatchService (api)]]
- La reazione e visibile pubblicamente nel feed eventi della partita tramite `matchEventReactionDto[]` in [[matchEventDto (web)]]

## Workflow correlati

- [[Spettatore Partita (workflow)]]

## Note

La creazione della reazione richiede account autenticato (cfr. [[Autenticazione Utente (workflow)]]). Il `ReactionType` e memorizzato come stringa libera; la logica di toggle (stessa emoji rimossa se gia presente), i valori consentiti e il limite di reazioni per utente/evento non sono deducibili dalla wiki.
