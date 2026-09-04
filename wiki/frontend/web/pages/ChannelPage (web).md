---
title: "ChannelPage (web)"
type: frontend-page
layer: frontend
---

# ChannelPage (web)

## Sintesi

Editor canale con 5 tab: Info (dati base), Layout (colori e stile), Editors (co-editor), Teams (squadre associate), Matches (partite).

## Route

`/user-channel/:channelId` — Guard: AuthGuardService — Parametri: `channelId`

## Responsabilità

Permette al proprietario del canale di gestirlo tramite 5 tab dedicate: Info per i dati base, Layout per personalizzazione colori, Editors per la gestione dei co-editor, Teams per le squadre associate, Matches per le partite del canale.

## Componenti usati

- [[EntityPageHeaderComponent (web)]]
- [[EntityTabsComponent (web)]]
- EntityStatsGridComponent (web)

## Servizi FE usati

- [[ChannelService (web)]]
- [[TeamService (web)]]
- [[AnalyticsService (web)]]
- [[PlatformService (web)]]

## Modelli FE usati

- [[channelDto (web)]]
- channelUpdateDto (web)
- channelLayoutUpdateDto (web)
- teamChannelDto (web)

## API dipendenti

- [[ChannelsV1Controller (api)]]
- [[TeamsV1Controller (api)]]

## Workflow correlati

- [[Gestione Canale (workflow)]]

## Stati UI

- Loading
- Tab selezionata (info/layout/editors/teams/matches)
- Mobile

## Note

Protetta da AuthGuardService. Il parametro `channelId` identifica il canale da editare. Il comportamento della UI si adatta al contesto mobile tramite PlatformService.

