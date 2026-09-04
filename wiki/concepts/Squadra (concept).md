---
title: "Squadra (concept)"
type: concept
layer: concept
---

# Squadra (concept)

## Sintesi

Squadra di rugby associata a un [[Radio Canale (concept)]]. Usata come squadra di casa (`HomeTeam`) o ospite (`AwayTeam`) in una [[Partita (concept)]]. I giocatori appartengono alla squadra e vengono assegnati a ruoli di formazione tramite `LineupPlayer`.

## Scope

La squadra rappresenta un'entità sportiva anagrafica con nome, logo, soprannome e rosa giocatori. Non include dati di partita o statistiche aggregate (gestite a livello di partita o canale).

## Componenti coinvolti

- Backend entity: [[Team (api)]], [[Player (api)]], [[LineupPlayer (api)]]
- Backend service: [[TeamService (api)]], [[PlayerService (api)]], [[LineupPlayerService (api)]]
- Backend API: [[TeamsV1Controller (api)]], [[PlayersV1Controller (api)]]
- Backend repository: [[TeamRepository (api)]], [[PlayerRepository (api)]], [[LineupPlayerRepository (api)]]
- Frontend page: [[GTeamPage (web)]]
- Frontend service: [[TeamService (web)]], [[PlayerService (web)]], [[LineupService (web)]]
- Frontend component: [[MatchLineupComponent (web)]]
- Frontend model: [[teamPublicDto (web)]], [[TeamTabIdModel (web)]], [[lineupPlayerDto (web)]]

## Relazioni principali

- Ogni squadra appartiene a un canale ([[Radio Canale (concept)]]) tramite FK `ChannelId`
- Due squadre (casa e ospite) partecipano a una [[Partita (concept)]]
- I [[Player (api)]] appartengono a una squadra tramite FK `TeamId`
- La formazione di partita collega squadra, partita e giocatori tramite [[LineupPlayer (api)]]
- La squadra visibile pubblicamente su [[GTeamPage (web)]] con tab Team, Players, Matches e Share
- Il cronista crea e gestisce le squadre del proprio canale tramite [[TeamService (api)]] e [[TeamService (web)]]

## Ciclo di vita

1. Il [[Cronista (actor)]] crea una squadra associata a un canale (owner primario o co-owner)
2. I giocatori vengono aggiunti alla rosa della squadra
3. Alla creazione di una partita, due squadre vengono selezionate come casa e ospite
4. Il sistema genera 23 slot formazione (`LineupPlayer`) per ogni squadra, assegnando giocatori per numero di maglia
5. Durante la partita il cronista clicca eventi riferiti ai giocatori in formazione
6. A fine partita gli spettatori possono votare i giocatori (`LineupPlayerRate`)
7. La squadra rimane associata al canale e riutilizzabile per partite future

## Decisioni architetturali

- Ownership verificata su canale (non su singola squadra): solo owner primario può modificare giocatori, co-owner può gestire squadre
- Avatar giocatore di default assegnato automaticamente alla creazione (`/images/avatars/players/{n}.png`)
- Eliminazione giocatore vincolata alla squadra di appartenenza

## Rischi

- Dettaglio di validazione alla creazione squadra non deducibile dalla wiki
- Relazioni tra squadra e classifiche/campionati non deducibili

## Note

Pagina creata da pagine wiki esistenti su entità, servizi, API, frontend e concept correlati. Nessun RAW letto.
