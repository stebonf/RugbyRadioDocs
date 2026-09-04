---
title: "Comment (api)"
type: backend-entity
layer: backend
---

# Comment (api)

## Sintesi

Rappresenta un commento lasciato da un utente su un evento di partita. Contiene riferimento alla partita, all'evento specifico, all'utente autore e al testo.

## Proprietà

- `Id`, `IsDeleted`, `Ts` (da EntityBase)
- `MatchId` (`string?`) — FK verso `Match`
- `EventId` (`string?`) — FK verso `MatchEvent`
- `UserId` (`string?`) — FK verso `User`
- `Message` (`string?`)

## Relazioni entity

- `User` — molti-a-uno → FK `UserId`
- `Match` — molti-a-uno → FK `MatchId` (navigation inversa `Match.Comments`)

## Repository correlati

- `CommentRepository`

## Services correlati

- [[MatchService (api)]]

## Workflow correlati

Non deducibile

## Tabella DB

`[Table("Comments")]`

## Nome nel codice

`Comment` — `src/RugbyRadio/Lib/Repositories/CommentBox/Comment.cs`
