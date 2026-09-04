---
title: "GStatsPage (web)"
type: frontend-page
layer: frontend
---

# GStatsPage (web)

## Sintesi

Statistiche globali della piattaforma: utenti, canali, partite, squadre, giocatori, eventi, emoji, commenti con top eventi per tipo.

## Route

`/g-stats` — Pubblica

## Responsabilità

Visualizza le statistiche aggregate dell'intera piattaforma: contatori di utenti, canali, partite, squadre, giocatori, eventi, emoji e commenti. Mostra anche i top eventi per tipo per fornire una panoramica dell'attività sulla piattaforma.

## Componenti usati

- [[EntityAlertComponent (web)]]
- [[EntityAdsComponent (web)]]
- [[IconComponent (web)]]

## Servizi FE usati

- [[StatsService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- [[statsDto (web)]]
- statsEventTypeDto (web)

## API dipendenti

- [[StatsV1Controller (api)]]

## Workflow correlati

Non deducibile

## Stati UI

- Loading
- Errore

## Note

Pagina pubblica, non richiede autenticazione. Fornisce una vista aggregata e anonimizzata dell'attività della piattaforma.

