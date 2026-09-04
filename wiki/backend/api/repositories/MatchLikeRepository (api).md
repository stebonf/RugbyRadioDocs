---
title: "MatchLikeRepository (api)"
type: backend-repository
layer: backend
---

# MatchLikeRepository (api)

## Sintesi

Repository per i like delle partite. Supporta conteggio like per canale e gestione toggle like.

## Responsabilità

- Inserimento/eliminazione like partita
- `GetChannelLikesCountAsync(channelId)` — conteggio like per canale (usato in `ChannelPublicDto`)

## Entities gestite

- [[MatchLike (api)]]

## Query rilevanti

- `GetChannelLikesCountAsync(channelId)` — conteggio aggregato like per canale

## Consumer

- [[MatchService (api)]]
- [[ChannelService (api)]]

## Nome nel codice

`MatchLikeRepository` — `src/RugbyRadio/Lib/Repositories/MatchLikeBox/MatchLikeRepository.cs`
