---
title: "statsDto (web)"
type: frontend-model
layer: frontend
---

# statsDto (web)

## Sintesi
DTO di risposta per le statistiche globali della piattaforma. Aggrega contatori di utenti, canali, partite, squadre, giocatori, eventi e reazioni emoji.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| users | number | Numero totale di utenti registrati |
| channels | number | Numero totale di canali creati |
| matches | number | Numero totale di partite telecronacate |
| teams | number | Numero totale di squadre |
| players | number | Numero totale di giocatori |
| events | number | Numero totale di eventi telecronaca |
| eventsByType | statsEventTypeDto[] | Distribuzione eventi per tipo |
| emojis | number | Numero totale di reazioni emoji |
| comments | number | Numero totale di commenti |

## Origine dati
- API: STS-01 (GET statistiche globali piattaforma)

## Consumer FE
- [[GStatsPage (web)]]

## API correlate
- STS-01: GET statistiche globali

## Note
- `eventsByType` è un array di `statsEventTypeDto` con la distribuzione per tipo evento (gol, cartellini, ecc.).
- Questo DTO è pubblico e non richiede autenticazione.
- Usato esclusivamente dalla pagina statistiche pubblica GStatsPage.
