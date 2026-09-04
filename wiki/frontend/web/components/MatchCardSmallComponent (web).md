---
title: "MatchCardSmallComponent (web)"
type: frontend-component
layer: frontend
---

# MatchCardSmallComponent (web)

## Sintesi

Card ridotta per visualizzare una partita in formato sintetico. Usata all'interno di MatchCardListComponent per elenchi paginati.

## Responsabilità

- Visualizzare i dati di una partita in formato card compatta
- Emettere evento al click per navigazione al dettaglio

## Parent pages

- [[GChannelPage (web)]]
- [[GMatchesPage (web)]]
- [[GTeamPage (web)]]

## Child components

- (nessuno)

## Modelli FE usati

- [[matchMinDto (web)]]

## Eventi input/output

| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | match | matchMinDto | Dati partita da visualizzare |
| Output | openMatch | EventEmitter<matchMinDto> | Emesso al click sulla card |

## Note

Componente non documentato in dettaglio nei RAW. Dettagli implementativi (template, stili, stati UI) non deducibili.
