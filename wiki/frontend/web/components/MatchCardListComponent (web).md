---
title: "MatchCardListComponent (web)"
type: frontend-component
layer: frontend
---

# MatchCardListComponent (web)

## Sintesi
Lista paginata di partite in formato card ridotto (matchMinDto). Gestisce skeleton loading, stato vuoto e inserimento banner AdSense a frequenza configurabile.

## Responsabilità
- Visualizzare una lista paginata di matchMinDto tramite MatchCardSmallComponent
- Gestire la paginazione tramite EntityPaginationComponent
- Mostrare skeleton loading durante il caricamento
- Mostrare stato vuoto tramite EntityInfoComponent
- Inserire banner AdSense nel feed con frequenza configurabile

## Parent pages
- [[GChannelPage (web)]]
- [[GMatchesPage (web)]]
- [[GTeamPage (web)]]

## Child components
- [[MatchCardSmallComponent (web)]]
- [[EntityPaginationComponent (web)]]
- EntityInfoComponent (web)
- [[EntitySkeletonComponent (web)]]
- [[EntityAdsComponent (web)]]

## Servizi FE usati
Nessuno.

## Modelli FE usati
- [[pageDto (web)]]
- [[matchMinDto (web)]]

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | matches | pageDto<matchMinDto> | Pagina di partite da visualizzare |
| Input | isLoading | boolean | Attiva skeleton loading |
| Input | emptyIcon | string | Icona da mostrare nello stato vuoto |
| Input | adClient | string | ID client AdSense |
| Input | adSlot | string | ID slot AdSense |
| Input | adsFrequency | number | Frequenza inserimento ads nella lista |
| Output | openMatch | EventEmitter<matchMinDto> | Emesso al click su una card partita |
| Output | pageChange | EventEmitter<number> | Emesso al cambio pagina |

## Note
- Gli ads vengono inseriti ogni `adsFrequency` elementi nella lista.
- Lo stato vuoto viene mostrato quando `matches.items` è vuoto e `isLoading` è false.
