---
title: "Rugby Radio Live (architecture)"
type: architecture
layer: architecture
---

# Rugby Radio Live (architecture)

## Sintesi
Architettura logica di [[Rugby Radio Live (product)]], centrata su telecronaca testuale, gestione partite, fruizione pubblica e generazione contenuti statici.

## Scope
- Prodotto e concetti: [[Rugby Radio Live (product)]], [[Telecronaca (concept)]], [[Radio Canale (concept)]], [[Partita (concept)]], [[AI-Talker (concept)]]
- Workflow principali: [[Cronista Telecronaca (workflow)]], [[Spettatore Partita (workflow)]]
- Frontend web, backend API, job backend, data schema, integrazioni e contenuti statici gia documentati nella wiki
- Pagina statica pubblica `architecture.html`, introdotta a fine maggio 2026 per descrivere struttura e flusso di RRL fuori dalla wiki interna

## Componenti coinvolti
- Frontend pagine: [[ChannelsPage (web)]], [[ChannelPage (web)]], [[MatchPage (web)]], [[GChannelPage (web)]], [[GMatchPage (web)]], [[GMatchesPage (web)]], [[GTeamPage (web)]], [[AdminMaintenancePage (web)]], [[DangerPage (web)]], [[GFeedbackPage (web)]]
- Frontend services: [[MatchService (web)]], [[ChannelService (web)]], [[ChannelUserService (web)]], [[UserService (web)]], [[BlogService (web)]], [[StatsService (web)]], [[VoiceService (web)]], [[ErrorHandlerService (web)]]
- Frontend modelli: [[ChannelTabIdModel (web)]], [[MatchTabIdModel (web)]], [[TeamTabIdModel (web)]], [[StatsCardViewModel (web)]], [[channelTableDto (web)]], [[matchAddDto (web)]]
- Backend API: [[AuthV1Controller (api)]], [[ChannelsV1Controller (api)]], [[MatchesV1Controller (api)]], [[MatchEventsV1Controllers (api)]], [[MatchLineupsV1Controller (api)]], [[BlogV1Controller (api)]], [[StatsV1Controller (api)]], [[VoicesV1Controller (api)]]
- Backend services: [[RugbyRadioLiveService (api)]], [[MatchService (api)]], [[ChannelService (api)]], [[BlogService (api)]], [[VoiceService (api)]], [[AiOllamaService (api)]]
- Backend repository e security: [[StatsRepository (api)]], [[CorsPolicy (api)]], [[SecuritySettings (api)]], [[HangfireDashboard (api)]]
- Job e integrazioni: [[CreateMatchEventJob (api)]], [[CreateMatchBlogJob (api)]], [[CreateMatchBlogHtmlJob (api)]], [[CreateMatchImageJob (api)]], [[CreateMatchImageInstagramJob (api)]], [[CreateChannelImageJob (api)]], [[CreateChannelImageInstagramJob (api)]], [[FakeLastYearAgentJob (api)]], [[FakeLeagueAgentJob (api)]], [[FakeFantasyAgentJob (api)]], [[MaintenanceJob (api)]], [[UsbBackupJob (api)]], [[FirebaseFCM (api)]], [[AzureSpeech (api)]], [[OllamaAI (api)]], [[BlogStaticFilePublishingIntegration (api)]], [[PublicMediaUrlReferenceIntegration (api)]], [[SocialShareUrlIntegration (api)]]
- Data: [[AppDbContext (api)]], [[EntityBase (api)]], [[Channel (api)]], [[Match (api)]], [[MatchEvent (api)]], [[Blog (api)]], [[User (api)]]
- Analytics e contenuti: [[Platform Stats 2026-05-13 (analytic)]], [[Google Analytics Traffic 2026-01 2026-06 (analytic)]], [[AdSense Performance 2026-01 2026-06 (analytic)]], [[Search Console Performance 2026-04 (analytic)]], [[Search Console Performance 2026-06 (analytic)]], [[Search Console Index Coverage 2026-04 (analytic)]], [[Search Console Index Coverage 2026-05 (analytic)]], [[Static Blog SEO Headers (article)]], [[Public Sitemap (article)]], [[Product Updates 2026 (article)]], [[Meet the Team (article)]]

