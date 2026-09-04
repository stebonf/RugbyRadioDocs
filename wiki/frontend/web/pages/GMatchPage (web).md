---
title: "GMatchPage (web)"
type: frontend-page
layer: frontend
---

# GMatchPage (web)

## Sintesi

Pagina pubblica partita (viewer) con tab Events, Lineup Home/Away, Stats e Share. Polling auto-aggiornamento, gestione follow, like e blog.

## Route

`/g-match/:matchId` — Parametri: `matchId` — Pubblica

## Responsabilità

Mostra la pagina pubblica di una partita accessibile a tutti i visitatori. Tab disponibili: Events (feed eventi + commentatore), Lineup Home/Away (formazioni), Stats (statistiche), Share (condivisione). Implementa polling per l'auto-aggiornamento durante partite in corso. Gestisce follow del canale, like agli eventi e interazione con il blog.

## Componenti usati

- [[MatchHeaderComponent (web)]]
- [[GMatchEventsComponent (web)]]
- [[MatchLineupComponent (web)]]
- [[MatchStatsComponent (web)]]
- EntityShareComponent (web)
- [[EntityTabsComponent (web)]]
- EntityScrollToTopComponent (web)

## Servizi FE usati

- [[MatchService (web)]]
- [[BlogService (web)]]
- [[ChannelService (web)]]
- [[LoginCallbackService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- [[matchDto (web)]]
- [[blogDto (web)]]

## API dipendenti

- [[MatchesV1Controller (api)]]
- [[BlogV1Controller (api)]]

## Workflow correlati

- [[Spettatore Partita (workflow)]]
- [[Riproduzione Audio Telecronaca (workflow)]]

## Stati UI

- Loading
- isStarted
- isHalfTime
- isFullTime
- Tab selezionata
- Polling attivo
- Radio tab `Leggi` / `Ascolta`

## Note

Pagina pubblica, non richiede autenticazione. Il polling è attivo solo durante partite in corso. Follow e like richiedono login, gestito tramite LoginCallbackService.

