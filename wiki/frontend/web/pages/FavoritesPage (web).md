---
title: "FavoritesPage (web)"
type: frontend-page
layer: frontend
---

# FavoritesPage (web)

## Sintesi

Lista canali seguiti dall'utente (favorites/follow). Navigazione a GChannelPage al click su un canale.

## Route

`/user-favorites` — Guard: AuthGuardService

## Responsabilità

Visualizza la lista dei canali che l'utente segue (follow). Al click su un canale naviga alla relativa pagina pubblica GChannelPage.

## Componenti usati

- [[EntityPageHeaderComponent (web)]]
- [[EntityButtonComponent (web)]]
- EntityCardSmallComponent (web)

## Servizi FE usati

- [[ChannelService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- [[channelDto (web)]]

## API dipendenti

- [[ChannelsV1Controller (api)]]

## Workflow correlati

Non deducibile

## Stati UI

- Loading

## Note

Protetta da AuthGuardService. I canali seguiti sono distinti dai canali di proprietà, visualizzati in ChannelsPage.

