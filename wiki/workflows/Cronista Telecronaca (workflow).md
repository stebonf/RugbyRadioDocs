---
title: "Cronista Telecronaca (workflow)"
type: workflow
layer: workflow
---

# Cronista Telecronaca (workflow)

## Obiettivo
Permettere al cronista di creare una telecronaca di partita tramite pochi click.

## Trigger
Il cronista crea o apre una partita da telecronacare.

## Attori
- [[Cronista (actor)]]

## Frontend coinvolto
- [[ChannelsPage (web)]]
- [[ChannelPage (web)]]
- [[MatchPage (web)]]

## Backend coinvolto
- [[ChannelsV1Controller (api)]]
- [[MatchesV1Controller (api)]]
- [[MatchLineupsV1Controller (api)]]

## Data coinvolti
- [[Channel (api)]]
- [[Match (api)]]
- [[MatchEvent (api)]]
- [[LineupPlayer (api)]]

## Analytics tracking
- [[Platform Stats 2026-05-13 (analytic)]]

## Failure points
- Auth/ownership canale o partita
- Creazione eventi non autorizzata
- Notifiche push non consegnate

## Gap noti
- Frequenze job HF non deducibili dai RAW
- Dettaglio completo template editor match non deducibile dai RAW

## Note
Relazioni dedotte da RAW frontend, backend e overview prodotto.

