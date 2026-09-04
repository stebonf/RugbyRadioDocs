# Inventory tecnico - Migrazione Next.js Tailwind

## Fonte

- Idea: `projects/nextjs-tailwind-migration/notes/idea-nextjs-tailwind.md`
- AF: `projects/nextjs-tailwind-migration/analysis/analisi-funzionale-nextjs-tailwind.md`
- Routing Angular: `src/RugbyRadioWeb/src/app/app.routes.ts`
- Routing/componenti Next rilevati: `src/RugbyRadioWebNext/app`, `src/RugbyRadioWebNext/components`, `src/RugbyRadioWebNext/lib`
- Wiki consultata:
  - `llm-wiki/wiki/comparisons/Mappatura Pagine e API (comparison).md`
  - `llm-wiki/wiki/comparisons/Mappatura Servizi FE e BE (comparison).md`
  - `llm-wiki/wiki/comparisons/Mappatura Componenti UI Condivisi (comparison).md`
  - `llm-wiki/wiki/comparisons/Mappatura SEO e Analytics (comparison).md`

Nota: `llm-wiki/wiki/index.md` e `llm-wiki/wiki/summary.md` non risultano presenti nel workspace. La mappa usa quindi AF, routing e confronti wiki disponibili.

## Obiettivo

Ridurre l'ambiguita prima dello scaffold o del consolidamento della migrazione, rendendo esplicita per ogni pagina Angular:

- route target Next.js;
- dipendenze API e servizi frontend equivalenti;
- componenti del design system globale necessari;
- stati funzionali da testare;
- note SEO, auth, redirect o noindex.

## Task list tecnica

| ID | Attivita | Output | Dipendenze | Stato |
|---|---|---|---|---|
| INV-01 | Confermare route legacy Angular e route target Next | Matrice pagina-per-pagina sotto | AF, `app.routes.ts`, file `app/` Next | Completato |
| INV-02 | Validare copertura API service Next rispetto ai service Angular | Checklist per dominio e gap endpoint | `services/*.ts`, `lib/api/*.ts`, controller wiki | Da fare |
| INV-03 | Classificare pagine SSR/SSG/client-only | Decisione rendering per route pubbliche e protette | SEO, auth, browser API, Firebase/FCM | Da fare |
| INV-04 | Definire redirect legacy -> Next | Tabella redirect/canonical deploy-ready | Hosting target, SEO policy | Da fare |
| INV-05 | Bloccare componenti DS minimi per pagina | Component inventory e varianti/stati | Tailwind theme, componenti `components/ui` | Da fare |
| INV-06 | Preparare test manuali e automatizzabili per stati pagina | QA checklist per route | Matrice sotto | Da fare |
| INV-07 | Verificare analytics, ads, PWA e FCM su pagine applicabili | Report tecnico di parita cross-cutting | Config env e deploy preview | Da fare |
| INV-08 | Decidere piano di switch e rollback | Runbook migrazione Angular -> Next | Redirect, hosting, validazione finale | Da fare |

## Legenda componenti DS

| Sigla | Componenti Next target |
|---|---|
| DS-Layout | `PublicShell`, `AuthenticatedShell`, header/footer/bottom navigation |
| DS-Button | `Button`, `IconButton`, controlli iconografici |
| DS-Feedback | `Alert`, `Toast`, `EmptyState`, error boundary/pattern errore |
| DS-Loading | `Skeleton`, placeholder liste/header/card |
| DS-Forms | `FormField`, `SelectField`, input, validazioni form |
| DS-Entity | `PageHeader`, card canale, card match, card blog, pannelli entita |
| DS-Nav | `Tabs`, `Pagination`, `Search`, link e callback di navigazione |
| DS-Share | `Share`, copia link, Web Share API fallback |
| DS-Ads | `AdsSlot`, placement AdSense |
| DS-Match | `match-panels`, eventi, lineup, commenti, reaction, radio/audio |
| DS-Account | pannelli profilo, preferiti, pericolo account |

## Inventory pagina-per-pagina

