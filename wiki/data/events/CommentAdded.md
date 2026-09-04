---
title: "CommentAdded"
type: data-event
layer: data
---

# CommentAdded

## Sintesi

Evento generato quando uno spettatore autenticato aggiunge un commento testuale a una partita o a un evento di telecronaca.

## Trigger

- `POST /v1/matches/{matchId}/comments` su [[MatchesV1Controller (api)]] (endpoint MTC-08)
- Chiamata a `MatchService` in [[MatchService (api)]]

## Payload

- **Input**: `MatchCommentAddDto` — commento testuale, riferimento opzionale a `EventId`
- **Output persistito**: [[Comment (api)]] — `Id`, `MatchId`, `EventId` (opzionale), `UserId`, `Message`, `IsDeleted`, `Ts`

## Consumer

- [[MatchEventsComponent (web)]] — aggiornamento feed commenti in tempo reale
- [[MatchPage (web)]] — pagina partita che ospita il componente commenti

## Side effects

- Scrittura su DB nella tabella `Comments` tramite repository `ICommentRepository` in [[MatchService (api)]]
- Il commento e visibile pubblicamente nel feed eventi della partita

## Workflow correlati

- [[Spettatore Partita (workflow)]]
- [[Autenticazione Utente (workflow)]]

## Note

La creazione del commento richiede account autenticato ([[Autenticazione Utente (workflow)]]). Il commento puo essere associato a un evento specifico tramite `EventId` oppure direttamente a una partita tramite `MatchId`. La cancellazione e gestita dall'endpoint `DELETE /v1/matches/{matchId}/comments/{commentId}` (MTC-09) che verifica l'appartenenza del commento alla partita richiesta. Meccanismi di notifica push per nuovi commenti non deducibili dalla wiki. Vincoli di validazione (limite caratteri, rate limiting, moderazione) non deducibili.
