---
title: "GChannelPage (web)"
type: frontend-page
layer: frontend
---

# GChannelPage (web)

## Sintesi

Pagina pubblica canale con tab Radio, Matches, Teams, Tables (classifica) e Share. Gestisce follow e condivisione.

## Route

`/g-channel/:channelPublicId` — Parametri: `channelPublicId` — Pubblica

## Responsabilità

Mostra la pagina pubblica di un canale accessibile a tutti. Organizzata in 5 tab: Radio (partite recenti), Matches (lista partite), Teams (squadre), Tables (classifica), Share (condivisione). Gestisce il follow/unfollow del canale e la condivisione del link.

## Componenti usati

- [[EntityPageHeaderComponent (web)]]
- [[EntityTabsComponent (web)]]
- EntityStatsGridComponent (web)
- EntityShareComponent (web)
- EntityScrollToTopComponent (web)
- [[MatchCardListComponent (web)]]
- ChannelTablesComponent (web)
- ChannelTeamsComponent (web)

## Servizi FE usati

- [[ChannelService (web)]]
- [[MatchService (web)]]
- [[LoginCallbackService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- [[channelPublicDto (web)]]
- [[pageDto (web)]]
- [[matchMinDto (web)]]

## API dipendenti

- [[ChannelsV1Controller (api)]]
- [[MatchesV1Controller (api)]]

## Workflow correlati

Non deducibile

## Stati UI

- Loading
- Tab selezionata (radio/matches/teams/tables/share)
- Scroll to top
- Copia link

## Note

Pagina pubblica, non richiede autenticazione. Il follow richiede login e usa LoginCallbackService per il redirect. Il parametro `channelPublicId` è l'identificatore pubblico del canale.

