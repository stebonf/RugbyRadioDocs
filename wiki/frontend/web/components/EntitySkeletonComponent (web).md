---
title: "EntitySkeletonComponent (web)"
type: frontend-component
layer: frontend
---

# EntitySkeletonComponent (web)

## Sintesi
Skeleton loader animato per stati di caricamento. Supporta quattro layout (header, card, list, text) configurabili con contatori per azioni, chip e voci lista.

## Responsabilità
- Visualizzare placeholder animati durante il caricamento dei dati
- Adattare il layout del placeholder in base all'input `layout`
- Supportare contatori configurabili per azioni, chip e voci lista

## Parent pages
- [[EntityPageHeaderComponent (web)]]
- [[ChannelCardListComponent (web)]]
- [[MatchCardListComponent (web)]]

## Child components
Nessuno.

## Servizi FE usati
Nessuno.

## Modelli FE usati
- SkeletonLayout (web)

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | layout | SkeletonLayout | Tipo di layout skeleton: `header`, `card`, `list`, `text` |
| Input | actionsCount | number | Numero di azioni skeleton da mostrare |
| Input | chipsCount | number | Numero di chip skeleton da mostrare |
| Input | listCount | number | Numero di voci lista skeleton da mostrare |

## Note
- Nessun output emesso: è un componente puramente visivo.
- SkeletonLayout è un enum/type che determina la struttura del placeholder.
