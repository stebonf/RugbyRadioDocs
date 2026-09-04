---
title: "EntityTabsComponent (web)"
type: frontend-component
layer: frontend
---

# EntityTabsComponent (web)

## Sintesi
Navigation tab bar configurabile tramite array di EntityTab. Supporta tab disabilitate e gestisce la selezione attiva con emissione di evento al cambio tab.

## Responsabilità
- Renderizzare una barra di navigazione a tab configurabile
- Evidenziare la tab selezionata
- Disabilitare tab tramite lista di ID
- Emettere l'evento selectedTabChange al cambio di tab

## Parent pages
- [[GChannelPage (web)]]
- [[GMatchPage (web)]]
- [[GTeamPage (web)]]
- [[ChannelPage (web)]]
- [[MatchPage (web)]]

## Child components
- [[IconComponent (web)]]

## Servizi FE usati
Nessuno.

## Modelli FE usati
- [[EntityTab (web)]]

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | tabs | EntityTab[] | Array di tab da visualizzare |
| Input | selectedTab | string | ID della tab attualmente selezionata |
| Input | disabledTabIds | string[] | Array di ID tab da disabilitare |
| Output | selectedTabChange | EventEmitter<string> | Emesso con l'ID della tab selezionata |

## Note
- Il modello EntityTab definisce id, label e icon opzionale.
- Usato come navigazione secondaria all'interno delle pagine entità.
