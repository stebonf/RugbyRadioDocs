---
title: "TeamService (web)"
type: frontend-service
layer: frontend
---

# TeamService (web)

## Sintesi

API client per la gestione delle squadre. Supporta operazioni CRUD, upload loghi e accesso a squadre pubbliche.

## Responsabilità

- Creazione, lettura, aggiornamento ed eliminazione di squadre
- Upload e gestione loghi squadra
- Accesso alle squadre in modalità pubblica (guest)

## Metodi

- `getTeams(channelId)` → `teamChannelDto[]` — lista squadre del canale (TMS-01)
- `getLogos()` → `teamLogoDto` — loghi disponibili (TMS-04)
- `addTeam(channelId, model)` → `teamChannelDto` — crea squadra (TMS-02)
- `updateTeam(channelId, teamId, model)` → `teamChannelDto` — aggiorna squadra (TMS-03)
- `getUserTeams()` → `teamMinDto[]` — squadre dell'utente
- `getTeam(teamId)` → `teamPublicDto` — profilo pubblico squadra (TMS-06)

## Consumer FE

- [[GTeamPage (web)]]
- [[ChannelPage (web)]]
- HomeUserComponent (web)

## API chiamate

- [[TeamsV1Controller (api)]]

## DTO o modelli usati

- [[teamMinDto (web)]]
- [[teamChannelDto (web)]]
- [[teamPublicDto (web)]]
- [[playerDto (web)]]
- [[teamAddDto (web)]]
- [[teamUpdateDto (web)]]
- [[teamLogoDto (web)]]

## Side effects

- Chiamate HTTP verso le API backend

## Note

`teamPublicDto` è utilizzato per le viste guest non autenticate. `teamChannelDto` contiene le informazioni di squadra contestualizzate a un canale specifico. Metodi e mapping endpoint dedotti da `llm-wiki/raw/docs/rrl-team.md`.

