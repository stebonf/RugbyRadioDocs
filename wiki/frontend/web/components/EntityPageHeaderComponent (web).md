---
title: "EntityPageHeaderComponent (web)"
type: frontend-component
layer: frontend
---

# EntityPageHeaderComponent (web)

## Sintesi
Layout header di pagina con supporto a immagine di sfondo, immagine media circolare, titolo, sottotitolo, badge e skeleton loading. Usato come header visivo nelle pagine entità principali.

## Responsabilità
- Visualizzare un header visivo con background image e media image
- Mostrare titolo, sottotitolo e badge configurabili
- Gestire lo stato di skeleton loading durante il caricamento dati
- Emettere evento mediaClick quando l'utente clicca sull'immagine media

## Parent pages
- [[GChannelPage (web)]]
- [[GTeamPage (web)]]
- [[ProfilePage (web)]]
- [[ChannelsPage (web)]]
- [[ChannelPage (web)]]

## Child components
- [[IconComponent (web)]]
- [[EntitySkeletonComponent (web)]]

## Servizi FE usati
Nessuno.

## Modelli FE usati
Nessuno.

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | title | string | Titolo principale dell'header |
| Input | subtitle | string | Sottotitolo dell'header |
| Input | backgroundImageUrl | string | URL immagine di sfondo |
| Input | mediaImageUrl | string | URL immagine media circolare |
| Input | isLoading | boolean | Attiva skeleton loading |
| Input | skeletonActionsCount | number | Numero di azioni skeleton da mostrare |
| Output | mediaClick | EventEmitter<void> | Emesso al click sull'immagine media |

## Note
- Lo skeleton loading delega la visualizzazione a EntitySkeletonComponent con layout `header`.
- I colori dell'header possono essere sovrapposti dal componente parent tramite CSS custom properties.
