---
title: "MatchPage (web)"
type: frontend-page
layer: frontend
---

# MatchPage (web)

## Sintesi

Editor telecronaca in tempo reale con tab Live, Events, Lineup Home/Away, Stats e Share. Timer auto-refresh per aggiornamento continuo.

## Route

`/user-match/:matchId` — Guard: AuthGuardService — Parametri: `matchId`

## Responsabilità

Interfaccia di controllo per il telecronista durante una partita. Gestisce in tempo reale: controllo dello stato della partita (Live), feed eventi con aggiunta ed eliminazione (Events), formazioni squadre (Lineup Home/Away), statistiche (Stats) e condivisione (Share). Prevede un timer auto-refresh per mantenere i dati aggiornati.

## Componenti usati

- [[MatchHeaderComponent (web)]]
- [[MatchLineupComponent (web)]]
- [[MatchStatsComponent (web)]]
- EntityShareComponent (web)
- [[EntityTabsComponent (web)]]

## Servizi FE usati

- [[MatchService (web)]]
- [[PlayerService (web)]]
- [[LineupService (web)]]
- [[BlogService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- [[matchDto (web)]]
- [[matchEventDto (web)]]
- [[blogDto (web)]]
- playerDto (web)
- matchStatsUpdateDto (web)

## API dipendenti

- [[MatchesV1Controller (api)]]
- [[PlayersV1Controller (api)]]
- [[BlogV1Controller (api)]]

## Workflow correlati

- [[Cronista Telecronaca (workflow)]]

## Stati UI

- Loading
- isStarted
- isPaused
- isHalfTime
- isFullTime
- Tab selezionata
- modePossession

## Note

Protetta da AuthGuardService. Il parametro `matchId` identifica la partita. L'auto-refresh mantiene sincronizzati i dati in tempo reale durante la telecronaca.

