---
title: "matchAddDto (web)"
type: frontend-model
layer: frontend
---

# matchAddDto (web)

## Sintesi
DTO di richiesta per la creazione o l'aggiornamento di una partita tramite l'area editor. Contiene data, squadre e fuso orario.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| dateDay | string | Data della partita (formato YYYY-MM-DD) |
| dateHour | string | Ora della partita (formato HH:mm) |
| homeTeamId | string | ID della squadra casa |
| awayTeamId | string | ID della squadra ospite |
| timezone | string | Fuso orario dell'evento (es. `Europe/Rome`) |

## Origine dati
Costruito lato FE da MatchPage o MatchService.

## Consumer FE
- [[MatchService (web)]]
- [[MatchPage (web)]]

## API correlate
- MTC-03: POST creazione nuova partita
- MTC-09: PUT aggiornamento partita esistente

## Note
- Differisce da `matchQuickAddDto` perché non include il canale (la partita viene creata nel contesto del canale già noto dalla pagina editor).
- `dateDay` e `dateHour` vengono combinati lato API in un unico timestamp con il `timezone` specificato.
