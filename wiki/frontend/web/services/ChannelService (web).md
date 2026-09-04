---
title: "ChannelService (web)"
type: frontend-service
layer: frontend
---

# ChannelService (web)

## Sintesi

API client per la gestione dei canali. Supporta operazioni CRUD, iscrizioni utente e ricerca pubblica dei canali.

## Responsabilità

- Creazione, lettura, aggiornamento ed eliminazione di canali
- Gestione delle iscrizioni degli utenti ai canali
- Ricerca canali pubblici

## Consumer FE

- [[GChannelPage (web)]]
- [[GChannelsPage (web)]]
- [[ChannelsPage (web)]]
- [[ChannelPage (web)]]
- [[FavoritesPage (web)]]

## API chiamate

- [[ChannelsV1Controller (api)]]

## DTO o modelli usati

- [[channelDto (web)]]
- [[channelPublicDto (web)]]
- channelAddDto (web)

## Side effects

- Chiamate HTTP verso le API backend

## Note

Distingue tra canali privati (gestiti dall'utente autenticato) e canali pubblici (accessibili in modalità guest tramite `channelPublicDto`).

