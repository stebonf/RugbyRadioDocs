---
title: "matchMinDto (web)"
type: frontend-model
layer: frontend
---

# matchMinDto (web)

## Sintesi
DTO di risposta per una partita in formato ridotto, ottimizzato per liste e caroselli. Contiene i dati essenziali per la visualizzazione in card senza caricare formazioni, eventi e statistiche complete.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | string | Identificatore univoco della partita |
| date | string | Data e ora della partita (ISO 8601) |
| dateShort | string | Data formattata breve per la UI |
| status | lookupDto | Stato della partita |
| homeTeamScore | number | Punteggio squadra casa |
| awayTeamScore | number | Punteggio squadra ospite |
| homeTeam | teamMinDto | Dati ridotti squadra casa |
| awayTeam | teamMinDto | Dati ridotti squadra ospite |
| channel | channelMinDto | Canale proprietario della partita |
| imageUrl | string | URL immagine di copertina della partita |

## Origine dati
- API: MTC-10 (partite recenti), MTC-11 (partite prossime), MTC-14 (partite per canale), MTC-17 (partite live), MTC-18 (partite per squadra)

## Consumer FE
- MatchCardSmallComponent (web)
- [[MatchCardListComponent (web)]]
- [[GMatchesPage (web)]]
- HomeLastMatchesComponent (web)
- HomeNextMatchesComponent (web)
- HomeOngoingMatchesComponent (web)

## API correlate
- MTC-10, MTC-11, MTC-14, MTC-17, MTC-18

## Note
- Versione alleggerita di matchDto: non include eventi, formazioni, statistiche o scoreboard.
- `dateShort` è una stringa preformattata lato API per evitare logiche di formattazione data nel FE.
