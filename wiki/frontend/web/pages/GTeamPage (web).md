---
title: "GTeamPage (web)"
type: frontend-page
layer: frontend
---

# GTeamPage (web)

## Sintesi

Pagina pubblica squadra con tab Team (info e statistiche), Players (giocatori), Matches (partite) e Share. Scroll-to-top.

## Route

`/g-team/:teamId` — Parametri: `teamId` — Pubblica

## Responsabilità

Mostra la pagina pubblica di una squadra. Organizzata in 4 tab: Team (informazioni generali, statistiche, lista giocatori), Players (dettaglio giocatori), Matches (partite della squadra), Share (condivisione). Include scroll-to-top per liste lunghe.

## Componenti usati

- [[EntityPageHeaderComponent (web)]]
- [[EntityTabsComponent (web)]]
- EntityStatsGridComponent (web)
- [[EntityShareComponent (web)]]
- EntityScrollToTopComponent (web)
- [[MatchCardListComponent (web)]]

## Servizi FE usati

- [[TeamService (web)]]
- [[MatchService (web)]]
- [[AnalyticsService (web)]]
- [[SeoMetadataService (web)]]

## Modelli FE usati

- [[teamPublicDto (web)]]
- [[playerDto (web)]]
- [[pageDto (web)]]
- [[matchMinDto (web)]]

## API dipendenti

- [[TeamsV1Controller (api)]]
- [[MatchesV1Controller (api)]]

## Tracking

- Evento GA: `team_viewed` con parametri `team_id`, `channel_id`, `players_count`

## SEO

- JSON-LD: `SportsTeam`, `sport: Rugby`, `athlete[]` (primi 30 giocatori), `memberOf` (channel)
- Title dinamico, canonical URL, og:image dal logo squadra

## Workflow correlati

Non deducibile

## Stati UI

- Loading
- Tab selezionata
- Scroll to top

## Note

Pagina pubblica, non richiede autenticazione. Il parametro `teamId` identifica la squadra da visualizzare. Tracking e SEO dedotti da `llm-wiki/raw/docs/rrl-team.md`.

