---
title: "MatchEventCreated"
type: data-event
layer: data
---

# MatchEventCreated

## Sintesi

Evento generato quando un cronista crea un nuovo evento di telecronaca per una partita. Attiva la notifica push verso gli spettatori e la generazione asincrona di bozze AI per la telecronaca multilingua.

## Trigger

- POST `/v1/matches/{matchId}/events` su [[MatchEventsV1Controllers (api)]]
- Chiamata a `MatchService.CreateEvent` in [[MatchService (api)]]

## Payload

- **Input**: `MatchEventAddDto` — tipo evento (`MatchEventType`), minuto, zona campo (`TerritoryType`), commento, giocatori coinvolti
- **Output persistito**: [[MatchEvent (api)]] — `Id`, `MatchId`, `TeamId`, `Type`, `Minute`, `Territory`, `Comment`, `TypeVersion`, `LineupPlayerId`, `LineupPlayer2Id`

## Consumer

- [[FirebaseFCM (api)]] via `MatchService.SendNotifications` — notifica push con `matchId` e `eventId` nel payload `Data`
- [[MatchEventsComponent (web)]] — aggiornamento feed eventi in tempo reale
- [[GMatchEventsComponent (web)]] — aggiornamento feed pubblico
- [[CreateMatchEventJob (api)]] — generazione asincrona bozze AI per telecronaca

## Side effects

- Notifica push FCM verso dispositivi spettatori ([[Spettatore (actor)]])
- Eliminazione token FCM non validi da `UserToken`
- Scrittura su DB nella tabella `Events` tramite [[MatchEventRepository (api)]]
- Generazione bozze `SystemMessageDraft` via `TailoorTalkerHelper` ([[CreateMatchEventJob (api)]])

## Workflow correlati

- [[Cronista Telecronaca (workflow)]]
- [[Spettatore Partita (workflow)]]

## Note

Payload FCM: `Notification` (title, body), `Data` (`matchId`, `eventId`), `Token`, `WebpushConfig`. La consegna e fire-and-forget senza risposta applicativa. `CreateMatchEventJob` elabora eventi reali in finestra temporale configurabile e filtra tipi `ErrataCorrige`, `Headset` e segnali arbitro (900–951). Dettaglio generazione AI in [[CreateMatchEventJob (api)]].