| Angular page / route | Next route target | API services | Componenti DS | Stati da testare | Note SEO/auth |
|---|---|---|---|---|---|
| `HomePage` / `/` | `/` | `ChannelService`, `MatchService` -> `lib/api/public-data`, `channels`, `matches` | DS-Layout, DS-Entity, DS-Loading, DS-Ads, DS-Nav | loading sezioni, empty liste, errore API, mobile, ads non configurati | Pubblica indicizzabile. Preservare canonical `/`, metadata social, analytics page view. |
| `LoginPage` / `/user-login` | `/login` | `UserService` -> `lib/api/user`, Auth API | DS-Layout, DS-Forms, DS-Button, DS-Feedback | credenziali errate, validazione campi, callback post-login, Google OAuth, API down | Pubblica ma `noindex`. Serve redirect legacy `/user-login` -> `/login`. Non esporre token in URL. |
| `RegistrationPage` / `/user-registration` | `/register` | `UserService` -> `lib/api/user`, Auth API | DS-Layout, DS-Forms, DS-Button, DS-Feedback | validazione campi, lingua selezionata, email gia usata, successo login/sessione | Pubblica ma `noindex`. Redirect legacy `/user-registration` -> `/register`. |
| `ResetPasswordPage` / `/user-reset-password` | `/reset-password` | `UserService` -> `lib/api/user`, Auth API | DS-Layout, DS-Forms, DS-Button, DS-Feedback | richiesta OTP, OTP errato/scaduto, password non valida, successo | Pubblica ma `noindex`. Redirect legacy `/user-reset-password` -> `/reset-password`. |
| `HomePage` protetta / `/user-dashboard` | `/account` oppure `/` con sessione | `UserService`, public data opzionale | DS-Layout, DS-Account, DS-Entity | accesso non autenticato, sessione valida, logout, dati utente assenti | Protetta se mantenuta come dashboard. Decidere redirect legacy `/user-dashboard` -> `/account` o `/`. |
| `ProfilePage` / `/user-profile` | `/account/profile` | `UserService` -> `lib/api/user` | DS-Layout, DS-Forms, DS-Account, DS-Feedback | loading profilo, update lingua/timezone, errori validazione, token scaduto | Protetta, `noindex`. Redirect a login con callback se sessione assente. |
| `ChannelsPage` / `/user-channels` | `/studio/channels` | `ChannelService` -> `lib/api/channels` | DS-Layout, DS-Entity, DS-Button, DS-Loading, DS-Feedback | lista vuota, creazione canale, errore API, permessi, mobile | Protetta, `noindex`. Route operativa cronista. |
| `ChannelPage` / `/user-channel/:channelId` | `/studio/channels/[channelId]` | `ChannelService`, `ChannelUserService`, `TeamService`, `MatchService` -> `lib/api/channels`, `teams`, `matches` | DS-Layout, DS-Entity, DS-Forms, DS-Nav, DS-Feedback, DS-Loading | canale inesistente, permesso negato, modifica info/layout, squadre, editor utenti, partite, salvataggi falliti | Protetta, `noindex`. Preservare callback login e controlli ownership/ruoli delegati al backend. |
| `MatchPage` / `/user-match/:matchId` | `/studio/matches/[matchId]` | `MatchService`, `PlayerService`, `LineupService`, `BlogService`, `VoiceService` -> `lib/api/matches`, `players`, `lineups`, `blog`, `voice` | DS-Layout, DS-Match, DS-Entity, DS-Forms, DS-Button, DS-Feedback, DS-Loading, DS-Share | match non trovato, permesso negato, eventi live, quick event, lineup, giocatori, blog, audio, rating, reaction, rete lenta mobile | Protetta, `noindex`. Workflow critico cronista: testare smartphone e rapidita operativa. |
| `DangerPage` / `/user-danger` | `/account/danger` | `UserService` -> `lib/api/user` | DS-Layout, DS-Account, DS-Forms, DS-Button, DS-Feedback | conferma cancellazione, errore password/sessione, logout dopo delete, annullamento | Protetta, `noindex`. Azione distruttiva con conferma esplicita. |
| `FavoritesPage` / `/user-favorites` | `/account/favorites` | `ChannelService`, `UserService` -> `lib/api/channels`, sessione | DS-Layout, DS-Account, DS-Entity, DS-Loading, DS-Feedback | lista vuota, unfollow, errore API, token scaduto | Protetta, `noindex`. Validare che follow/unfollow richieda account. |
| `GChannelPage` / `/g-channel/:channelPublicId` | `/channels/[channelPublicId]` | `ChannelService`, `MatchService` -> `lib/api/public-data`, `channels`, `matches` | DS-Layout, DS-Entity, DS-Nav, DS-Share, DS-Ads, DS-Loading | canale non trovato, tabs, match empty, follow login-required, share fallback, ads | Pubblica indicizzabile. Canonical su nuova URL, redirect legacy `/g-channel/*`, Open Graph con dati canale. |
| `GMatchPage` / `/g-match/:matchId` | `/matches/[matchId]` | `MatchService`, `BlogService`, `VoiceService` -> `lib/api/public-data`, `matches`, `blog`, `voice` | DS-Layout, DS-Match, DS-Entity, DS-Nav, DS-Share, DS-Ads, DS-Loading | match non trovato, eventi empty, commenti/reaction login-required, audio assente, blog assente, refresh eventi | Pubblica indicizzabile. Canonical su nuova URL, redirect legacy `/g-match/*`, metadata match e JSON-LD se previsto. |
| `GMatchRadioPage` / `/g-radio/:matchId` | `/radio/[matchId]` | `MatchService`, `VoiceService` -> `lib/api/matches`, `voice` | DS-Layout, DS-Match, DS-Feedback, DS-Button | audio non disponibile, autoplay bloccato, cambio voce/lingua, rete lenta, fine coda audio | Pubblica o ibrida. Canonical da decidere rispetto a `/matches/[matchId]`; verificare SEO se pagina separata resta indicizzabile. |
| `GMatchesPage` / `/g-matches` | `/matches` | `MatchService` -> `lib/api/public-data`, `matches` | DS-Layout, DS-Entity, DS-Nav, DS-Search, DS-Loading, DS-Ads | ricerca, paginazione, filtri/stati temporali, empty, errore API, mobile | Pubblica indicizzabile. Redirect legacy `/g-matches`, canonical `/matches`, analytics lista. |
| `GChannelsPage` / `/g-channels` | `/channels` | `ChannelService` -> `lib/api/public-data`, `channels` | DS-Layout, DS-Entity, DS-Nav, DS-Search, DS-Loading, DS-Ads | ricerca, paginazione, empty, errore API, card con logo mancante | Pubblica indicizzabile. Redirect legacy `/g-channels`, canonical `/channels`. |
| `GTeamPage` / `/g-team/:teamId` | `/teams/[teamId]` | `TeamService`, `MatchService` -> `lib/api/public-data`, `teams`, `matches` | DS-Layout, DS-Entity, DS-Nav, DS-Share, DS-Loading, DS-Ads | team non trovato, logo mancante, match empty, tabs/stats, share fallback | Pubblica indicizzabile. Redirect legacy `/g-team/*`, canonical `/teams/*`, metadata team. |
| `GStatsPage` / `/g-stats` | `/stats` | `StatsService` -> `lib/api/public-data` o `stats` | DS-Layout, DS-Entity, DS-Loading, DS-Ads | dati vuoti, errore API, card statistiche, mobile, ads | Pubblica indicizzabile. Redirect legacy `/g-stats`, canonical `/stats`. |
| `GFeedbackPage` / `/g-feedback` | `/feedback` | `UserService` -> feedback API in `lib/api/user` | DS-Layout, DS-Forms, DS-Button, DS-Feedback | invio anonimo/autenticato, validazioni, API down, successo, rate limit se presente | Pubblica. Canonical `/feedback`; valutare `noindex` solo se pagina non strategica SEO. |
| `AdminMaintenancePage` / `/admin-maintenance`, `/adm-maintenance` | `/_maintenance` | Nessuna API documentata | DS-Layout, DS-Feedback | maintenance on/off, route wildcard in modalita manutenzione, accesso diretto | Pubblica tecnica. Generalmente `noindex`; chiarire mapping legacy `/admin-maintenance` -> `/_maintenance`. |