## Relazioni principali
- Il cronista usa pagine e servizi frontend per creare o aprire una partita e generare eventi di telecronaca tramite API backend.
- Lo spettatore usa pagine pubbliche per consultare partite, eventi, commenti, emoji, voti e contenuti collegati.
- [[MatchService (web)]] aggrega chiamate verso [[MatchesV1Controller (api)]], [[MatchEventsV1Controllers (api)]] e [[MatchLineupsV1Controller (api)]].
- [[MatchesV1Controller (api)]] delega a [[MatchService (api)]], [[UserService (api)]], [[LineupPlayerService (api)]] e [[RugbyRadioLiveService (api)]].
- [[MatchService (api)]] coordina scritture su entity partita, eventi, commenti, reazioni, like, voti e subscription.
- [[CreateMatchBlogHtmlJob (api)]] genera HTML statici, indici e sitemap a partire da [[Blog (api)]] e [[Match (api)]].
- Le pagine di gestione canale usano modelli tabulari e stato tab come [[ChannelTabIdModel (web)]], [[channelTableDto (web)]], [[MatchTabIdModel (web)]] e [[TeamTabIdModel (web)]] per organizzare viste pubbliche e dati aggregati.
- Le integrazioni documentate coprono notifiche push, sintesi vocale, OAuth, email, Facebook e generazione AI.
- A fine maggio 2026 viene aggiunta la pagina statica pubblica `architecture.html` con banner pubblicitario `PAGE-ARCHITECTURE: 4750353703`.
- Il RAW indica introduzione di Sentry anche lato API per tracciare anomalie; i dettagli tecnici dell'integrazione non sono sufficienti per una pagina canonica dedicata.

## Decisioni architetturali
- Separazione tra frontend web, API backend, job backend e contenuti statici.
- Il dominio partita e telecronaca ruota intorno a [[Match (api)]] e [[MatchEvent (api)]].
- Le pagine statiche blog sono generate da job e documentate separatamente dagli endpoint runtime.
- I workflow documentati separano uso cronista e uso spettatore.
- L'architettura viene resa esplicita anche come pagina statica indicizzabile, distinta dalla wiki tecnica interna.

## Rischi
- Frequenze dei job Hangfire non deducibili dalla wiki.
- Analytics tracking dei workflow non deducibile dalla wiki.
- Alcune relazioni consumer tra API e frontend restano parziali quando le singole pagine indicano "Non deducibile".
- Configurazione Sentry lato API, eventi tracciati e filtri di errore non deducibili dal RAW.

## Infrastruttura hosting

Il server di casa (Windows 11, IIS) esposto via Cloudflare Tunnel:

- **Server**: Intel Core i5-10400F, 32GB RAM, SSD 480GB + HDD 1TB, GPU NVIDIA GTX 1660 SUPER
- **Backup**: chiavetta USB 60GB
- **Software**: Windows 11, SQL Server Express, IIS, .NET Core, Docker (Metabase)
- **Accesso remoto**: TeamViewer free
- **UPS**: server, modem e router su UPS dedicati

### Cloudflare Tunnel

Tunnel ID: `7ca4a242-01a7-46a9-b159-992687ff2049`

| Hostname | Servizio locale | Ruolo |
|---|---|---|
| `api-s1-sh.rugbyradiolive.com` | `localhost:5110` | API shard 1 |
| `api-s2-sh.rugbyradiolive.com` | `localhost:5120` | API shard 2 |
| `storage-sh.rugbyradiolive.com` | `localhost:5140` | Storage file |
| `blog.rugbyradiolive.com` | `localhost:5150` | Blog statico |
| `bi.rugbyradiolive.com` | `localhost:5160` | Business intelligence (Metabase) |
| `seo-sh.rugbyradiolive.com` | `localhost:5170` | Sitemap SEO |

### App pubblicate

- Api RRL (sh1 e sh2)
- HF RRL (Hangfire)
- Blog RRL
- Sitemap RRL
- Storage RRL

## Note
- [[Mappatura Pagine e API (comparison)]] — mapping tra pagine frontend e API backend.
- [[Mappatura Modelli FE e Entity BE (comparison)]] — mapping tra modelli FE ed entity BE.
- [[Mappatura Servizi FE e BE (comparison)]] — mapping tra servizi FE e API BE.
- Pagina aggiornata con `llm-wiki/raw/dev/rrl-202605-arch.md`, `llm-wiki/raw/dev/cloudflared-config.yml`, `llm-wiki/raw/docs/home.server.md`. Il bug fixing Sentry e' citato come evidenza testuale senza elenco bug o dettagli implementativi.
