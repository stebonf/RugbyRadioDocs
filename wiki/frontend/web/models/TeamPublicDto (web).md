---
title: "teamPublicDto (web)"
type: frontend-model
layer: frontend
---

# teamPublicDto (web)

## Sintesi
DTO di risposta per una squadra pubblica completa. Include dati anagrafici della squadra, la lista dei giocatori e il canale di appartenenza.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | string | Identificatore univoco della squadra |
| name | string | Nome della squadra |
| logoUrl | string | URL logo della squadra |
| nickname | string | Soprannome/abbreviazione della squadra |
| players | playerDto[] | Lista giocatori della squadra |
| channel | channelMinDto | Canale di appartenenza della squadra |

## Origine dati
- API: TMS-06 (GET squadra pubblica per ID)

## Consumer FE
- [[GTeamPage (web)]]

## API correlate
- TMS-06: GET singola squadra pubblica con giocatori

## Note
- La lista `players` include tutti i giocatori della rosa, non solo quelli in formazione per una partita specifica.
- `channelMinDto` è la versione minima del canale con solo id, name e colori.
- Per la formazione specifica di una partita si usa `lineupPlayerDto` all'interno di `matchDto`.
