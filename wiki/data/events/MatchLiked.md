---
title: "MatchLiked"
type: data-event
layer: data
---

# MatchLiked

## Sintesi

Evento generato quando uno spettatore autenticato mette like (o rimuove il like) a una partita. Il like e gestito da [[MatchService (api)]] come operazione di toggle: se il like esiste gia viene eliminato (soft-delete), altrimenti viene creato. La persistenza usa [[MatchLike (api)]] con tabella `MatchLikes`.

## Trigger

- `POST /v1/matches/{matchId}/like` su [[MatchesV1Controller (api)]] (endpoint MTC-07)
- Chiamata a `MatchService` in [[MatchService (api)]] che orchestra la logica di toggle

## Payload

- **Input**: `matchId` (dalla route), `UserId` (da autenticazione JWT)
- **Output persistito**: [[MatchLike (api)]] — `Id`, `MatchId`, `UserId`, `IsDeleted`, `Ts`
- **Rimozione**: soft-delete (`IsDeleted = true`) sul record esistente in caso di unlike

## Consumer

- [[GMatchPage (web)]] — aggiornamento stato like nella UI pubblica
- [[GMatchEventsComponent (web)]] — propagazione evento `like` verso il parent
- [[MatchService (web)]] — chiamata API e riflesso sul modello client

## Side effects

- Scrittura su DB nella tabella `MatchLikes` tramite `IMatchLikeRepository` in [[MatchService (api)]]
- Aggiornamento conteggio like per canale (`GetChannelLikesCountAsync`) in [[MatchLikeRepository (api)]]
- Il conteggio like aggregato e esposto in `ChannelPublicDto` tramite [[ChannelService (api)]]

## Workflow correlati

- [[Spettatore Partita (workflow)]]

## Note

L'endpoint MTC-07 implementa una logica di toggle: se l'utente ha gia un like attivo per la stessa partita, il record viene marcato come eliminato (unlike). In caso contrario viene inserito un nuovo record. La creazione del like richiede account autenticato (cfr. [[Autenticazione Utente (workflow)]]). La logica esatta di conflitto (like concorrenti, unique constraint su UserId+MatchId) non e deducibile dalla wiki.
