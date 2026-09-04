---
title: "SubscriptionChanged"
type: data-event
layer: data
---

# SubscriptionChanged

## Sintesi

Evento generato quando uno spettatore autenticato segue (follow) o smette di seguire (unfollow) un canale o una partita. Il follow/unfollow e gestito come operazione di toggle su [[Subscription (api)]]: inserimento per follow, soft-delete (`IsDeleted`) per unfollow. La stessa entita copre sia follow canale (tramite `ChannelId`) sia follow partita (tramite `MatchId`).

## Trigger

- `POST /v1/matches/{matchId}/follow` su [[MatchesV1Controller (api)]] (endpoint MTC-12) — follow partita, orchestrato da [[MatchService (api)]]
- `POST /v1/channels/{channelId}/subscription` su [[ChannelsV1Controller (api)]] — follow canale, orchestrato da [[ChannelService (api)]]

## Payload

- **Input**: `matchId` o `channelId` (dalla route), `UserId` (da autenticazione JWT)
- **Output persistito**: [[Subscription (api)]] — `Id`, `UserId`, `ChannelId`/`MatchId`, `IsDeleted`, `Ts`
- **Rimozione**: soft-delete (`IsDeleted = true`) sul record esistente in caso di unfollow

## Consumer

- [[FavoritesPage (web)]] — lista canali seguiti dall'utente, rifresca dopo toggle follow
- [[GMatchPage (web)]] — stato follow partita nella UI pubblica
- [[GMatchEventsComponent (web)]] — propagazione evento `follow` verso il parent
- [[ChannelService (web)]] — chiamata API toggle iscrizione canale
- [[MatchService (web)]] — chiamata API toggle follow partita

## Side effects

- Scrittura su DB nella tabella `Subscriptions` tramite `ISubscriptionRepository` in [[ChannelService (api)]] o [[MatchService (api)]]
- Recupero token FCM degli iscritti a una partita tramite [[SubscriptionRepository (api)]] per notifiche push evento (cfr. [[Notifica (concept)]])
- Il canale seguito appare nella lista di [[FavoritesPage (web)]]

## Workflow correlati

- [[Spettatore Partita (workflow)]]

## Note

L'endpoint MTC-12 e l'endpoint `POST /v1/channels/{channelId}/subscription` implementano entrambi una logica di toggle: se l'utente ha gia una subscription attiva per la stessa partita o canale, il record viene marcato come eliminato (unfollow). In caso contrario viene inserito un nuovo record. La creazione della subscription richiede account autenticato (cfr. [[Autenticazione Utente (workflow)]]). Il dettaglio di aggiornamento in tempo reale della UI dopo il toggle, la gestione di toggle concorrenti e l'analytics tracking del follow/unfollow non sono deducibili dalla wiki.
