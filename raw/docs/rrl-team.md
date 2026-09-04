# Team Feature — Riepilogo Funzionale

## Overview

La funzionalita "Team" di Rugby Radio Live copre due domini distinti:

1. **Squadre sportive** (team) — entita gestite dagli utenti per organizzare partite, con roster giocatori, statistiche e pagine pubbliche.
2. **Team del prodotto** (team members) — pagina vetrina pubblica `/team` che presenta il founder, gli AI-Talkers e gli AI-Dev del progetto.

Questo documento riepiloga tutte le pagine, componenti, servizi, DTO ed entita coinvolte.

---

## 1. Squadre sportive (dominio Match/Team)

### 1.1 Backend entity

**`Team (api)`** — `src/RugbyRadio/Lib/Repositories/TeamBox/Team.cs`

- `Id`, `IsDeleted`, `Ts` (da EntityBase)
- `ChannelId` (FK → Channel)
- `Name`, `LogoUrl`, `Nickname`

Relazioni: Channel (many-to-one), usata come HomeTeam/AwayTeam in Match.

### 1.2 Backend API

**`TeamsV1Controller (api)`** — `src/RugbyRadio/Api/Controllers/TeamsV1Controller.cs`

| Endpoint | Descrizione | Auth |
|---|---|---|
| GET `/v1/channels/{channelId}/teams` | Lista squadre canale (TMS-01) | Authorize |
| POST `/v1/channels/{channelId}/teams` | Crea squadra (TMS-02) | Authorize |
| PUT `/v1/channels/{channelId}/teams/{teamId}` | Aggiorna squadra (TMS-03) | Authorize |
| GET `/v1/teams/logos` | Lista loghi disponibili (TMS-04) | Pubblico |
| GET `/v1/teams/{teamId}` | Profilo pubblico squadra (TMS-05) | Pubblico |

Backend service: `TeamService (api)` con repository `TeamRepository (api)`.

### 1.3 Frontend DTO

File: `src/RugbyRadioWeb/src/app/dto/teamDto.ts`

| Interfaccia | Campi | Ruolo |
|---|---|---|
| `teamMinDto` | id, channelId, name, logoUrl | Versione minima per liste |
| `teamDto` | id, name, logoUrl, nickname | DTO base |
| `teamChannelDto` | id, name, logoUrl, nickname, players[], matchesPlayed? | Squadra in contesto canale |
| `teamPublicDto` | id, name, logoUrl, nickname, players[], channel | Profilo pubblico (GTeamPage) |
| `teamAddDto` | name, nickname?, logoUrl? | Input creazione |
| `teamUpdateDto` | name, nickname?, logoUrl? | Input aggiornamento |
| `teamLogoDto` | Record<string, string> | Dizionario loghi disponibili |

### 1.4 Frontend service

**`TeamService (web)`** — `src/RugbyRadioWeb/src/app/services/team.service.ts`

Estende `BaseService`. Metodi:
- `getTeams(channelId)` → `teamChannelDto[]` (TMS-01)
- `getLogos()` → `teamLogoDto` (TMS-02)
- `addTeam(channelId, model)` → `teamChannelDto` (TMS-03)
- `updateTeam(channelId, teamId, model)` → `teamChannelDto` (TMS-04)
- `getUserTeams()` → `teamMinDto[]` (TMS-05)
- `getTeam(teamId)` → `teamPublicDto` (TMS-06)

### 1.5 Frontend pages

#### GTeamPage (web) — SPA page

- **Route**: `/g-team/:teamId` (pubblica)
- **Componente**: `GTeamComponent` in `src/app/global/g-team/`
- **4 tabs**: Team (info), Players (roster), Matches (partite), Share
- **Servizi**: TeamService, MatchService, AnalyticsService, SeoMetadataService
- **API chiamate**: TeamsV1Controller (getTeam), MatchesV1Controller (findMatchesByTeam)
- **Tracking**: `team_viewed` con team_id, channel_id, players_count
- **SEO metadata**: SportsTeam schema.org, title dinamico, canonical URL, og:image dal logo
- **Structured data**: @type SportsTeam, athlete[] (primi 30 giocatori), memberOf channel
- **Componenti**: EntityPageHeaderComponent, EntityTabsComponent, EntityStatsGridComponent, EntityShareComponent, EntityAdsComponent, MatchCardListComponent, EntityScrollToTopComponent

#### ChannelTeamsComponent (user area)

- **Selector**: `app-channel-teams` (in `src/app/user/channel/channel-teams/`)
- CRUD squadre in contesto canale
- Integra TeamEditComponent per modale creazione/editing squadra
- Integra PlayerEditComponent per modale creazione/editing/delete giocatori
- Gestione loghi squadra, espansione drawer giocatori per team

#### ChannelTeamsComponent (common)

- **Selector**: `app-channel-teams` (in `src/app/common/channel-teams/`)
- Versione read-only: mostra lista squadre, click → naviga a GTeamPage
- Output: `openTeam` con teamId

#### TeamEditComponent