## Superfici statiche/editoriali da includere nella migrazione

Queste route non compaiono in `app.routes.ts`, ma sono rilevanti per AF, SEO e app Next gia rilevata.

| Superficie | Next route target | Fonte/servizi | Componenti DS | Stati da testare | Note SEO/auth |
|---|---|---|---|---|---|
| Why / value proposition | `/why` | contenuto statico | DS-Layout, DS-Entity | render statico, mobile, metadata | Pubblica indicizzabile, Open Graph e canonical dedicati. |
| Tutorial | `/tutorial` | contenuto statico | DS-Layout, DS-Entity | render statico, link interni, mobile | Pubblica indicizzabile. |
| News / updates | `/news` | contenuto statico | DS-Layout, DS-Entity | render statico, link, mobile | Pubblica indicizzabile. |
| How-to | `/how-to` | contenuto statico | DS-Layout, DS-Entity | render statico, leggibilita mobile | Pubblica indicizzabile. |
| Architecture/editoriale prodotto | `/architecture` | contenuto statico | DS-Layout, DS-Entity | render statico, mobile | Pubblica indicizzabile se mantenuta come contenuto marketing/SEO. |
| Terms | `/terms` | contenuto statico | DS-Layout | render statico, link legali | Pubblica, canonical dedicato. |
| Team editoriale | `/team`, `/team/[memberSlug]` | `lib/content/team-members` | DS-Layout, DS-Entity | membro non trovato, metadata, mobile | Pubblica indicizzabile, utile per traffico documentato in GA. |
| Blog index e dettaglio match blog | `/blog`, `/blog/[matchId]` | `BlogService` / contenuti blog statici | DS-Layout, card blog, DS-Loading, DS-Ads | blog vuoto, match blog mancante, errore API/statico | Pubblica indicizzabile. Preservare strategia sitemap/blog statico e header SEO. |
| Design system | `/design-system` | nessuna API | DS completo | varianti, disabled, loading, focus, mobile | Interna/tecnica: valutare `noindex` o protezione se pubblicata. |
| Manifest, robots, sitemap, not-found | `/manifest.webmanifest`, `/robots.txt`, `/sitemap.xml`, `404` | Next metadata/files | DS-Layout per 404 | installabilita, indicizzazione, not-found route | Critico per SEO/PWA; validare dopo deploy preview. |

