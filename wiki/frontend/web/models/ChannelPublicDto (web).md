---
title: "channelPublicDto (web)"
type: frontend-model
layer: frontend
---

# channelPublicDto (web)

## Sintesi
DTO di risposta per un canale pubblico completo. Include owner, statistiche di engagement, stato follow dell'utente, squadre associate e classifica.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | string | Identificatore univoco del canale |
| ownerId | string | ID dell'utente proprietario |
| owner | userProfileMinDto | Dati ridotti del proprietario |
| name | string | Nome del canale |
| headerBgColor | string | Colore sfondo header (hex) |
| headerFtColor | string | Colore testo header (hex) |
| matchesCount | number | Numero totale di partite nel canale |
| likeCount | number | Numero totale di follower/like |
| userFollow | boolean | L'utente corrente segue il canale |
| teams | teamMinDto[] | Squadre associate al canale |
| tables | channelTableDto[] | Classifica squadre del canale |

## Origine dati
- API: CHL-10 (GET canale pubblico per publicId), CHL-11 (GET lista canali pubblici)

## Consumer FE
- [[GChannelPage (web)]]
- ChannelCardComponent (web)
- [[ChannelCardListComponent (web)]]

## API correlate
- CHL-10: GET singolo canale pubblico
- CHL-11: GET lista canali pubblici paginata

## Note
- `userFollow` è popolato solo se l'utente è autenticato.
- I colori `headerBgColor` e `headerFtColor` vengono usati da EntityPageHeaderComponent per il gradiente visivo.
- `tables` contiene la classifica come array di channelTableDto.
