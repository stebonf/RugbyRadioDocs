---
title: "Mappatura Modelli FE e Entity BE (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Modelli FE e Entity BE (comparison)

## Sintesi

Confronto tra i modelli frontend (`web`) e le entity backend (`api`) di [[Rugby Radio Live (architecture)]], con lo scopo di chiarire il confine FE/BE nel layer dati, mostrare quali DTO corrispondono a entity persistenti e quali sono modelli puramente frontend.

## Scope

Tutti i modelli frontend documentati in `wiki/frontend/web/models/` e tutte le entity backend documentate in `wiki/backend/api/entities/`.

## Mappatura

### DTO di dominio con entity BE diretta

| Modello FE | Entity BE | Note |
|---|---|---|
| [[matchDto (web)]] | [[Match (api)]] | DTO completo partita. Include embedded `matchEventDto[]` (MatchEvent), `lineupPlayerDto[]` (LineupPlayer), commenti (Comment) |
| [[matchMinDto (web)]] | [[Match (api)]] | Versione ridotta per liste: senza eventi, formazioni, statistiche. Include `teamMinDto` e `channelMinDto` embedded |
| [[matchEventDto (web)]] | [[MatchEvent (api)]] | DTO singolo evento telecronaca. Include `lineupPlayerDto` (LineupPlayer) e reazioni (EventReaction) embedded |
| [[matchEventAddDto (web)]] | [[MatchEvent (api)]] | DTO di scrittura per creazione evento telecronaca. Usa `matchEventType` e `territoryType` enum |
| [[matchAddDto (web)]] | [[Match (api)]] | DTO di scrittura per creazione/aggiornamento partita (data, squadre, timezone) |
| [[matchQuickAddDto (web)]] | [[Match (api)]] | DTO di scrittura per creazione rapida partita via wizard. Usa `matchQuickItemAddDto` per create-or-reference di canale e squadre |
| [[channelPublicDto (web)]] | [[Channel (api)]] | DTO pubblico canale: owner, statistiche, squadre, classifica. Contiene embedded `channelTableDto[]`, `teamMinDto[]` |
| [[channelDto (web)]] | [[Channel (api)]] | DTO privato/editor: include headerTitle, headerSubtitle, matches. Non espone dati pubblici di engagement |
| [[userProfileDto (web)]] | [[User (api)]] | DTO profilo utente autenticato: email, nickname, avatar, preferenze, canali posseduti/seguiti |
| [[userTokenDto (web)]] | [[UserToken (api)]] | DTO sessione JWT: id, nickname, token, lingua. Mappato sull'entity UserToken dei dispositivi notifiche |
| [[teamPublicDto (web)]] | [[Team (api)]] | DTO pubblico squadra: nome, logo, nickname, giocatori (playerDto[]), canale |
| [[playerDto (web)]] | [[Player (api)]] | DTO anagrafico giocatore: nome, nickname, avatar, numero maglia, squadra |
| [[lineupPlayerDto (web)]] | [[LineupPlayer (api)]] | DTO assegnazione formazione: giocatore in uno slot ruolo, voto, eventi associati |
| [[blogDto (web)]] | [[Blog (api)]] | DTO post blog partita: titolo, corpo HTML/markdown, match ridotto |
| [[statsDto (web)]] | (aggregata) | DTO statistiche globali piattaforma. Dato aggregato calcolato da StatsRepository su piu entity (User, Channel, Match, Team, Player, MatchEvent, Comment, EventReaction) |
| [[channelTableDto (web)]] | (aggregata) | DTO riga classifica canale. Dato aggregato calcolato dai risultati partita del canale |

### DTO e modelli tecnici senza entity BE diretta

| Modello FE | Ruolo |
|---|---|
| [[pageDto (web)]] | Wrapper generico di paginazione `<T>`. Non corrisponde a una entity. Usato da tutti gli endpoint con paginazione |
| [[SeoMetadataModel (web)]] | View model SEO per metadata pagina (title, description, canonical, Open Graph, JSON-LD). Definito e consumato solo lato FE |
| [[SeoStructuredDataModel (web)]] | Type alias `Record<string, unknown>` per structured data JSON-LD. Solo frontend |
| [[StatsCardViewModel (web)]] | View model locale per card statistiche in GStatsPage. Derivato da statsDto |
| [[ChannelTabIdModel (web)]] | View model tab per pagine canale. Definito lato FE |
| [[MatchTabIdModel (web)]] | View model tab per pagine partita. Definito lato FE |
| [[TeamTabIdModel (web)]] | View model tab per pagine squadra. Definito lato FE |
| [[EntityTab (web)]] | View model base per tab navigation bar. Definito lato FE, usato da EntityTabsComponent |
| [[Toast (web)]] | View model notifica toast. Creato e gestito da ToastService, solo lato FE |

## Pattern

- **DTO di dominio con entity BE**: i DTO di lettura (matchDto, channelPublicDto, userProfileDto, teamPublicDto) riflettono la struttura delle entity backend, spesso aggregando dati da piu entity in una singola risposta API.
- **DTO di scrittura separati**: i DTO di scrittura (matchAddDto, matchEventAddDto) hanno una struttura diversa dai DTO di lettura e dalle entity, ottimizzati per l'input utente.
- **DTO aggregati**: statsDto e channelTableDto non hanno una entity diretta ma sono il risultato di query di aggregazione su piu tabelle.
- **View model puramente FE**: EntityTab, Toast, ChannelTabIdModel, SeoMetadataModel e simili non hanno alcuna corrispondenza backend. Sono strutture dati definite nel frontend per gestire stato UI, navigazione e metadati SEO runtime.
- **Naming divergente**: i DTO frontend usano naming `camelCase` (es. `homeTeamScore`, `headerBgColor`) mentre le entity backend usano `PascalCase` (es. `HomeScore`, `HeaderBgColor`). La conversione avviene a livello di serializzazione JSON.

## Note

Mappatura dedotta dalle pagine wiki esistenti. I dettagli sui tipi esatti e sulle proprieta nullable non sono verificabili con certezza dalla wiki. Le entity non ancora referenziate da DTO frontend (es. Audit, FakeAgentSetting, SystemMessage, SystemMessageDraft, Email, Subscription, MatchLike, LineupPlayerRate, ChannelUser) non sono incluse per assenza di pagine modello FE corrispondenti.
