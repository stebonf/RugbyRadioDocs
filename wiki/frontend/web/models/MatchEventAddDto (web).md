---
title: "matchEventAddDto (web)"
type: frontend-model
layer: frontend
---

# matchEventAddDto (web)

## Sintesi
DTO di richiesta per l'aggiunta di un evento telecronaca a una partita in corso. Contiene tipo evento, giocatore, territorio, commento e flag per la generazione AI dell'emoji.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| teamId | string | ID della squadra a cui appartiene l'evento |
| lineupPlayerId | string | ID del giocatore in formazione coinvolto (opzionale) |
| type | matchEventType | Tipo di evento (gol, ammonizione, espulsione, ecc.) |
| subType | string | Sottotipo evento (opzionale, es. rigore per i gol) |
| territory | territoryType | Zona del campo in cui si è verificato l'evento |
| comment | string | Commento testuale libero sull'evento (opzionale) |
| useAiEmoji | boolean | Se true, l'API genera automaticamente l'emoji tramite AI |

## Origine dati
Costruito lato FE da MatchEventsComponent in edit mode.

## Consumer FE
- [[MatchEventsComponent (web)]]
- [[MatchService (web)]]

## API correlate
- EVT-03: POST aggiunta evento telecronaca

## Note
- `matchEventType` è un enum condiviso con `matchEventDto`.
- `territoryType` è un enum che identifica la zona del campo (es. area di rigore, centrocampo, ecc.).
- `lineupPlayerId` è opzionale: non tutti i tipi di evento richiedono un giocatore specifico.
- `useAiEmoji` attiva la generazione di testo/emoji contestuale tramite AI lato API.