- **Selector**: `app-team-edit`
- Modale (drawer) per creazione/edizione squadra
- Campi: teamName (required, max 20), teamNickname (optional, max 20), logoUrl (selezione)
- Validazione Angular FormControl

### 1.6 DTO wiki pages

- `teamPublicDto (web)` — wiki/frontend/web/models/teamPublicDto (web).md
- `playerDto (web)` — wiki/frontend/web/models/playerDto (web).md
- `pageDto (web)` — wiki/frontend/web/models/pageDto (web).md

---

## 2. Team del prodotto (pagine statiche)

### 2.1 Struttura pagine statiche

17 pagine HTML statiche in `src/RugbyRadioWeb/src/assets/static/`:

| File | Categoria | Pagina |
|---|---|---|
| `team.html` | Hub | Lista completa team (Founder + AI-Talkers + AI-Dev) |
| `team-section.component.html` | Component | Strip orizzontale membri (riutilizzata in pagine dettaglio) |
| `team-stefano.html` | Founder | Profilo Stefano Bonfiglio |
| `team-vox.html` | AI-Talker | Classic |
| `team-nitro.html` | AI-Talker | Youth |
| `team-beat-breaker.html` | AI-Talker | Rap |
| `team-orfeo.html` | AI-Talker | Poetic |
| `team-zoe.html` | AI-Talker | Social |
| `team-maul.html` | AI-Talker | Broadcast |
| `team-zorblax.html` | AI-Talker | Sci-fi |
| `team-elixir.html` | AI-Talker | Alchemy |
| `team-bulldog.html` | AI-Talker | Grit |
| `team-newsly.html` | AI-Talker | Reporter |
| `team-brushy.html` | AI-Talker | Visual |
| `team-stacker.html` | AI-Dev | Full-stack |
| `team-analysta.html` | AI-Dev | Analysis |
| `team-blueprint.html` | AI-Dev | Architecture |
| `team-trasteverino.html` | AI-Talker | (commentato, non attivo) |
| `team-el-mangiapolenta.html` | AI-Talker | (commentato, non attivo) |

### 2.2 Pagina hub: `team.html`

- **URL**: `https://rugbyradiolive.com/team`
- **Canonical**: `/team`
- **SEO type**: CollectionPage
- **5 lingue**: EN, IT, FR, ES, JA (attributo `data-lang`)
- **3 sezioni**:
  1. **Founder** — Stefano Bonfiglio con descrizione multilingue, link LinkedIn e pagina dettaglio
  2. **AI-Talkers** — 12 personalita AI (Vox, Nitro, Beat Breaker, Orfeo, Zoe, Maul, Zorblax, Elixir, Bulldog, Newsly, Brushy) + 2 commentate (Trasteverino, El Mangiapolenta)
  3. **AI-Dev** — 3 profili AI (Stacker, Analysta, Blueprint)
- **AdSense**: slot `2308901507` (PAGE-TEAM o simile)
- **Tracking**: `team_member_click` con member-id, member-type (founder/ai_talker/ai_dev), source-section
- **Sezione "How it works" commentata** — rimanda a /g-matches, /g-channels, tutorial.html, how-to.html, blog

### 2.3 Pagine dettaglio membri (pattern comune)

Ogni membro ha una pagina HTML statica con:
- **URL**: `/team-{id}.html`
- **Canonical**: `/team-{id}.html`
- **SEO type**: ProfilePage (con `mainEntity` Person per Stefano)
- **SEO metadata**: title, description, Open Graph, Twitter card, JSON-LD
- **Body class**: `static-page team-detail`
- **Data attributi**: `data-static-page="team-detail"`, `data-team-member="{id}"`, `data-member-type="founder|ai_talker|ai_dev"`
- **Header**: back link a `/team`, nome membro
- **Contenuto**: descrizione in 5 lingue, chip tags, hero image, social link
- **Footer**: `team-section.component.html` strip con tutti i membri navigabili
- **Tracking**: `team_member_click` e `team_social_click`

### 2.4 AI-Talkers — riepilogo personalita

| ID | Nome | Chip | Avatar | Ruolo |
|---|---|---|---|---|
| vox | Vox | Classic | default.webp | Guida chiara e classica |
| nitro | Nitro | Youth | adolescente.webp | Veloce e giovanile |
| beat-breaker | Beat Breaker | Rap | rapper.webp | Ritmo e incisivita |
| orfeo | Orfeo | Poetic | arcaico.webp | Narrazione poetica |
| zoe | Zoe | Social | influencer.webp | Social e hype |
| maul | Maul | Broadcast | telecronista.webp | Telecronista tradizionale |
| zorblax | Zorblax | Sci-fi | alieno.webp | Voce aliena |
| elixir | Elixir | Alchemy | chef.webp | Alchimista di fasi |
| bulldog | Bulldog | Grit | explayer.webp | Grinta old-school |
| newsly | Newsly | Reporter | reporter.webp | Reporter social |
| brushy | Brushy | Visual | artista.webp | Artista visivo |
| trasteverino | (commentato) | Romano | romano.webp | Romanesco (non attivo) |
| el-mangiapolenta | (commentato) | Milanese | milanese.webp | Milanese (non attivo) |

