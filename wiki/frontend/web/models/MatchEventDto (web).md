---
title: "matchEventDto (web)"
type: frontend-model
layer: frontend
---

# matchEventDto (web)

## Sintesi
DTO di risposta per un singolo evento della telecronaca di una partita. Include tipo evento, minuto, giocatori coinvolti, reazioni emoji, commenti, icona e testo generato (opzionalmente via AI).

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | string | Identificatore univoco dell'evento |
| type | matchEventType | Tipo evento (gol, ammonizione, espulsione, ecc.) |
| minute | number | Minuto di gioco in cui si è verificato l'evento |
| player | lineupPlayerDto | Giocatore principale coinvolto |
| assistPlayer | lineupPlayerDto | Giocatore assistman (opzionale) |
| iconUrl | string | URL icona rappresentativa del tipo evento |
| text | string | Testo descrittivo dell'evento (generato o manuale) |
| reactions | matchEventReactionDto[] | Lista reazioni emoji degli utenti |
| comments | matchCommentDto[] | Lista commenti all'evento |
| imageUrl | string | URL immagine allegata all'evento (opzionale) |

## Origine dati
- Parte di matchDto.events (incluso in MTC-02)
- API aggiunta evento: EVT-03

## Consumer FE
- [[MatchEventsComponent (web)]]
- matchDto (web) — via campo `events`

## API correlate
- MTC-02: GET partita completa (include gli eventi)
- EVT-03: POST aggiunta nuovo evento

## Note
- `matchEventType` è un enum che determina l'icona e il comportamento visivo dell'evento nel feed.
- Il testo può essere generato automaticamente dall'AI in base al tipo evento e al telecronista selezionato.
- I modelli collegati includono: matchEventType (web), lineupPlayerDto (web), matchCommentDto (web).
