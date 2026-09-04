# Log

## [2026-07-28] ingest | HfFixJob (api)

- created: [[HfFixJob (api)]]
- linked: [[Data Quality Maintenance (workflow)]], [[MatchRepository (api)]], [[TeamRepository (api)]], [[ChannelRepository (api)]], [[UserRepository (api)]], [[Match (api)]], [[Team (api)]], [[Channel (api)]], [[User (api)]], [[RepairMatchImageJob (api)]]
- source: raw/projects/job-hf-fix/job-hf-fix-closeout.md
- notes: pagina creata da closeout di progetto; il job e progettato ma non risulta implementato nel codice sorgente.

## [2026-07-28] ingest | Data Quality Maintenance (workflow)

- created: [[Data Quality Maintenance (workflow)]]
- updated: [[Operativita Backend (concept)]], [[Operazioni Amministrative (workflow)]], [[index]]
- source: raw/projects/job-hf-fix/job-hf-fix-closeout.md
- notes: workflow creato per consolidare il processo di bonifica dati oraria; impatti analytics diretti non previsti; dettagli tecnici di implementazione immagine e affidabilita DateUtc ancora da verificare.

## [2026-07-08] ingest | AdSense Blog Alignment 2026-06 (analytic)

- created: [[AdSense Blog Alignment 2026-06 (analytic)]]
- updated: [[AdSense Placements 2026-05 (analytic)]], [[AdSense Performance 2026-01 2026-06 (analytic)]], [[Monetizzazione (monetization)]], [[Product Updates 2026 (article)]]
- source: `raw/dev/rrl-2026-06.md`
- notes: documentato allineamento del blog statico allo slot unico `BLOG-HOME: 6223722056`; nessun nuovo workflow creato per mancanza di evidenza nel RAW.

## [2026-07-07] ingest | Analytics giugno e RAW analysis

- created: [[Search Console Performance 2026-06 (analytic)]], [[Meet the Team (article)]], [[Meet the Team Static Pages (architecture)]], [[Backup USB (workflow)]]
- updated: [[Google Analytics Traffic 2026-01 2026-06 (analytic)]], [[AdSense Performance 2026-01 2026-06 (analytic)]], [[Superficie SEO Pubblica (concept)]]
- source: `raw/ga/GA-202606.csv`, `raw/adsense/AdSense-2026-06.csv`, `raw/gcs/gsc-202606-Aspetto nella ricerca.csv`, `raw/gcs/gsc-202606-Dispositivi.csv`, `raw/gcs/gsc-202606-Filtri.csv`, `raw/gcs/gsc-202606-Grafico.csv`, `raw/gcs/gsc-202606-Paesi.csv`, `raw/gcs/gsc-202606-Pagine.csv`, `raw/gcs/gsc-202606-Query.csv`, `raw/analysis/analisi-funzionale-meet-team.md`, `raw/analysis/architettura-meet-team.md`, `raw/analysis/TRRL-014-analisi-funzionale-backup-usb.md`, `raw/analysis/TRRL-014-analisi-architetturale-backup-usb.md`, `raw/analysis/seo-audit-generale-rrl.md`
- notes: metriche giugno aggregate in pagine analytics; Meet the Team mappato come articolo e architecture static content; TRRL-014 mappato come workflow collegato a UsbBackupJob; audit SEO usato solo come conferma di contesto per Superficie SEO Pubblica, senza nuova pagina canonica dedicata.

## [2026-06-19] ingest | Radio Live chiusura progetto

- created: [[matchRadioDto (web)]]
- updated: [[GMatchRadioPage (web)]], [[MatchRadioPlayerService (web)]], [[MatchRadioStorageService (web)]], [[GMatchEventsComponent (web)]], [[GMatchPage (web)]], [[Riproduzione Audio Telecronaca (workflow)]]
- source: `raw/dev/radio-live/rrl-202606-radiolive.md`, `raw/dev/radio-live/analisi-funzionale-radio-evento.md`, `raw/dev/radio-live/analisi-architetturale-radio-evento.md`
- notes: documentata chiusura MVP Radio Live frontend-first: route `/g-radio/:matchId`, tab `Leggi`/`Ascolta`, coda audio locale, deduplica `eventId:talkerId:language`, persistenza localStorage, analytics radio e nessuna nuova API/backend/database.

## [2026-05-26] ingest | rrl-202605-arch

- updated: Rugby Radio Live (architecture), Product Updates 2026 (article)
- linked: link canonici gia presenti nelle sezioni Architecture e Articles
- source: `raw/dev/rrl-202605-arch.md`
- notes: pagina statica `architecture.html`, slot AdSense `PAGE-ARCHITECTURE: 4750353703` e Sentry API documentati; nessuna pagina Sentry dedicata creata per dettagli tecnici insufficienti

## [2026-05-21] ingest | Public Sitemap (article)

- updated: Public Sitemap (article), Product Updates 2026 (article)
- linked: link canonici gia presenti nella sezione Articles
- source: `raw/dev/rrl-202605-seo.md`, `raw/dev/sitemap.xml`
- notes: aggiornata evidenza sitemap root come `sitemapindex` rilasciato via Firebase; non create nuove pagine per evitare duplicati canonicali

## [2026-05-15] ingest | analytics RAW

- created: AdSense Performance 2026-01 2026-04 (analytic), Google Analytics Traffic 2026-01 2026-04 (analytic), Search Console Performance 2026-04 (analytic), Search Console Index Coverage 2026-05 (analytic)
- source: `raw/adsense/*.csv`, `raw/ga/*.csv`, `raw/gcs/*.csv`
- notes: CSV analytics aggregati per piattaforma e periodo; causalita tra redesign, GA e metriche non deducibile

## [2026-05-15] schema | analytics/article naming

- updated: analytic/article canonical names
- linked: updated wiki Obsidian links after renames

## [2026-07-08] content | Blog Statico Multilingua (article)

- created: [[Blog Statico Multilingua (article)]]
- linked: [[Blog (concept)]], [[Pubblicazione Blog Statico (workflow)]], [[Static Blog SEO Headers (article)]], [[AdSense Blog Alignment 2026-06 (analytic)]]
- notes: articolo ponte sul blog statico multilingua creato usando solo pagine wiki esistenti.

## [2026-07-08] content | Pipeline Contenuti Post Partita (article)

- created: [[Pipeline Contenuti Post Partita (article)]]
- linked: [[Pipeline Contenuti (concept)]], [[CreateMatchBlogJob (api)]], [[CreateMatchBlogHtmlJob (api)]], [[FacebookJob (api)]], [[GenerateSeoSitemapJob (api)]]
- notes: articolo ponte sulla pipeline contenuti post-partita creato usando solo pagine wiki esistenti.

## [2026-07-08] content | Superficie SEO e Indicizzazione (article)

- created: [[Superficie SEO e Indicizzazione (article)]]
- linked: [[Superficie SEO Pubblica (concept)]], [[Public Sitemap (article)]], [[Static Blog SEO Headers (article)]], [[Mappatura SEO e Analytics (comparison)]]
- notes: articolo ponte SEO creato usando solo pagine wiki esistenti.

## [2026-07-08] content | Radio Live e Audio Telecronaca (article)

- created: [[Radio Live e Audio Telecronaca (article)]]
- linked: [[Riproduzione Audio Telecronaca (workflow)]], [[GMatchRadioPage (web)]], [[MatchRadioPlayerService (web)]], [[VoicesV1Controller (api)]], [[AzureSpeech (api)]]
- notes: articolo ponte sul flusso audio radio creato usando solo pagine wiki esistenti.

## [2026-07-08] content | Account e Profilo Utente (article)

