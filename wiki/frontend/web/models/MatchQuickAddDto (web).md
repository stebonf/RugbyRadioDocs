---
title: "matchQuickAddDto (web)"
type: frontend-model
layer: frontend
---

# matchQuickAddDto (web)

## Sintesi
DTO di richiesta per la creazione rapida di una partita tramite il wizard MatchCreateComponent. Include canale e squadre in formato quick (con possibilità di creazione inline).

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| dateDay | string | Data della partita (formato YYYY-MM-DD) |
| channel | matchQuickItemAddDto | Riferimento/creazione canale per la partita |
| homeTeam | matchQuickItemAddDto | Riferimento/creazione squadra casa |
| awayTeam | matchQuickItemAddDto | Riferimento/creazione squadra ospite |

## Origine dati
Costruito lato FE da MatchCreateComponent.

## Consumer FE
- [[MatchCreateComponent (web)]]
- [[MatchService (web)]]

## API correlate
- MTC-17: POST creazione rapida partita

## Note
- `matchQuickItemAddDto` permette di referenziare un'entità esistente tramite ID oppure di crearla inline con un nome (pattern create-or-reference).
- Differisce da `matchAddDto` perché include il canale e usa il pattern quick con squadre identificate per nome o ID.
- Usato esclusivamente dal flusso di creazione rapida partita (bottom nav → drawer).
