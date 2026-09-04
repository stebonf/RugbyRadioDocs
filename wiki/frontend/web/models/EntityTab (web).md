---
title: "EntityTab (web)"
type: frontend-model
layer: frontend
---

# EntityTab (web)

## Sintesi
View model per una singola tab nella navigation tab bar. Usato da EntityTabsComponent per definire le voci di navigazione configurabili.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | string | Identificatore univoco della tab (usato per selezione e disabilitazione) |
| label | string | Testo visualizzato nella tab |
| icon | string | Nome icona opzionale da mostrare nella tab (passato a IconComponent) |

## Origine dati
Definito lato FE nelle pagine che usano EntityTabsComponent. Non proviene dall'API.

## Consumer FE
- [[EntityTabsComponent (web)]]
- [[GChannelPage (web)]]
- [[GMatchPage (web)]]
- [[GTeamPage (web)]]
- [[ChannelPage (web)]]
- [[MatchPage (web)]]

## API correlate
Nessuna. Modello puramente frontend.

## Note
- Modello di tipo view model: non è un DTO API ma una struttura dati definita nel FE per configurare la UI.
- L'`id` viene usato da EntityTabsComponent sia per identificare la tab selezionata che per filtrarla dalla lista `disabledTabIds`.
- `icon` è opzionale: se non fornito, la tab mostra solo il `label`.
