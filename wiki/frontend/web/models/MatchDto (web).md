---
title: "matchDto (web)"
type: frontend-model
layer: frontend
---

# matchDto (web)

## Sintesi
DTO di risposta per una partita completa. Include formazioni, eventi telecronaca, commenti, statistiche, scoreboard e lo stato relativo all'utente corrente (like, follow, editor).

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | string | Identificatore univoco della partita |
| date | string | Data e ora della partita (ISO 8601) |
| status | lookupDto | Stato della partita (pianificata, in corso, terminata, ecc.) |
| homeTeamScore | number | Punteggio squadra casa |
| awayTeamScore | number | Punteggio squadra ospite |
| minute | number | Minuto corrente di gioco |
| homeTeamLineup | lineupPlayerDto[] | Formazione squadra casa (23 slot) |
| awayTeamLineup | lineupPlayerDto[] | Formazione squadra ospite (23 slot) |
| events | matchEventDto[] | Lista eventi telecronaca |
| comments | matchCommentDto[] | Lista commenti alla partita |
| homeStats | object | Statistiche squadra casa |
| awayStats | object | Statistiche squadra ospite |
| stats | object | Statistiche comparative aggregate |
| channel | channelPublicMinDto | Canale proprietario della partita |
| scoreboard | matchScoreboardTimelineItemDto[] | Timeline punteggi |
| likes | number | Numero totale di like |
| userLike | boolean | L'utente corrente ha messo like |
| userFollow | boolean | L'utente corrente segue la partita |
| isEditor | boolean | L'utente corrente è editor della partita |

## Origine dati
- API: MatchesV1Controller (api), endpoint MTC-02 (GET /matches/:id)

## Consumer FE
- [[GMatchPage (web)]]
- [[MatchPage (web)]]
- [[MatchHeaderComponent (web)]]
- [[MatchEventsComponent (web)]]
- [[MatchLineupComponent (web)]]
- [[MatchStatsComponent (web)]]

## API correlate
- MTC-02: GET singola partita completa

## Note
- Il campo `status` è un `lookupDto` con id e label localizzata.
- I campi `userLike`, `userFollow`, `isEditor` sono popolati solo se l'utente è autenticato.
