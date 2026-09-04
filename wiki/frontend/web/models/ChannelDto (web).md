---
title: "channelDto (web)"
type: frontend-model
layer: frontend
---

# channelDto (web)

## Sintesi
DTO di risposta per un canale privato accessibile nell'area editor/owner. Include configurazione header, URL pubblico e lista partite associate.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | string | Identificatore univoco del canale |
| name | string | Nome del canale |
| publicId | string | Slug pubblico del canale (usato nell'URL pubblico) |
| headerBgColor | string | Colore sfondo header (hex) |
| headerFtColor | string | Colore testo header (hex) |
| headerTitle | string | Titolo personalizzato dell'header |
| headerSubtitle | string | Sottotitolo personalizzato dell'header |
| matches | matchMinDto[] | Lista partite associate al canale |

## Origine dati
- API: CHL-01 (GET lista canali dell'utente), CHL-02 (GET singolo canale privato)

## Consumer FE
- [[ChannelsPage (web)]]
- [[ChannelPage (web)]]
- [[FavoritesPage (web)]]
- MatchCreateComponent (web) — come sorgente canali selezionabili

## API correlate
- CHL-01: GET lista canali dell'utente autenticato
- CHL-02: GET singolo canale privato

## Note
- Versione privata/editor di channelPublicDto: include campi di configurazione header non esposti pubblicamente.
- `publicId` è lo slug usato per costruire l'URL pubblico del canale (es. `/c/:publicId`).
- `matches` è una lista ridotta (matchMinDto) per la visualizzazione nella gestione canale.
