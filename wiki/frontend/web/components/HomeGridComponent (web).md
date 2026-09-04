---
title: "HomeGridComponent (web)"
type: frontend-component
layer: frontend
---

# HomeGridComponent (web)

## Sintesi
Componente griglia/carosello generico tipizzato <T> per la home page. Visualizza una lista paginata di elementi con template configurabile, skeleton loading e link "Vedi tutti" navigabile.

## Responsabilità
- Visualizzare una griglia o carosello di elementi di tipo generico T
- Renderizzare ogni elemento tramite un template esterno configurabile (itemTemplate)
- Gestire skeleton loading con contatore configurabile
- Fornire il link "Vedi tutti" basato su config.viewAllRoute
- Emettere itemClick al click su un elemento

## Parent pages
- HomeLastChannelsComponent (web)
- HomeLastMatchesComponent (web)
- HomeNextMatchesComponent (web)
- HomeOngoingMatchesComponent (web)

## Child components
Nessuno (il rendering degli item è delegato al template esterno).

## Servizi FE usati
Nessuno.

## Modelli FE usati
- pageDto (web) — contenitore degli item
- HomeListConfig (web) — configurazione titolo, route "vedi tutti", ecc.

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | items | pageDto<T> | Pagina di elementi da visualizzare |
| Input | config | HomeListConfig | Configurazione del componente (titolo, viewAllRoute, ecc.) |
| Input | itemTemplate | TemplateRef<any> | Template Angular per il rendering di ogni item |
| Input | isLoading | boolean | Attiva skeleton loading |
| Input | skeletonCount | number | Numero di placeholder skeleton da mostrare |
| Output | itemClick | EventEmitter<T> | Emesso con l'elemento al click su una card |

## Note
- La genericità tramite <T> permette di riutilizzare lo stesso componente per partite, canali e qualsiasi altra entità.
- La navigazione "Vedi tutti" usa il router Angular con la route definita in `config.viewAllRoute`.
