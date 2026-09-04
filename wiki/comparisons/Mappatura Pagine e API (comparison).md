---
title: "Mappatura Pagine e API (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Pagine e API (comparison)

## Sintesi

Confronto tra le pagine frontend (`web`) e i controller API backend (`api`) di [[Rugby Radio Live (architecture)]], con lo scopo di mostrare quali pagine consumano direttamente quali API e quali API non hanno una pagina consumer diretta.

## Scope

Tutte le 18 pagine frontend documentate in `wiki/frontend/web/pages/` e tutti i 13 controller API documentati in `wiki/backend/api/apis/`.

## Mappatura

### Pagine FE e API dipendenti

| Pagina FE | API BE dipendenti |
|---|---|
| [[HomePage (web)]] | [[ChannelsV1Controller (api)]], [[MatchesV1Controller (api)]] |
| [[LoginPage (web)]] | [[AuthV1Controller (api)]] |
| [[RegistrationPage (web)]] | [[AuthV1Controller (api)]] |
| [[ResetPasswordPage (web)]] | [[AuthV1Controller (api)]] |
| [[ProfilePage (web)]] | [[UserV1Controller (api)]] |
| [[ChannelsPage (web)]] | [[ChannelsV1Controller (api)]] |
| [[ChannelPage (web)]] | [[ChannelsV1Controller (api)]], [[TeamsV1Controller (api)]] |
| [[MatchPage (web)]] | [[MatchesV1Controller (api)]], [[PlayersV1Controller (api)]], [[BlogV1Controller (api)]] |
| [[DangerPage (web)]] | [[UserV1Controller (api)]] |
| [[FavoritesPage (web)]] | [[ChannelsV1Controller (api)]] |
| [[GChannelPage (web)]] | [[ChannelsV1Controller (api)]], [[MatchesV1Controller (api)]] |
| [[GMatchPage (web)]] | [[MatchesV1Controller (api)]], [[BlogV1Controller (api)]] |
| [[GMatchesPage (web)]] | [[MatchesV1Controller (api)]] |
| [[GChannelsPage (web)]] | [[ChannelsV1Controller (api)]] |
| [[GTeamPage (web)]] | [[TeamsV1Controller (api)]], [[MatchesV1Controller (api)]] |
| [[GStatsPage (web)]] | [[StatsV1Controller (api)]] |
| [[GFeedbackPage (web)]] | [[UserV1Controller (api)]] |
| [[AdminMaintenancePage (web)]] | Nessuna |

### API BE e pagine FE consumer

| API BE | Pagine FE consumer |
|---|---|
| [[AuthV1Controller (api)]] | [[LoginPage (web)]], [[RegistrationPage (web)]], [[ResetPasswordPage (web)]] |
| [[UserV1Controller (api)]] | [[ProfilePage (web)]], [[DangerPage (web)]], [[GFeedbackPage (web)]] |
| [[ChannelsV1Controller (api)]] | [[HomePage (web)]], [[ChannelsPage (web)]], [[ChannelPage (web)]], [[FavoritesPage (web)]], [[GChannelPage (web)]], [[GChannelsPage (web)]] |
| [[MatchesV1Controller (api)]] | [[HomePage (web)]], [[MatchPage (web)]], [[GChannelPage (web)]], [[GMatchesPage (web)]], [[GTeamPage (web)]], [[GMatchPage (web)]] |
| [[BlogV1Controller (api)]] | [[MatchPage (web)]], [[GMatchPage (web)]] |
| [[PlayersV1Controller (api)]] | [[MatchPage (web)]] |
| [[TeamsV1Controller (api)]] | [[ChannelPage (web)]], [[GTeamPage (web)]] |
| [[StatsV1Controller (api)]] | [[GStatsPage (web)]] |

### API BE senza pagina FE consumer diretta

| API BE | Note |
|---|---|
| [[AdminV1Controller (api)]] | Pagina [[AdminMaintenancePage (web)]] indica "Nessuna API dipendente"; possibile chiamata diretta o assente |
| [[ChannelUsersV1Controller (api)]] | Chiamato da [[ChannelUserService (web)]] ma nessuna pagina FE lo dichiara come dipendenza diretta |
| [[MatchEventsV1Controllers (api)]] | Chiamato da [[MatchService (web)]] ma nessuna pagina FE lo dichiara come dipendenza diretta |
| [[MatchLineupsV1Controller (api)]] | Chiamato da [[MatchService (web)]] e [[LineupService (web)]] ma nessuna pagina FE lo dichiara come dipendenza diretta |
| [[VoicesV1Controller (api)]] | Chiamato da [[VoiceService (web)]] ma nessuna pagina FE lo dichiara come dipendenza diretta |

### Pagina FE senza dipendenza API

[[AdminMaintenancePage (web)]] non dichiara API dipendenti. Opera verosimilmente come pagina informativa di stato o manutenzione.

## Pattern

- Le API di dominio piu utilizzate sono [[ChannelsV1Controller (api)]] (6 pagine) e [[MatchesV1Controller (api)]] (6 pagine), coerentemente con il prodotto centrato su canali e partite.
- [[AuthV1Controller (api)]] e [[UserV1Controller (api)]] servono esclusivamente pagine del flusso utente (login, registrazione, profilo, cancellazione, feedback).
- [[BlogV1Controller (api)]] e usato solo dalle due pagine partita (editor e pubblica).
- Le API tecniche o di nicchia ([[ChannelUsersV1Controller (api)]], [[MatchEventsV1Controllers (api)]], [[MatchLineupsV1Controller (api)]], [[VoicesV1Controller (api)]]) non hanno pagine FE che le dichiarano come dipendenza diretta: vengono chiamate esclusivamente tramite servizi FE intermedi ([[ChannelUserService (web)]], [[MatchService (web)]], [[LineupService (web)]], [[VoiceService (web)]]).
- La maggior parte delle pagine pubbliche (G-* pages) dipende da pochi controller, mentre MatchPage (editor) ne coinvolge tre (Matches, Players, Blog).
- [[AdminV1Controller (api)]] e l'unico controller senza alcuna dipendenza diretta da pagina FE documentata.

## Note

Mappatura dedotta dalle sezioni "API dipendenti" delle singole pagine frontend. Le dipendenze indirette (pagina → servizio FE → API) non sono incluse in questa tabella; sono documentate in [[Mappatura Servizi FE e BE (comparison)]]. I consumer FE effettivi di AdminV1Controller non sono deducibili con certezza dalla wiki.