## Matrice servizi API

| Dominio Angular | Next target | Route/pagine principali | Gap da verificare |
|---|---|---|---|
| `UserService` | `lib/api/user`, `lib/auth/session`, `lib/client/storage` | login, register, reset, account, feedback, danger | Parita completa metodi auth/user; gestione callback e token scaduto. |
| `MatchService` | `lib/api/matches`, `lib/api/public-data` | home, matches, match public, studio match, team, channel | Endpoint eventi, quick match/event, reaction, rating, commenti, audio e scoreboard. |
| `ChannelService` | `lib/api/channels`, `lib/api/public-data` | channels, channel public, studio channels, favorites | Follow/subscription, layout, editor, create/update, liste pubbliche e private. |
| `ChannelUserService` | `lib/api/channels` | studio channel editor utenti | CRUD utenti canale, permessi e stati conflitto. |
| `TeamService` | `lib/api/teams`, `lib/api/public-data` | studio channel, team public | Create/update team, loghi, get team pubblico/privato. |
| `PlayerService` | `lib/api/players` | studio match | CRUD giocatori e ritorno DTO su delete/update. |
| `LineupService` | `lib/api/lineups`, `lib/api/matches` | studio match, match public | Lineup, rate player, stati massimo voti e doppio voto. |
| `BlogService` | `lib/api/blog` | studio match, match public, blog | Publish/update/get blog match, assenza contenuto, SEO statico. |
| `StatsService` | `lib/api/public-data` o `lib/api/stats` | stats | Nomi endpoint e DTO statistiche; decidere se estrarre file `stats.ts`. |
| `VoiceService` | `lib/api/voice` | radio, match public, studio match | Voci disponibili, audio URL, lingua/fallback. |
| `AnalyticsService` | `lib/client/analytics` | tutte le route pubbliche e principali azioni | Page view, eventi prodotto, fallback senza env. |
| `PlatformService`, `ErrorHandlerService`, `LoggingService` | `lib/client/platform`, `error-handler`, `logging` | cross-cutting | Uso solo client e assenza errori SSR. |

## Stati QA minimi per ogni pagina migrata

- Rendering desktop e mobile senza sovrapposizioni.
- Stato loading con skeleton o placeholder coerente.
- Stato empty con messaggio azionabile quando non ci sono dati.
- Stato errore API con feedback non distruttivo.
- Stato dato parziale: logo, immagine, audio, blog o statistiche mancanti.
- Navigazione da URL diretta e da link interno.
- Redirect da route legacy Angular, dove previsto.
- Login-required action con ritorno al contesto.
- Token scaduto su route protetta.
- Metadata `title`, `description`, canonical e Open Graph per pagine pubbliche indicizzabili.
- `noindex` per pagine auth, account, studio, maintenance e design-system se pubblicata.
- Analytics e AdSense non bloccanti quando configurazione assente.
- Persistenza lingua e fallback traduzioni.

## Decisioni aperte

| ID | Decisione | Impatto |
|---|---|---|
| D-01 | Le URL Next devono sostituire direttamente le legacy o convivere con redirect permanenti? | SEO, sitemap, canonical, link condivisi. |
| D-02 | `/g-radio/:matchId` resta pagina indicizzabile o diventa variante funzionale di `/matches/[matchId]`? | SEO, duplicazione contenuti, canonical. |
| D-03 | `/user-dashboard` deve puntare a `/account`, alla home personalizzata o restare alias autenticato? | UX post-login e callback legacy. |
| D-04 | `StatsService` resta dentro `public-data` o merita un modulo API dedicato `stats.ts`? | Chiarezza parita service e manutenzione DTO. |
| D-05 | `/design-system` deve essere pubblica, protetta o disponibile solo in sviluppo? | Sicurezza informativa e indicizzazione. |
| D-06 | Le statiche editoriali gia presenti negli asset Angular sono fonte canonica o devono essere consolidate in componenti Next? | Duplicazione contenuti e SEO. |

## Prossimo passo operativo

Eseguire `INV-02`: audit dei service Angular contro `src/RugbyRadioWebNext/lib/api`, producendo una tabella endpoint-per-endpoint con stato `coperto`, `parziale`, `mancante` o `non applicabile`. Questo riduce il rischio di arrivare allo scaffold o al wiring pagina con contratti API incompleti.
