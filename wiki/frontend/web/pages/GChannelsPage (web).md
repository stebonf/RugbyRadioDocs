---
title: "GChannelsPage (web)"
type: frontend-page
layer: frontend
---

# GChannelsPage (web)

## Sintesi

Lista pubblica canali con ricerca testuale e paginazione. Persiste page e ricerca in sessionStorage. Scroll-to-top.

## Route

`/g-channels` — Pubblica

## Responsabilità

Visualizza la lista pubblica di tutti i canali con supporto a ricerca testuale e paginazione. Persiste lo stato corrente (pagina e testo di ricerca) in sessionStorage per mantenere la posizione alla navigazione. Include scroll-to-top per facilitare la navigazione in liste lunghe.

## Componenti usati

- [[ChannelCardListComponent (web)]]
- [[EntitySearchComponent (web)]]
- EntityScrollToTopComponent (web)

## Servizi FE usati

- [[ChannelService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- [[pageDto (web)]]
- [[channelPublicDto (web)]]

## API dipendenti

- [[ChannelsV1Controller (api)]]

## Workflow correlati

Non deducibile

## Stati UI

- Loading
- Scroll to top

## Note

Pagina pubblica, non richiede autenticazione. La persistenza in sessionStorage garantisce che l'utente torni alla stessa pagina e ricerca dopo la navigazione.

