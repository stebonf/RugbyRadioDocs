---
title: "Spettatore Partita (workflow)"
type: workflow
layer: workflow
---

# Spettatore Partita (workflow)

## Obiettivo
Permettere allo spettatore di seguire una partita e interagire con eventi, commenti, emoji e voti.

## Trigger
Lo spettatore apre un link pubblico alla partita o naviga verso una partita pubblica.

## Attori
- [[Spettatore (actor)]]

## Frontend coinvolto
- [[GMatchPage (web)]]
- [[GMatchesPage (web)]]
- [[GChannelPage (web)]]
- [[GTeamPage (web)]]
- [[MatchEventsComponent (web)]]
- [[MatchCommentatorComponent (web)]]
- [[MatchTabIdModel (web)]]
- [[TeamTabIdModel (web)]]
- [[StatsCardViewModel (web)]]

## Backend coinvolto
- [[MatchesV1Controller (api)]]
- [[BlogV1Controller (api)]]
- [[VoicesV1Controller (api)]]

## Data coinvolti
- [[Match (api)]]
- [[MatchEvent (api)]]
- [[Comment (api)]]
- [[EventReaction (api)]]
- [[LineupPlayerRate (api)]]

## Analytics tracking
- [[Platform Stats 2026-05-13 (analytic)]]

## Failure points
- Commenti, voti e follow richiedono account
- Audio TTS puo fallire se sintesi o file non disponibili
- Polling/refresh partita non dettagliato nei RAW
- Alcuni AI-Talker non hanno audio TTS disponibile

## Gap noti
- Vincoli esatti commenti e rating non deducibili
- Dettaglio completo dei template pubblici non deducibile

## Note
Relazioni dedotte da RAW frontend, backend e overview prodotto.

Il sottoflusso audio e documentato in [[Riproduzione Audio Telecronaca (workflow)]].

