---
title: "playerDto (web)"
type: frontend-model
layer: frontend
---

# playerDto (web)

## Sintesi

DTO di risposta per un giocatore anagrafico. Include i dati identificativi del giocatore, il numero di maglia default e l'appartenenza alla squadra.

## Proprietà

| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | string | Identificatore univoco del giocatore |
| name | string | Nome del giocatore |
| nickname | string | Soprannome/abbreviazione |
| avatarUrl | string | URL dell'avatar |
| defaultNumber | number | Numero di maglia default in formazione |
| teamId | string | Identificatore della squadra di appartenenza |

## Origine dati

- API: [[PlayersV1Controller (api)]] — endpoint TMS (GET lista, GET singolo)

## Consumer FE

- [[MatchPage (web)]] — gestione formazione partita
- [[GTeamPage (web)]] — pagina pubblica squadra
- [[MatchLineupComponent (web)]] — composizione formazione
- [[PlayerService (web)]] — CRUD giocatori

## Modelli collegati

- [[teamPublicDto (web)]] — contiene `players: playerDto[]`
- [[lineupPlayerDto (web)]] — contiene `player: playerDto`
- [[Match (api)]] — entità backend corrispondente

## API correlate

- TMS-04: GET lista giocatori per squadra
- TMS-05: POST crea giocatore
- TMS-06: PUT aggiorna giocatore (usato indirettamente)
- TMS-07: DELETE elimina giocatore

## Note

Proprietà dedotte da [[Player (api)]] e dai DTO compositi [[teamPublicDto (web)]] e [[lineupPlayerDto (web)]]. La corrispondenza esatta dei nomi dei campi e dei tipi nullable non è verificabile dalla wiki.
