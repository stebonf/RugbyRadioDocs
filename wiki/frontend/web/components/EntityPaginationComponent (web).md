---
title: "EntityPaginationComponent (web)"
type: frontend-component
layer: frontend
---

# EntityPaginationComponent (web)

## Sintesi
Componente di paginazione con logica ellissi adattiva e comportamento responsive. Mostra i controlli precedente/successivo e i numeri di pagina con collasso intelligente per liste lunghe.

## Responsabilità
- Calcolare e visualizzare i controlli di paginazione
- Gestire l'ellissi adattiva per grandi numeri di pagine
- Disabilitare i controlli durante il caricamento
- Emettere pageChange con il numero di pagina selezionata

## Parent pages
- [[ChannelCardListComponent (web)]]
- [[MatchCardListComponent (web)]]

## Child components
- [[IconComponent (web)]]

## Servizi FE usati
Nessuno.

## Modelli FE usati
Nessuno.

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | currentPage | number | Pagina corrente (1-based) |
| Input | totalItems | number | Numero totale di elementi |
| Input | pageSize | number | Numero di elementi per pagina |
| Input | isLoading | boolean | Disabilita i controlli durante il caricamento |
| Output | pageChange | EventEmitter<number> | Emesso con il numero della pagina selezionata |

## Note
- Il numero totale di pagine è calcolato internamente come `ceil(totalItems / pageSize)`.
- Responsive: riduce il numero di pagine visibili su schermi piccoli.
