---
title: "lineupPlayerDto (web)"
type: frontend-model
layer: frontend
---

# lineupPlayerDto (web)

## Sintesi
DTO di risposta per un giocatore assegnato in formazione. Rappresenta uno dei 23 slot ruolo di una squadra per una partita specifica. Include voto post-partita ed eventi associati al giocatore.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | string | Identificatore univoco dell'assegnazione in formazione |
| player | playerDto | Dati anagrafici del giocatore |
| number | number | Numero ruolo nello slot (1-23) |
| rate | number | Voto assegnato al giocatore post-partita (es. 0-10) |
| events | lineupPlayerEventDto[] | Lista eventi associati al giocatore nella partita |

## Origine dati
- Parte di matchDto.homeTeamLineup e matchDto.awayTeamLineup (incluso in MTC-02)

## Consumer FE
- [[MatchLineupComponent (web)]]
- MatchEventsComponent (web) — per associare gli eventi ai giocatori
- matchDto (web) — via campi `homeTeamLineup` e `awayTeamLineup`

## API correlate
- MTC-02: GET partita completa (include le formazioni)

## Note
- `number` identifica lo slot ruolo nella formazione (1=portiere, 2-6=difensori, ecc.) secondo la convenzione dell'app.
- `events` sono gli eventi (gol, cartellini, ecc.) attribuiti a questo giocatore nella partita.
- `rate` è valorizzato solo dopo la fine della partita e dopo che l'editor ha assegnato i voti.
- Modelli collegati: playerDto (web), lineupPlayerEventDto (web).
