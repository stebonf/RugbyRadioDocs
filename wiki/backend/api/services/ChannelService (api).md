---
title: "ChannelService (api)"
type: backend-service
layer: backend
---

# ChannelService (api)

## Sintesi

Gestisce il ciclo di vita dei canali: creazione (con generazione `PublicId` univoco), aggiornamento, ricerca pubblica con statistiche classifica, gestione co-owner, gestione iscrizioni (follow/unfollow).

## Responsabilità

- Creazione canale con `PublicId` univoco (8 char da GUID, retry su collisione)
- Aggiornamento canale e layout
- Composizione `ChannelPublicDto` con owner, statistiche like, follow, tabella classifica per squadra
- Verifica ownership (`VerifyAuthAsync`): supporta owner primario e co-owner
- Toggle iscrizione canale (follow/unfollow)
- CRUD co-editor (`ChannelUser`)

## Consumer

- [[ChannelsV1Controller (api)]]
- [[ChannelUsersV1Controller (api)]]
- [[MatchesV1Controller (api)]]
- [[RugbyRadioLiveService (api)]]

## Repository usati

- `IChannelRepository`
- `IMatchRepository`
- `ISubscriptionRepository`
- `IMatchLikeRepository`
- [[ChannelUserRepository (api)]]
- `IUserRepository`
- `ITeamRepository`
- `IUnitOfWork`

## Integrazioni usate

Nessuna

## Jobs usati

Nessuno diretto

## Entities coinvolte

- [[Channel (api)]]
- [[ChannelUser (api)]]
- [[Subscription (api)]]

## Workflow correlati

- [[Gestione Canale (workflow)]]

## Side effects

- Scrittura DB: `Channel`, `ChannelUser`, `Subscription`
- Eventuale spostamento file immagine su filesystem

## Nome nel codice

`ChannelService` — `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelService.cs`

## Note

Non deducibile dai RAW disponibili.