- created: [[Account e Profilo Utente (article)]]
- linked: [[Autenticazione Utente (workflow)]], [[Mappatura Account e Profilo Utente (comparison)]], [[AuthV1Controller (api)]], [[UserV1Controller (api)]], [[UserService (web)]]
- notes: articolo ponte account/profilo creato usando solo pagine wiki esistenti.

## [2026-07-08] content | Telecronaca AI e Talker (article)

- created: [[Telecronaca AI e Talker (article)]]
- linked: [[AI-Talker (concept)]], [[Telecronaca (concept)]], [[Cronista Telecronaca (workflow)]], [[Spettatore Partita (workflow)]], [[Riproduzione Audio Telecronaca (workflow)]]
- notes: articolo ponte sulla telecronaca AI creato usando solo pagine wiki esistenti.

## [2026-07-08] content | Pubblicazione Social Post Partita (article)

- created: [[Pubblicazione Social Post Partita (article)]]
- linked: [[Pubblicazione Social (concept)]], [[FacebookJob (api)]], [[FacebookService (api)]], [[FacebookGraphAPI (api)]], [[Pipeline Contenuti (concept)]]
- notes: articolo ponte sul social post-partita creato usando solo pagine wiki esistenti.

## [2026-07-08] content | Backup e Operativita Backend (article)

- created: [[Backup e Operativita Backend (article)]]
- linked: [[Operativita Backend (concept)]], [[Backup USB (workflow)]], [[UsbBackupJob (api)]], [[MaintenanceJob (api)]], [[HangfireDashboard (api)]]
- notes: articolo ponte operativo creato usando solo pagine wiki esistenti.

## [2026-07-08] content | Monetizzazione AdSense (article)

- created: [[Monetizzazione AdSense (article)]]
- linked: [[Monetizzazione (monetization)]], [[AdSense Placements 2026-05 (analytic)]], [[AdSense Performance 2026-01 2026-06 (analytic)]], [[EntityAdsComponent (web)]]
- notes: articolo ponte AdSense creato usando solo pagine wiki esistenti.

## [2026-07-08] content | Esperienza Spettatore Partita (article)

- created: [[Esperienza Spettatore Partita (article)]]
- linked: [[Spettatore Partita (workflow)]], [[Spettatore (actor)]], [[GMatchPage (web)]], [[MatchesV1Controller (api)]], [[Riproduzione Audio Telecronaca (workflow)]]
- notes: articolo ponte sull'esperienza spettatore creato usando solo pagine wiki esistenti.

## [2026-07-08] content | Creazione Rapida Partita (article)

- created: [[Creazione Rapida Partita (article)]]
- linked: [[MatchCreateComponent (web)]], [[matchQuickAddDto (web)]], [[MatchesV1Controller (api)]], [[RugbyRadioLiveService (api)]], [[EntityBottomNavComponent (web)]], [[BusService (web)]], [[CreateTrainingChannelJob (api)]], [[Ciclo di Vita Partita (concept)]]
- notes: articolo ponte creato su richiesta dopo verifica dei RAW; contenuto scritto usando solo pagine gia presenti in wiki secondo `prompt-wiki-02-content.md`.
- notes: naming now uses `Nome (analytic)` and `Nome (article)`; removed ADS/PRD naming suffixes from canonical page names

## [2026-05-15] ingest | dev RAW

- created: Platform Stats 2026-05-13 (analytic), AdSense Placements 2026-05 (analytic), Product Updates 2026 (article), Static Blog SEO Headers (article), Public Sitemap (article)
- source: `raw/dev/Header Pagine Blog.md`, `raw/dev/rrl-202601.md`, `raw/dev/rrl-202603.md`, `raw/dev/rrl-202605.md`, `raw/dev/stats-20260513.md`, `raw/dev/sitemap.xml`
- notes: dev RAW mappati in analytics/product, analytics/ads e articles; Sentry citato solo come evidenza testuale, senza pagina canonica per mapping insufficiente

## [2026-05-15] schema | business/concept/workflow naming

- updated: actor/product/concept/workflow canonical names
- linked: updated wiki Obsidian links after renames
- notes: naming now uses `Nome (actor)`, `Nome (product)`, `Nome (concept)`, `Nome (workflow)`

## [2026-05-15] ingest | Rugby Radio Live (product)

- created: Rugby Radio Live (product), Cronista (actor), Spettatore (actor), Telecronaca (concept), Radio Canale (concept), Partita (concept), AI-Talker (concept), Cronista Telecronaca (workflow), Spettatore Partita (workflow)
- source: `raw/RugbyRadioLive.md`
- notes: overview prodotto ingerita nei layer business, concepts e workflow; monetizzazione lasciata non deducibile in pagina canonica dedicata

## [2026-05-15] ingest | MatchEventsV1Controllers (api)

- created: MatchEventsV1Controllers (api)
- source: `raw/backend/api/api-map-20260514.md`, `raw/backend/api/auth-security-map-20260514.md`
- notes: controller eventi partita separato da MatchesV1Controller

## [2026-05-15] ingest | schema validation fixes

- updated: filename canonicalization for frontend web components and models
- linked: moved empty root duplicate `channelTableDto (web).md` to artifacts analysis
- notes: file name, title and heading aligned for project-qualified FE pages

## [2026-05-14] ingest | project: web — Frontend Pages

