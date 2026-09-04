---
title: "channelTableDto (web)"
type: frontend-model
layer: frontend
---

# channelTableDto (web)

## Sintesi
DTO di risposta per una riga della classifica squadre di un canale. Contiene statistiche aggregate (partite giocate, vittorie, sconfitte, pareggi, punti).

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| teamId | string | Identificatore univoco della squadra |
| teamName | string | Nome della squadra |
| teamLogo | string | URL logo della squadra |
| played | number | Partite giocate |
| won | number | Partite vinte |
| lost | number | Partite perse |
| drawn | number | Partite pareggiate |
| pointsFor | number | Punti/gol segnati |
| pointsAgainst | number | Punti/gol subiti |
| pointsDifference | number | Differenza punti/gol (pointsFor - pointsAgainst) |

## Origine dati
- Parte di channelPublicDto.tables (incluso in CHL-10)

## Consumer FE
- ChannelTablesComponent (web)
- [[GChannelPage (web)]]

## API correlate
- CHL-10: GET canale pubblico completo (include la classifica nel campo `tables`)

## Note
- La classifica è calcolata lato API aggregando i risultati di tutte le partite del canale.
- L'ordinamento della classifica (per punti, differenza reti, ecc.) è determinato lato API.
- `pointsFor` e `pointsAgainst` possono rappresentare gol (calcio), punti (basket), ecc. a seconda dello sport del canale.
