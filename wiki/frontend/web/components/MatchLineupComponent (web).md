---
title: "MatchLineupComponent (web)"
type: frontend-component
layer: frontend
---

# MatchLineupComponent (web)

## Sintesi
Componente formazione partita con 23 slot per ruolo. In edit mode permette di assegnare, rimuovere e creare giocatori inline. Post-partita supporta la valutazione (voto) dei giocatori.

## Responsabilità
- Visualizzare la formazione di una squadra con 23 slot ruolo numerati
- In edit mode: assegnare/rimuovere giocatori agli slot tramite MatchService e LineupService
- In edit mode: creare nuovi giocatori inline
- Post-partita: raccogliere i voti dei giocatori tramite MatchService
- Mostrare gli eventi associati ai giocatori in formazione

## Parent pages
- [[GMatchPage (web)]]
- [[MatchPage (web)]]

## Child components
- [[EntityButtonComponent (web)]]
- [[EntityAlertComponent (web)]]

## Servizi FE usati
- [[MatchService (web)]]
- [[LineupService (web)]]
- [[UserService (web)]]

## Modelli FE usati
- [[matchDto (web)]]
- [[lineupPlayerDto (web)]]
- playerDto (web)

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | match | matchDto | Dati completi della partita |
| Input | team | teamPublicDto | Squadra di cui visualizzare la formazione |
| Input | lineup | lineupPlayerDto[] | Array dei giocatori in formazione |
| Input | lineupRates | object | Mappa voti giocatori |
| Input | players | playerDto[] | Pool giocatori disponibili per assegnazione |
| Input | isStarted | boolean | La partita è iniziata |
| Input | isFullTime | boolean | La partita è terminata |
| Input | isEditMode | boolean | Abilita le funzionalità di editing |
| Output | matchChange | EventEmitter<matchDto> | Emesso dopo aggiornamenti alla partita |
| Output | playersChange | EventEmitter<playerDto[]> | Emesso dopo creazione di nuovi giocatori |

## Note
- Gli slot ruolo vanno da 1 a 23 secondo la numerazione standard.
- La creazione di giocatori inline salva direttamente tramite LineupService senza navigare fuori dal componente.
