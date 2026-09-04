---
title: "LineupPlayerRated"
type: data-event
layer: data
---

# LineupPlayerRated

## Sintesi

Evento generato quando uno spettatore autenticato assegna un voto a un giocatore in formazione per una partita. Il voto e gestito da [[MatchService (api)]] come voto singolo per utente/giocatore: la repository verifica l'esistenza di un voto prima dell'inserimento. La persistenza usa [[LineupPlayerRate (api)]] con tabella `LineupPlayerRates`.

## Trigger

- `POST /v1/matches/{matchId}/lineups/{lineupId}/rate` su [[MatchesV1Controller (api)]] (endpoint MTC-11)
- Chiamata a `MatchService` in [[MatchService (api)]] che orchestra la scrittura e verifica esistenza voto tramite [[LineupPlayerRateRepository (api)]]

## Payload

- **Input**: `LineupPlayerRateDto` — `matchId`, `lineupId` (dalla route), `rate` (int), `UserId` (da autenticazione JWT)
- **Output persistito**: [[LineupPlayerRate (api)]] — `Id`, `LineupPlayerId`, `UserId`, `Rate`, `IsDeleted`, `Ts`

## Consumer

- [[MatchLineupComponent (web)]] — aggiornamento voti nella UI post-partita tramite input `lineupRates`
- [[lineupPlayerDto (web)]] — proprieta `rate` (number, 0-10) valorizzata nella risposta MTC-02 per gli spettatori

## Side effects

- Scrittura su DB nella tabella `LineupPlayerRates` tramite `ILineupPlayerRateRepository` in [[MatchService (api)]]
- Verifica esistenza voto per utente/formazione: se un voto esiste gia, il comportamento (sovrascrittura o rifiuto) non e deducibile dalla wiki
- Il voto e visibile pubblicamente nel DTO partita (`matchDto.homeTeamLineup`, `matchDto.awayTeamLineup`) dopo la valorizzazione

## Workflow correlati

- [[Spettatore Partita (workflow)]]

## Note

La votazione giocatore e attiva solo dopo il termine della partita (stato `FullTime`), come documentato in [[Squadra (concept)]] ("A fine partita gli spettatori possono votare i giocatori"). Il voto richiede account autenticato (cfr. [[Autenticazione Utente (workflow)]]). La logica esatta di sovrascrittura (re-vote permesso o bloccato), il range minimo/massimo di `Rate` e la visibilita in tempo reale (polling, SignalR) non sono deducibili dalla wiki.
