---
title: "ChannelCardListComponent (web)"
type: frontend-component
layer: frontend
---

# ChannelCardListComponent (web)

## Sintesi
Lista paginata di canali pubblici in formato card (channelPublicDto). Gestisce skeleton loading, stato vuoto e inserimento banner AdSense a frequenza configurabile.

## Responsabilità
- Visualizzare una lista paginata di channelPublicDto tramite ChannelCardComponent
- Gestire la paginazione tramite EntityPaginationComponent
- Mostrare skeleton loading durante il caricamento
- Mostrare stato vuoto tramite EntityInfoComponent
- Inserire banner AdSense nel feed con frequenza configurabile

## Parent pages
- [[GChannelsPage (web)]]

## Child components
- ChannelCardComponent (web)
- [[EntityPaginationComponent (web)]]
- EntityInfoComponent (web)
- [[EntitySkeletonComponent (web)]]
- [[EntityAdsComponent (web)]]

## Servizi FE usati
Nessuno.

## Modelli FE usati
- [[pageDto (web)]]
- [[channelPublicDto (web)]]

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | channels | pageDto<channelPublicDto> | Pagina di canali da visualizzare |
| Input | isLoading | boolean | Attiva skeleton loading |
| Input | emptyIcon | string | Icona da mostrare nello stato vuoto |
| Input | adClient | string | ID client AdSense |
| Input | adSlot | string | ID slot AdSense |
| Input | adsFrequency | number | Frequenza inserimento ads nella lista |
| Output | openChannel | EventEmitter<channelPublicDto> | Emesso al click su una card canale |
| Output | pageChange | EventEmitter<number> | Emesso al cambio pagina |

## Note
- Pattern identico a MatchCardListComponent ma per i canali.
- Gli ads vengono inseriti ogni `adsFrequency` elementi nella lista.