### 2.5 AI-Dev — riepilogo profili

| ID | Nome | Chip | Ruolo |
|---|---|---|---|
| stacker | Stacker | Full-stack, AI-Dev | Costruttore full-stack |
| analysta | Analysta | Requirements, AI-Dev | Analista requisiti |
| blueprint | Blueprint | Architecture, AI-Dev | Architetto di sistema |

---

## 3. Schema dati e flussi

### 3.1 Flussi squadra (dominio sportivo)

```
[User] → ChannelTeamsComponent → TeamService.getTeams() → API GET /channels/{id}/teams
                                                        → TeamRepository → DB Teams
[Guest] → GTeamPage → TeamService.getTeam(id) → API GET /teams/{id}
                                               → TeamRepository → DB Teams
[User] → TeamEditComponent → TeamService.addTeam() → API POST /channels/{id}/teams
[User] → TeamEditComponent → TeamService.updateTeam() → API PUT /channels/{id}/teams/{id}
```

### 3.2 Flusso pagina team prodotto

```
[Utente] → /team (static HTML) → /team-{id}.html (static detail)
   ↓
SEO: CollectionPage → ProfilePage
Tracking: team_member_click, team_social_click
```

### 3.3 SEO e structured data

**GTeamPage (squadra sportiva)**:
- JSON-LD: `SportsTeam`, `sport: Rugby`, `athlete[]`, `memberOf` (channel)
- Tags: title dinamico, canonical, og:image dal logo
- Tracking GA: `team_viewed`

**team.html (prodotto)**:
- JSON-LD: `CollectionPage`
- Tags: description multilingua, og:image, twitter:card

**Pagine dettaglio membri**:
- JSON-LD: `ProfilePage` (Person per founder)
- Tags: description, og:image per membro

---

## 4. Riepilogo pagine wiki collegate

| Pagina wiki | Tipo | Cartella |
|---|---|---|
| GTeamPage (web) | frontend-page | wiki/frontend/web/pages/ |
| TeamService (web) | frontend-service | wiki/frontend/web/services/ |
| teamPublicDto (web) | frontend-model | wiki/frontend/web/models/ |
| playerDto (web) | frontend-model | wiki/frontend/web/models/ |
| TeamsV1Controller (api) | backend-api | wiki/backend/api/apis/ |
| Team (api) | backend-entity | wiki/backend/api/entities/ |
| TeamService (api) | backend-service | wiki/backend/api/services/ |
| TeamRepository (api) | backend-repository | wiki/backend/api/repositories/ |
| Player (api) | backend-entity | wiki/backend/api/entities/ |
| PlayerService (api) | backend-service | wiki/backend/api/services/ |
| PlayerRepository (api) | backend-repository | wiki/backend/api/repositories/ |
| PlayersV1Controller (api) | backend-api | wiki/backend/api/apis/ |
| EntityPageHeaderComponent (web) | frontend-component | wiki/frontend/web/components/ |
| EntityTabsComponent (web) | frontend-component | wiki/frontend/web/components/ |
| EntityShareComponent (web) | frontend-component | wiki/frontend/web/components/ |
| MatchCardListComponent (web) | frontend-component | wiki/frontend/web/components/ |
| EntityAdsComponent (web) | frontend-component | wiki/frontend/web/components/ |
| pageDto (web) | frontend-model | wiki/frontend/web/models/ |
| matchMinDto (web) | frontend-model | wiki/frontend/web/models/ |
| Squadra (concept) | concept | wiki/concepts/ |
| Partita (concept) | concept | wiki/concepts/ |

---

## 5. File sorgente chiave

| File | Percorso |
|---|---|
| GTeamComponent | `src/RugbyRadioWeb/src/app/global/g-team/g-team.component.ts` |
| GTeamComponent HTML | `src/RugbyRadioWeb/src/app/global/g-team/g-team.component.html` |
| TeamService | `src/RugbyRadioWeb/src/app/services/team.service.ts` |
| Team DTO | `src/RugbyRadioWeb/src/app/dto/teamDto.ts` |
| ChannelTeams (user) | `src/RugbyRadioWeb/src/app/user/channel/channel-teams/channel-teams.component.ts` |
| ChannelTeams (common) | `src/RugbyRadioWeb/src/app/common/channel-teams/channel-teams.component.ts` |
| TeamEditComponent | `src/RugbyRadioWeb/src/app/common/team-edit/team-edit.component.ts` |
| team.html | `src/RugbyRadioWeb/src/assets/static/team.html` |
| team-section.component | `src/RugbyRadioWeb/src/assets/static/team-section.component.html` |
| Team member pages | `src/RugbyRadioWeb/src/assets/static/team-{id}.html` (17 file) |
| TeamsController | `src/RugbyRadio/Api/Controllers/TeamsV1Controller.cs` |
| Team entity | `src/RugbyRadio/Lib/Repositories/TeamBox/Team.cs` |
| Sitemap | `src/RugbyRadioSitemap/sitemap-teams.xml` |
