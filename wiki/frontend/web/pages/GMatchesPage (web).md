---
title: "GMatchesPage (web)"
type: frontend-page
layer: frontend
---

# GMatchesPage (web)

## Sintesi

Lista pubblica partite con ricerca testuale e paginazione. Persiste page e ricerca in sessionStorage. Scroll-to-top.

## Route

`/g-matches` — Pubblica

## Responsabilità

Visualizza la lista pubblica di tutte le partite con supporto a ricerca testuale e paginazione. Persiste lo stato corrente (pagina e testo di ricerca) in sessionStorage per mantenere la posizione alla navigazione. Include scroll-to-top per facilitare la navigazione in liste lunghe.

## Componenti usati

- [[MatchCardListComponent (web)]]
- [[EntitySearchComponent (web)]]
- EntityScrollToTopComponent (web)

## Servizi FE usati

- [[MatchService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- [[pageDto (web)]]
- [[matchMinDto (web)]]

## API dipendenti

- [[MatchesV1Controller (api)]]

## Workflow correlati

Non deducibile

## Stati UI

- Loading
- Scroll to top

## Note

Pagina pubblica, non richiede autenticazione. La persistenza in sessionStorage garantisce che l'utente torni alla stessa pagina e ricerca dopo la navigazione.

