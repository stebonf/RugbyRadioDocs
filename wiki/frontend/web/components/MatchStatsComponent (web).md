---
title: "MatchStatsComponent (web)"
type: frontend-component
layer: frontend
---

# MatchStatsComponent (web)

## Sintesi
Componente statistiche comparative della partita. Visualizza barre percentuali per le statistiche home/away e una timeline degli eventi punteggio.

## Responsabilità
- Visualizzare le statistiche comparative home vs away tramite barre percentuali
- Renderizzare la timeline degli eventi punteggio (scoreboard)
- Derivare i dati di visualizzazione dal matchDto in input

## Parent pages
- [[GMatchPage (web)]]
- [[MatchPage (web)]]

## Child components
Nessuno.

## Servizi FE usati
Nessuno.

## Modelli FE usati
- [[matchDto (web)]]
- matchScoreboardTimelineItemDto (web)

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | match | matchDto | Dati completi della partita (include homeStats, awayStats, scoreboard) |

## Note
- Nessun output emesso: componente puramente visualizzativo.
- Le barre percentuali sono calcolate come rapporto tra valore home e valore away per ciascuna statistica.
- La timeline è derivata da `match.scoreboard` e visualizza i momenti in cui è cambiato il punteggio.
