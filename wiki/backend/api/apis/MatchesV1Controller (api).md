---
title: "MatchesV1Controller (api)"
type: backend-api
layer: backend
---

# MatchesV1Controller (api)

## Sintesi

Controller principale per la gestione delle partite. Copre l'intero ciclo di vita: creazione, aggiornamento, eventi, formazioni, like, commenti, votazioni, notifiche push, follow. Include endpoint pubblici per visualizzazione.

## Base route

`/v1` (route completa varia per endpoint)

## Endpoints

- GET `/v1/channels/{channelId}/matches` — lista partite del canale (MTC-01)
- GET `/v1/matches/{matchId}` — dettaglio partita (MTC-02)
- POST `/v1/channels/{channelId}/matches` — crea partita (MTC-03)
- PUT `/v1/channels/{channelId}/matches/{matchId}` — aggiorna partita (MTC-04)
- PUT `/v1/channels/{channelId}/matches/{matchId}/status` — cambia stato partita (MTC-05)
- DELETE `/v1/channels/{channelId}/matches/{matchId}` — elimina partita (MTC-06)
- POST `/v1/matches/{matchId}/like` — toggle like partita (MTC-07)
- POST `/v1/matches/{matchId}/comments` — aggiunge commento (MTC-08)
- DELETE `/v1/matches/{matchId}/comments/{commentId}` — elimina commento (MTC-09)
- POST `/v1/matches/{matchId}/events/{eventId}/reactions` — aggiunge reazione (MTC-10)
- POST `/v1/matches/{matchId}/lineups/{lineupId}/rate` — vota giocatore (MTC-11)
- POST `/v1/matches/{matchId}/follow` — follow partita (MTC-12)
- POST `/v1/matches/{matchId}/notification` — invia notifica push (MTC-13) — Protetto
- GET `/v1/matches/{matchId}/image` — immagine partita (MTC-14) — pubblico
- GET `/v1/matches/public` — lista partite pubbliche (MTC-15)
- POST `/v1/channels/{channelId}/matches/image` — upload immagine (MTC-16) — Protetto
- POST `/v1/channels/{channelId}/matches/quick` — crea partita rapida wizard (MTC-17)

## DTO input

- `MatchAddDto`, `MatchUpdateDto`, `MatchStatusDto`
- `MatchCommentAddDto`, `MatchEventAddDto`
- `LineupPlayerRateDto`, `MatchQuickAddDto`

## DTO output

- `MatchDto`, `MatchChannelDto`, `PageDto<MatchDto>`

## Backend services usati

- [[MatchService (api)]]
- [[UserService (api)]]
- [[LineupPlayerService (api)]]
- [[RugbyRadioLiveService (api)]]

## Regole auth

Endpoint di gestione richiedono autenticazione. Endpoint pubblici (`/public`, `/image`) accessibili senza token. Notifiche richiedono `[Authorize]`.
La cancellazione commento `DELETE /v1/matches/{matchId}/comments/{commentId}` verifica l'autorizzazione sulla partita della route e il service conferma che il commento appartenga allo stesso `matchId`.

## Consumer FE

- [[MatchPage (web)]]

## Workflow correlati

- [[Cronista Telecronaca (workflow)]]
- [[Spettatore Partita (workflow)]]

## Nome nel codice

`MatchesV1Controller` — `src/RugbyRadio/Api/Controllers/MatchesV1Controller.cs`

## Note

Non deducibile dai RAW disponibili.
