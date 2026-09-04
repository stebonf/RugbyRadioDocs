---
title: "MatchLineupsV1Controller (api)"
type: backend-api
layer: backend
---

# MatchLineupsV1Controller (api)

## Sintesi

Controller per la gestione delle formazioni di partita. Permette di aggiornare, aggiungere e rimuovere giocatori dai ruoli in formazione.

## Base route

`/v1` (route completa: `/v1/channels/{channelId}/matches/{matchId}/lineups/{lineupId}`)

## Endpoints

- PUT `/v1/channels/{channelId}/matches/{matchId}/lineups/{lineupId}` — aggiorna giocatore nel ruolo (LNP-01)
- POST `/v1/channels/{channelId}/matches/{matchId}/lineups/{lineupId}` — aggiunge giocatore al ruolo (LNP-02)
- DELETE `/v1/channels/{channelId}/matches/{matchId}/lineups/{lineupId}` — rimuove giocatore dal ruolo (LNP-03)

## DTO input

- `LineupPlayerEditDto` (LNP-01)
- `LineupPlayerAddDto` (LNP-02)

## DTO output

- `MatchDto` (tutti gli endpoint ritornano lo stato aggiornato della partita)

## Backend services usati

- [[MatchService (api)]]

## Regole auth

Tutti gli endpoint richiedono autenticazione. `MatchService.VerifyAuthAsync` verifica la gerarchia match/channel/lineup.

## Consumer FE

Non deducibile

## Workflow correlati

Non deducibile

## Nome nel codice

`MatchLineupsV1Controller` — `src/RugbyRadio/Api/Controllers/MatchLineupsV1Controller.cs`

## Note

Non deducibile dai RAW disponibili.