- created: HomePage (web), LoginPage (web), RegistrationPage (web), ResetPasswordPage (web), ProfilePage (web), ChannelsPage (web), ChannelPage (web), MatchPage (web), DangerPage (web), FavoritesPage (web), GChannelPage (web), GMatchPage (web), GMatchesPage (web), GChannelsPage (web), GTeamPage (web), GStatsPage (web), GFeedbackPage (web), AdminMaintenancePage (web)
- source: `raw/frontend/web/page-map-20260514.md`
- notes: 18 pagine create; 7 protette da AuthGuardService; 10 pubbliche; 1 solo maintenance mode; sub-componenti user/channel/* e user/match/* non analizzati nel dettaglio

## [2026-05-14] ingest | project: web — Frontend Services

- created: BaseService (web), UserService (web), MatchService (web), ChannelService (web), ChannelUserService (web), TeamService (web), PlayerService (web), LineupService (web), BlogService (web), StatsService (web), VoiceService (web), BusService (web), ToastService (web), AnalyticsService (web), LoggingService (web), ErrorHandlerService (web), LoginCallbackService (web), PlatformService (web), AuthGuardService (web)
- source: `raw/frontend/web/service-map-20260514.md`
- notes: 19 servizi creati (10 API client, 2 stato/UI, 7 infrastruttura); AuthInterceptor escluso (non è service applicativo)

## [2026-05-14] ingest | project: web — Frontend Components

- created: EntityButtonComponent (web), EntityPageHeaderComponent (web), EntityTabsComponent (web), EntitySearchComponent (web), EntityPaginationComponent (web), EntitySkeletonComponent (web), EntityToastComponent (web), EntityAlertComponent (web), EntityBottomNavComponent (web), IconComponent (web), MatchHeaderComponent (web), MatchEventsComponent (web), MatchLineupComponent (web), MatchStatsComponent (web), MatchCardListComponent (web), MatchCreateComponent (web), MatchCommentatorComponent (web), GMatchEventsComponent (web), ChannelCardListComponent (web), HomeGridComponent (web)
- source: `raw/frontend/web/component-map-20260514.md`
- notes: 20 componenti chiave creati su 57 totali; sezioni Home statiche (HomeFaq, HomeFeatures ecc.) e componenti user/channel/* esclusi per evidenza insufficiente

## [2026-05-14] ingest | project: web — Frontend Models

- created: matchDto (web), matchMinDto (web), matchEventDto (web), channelPublicDto (web), channelDto (web), userProfileDto (web), userTokenDto (web), pageDto (web), teamPublicDto (web), lineupPlayerDto (web), blogDto (web), statsDto (web), matchAddDto (web), matchQuickAddDto (web), matchEventAddDto (web), channelTableDto (web), EntityTab (web), Toast (web)
- source: `raw/frontend/web/model-map-20260514.md`
- notes: 18 modelli principali creati su 52 DTO totali; adminDto consumer non verificati; messageDraftDto escluso

## [2026-05-14] ingest | log aggiornato (web)

- updated: wiki/log.md — sessione web aggiunta

## [2026-05-15] ingest | project: api — Backend APIs

- created: AdminV1Controller (api), AuthV1Controller (api), BlogV1Controller (api), ChannelUsersV1Controller (api), ChannelsV1Controller (api), MatchLineupsV1Controller (api), MatchesV1Controller (api), PlayersV1Controller (api), StatsV1Controller (api), TeamsV1Controller (api), UserV1Controller (api), VoicesV1Controller (api)
- source: `raw/backend/api/api-map-20260514.md`
- notes: 12 controller creati; consumer FE non deducibili; cron job non deducibili da codice

## [2026-05-15] ingest | project: api — Backend Services

- created: UserService (api), ChannelService (api), MatchService (api), TeamService (api), PlayerService (api), LineupPlayerService (api), BlogService (api), EmailService (api), VoiceService (api), FacebookService (api), AiOllamaService (api), SystemMessageService (api), HttpClientService (api), RugbyRadioLiveService (api)
- source: `raw/backend/api/service-map-20260514.md`
- notes: 14 servizi creati; MatchService (~2000 righe) verificato parzialmente; SystemMessageService metodi interni dedotti per firma

## [2026-05-15] ingest | project: api — Backend Entities

- created: EntityBase (api), User (api), Channel (api), ChannelUser (api), Team (api), Player (api), Match (api), MatchEvent (api), LineupPlayer (api), Comment (api), EventReaction (api), Subscription (api), LineupPlayerRate (api), MatchLike (api), UserToken (api), Blog (api), UserOtpCode (api), Email (api), SystemMessage (api), SystemMessageDraft (api), Audit (api), FakeAgentSetting (api)
- source: `raw/backend/api/entities-20260514.md`
- notes: 22 entity create; MatchScoreboard/MatchScoreboardAi escluse (non persistenti); typo DbSet UserOptCodes documentato

## [2026-05-15] ingest | project: api — Backend Repositories

- created: UserRepository (api), ChannelRepository (api), MatchRepository (api), MatchEventRepository (api), TeamRepository (api), PlayerRepository (api), LineupPlayerRepository (api), LineupPlayerRateRepository (api), MatchLikeRepository (api), SubscriptionRepository (api), SystemMessageRepository (api), StatsRepository (api)
- source: `raw/backend/api/data-map-20260514.md`
- notes: 12 repository creati; StatsRepository dettaglio query non verificato

## [2026-05-15] ingest | project: api — Backend Jobs

- created: CreateMatchEventJob (api), CreateMatchEventAdminJob (api), MaintenanceJob (api), CreateMatchBlogJob (api), CreateMatchBlogHtmlJob (api), CreateMatchImageJob (api), CreateMatchImageInstagramJob (api), CreateChannelImageJob (api), CreateChannelImageInstagramJob (api), RepairMatchImageJob (api), CreateTrainingChannelJob (api), TranslateMatchEventFemaleJob (api), FacebookJob (api), FakeLastYearAgentJob (api), FakeLeagueAgentJob (api), FakeFantasyAgentJob (api)
- source: `raw/backend/api/job-map-20260514.md`
- notes: 16 job creati (1 stub FakeFantasyAgentJob); cron expression non deducibili da codice (tutti via Hangfire dashboard); WritePost in job Instagram parzialmente dedotto

## [2026-05-15] ingest | project: api — Backend Integrations

- created: AzureSpeech (api), FirebaseFCM (api), GoogleOAuth (api), SmtpEmail (api), FacebookGraphAPI (api), OllamaAI (api)
- source: `raw/backend/api/integration-map-20260514.md`
- notes: 6 integrazioni create; chiave Azure Speech hardcoded nel codice (segnalato); configurazione Meta non in appsettings.json principale

## [2026-05-15] ingest | project: api — Backend Security

- created: JwtBearerAuthentication (api), SecuritySettings (api), CorsPolicy (api), AuditMiddleware (api)
- source: `raw/backend/api/auth-security-map-20260514.md`
- notes: 4 pagine security create; CORS completamente aperto (AllowAllOrigins); SecretKey JWT in appsettings in chiaro; AdminV1Controller usa auth custom non standard (authKey query param)

## [2026-05-15] ingest | project: api — Data Schemas

- created: AppDbContext (api)
- source: `raw/backend/api/data-map-20260514.md`
- notes: DbContext con 21 DbSet; conversioni enum documentate; typo UserOptCodes segnalato

## [2026-05-15] ingest | log aggiornato

- updated: wiki/log.md
- notes: prima creazione; sezioni Frontend, Analytics, Business, Workflows, Concepts vuote (nessun RAW disponibile)


## [2026-05-15] content | Rugby Radio Live (architecture)

- created
- linked
- notes: pagina ponte architecture creata usando solo pagine wiki esistenti; nessun RAW letto; naming bonificato a `Nome (architecture)`

## [2026-05-15] maintenance | architecture naming

- updated
- linked
- notes: rinominata pagina architecture e aggiornati collegamenti al formato `Nome (architecture)`

## [2026-05-16] content | Gestione Canale (workflow)

- created
- linked
- notes: workflow creato usando solo pagine wiki esistenti e suggerimento lint; nessun RAW letto

## [2026-05-16] content | Pubblicazione Blog Statico (workflow)

- created
- linked
- notes: workflow tecnico creato usando solo pagine wiki esistenti e suggerimento lint; nessun RAW letto

## [2026-05-16] content | Autenticazione Utente (workflow)

- created
- linked
- notes: workflow creato usando solo pagine wiki esistenti e suggerimento lint; nessun RAW letto

## [2026-05-19] ingest | project: web — SEO metadata frontend

- created: SeoMetadataService (web), SeoMetadataModel (web), SeoStructuredDataModel (web), ChannelTabIdModel (web), MatchTabIdModel (web), TeamTabIdModel (web), StatsCardViewModel (web)
- linked: link canonici aggiornati
- source: `raw/frontend/web/service-map-20260519.md`, `raw/frontend/web/model-map-20260519.md`, `raw/frontend/web/page-map-20260519.md`, `raw/frontend/web/component-map-20260519.md`
- notes: component map 20260519 non ha creato componenti canonici perche i file modificati risultano page-level; API backend dipendenti da SeoMetadataService non deducibili.

## [2026-05-19] ingest | project: api — SEO sitemap backend

- created: SeoUrlInventoryService (api), GenerateSeoSitemapJob (api), BlogStaticFilePublishingIntegration (api), SeoSitemapFilePublishingIntegration (api), BlogSitemapReferenceIntegration (api), SocialShareUrlIntegration (api), PublicMediaUrlReferenceIntegration (api), HangfireDashboard (api)
- linked: link canonici aggiornati
- source: `raw/backend/api/service-map-20260519.md`, `raw/backend/api/job-map-20260519.md`, `raw/backend/api/integration-map-20260519.md`, `raw/backend/api/auth-security-map-20260519.md`
- notes: cron Hangfire, filtri autorizzativi dashboard e API backend specifiche non deducibili dai soli RAW 20260519; `IBlogRepository` citato come riferimento tecnico senza pagina repository canonica.

## [2026-06-04] ingest | Analytics maggio e copertura GSC aprile

- created: Search Console Index Coverage 2026-04 (analytic)
- updated: AdSense Performance 2026-01 2026-06 (analytic), Google Analytics Traffic 2026-01 2026-06 (analytic), Search Console Index Coverage 2026-05 (analytic)
- linked: link canonici aggiornati
- source: `raw/adsense/AdSense-2026-05.csv`, `raw/ga/GA-202605.csv`, `raw/gcs/gsc-202604-Pagina alternativa con tag canonical appropriato.csv`, `raw/gcs/gsc-202604-Pagina duplicata senza URL canonico selezionato dall'utente.csv`, `raw/gcs/gsc-202604-Pagina scansionata, ma attualmente non indicizzata.csv`, `raw/gcs/gsc-20260531-Grafico.csv`, `raw/gcs/gsc-20260531-Problemi critici.csv`, `raw/gcs/gsc-20260531-Problemi non critici.csv`, `raw/gcs/gsc-20260531-Metadati.csv`
- notes: workflow analytics specifici non deducibili dai RAW; pagine aggregate AdSense e GA rinominate per includere maggio 2026.

## [2026-06-13] ingest | TTS audio e pagina architecture statica

- created: TTS Audio (concept), Riproduzione Audio Telecronaca (workflow)
- updated: VoicesV1Controller (api), VoiceService (api), VoiceService (web), MatchCommentatorComponent (web), MatchEventsComponent (web), UserService (web), AzureSpeech (api), AI-Talker (concept), Telecronaca (concept), Spettatore Partita (workflow), AdSense Placements 2026-05 (analytic)
- source: `raw/docs/rrl-tts.md`, `raw/dev/rrl-202605-arch.md`
- notes: corretto endpoint evento TTS a `/v1/voices/events`; dettagli Sentry API insufficienti per pagina canonica dedicata.

## [2026-06-13] maintenance | Backend API/service template notes

- updated: BlogV1Controller (api), ChannelUsersV1Controller (api), ChannelsV1Controller (api), MatchLineupsV1Controller (api), MatchesV1Controller (api), PlayersV1Controller (api), StatsV1Controller (api), TeamsV1Controller (api), UserV1Controller (api), AiOllamaService (api), BlogService (api), ChannelService (api), EmailService (api), FacebookService (api), HttpClientService (api), LineupPlayerService (api), PlayerService (api), RugbyRadioLiveService (api), TeamService (api), UserService (api)
- linked: template backend API/service allineato allo schema
- notes: aggiunta sezione `## Note` con limite informativo verificabile; aggiornato report lint.

## [2026-06-13] maintenance | Backend repository canonical pages

- created: BlogRepository (api), ChannelUserRepository (api), UserTokenRepository (api), UserOtpCodeRepository (api)
- updated: Blog (api), ChannelUser (api), UserToken (api), UserOtpCode (api), BlogService (api), SeoUrlInventoryService (api), AiOllamaService (api), ChannelService (api), UserService (api), MatchService (api)
- linked: repository citati come riferimenti tecnici convertiti in pagine canoniche dove la wiki conteneva evidenza sufficiente
- notes: dettagli query non deducibili dalla wiki attuale; aggiornato report lint.

## [2026-06-13] maintenance | Wiki orphan links

- updated: Rugby Radio Live (architecture), Pubblicazione Blog Statico (workflow), Gestione Canale (workflow), Spettatore Partita (workflow)
- linked: pagine frontend, analytics, security, job, integrazioni, modelli e repository senza link in ingresso collegate da pagine aggregate o workflow coerenti
- notes: ricalcolo lint senza pagine orfane e senza link Obsidian rotti; aggiornato report lint.

## [2026-06-13] content | Superficie SEO Pubblica (concept)

- created
- linked
- notes: pagina ponte creata da pagine wiki esistenti su sitemap, blog statico, header SEO, job sitemap e report Search Console; nessun RAW letto.

## [2026-06-13] content | Operativita Backend (concept)

- created
- linked
- notes: pagina ponte creata da pagine wiki esistenti su maintenance mode, Hangfire dashboard, job manutenzione/backup, AdminV1Controller, audit e sicurezza; nessun RAW letto.

## [2026-06-13] maintenance | TTS Audio (concept)

- updated
- linked
- notes: integrata spiegazione del percorso FE per preview AI-Talker e audio evento usando pagine wiki esistenti; nessun RAW letto.

## [2026-06-13] content | Monetizzazione (monetization)

- created
- linked: AdSense Performance 2026-01 2026-06 (analytic), AdSense Placements 2026-05 (analytic), Product Updates 2026 (article), MatchCardListComponent (web), ChannelCardListComponent (web), MatchEventsComponent (web), HomePage (web), GStatsPage (web), Rugby Radio Live (architecture), Rugby Radio Live (product)
- notes: pagina di monetizzazione creata da pagine wiki esistenti su AdSense performance, placements, componenti frontend con EntityAdsComponent e banner architecture; nessun RAW letto.

## [2026-06-13] content | Blog (concept)

- created
- linked: Blog (api), BlogService (api), BlogRepository (api), BlogV1Controller (api), CreateMatchBlogJob (api), CreateMatchBlogHtmlJob (api), BlogStaticFilePublishingIntegration (api), BlogSitemapReferenceIntegration (api), BlogService (web), blogDto (web), Pubblicazione Blog Statico (workflow), Static Blog SEO Headers (article), Superficie SEO Pubblica (concept), Match (api), SeoUrlInventoryService (api), GenerateSeoSitemapJob (api), SeoSitemapFilePublishingIntegration (api), PublicMediaUrlReferenceIntegration (api), SocialShareUrlIntegration (api)
- notes: pagina ponte concept creata da pagine wiki esistenti su entita blog, servizi backend/frontend, API, job di generazione e staticizzazione, integrazioni filesystem/sitemap e workflow pubblicazione blog; cron job HF e dettagli pubblicazione Facebook non deducibili dalla wiki; nessun RAW letto.

## [2026-06-13] content | Interazione (concept)

- created
- linked: Comment (api), EventReaction (api), MatchLike (api), Subscription (api), LineupPlayerRate (api), MatchService (api), MatchEventsComponent (web), GMatchEventsComponent (web), GMatchPage (web), MatchPage (web), FavoritesPage (web), MatchService (web), UserService (web), LoginCallbackService (web), AuthGuardService (web), Spettatore (actor)
- notes: pagina ponte concept creata da pagine wiki esistenti su entita di interazione, componenti frontend e servizi; vincoli di validazione e meccanismi realtime non deducibili; nessun RAW letto.

## [2026-06-13] content | Squadra (concept)

- created
- linked: Team (api), Player (api), LineupPlayer (api), TeamService (api), PlayerService (api), LineupPlayerService (api), TeamsV1Controller (api), PlayersV1Controller (api), TeamRepository (api), PlayerRepository (api), LineupPlayerRepository (api), GTeamPage (web), TeamService (web), PlayerService (web), LineupService (web), MatchLineupComponent (web), teamPublicDto (web), TeamTabIdModel (web), lineupPlayerDto (web), Radio Canale (concept), Partita (concept), Cronista (actor)
- notes: pagina ponte concept creata da pagine wiki esistenti su entita squadra/giocatore/lineup, servizi backend/frontend, API e concept correlati; dettagli di validazione e classifiche non deducibili; nessun RAW letto.

## [2026-06-14] content | Mappatura Servizi FE e BE (comparison)

- created
- linked: 10 FE services with BE API, 10 FE services without API, 3 BE API senza service dedicato — 23 pagine collegate
- notes: pagina comparison creata da pagine wiki esistenti per chiarire il confine FE/BE; consumer effettivi di AdminV1Controller non deducibili; BaseService e classi infrastruttura senza API diretta documentati come pattern; nessun RAW letto.

## [2026-06-14] content | MatchEventCreated

- created
- linked: MatchEventsV1Controllers (api), MatchService (api), MatchEvent (api), FirebaseFCM (api), MatchEventsComponent (web), GMatchEventsComponent (web), CreateMatchEventJob (api), MatchEventRepository (api), Cronista Telecronaca (workflow), Spettatore Partita (workflow), Spettatore (actor)
- notes: prima pagina data-event creata da pagine wiki esistenti su evento partita, API MatchEventsV1Controllers, MatchService, FirebaseFCM, job AI e componenti frontend; nessun RAW letto.

## [2026-06-14] content | CommentAdded

- created
- linked: MatchesV1Controller (api), MatchService (api), Comment (api), MatchEventsComponent (web), MatchPage (web), Spettatore Partita (workflow), Autenticazione Utente (workflow)
- notes: seconda pagina data-event creata da pagine wiki esistenti su flusso commenti, endpoint MTC-08, MatchService, Comment entity, MatchEventsComponent e Interazione concept; meccanismi notifica e validazione non deducibili; nessun RAW letto.

## [2026-06-14] content | Pipeline Contenuti (concept)

- created
- linked: Match (api), MatchEvent (api), MatchService (api), Blog (api), Channel (api), Team (api), AiOllamaService (api), BlogService (api), SeoUrlInventoryService (api), FacebookService (api), OllamaAI (api), BlogStaticFilePublishingIntegration (api), SeoSitemapFilePublishingIntegration (api), BlogSitemapReferenceIntegration (api), SocialShareUrlIntegration (api), PublicMediaUrlReferenceIntegration (api), FacebookGraphAPI (api), CreateMatchBlogJob (api), CreateMatchBlogHtmlJob (api), CreateMatchImageJob (api), CreateMatchImageInstagramJob (api), CreateChannelImageJob (api), CreateChannelImageInstagramJob (api), FacebookJob (api), GenerateSeoSitemapJob (api), Pubblicazione Blog Statico (workflow), Cronista (actor), Spettatore (actor)
- notes: pagina ponte concept creata da pagine wiki esistenti sulla pipeline di generazione contenuti post-partita: AI blog, traduzione multilingua, immagini, staticizzazione HTML, pubblicazione Facebook e sitemap SEO; cron job e analytics delle fasi non deducibili; nessun RAW letto.

## [2026-06-14] content | Utente (concept)

- created
- linked: Cronista (actor), Spettatore (actor), Autenticazione Utente (workflow), User (api), UserToken (api), UserOtpCode (api), AuthV1Controller (api), UserV1Controller (api), UserService (api), UserService (web), AuthGuardService (web), LoginCallbackService (web), LoginPage (web), RegistrationPage (web), ResetPasswordPage (web), ProfilePage (web), JwtBearerAuthentication (api), GoogleOAuth (api), SmtpEmail (api), userProfileDto (web), userTokenDto (web), Subscription (api), Comment (api), EventReaction (api), MatchLike (api), LineupPlayerRate (api), Interazione (concept), Rugby Radio Live (product)
- notes: pagina ponte concept creata da pagine wiki esistenti sull'utente come attore digitale della piattaforma: registrazione, autenticazione, profilo, notifiche push e ciclo di vita account; dettagli di validazione password e rate limiting non deducibili; nessun RAW letto.

## [2026-06-14] content | EntityAdsComponent (web)

- created
- linked: MatchCardListComponent (web), ChannelCardListComponent (web), MatchEventsComponent (web), HomePage (web), GStatsPage (web), Monetizzazione (monetization), AdSense Placements 2026-05 (analytic), AdSense Performance 2026-01 2026-06 (analytic)
- notes: componente frontend creato per colmare gap di conoscenza sul componente AdSense riutilizzabile citato in 6 pagine wiki; input adClient, adSlot e adsFrequency documentati; dettagli implementativi (template, stili, rotazione annunci) non deducibili; nessun RAW letto.

## [2026-06-14] content | Notifica (concept)

- created
- linked: FirebaseFCM (api), MatchService (api), UserService (api), UserV1Controller (api), MatchesV1Controller (api), UserToken (api), UserTokenRepository (api), Subscription (api), SubscriptionRepository (api), User (api), UserService (web), ProfilePage (web), MatchEventCreated, Cronista Telecronaca (workflow), Spettatore Partita (workflow), Autenticazione Utente (workflow), Utente (concept), Rugby Radio Live (product)
- notes: pagina ponte concept creata da pagine wiki esistenti su FirebaseFCM, MatchService, UserService, UserToken, Subscription, MatchEventCreated, MatchesV1Controller, UserV1Controller e concetti/workflow correlati; dettagli notifiche commenti e analytics tracking non deducibili; nessun RAW letto.

## [2026-06-14] content | Match Event Types (concept)

- created
- linked: MatchEvent (api), MatchEventCreated, matchEventDto (web), matchEventAddDto (web), SystemMessage (api), CreateMatchEventJob (api), CreateMatchEventAdminJob (api), Platform Stats 2026-05-13 (analytic), Telecronaca (concept), Partita (concept), MatchEventsComponent (web), GMatchEventsComponent (web), Cronista (actor), AppDbContext (api)
- notes: pagina ponte concept creata da pagine wiki esistenti su MatchEvent entity, MatchEventCreated data-event, DTO frontend, SystemMessage, CreateMatchEventJob, CreateMatchEventAdminJob e Platform Stats; set completo valori enum e regole validazione non deducibili; nessun RAW letto.

## [2026-06-14] content | Amministratore (actor)

- created
- linked: AdminV1Controller (api), AdminMaintenancePage (web), HangfireDashboard (api), MaintenanceJob (api), UsbBackupJob (api), AuditMiddleware (api), SecuritySettings (api), JwtBearerAuthentication (api), Operativita Backend (concept), SystemMessageDraft (api), SystemMessage (api), Rugby Radio Live (product)
- notes: pagina attore amministrativo creata da pagine wiki esistenti su controller admin, maintenance page, Hangfire dashboard, job operativi, audit e sicurezza; nessun workflow admin documentato nella wiki; nessun RAW letto.

## [2026-06-14] content | Operazioni Amministrative (workflow)

- created
- linked: Amministratore (actor), Operativita Backend (concept), AdminV1Controller (api), AdminMaintenancePage (web), HangfireDashboard (api), MaintenanceJob (api), UsbBackupJob (api), AuditMiddleware (api), Audit (api), SystemMessage (api), SystemMessageDraft (api), SecuritySettings (api), JwtBearerAuthentication (api), Rugby Radio Live (product)
- notes: workflow amministrativo creato da pagine wiki esistenti per colmare il gap esplicitamente segnalato in Amministratore (actor) e Operativita Backend (concept); cron job frequenze, trigger end-to-end e analytics tracking non deducibili; nessun RAW letto.

## [2026-06-15] content | Generazione Immagini (concept)

- created
- linked: CreateMatchImageJob (api), CreateMatchImageInstagramJob (api), CreateChannelImageJob (api), CreateChannelImageInstagramJob (api), RepairMatchImageJob (api), FacebookJob (api), MatchService (api), Partita (concept), Radio Canale (concept), Match (api)
- notes: pagina ponte concept creata da pagine wiki esistenti su 5 job Hangfire di generazione immagini, MatchService per compositing tabellino e concetti Partita/Radio Canale che citano copertine AI; cron job frequenze e side effects WritePost Instagram non deducibili; nessun RAW letto.

## [2026-06-15] content | EntityShareComponent (web)

- created
- linked: GChannelPage (web), GMatchPage (web), GTeamPage (web), MatchPage (web)
- notes: componente frontend creato per colmare gap di conoscenza sul componente di condivisione riutilizzabile citato in 4 pagine wiki; input shareUrl e output linkCopied documentati; dettagli implementativi (template, stili, clipboard API) non deducibili; nessun RAW letto.

## [2026-06-15] content | ReactionAdded

- created
- linked
- notes: terza pagina data-event creata da pagine wiki esistenti sul flusso di reazione emoji: endpoint MTC-10, EventReaction entity, MatchService, componenti frontend e Interazione concept; valori ReactionType e logica di toggle non deducibili; nessun RAW letto.

## [2026-06-15] content | Sistema Messaggi Telecronaca AI (concept)

- created
- linked: SystemMessage (api), SystemMessageDraft (api), SystemMessageService (api), SystemMessageRepository (api), CreateMatchEventJob (api), CreateMatchEventAdminJob (api), TranslateMatchEventFemaleJob (api), AdminV1Controller (api), OllamaAI (api), VoiceService (api), Telecronaca (concept), AI-Talker (concept), Match Event Types (concept), TTS Audio (concept)
- notes: pagina ponte concept creata da pagine wiki esistenti sul sistema di generazione, traduzione, verifica e pubblicazione messaggi AI per telecronaca multilingua; flusso draft→verified→published ricostruito da SystemMessageService, SystemMessage, SystemMessageDraft, CreateMatchEventJob e CreateMatchEventAdminJob; cron job frequenze e prompt AI non deducibili; nessun RAW letto.

## [2026-06-15] content | Mappatura Pagine e API (comparison)

- created
- linked: 18 pagine FE e 13 API BE mappate — 8 API con pagine consumer dirette, 5 API senza pagina FE diretta, 1 pagina senza API
- notes: pagina comparison creata da pagine wiki esistenti per mappare le dipendenze dirette tra pagine frontend e controller API backend; consumer effettivi di AdminV1Controller non deducibili; nessun RAW letto.

## [2026-06-15] content | Ciclo di Vita Partita (concept)

- created
- linked: Match, MatchesV1Controller, MatchService, Partita (concept), Cronista Telecronaca (workflow), Spettatore Partita (workflow), Pipeline Contenuti (concept), Generazione Immagini (concept), CreateMatchBlogJob, CreateMatchImageJob, RepairMatchImageJob, FacebookJob, CreateMatchBlogHtmlJob, GenerateSeoSitemapJob, RugbyRadioLiveService, AppDbContext, GMatchPage (web), GMatchesPage (web), GChannelPage (web), ChannelPage (web), ChannelsPage (web), MatchPage (web), MatchEventCreated, Interazione (concept), Notifica (concept), Match Event Types (concept), FirebaseFCM
- notes: pagina ponte concept creata da pagine wiki esistenti per documentare il ciclo di vita tecnico della partita attraverso stati Scheduled-InProgress-Halftime-FullTime e automazioni backend post-FullTime; frequenze cron job e analytics transizioni non deducibili; nessun RAW letto.

## [2026-06-15] content | MatchStatusChanged

- created
- linked: MatchesV1Controller (api), MatchService (api), Match (api), Ciclo di Vita Partita (concept), Pipeline Contenuti (concept), Generazione Immagini (concept), MatchPage (web), GMatchPage (web), Interazione (concept), CreateMatchBlogJob (api), CreateMatchImageJob (api), CreateMatchImageInstagramJob (api), RepairMatchImageJob (api), FacebookJob (api), CreateMatchBlogHtmlJob (api), GenerateSeoSitemapJob (api), Cronista Telecronaca (workflow), Spettatore Partita (workflow)
- notes: quarta pagina data-event creata da pagine wiki esistenti su transizioni Scheduled→InProgress→Halftime→FullTime con side effects, visibilità pubblica e automazioni post-FullTime; frequenze cron job e vincoli validazione transizioni non deducibili; nessun RAW letto.

## [2026-06-15] content | playerDto (web)

- created
- linked
- notes: frontend model DTO creato da pagine wiki esistenti per colmare il gap del modello giocatore piu referenziato senza pagina canonica (citato in 7 pagine wiki come riferimento testuale senza link Obsidian); proprieta dedotte da Player entity e DTO compositi; nessun RAW letto.

## [2026-06-15] content | Pubblicazione Social (concept)

- created
- linked: FacebookJob (api), FacebookService (api), FacebookGraphAPI (api), HttpClientService (api), Blog (api), Blog (concept), Match (api), Ciclo di Vita Partita (concept), Pipeline Contenuti (concept), Generazione Immagini (concept), MatchStatusChanged, Partita (concept), Pubblicazione Blog Statico (workflow), SocialShareUrlIntegration (api), EntityShareComponent (web), Rugby Radio Live (architecture), Cronista (actor), Spettatore (actor)
- notes: pagina ponte concept creata da pagine wiki esistenti per documentare la fase 4 della Pipeline Contenuti: generazione immagine Tailoor Painter, compositing tabellino visuale ImageSharp, pubblicazione Facebook via Graph API e aggiornamento IsFacebookPosted; frequenza cron, dettagli retry e side effects WritePost Instagram non deducibili; nessun RAW letto.

## [2026-06-15] ingest | dev SEO implementation summary

- created: [[SitemapXmlWriter (api)]]
- updated: [[SeoMetadataService (web)]], [[SeoUrlInventoryService (api)]], [[GenerateSeoSitemapJob (api)]], [[CreateMatchBlogHtmlJob (api)]], [[Public Sitemap (article)]], [[Superficie SEO Pubblica (concept)]]
- source: `raw/dev/seo-20260519.md`
- notes: 24 task SEO (20 done, 4 dropped) documentati; SeoMetadataService aggiornato con dettaglio implementazione e consumer FE; SeoUrlInventoryService aggiornato con SeoPublicUrl/SeoPublicUrlRules; GenerateSeoSitemapJob aggiornato con SitemapXmlWriter, SeoSitemapSettings e output paths; CreateMatchBlogHtmlJob aggiornato con lowercase URL, canonical, hreflang e JSON-LD Article; Public Sitemap aggiornato con chunking, indexability policy e inventory; Superficie SEO Pubblica aggiornato con SeoMetadataService, SitemapXmlWriter e policy match indicizzabilita.

## [2026-06-15] ingest | Infrastructure hosting RAW

- updated: [[Rugby Radio Live (architecture)]]
- source: `raw/dev/cloudflared-config.yml`, `raw/docs/home.server.md`
- notes: aggiunta sezione infrastruttura hosting con specifiche server casa, Cloudflare Tunnel ingress (6 hostname: api-s1-sh, api-s2-sh, storage-sh, blog, bi, seo-sh) e app pubblicate.

## [2026-06-15] ingest | GSC backlink data

- updated: [[Search Console Index Coverage 2026-05 (analytic)]]
- source: `raw/gcs/gsc-202605-Latest links.csv`, `raw/gcs/gsc-202605-More sample links.csv`
- notes: aggiunta sezione backlink profile: circa 90 backlink esterni verso Play Store TWA e Chrome Stats, con 70+ varianti hreflang; backlink rilevanti da forum.rugby.it e twstalker.com.

## [2026-06-15] ingest | rrl-team.md

- created: teamAddDto (web), teamUpdateDto (web), teamMinDto (web), teamChannelDto (web), teamLogoDto (web), MatchCardSmallComponent (web)
- updated: GTeamPage (web), TeamService (web), TeamsV1Controller (api), MatchCardListComponent (web)
- source: `raw/docs/rrl-team.md`
- notes: 5 DTO squadra creati con proprieta dedotte dal RAW; MatchCardSmallComponent creato come child card di MatchCardListComponent; GTeamPage aggiornata con SeoMetadataService, tracking GA e JSON-LD SportsTeam; TeamService aggiornato con metodi e DTO; TeamsV1Controller aggiornato con consumer FE GTeamPage.

## [2026-06-15] content | Fake Agent (concept)

- created
- linked: FakeLastYearAgentJob (api), FakeLeagueAgentJob (api), FakeFantasyAgentJob (api), FakeAgentSetting (api), Platform Stats 2026-05-13 (analytic), UserService (api), MatchService (api), AppDbContext (api)
- notes: pagina ponte concept creata da pagine wiki esistenti sul sistema di job Hangfire per generazione dati fake di simulazione; piattaforma stats documenta presenza di contenuti FakeAgent nel dataset; cron expression e corpo job non integralmente deducibili; nessun RAW letto.

## [2026-06-15] content | EntityScrollToTopComponent (web)

- created
- linked: GChannelPage (web), GChannelsPage (web), GMatchesPage (web), GMatchPage (web), GTeamPage (web), ProfilePage (web)
- notes: componente utility scroll-to-top creato da pagine wiki esistenti; referenziato come testo semplice in 6 pagine frontend; dettagli implementativi (soglia scroll, animazioni) non deducibili; nessun RAW letto.

## [2026-06-15] content | Mappatura Modelli FE e Entity BE (comparison)

- created
- linked: 16 DTO di dominio mappati a entity BE, 9 modelli tecnici senza entity BE — 25 pagine collegate
- notes: pagina comparison creata da pagine wiki esistenti per mappare il confine FE/BE nel layer dati: DTO di lettura/scrittura con entity corrispondenti, DTO aggregati senza entity diretta, view model puramente FE. Mappatura dedotta dalle pagine modello FE ed entity BE; nessun RAW letto.

## [2026-06-19] content | MatchLiked

- created
- linked: MatchLike (api), MatchLikeRepository (api), MatchService (api), MatchesV1Controller (api), GMatchPage (web), GMatchEventsComponent (web), MatchService (web), ChannelService (api), Interazione (concept), Spettatore Partita (workflow), Autenticazione Utente (workflow)
- notes: quinta pagina data-event creata da pagine wiki esistenti sul flusso like partita: endpoint MTC-07 toggle, MatchLike entity, MatchLikeRepository, MatchService, componenti frontend GMatchPage/GMatchEventsComponent e Interazione concept; logica di toggle e unique constraint UserId+MatchId non deducibili; nessun RAW letto.

## [2026-06-19] content | LineupPlayerRated

- created
- linked: LineupPlayerRate (api), LineupPlayerRateRepository (api), MatchService (api), MatchesV1Controller (api), MatchLineupComponent (web), lineupPlayerDto (web), LineupPlayer (api), LineupPlayerService (api), Squadra (concept), Interazione (concept), Spettatore Partita (workflow), Spettatore (actor), Autenticazione Utente (workflow)
- notes: sesta pagina data-event creata da pagine wiki esistenti sul flusso voto giocatore post-partita: endpoint MTC-11, LineupPlayerRate entity/repository, MatchService, MatchLineupComponent, Squadra concept e Interazione concept; logica sovrascrittura voto, range Rate e visibilita realtime non deducibili; nessun RAW letto.

## [2026-06-19] content | SubscriptionChanged

- created
- linked: Subscription (api), SubscriptionRepository (api), MatchService (api), ChannelService (api), MatchesV1Controller (api), ChannelsV1Controller (api), Interazione (concept), Notifica (concept), Utente (concept), Spettatore Partita (workflow), Autenticazione Utente (workflow), FavoritesPage (web), GMatchPage (web), GMatchEventsComponent (web), ChannelService (web), MatchService (web), Spettatore (actor)
- notes: settima pagina data-event creata da pagine wiki esistenti sul flusso follow/unfollow canale e partita: endpoint MTC-12 e POST subscription, Subscription entity/repository, MatchService/ChannelService, FavoritesPage, GMatchPage e Interazione/Notifica concept; completa il set di 5 data-event delle interazioni spettatore definite in Interazione (concept); logica toggle concorrente e analytics tracking non deducibili; nessun RAW letto.

## [2026-06-19] content | Localizzazione (concept)

- created
- linked: Sistema Messaggi Telecronaca AI (concept), AI-Talker (concept), Blog (concept), Pipeline Contenuti (concept), TTS Audio (concept), OllamaAI (api), SystemMessageService (api), AiOllamaService (api), VoiceService (api), AzureSpeech (api), SystemMessage (api), SystemMessageDraft (api), SystemMessageRepository (api), TranslateMatchEventFemaleJob (api), Blog (api), MatchCommentatorComponent (web), Static Blog SEO Headers (article)
- notes: pagina ponte concept creata da pagine wiki esistenti per documentare il sistema multilingua su due domini: messaggi telecronaca (SystemMessage) e blog (Blog), entrambi basati su OllamaAI con traduzione da IT a EN/FR/ES/JA; ambito contenuti non localizzati e cron job non deducibili; nessun RAW letto.

## [2026-06-19] content | Co-proprietà (concept)

- created
- linked: Channel (api), ChannelUser (api), ChannelService (api), ChannelRepository (api), ChannelUsersV1Controller (api), PlayerService (api), TeamService (api), MatchService (api), ChannelPage (web), ChannelsPage (web), ChannelUserService (web), Gestione Canale (workflow), Radio Canale (concept), Cronista (actor), Squadra (concept), Utente (concept), Ciclo di Vita Partita (concept)
- notes: pagina ponte concept creata da pagine wiki esistenti per documentare il modello di proprietà condivisa dei canali a due ruoli (owner primario e co-owner) con policy di autorizzazione differenziate per servizio; DTO co-editor, flusso invito, limiti e audit trail non deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Eventi e Workflow (comparison)

- created
- linked: MatchEventCreated, MatchStatusChanged, CommentAdded, ReactionAdded, MatchLiked, LineupPlayerRated, SubscriptionChanged, Cronista Telecronaca (workflow), Spettatore Partita (workflow), Autenticazione Utente (workflow), Interazione (concept), Ciclo di Vita Partita (concept)
- notes: pagina comparison creata da pagine wiki esistenti per mappare data-event, workflow e concetti correlati; analytics tracking, realtime UI e vincoli esatti di validazione non deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Job e Side Effects (comparison)

- created
- linked: CreateMatchBlogJob (api), CreateMatchBlogHtmlJob (api), GenerateSeoSitemapJob (api), CreateMatchImageJob (api), CreateChannelImageJob (api), CreateMatchImageInstagramJob (api), CreateChannelImageInstagramJob (api), RepairMatchImageJob (api), FacebookJob (api), MaintenanceJob (api), UsbBackupJob (api), FakeLastYearAgentJob (api), FakeLeagueAgentJob (api), FakeFantasyAgentJob (api), Pipeline Contenuti (concept), Generazione Immagini (concept), Pubblicazione Social (concept), Operativita Backend (concept), Fake Agent (concept)
- notes: pagina comparison creata da pagine wiki esistenti per mappare job Hangfire e side effects su DB, filesystem, servizi esterni, social e sitemap; cron expression, tracking analytics e alcuni side effects Instagram non deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Sicurezza e Superfici Protette (comparison)

- created
- linked: JwtBearerAuthentication (api), SecuritySettings (api), CorsPolicy (api), AuditMiddleware (api), AuthV1Controller (api), UserV1Controller (api), MatchesV1Controller (api), ChannelsV1Controller (api), AdminV1Controller (api), HangfireDashboard (api), AdminMaintenancePage (web), Autenticazione Utente (workflow), Operazioni Amministrative (workflow), Co-proprietà (concept)
- notes: pagina comparison creata da pagine wiki esistenti per mappare superfici pubbliche, autenticate, amministrative e meccanismi trasversali; policy Hangfire, rate limiting e copertura completa degli attributi endpoint non deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura SEO e Analytics (comparison)

- created
- linked: Superficie SEO Pubblica (concept), Public Sitemap (article), Static Blog SEO Headers (article), Search Console Performance 2026-04 (analytic), Search Console Performance 2026-06 (analytic), Search Console Index Coverage 2026-04 (analytic), Search Console Index Coverage 2026-05 (analytic), Google Analytics Traffic 2026-01 2026-06 (analytic), AdSense Performance 2026-01 2026-06 (analytic), AdSense Placements 2026-05 (analytic), Monetizzazione (monetization), Meet the Team (article)
- notes: pagina comparison creata da pagine wiki esistenti per collegare superficie indicizzabile, report Search Console, GA/Firebase e AdSense; conversioni, causalita e KPI formali non deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Attori e Workflow (comparison)

- created
- linked: Cronista (actor), Spettatore (actor), Amministratore (actor), Autenticazione Utente (workflow), Gestione Canale (workflow), Cronista Telecronaca (workflow), Spettatore Partita (workflow), Riproduzione Audio Telecronaca (workflow), Operazioni Amministrative (workflow), Backup USB (workflow), Pubblicazione Blog Statico (workflow), Rugby Radio Live (product)
- notes: pagina comparison creata da pagine wiki esistenti per mappare attori business, workflow utente e workflow tecnici; analytics tracking completo, attore del blog statico e matrice permessi completa non deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Dominio Core Rugby (comparison)

- created
- linked: Radio Canale (concept), Squadra (concept), Partita (concept), Ciclo di Vita Partita (concept), Co-proprietà (concept), Gestione Canale (workflow), Cronista Telecronaca (workflow), Spettatore Partita (workflow)
- notes: pagina comparison creata da pagine wiki esistenti per chiarire canale, squadra, partita, ownership e ciclo partita; regole di campionato, validazioni complete e conflitti owner/co-owner non deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Audio TTS e Localizzazione (comparison)

- created
- linked: AI-Talker (concept), TTS Audio (concept), Localizzazione (concept), Sistema Messaggi Telecronaca AI (concept), Riproduzione Audio Telecronaca (workflow), VoiceService (api), AzureSpeech (api)
- notes: pagina comparison creata da pagine wiki esistenti per collegare stile AI-Talker, messaggi multilingua, TTS e riproduzione audio; prompt AI, mapping lingua UI e caching audio non deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Blog e Pubblicazione Social (comparison)

- created
- linked: Blog (concept), Pipeline Contenuti (concept), Pubblicazione Social (concept), Pubblicazione Blog Statico (workflow), Static Blog SEO Headers (article), FacebookJob (api), SocialShareUrlIntegration (api)
- notes: pagina comparison creata da pagine wiki esistenti per mappare blog automatico, staticizzazione, SEO, condivisione e pubblicazione Facebook; cron, analytics e relazione Instagram/social non completamente deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Operativita e Backup (comparison)

- created
- linked: Operativita Backend (concept), Operazioni Amministrative (workflow), Backup USB (workflow), MaintenanceJob (api), UsbBackupJob (api), HangfireDashboard (api), AuditMiddleware (api)
- notes: pagina comparison creata da pagine wiki esistenti per mappare manutenzione, backup database, backup USB, audit e superfici operative; frequenze job, cartelle definitive backup e runbook restore non deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Interazioni e Notifiche (comparison)

- created
- linked: Interazione (concept), Notifica (concept), MatchEventCreated, CommentAdded, ReactionAdded, MatchLiked, SubscriptionChanged, Spettatore Partita (workflow), FirebaseFCM (api), UserToken (api), Subscription (api)
- notes: pagina comparison creata da pagine wiki esistenti per collegare interazioni spettatore, follow, notifiche push e data-event; notifiche commenti, analytics, moderazione e realtime UI completo non deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Frontend Pubblico e Autenticato (comparison)

- created
- linked: HomePage (web), GMatchPage (web), GFeedbackPage (web), LoginPage (web), RegistrationPage (web), ResetPasswordPage (web), ProfilePage (web), DangerPage (web), MatchPage (web), ChannelPage (web), ChannelsPage (web), AuthGuardService (web), LoginCallbackService (web), UserService (web), AuthV1Controller (api), UserV1Controller (api), Autenticazione Utente (workflow), Spettatore Partita (workflow), Cronista Telecronaca (workflow), Gestione Canale (workflow)
- notes: pagina comparison creata da pagine wiki esistenti per mappare superfici frontend pubbliche, ibride e autenticate; matrice completa delle route Angular, policy endpoint puntuali e redirect completi non deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Integrazioni Esterne (comparison)

- created
- linked: FirebaseFCM (api), SmtpEmail (api), GoogleOAuth (api), FacebookGraphAPI (api), OllamaAI (api), AzureSpeech (api), BlogStaticFilePublishingIntegration (api), SeoSitemapFilePublishingIntegration (api), SocialShareUrlIntegration (api), PublicMediaUrlReferenceIntegration (api), AnalyticsService (web), EmailService (api), UserService (api), FacebookService (api), FacebookJob (api), CreateMatchBlogHtmlJob (api), GenerateSeoSitemapJob (api)
- notes: pagina comparison creata da pagine wiki esistenti per mappare provider esterni, integrazioni filesystem, side effect e fallback noti; SLA, rate limit, retry completi e osservabilita per provider non deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Repository e Persistenza (comparison)

- created
- linked: AppDbContext (api), UserRepository (api), ChannelRepository (api), MatchRepository (api), BlogRepository (api), UserTokenRepository (api), UserOtpCodeRepository (api), UserService (api), ChannelService (api), MatchService (api), BlogService (api), User (api), Channel (api), Match (api), Blog (api), Interazione (concept), Utente (concept)
- notes: pagina comparison creata da pagine wiki esistenti per mappare AppDbContext, repository principali, aggregati e servizi consumer; repository minori, confini transazionali, indici e migrazioni non completamente deducibili; nessun RAW letto.

## [2026-07-07] content | Mappatura Account e Profilo Utente (comparison)

- created
- linked: Utente (concept), LoginPage (web), RegistrationPage (web), ResetPasswordPage (web), ProfilePage (web), DangerPage (web), GFeedbackPage (web), UserService (web), AuthGuardService (web), LoginCallbackService (web), AuthV1Controller (api), UserV1Controller (api), UserService (api), User (api), UserToken (api), UserOtpCode (api), JwtBearerAuthentication (api), GoogleOAuth (api), SmtpEmail (api), FirebaseFCM (api), Autenticazione Utente (workflow)
- notes: pagina comparison creata da pagine wiki esistenti per mappare registrazione, login, reset OTP, profilo, preferenze, token notifiche, feedback e cancellazione account; criteri password, rate limiting, refresh token e discrepanza accesso feedback richiedono verifica; nessun RAW letto.

## [2026-07-07] content | Mappatura Componenti UI Condivisi (comparison)

- created
- linked: IconComponent (web), EntityButtonComponent (web), EntityAlertComponent (web), EntityToastComponent (web), ToastService (web), EntityPageHeaderComponent (web), EntitySkeletonComponent (web), EntityPaginationComponent (web), EntitySearchComponent (web), EntityTabsComponent (web), EntityShareComponent (web), EntityAdsComponent (web), AnalyticsService (web), UserService (web), HomePage (web), GMatchPage (web), ProfilePage (web), ChannelPage (web), ChannelsPage (web), GChannelsPage (web), GMatchesPage (web)
- notes: pagina comparison creata da pagine wiki esistenti per mappare componenti UI atomici, layout, liste, stati, tab, share, ads e servizi trasversali; varianti visuali complete, accessibilita e test visuali non deducibili; nessun RAW letto.
