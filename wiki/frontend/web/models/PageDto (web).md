---
title: "pageDto (web)"
type: frontend-model
layer: frontend
---

# pageDto (web)

## Sintesi
DTO di risposta generico per la paginazione lato server. Tipizzato con <T> per contenere qualsiasi tipo di elemento. Usato da tutti i componenti lista dell'app.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| currentPage | number | Numero della pagina corrente (1-based) |
| pageSize | number | Numero di elementi per pagina |
| totalPages | number | Numero totale di pagine |
| totalItems | number | Numero totale di elementi |
| items | T[] | Array degli elementi della pagina corrente |

## Origine dati
Tutti gli endpoint API che restituiscono liste paginate.

## Consumer FE
- [[ChannelCardListComponent (web)]]
- [[MatchCardListComponent (web)]]
- [[EntityPaginationComponent (web)]]
- [[HomeGridComponent (web)]]
- [[GMatchesPage (web)]]
- [[GChannelsPage (web)]]

## API correlate
Tutti gli endpoint con paginazione (MTC-10, MTC-11, MTC-14, CHL-11, ecc.).

## Note
- Modello generico: viene specializzato nel codice come `pageDto<matchMinDto>`, `pageDto<channelPublicDto>`, ecc.
- `totalPages` è ridondante rispetto a `ceil(totalItems / pageSize)` ma viene fornito dall'API per comodità.
- `currentPage` è 1-based per allineamento con la convenzione dell'API.
