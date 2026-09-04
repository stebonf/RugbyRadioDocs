---
type: task-plan
created: 2026-07-23T21:30:00+02:00
source: functional-analysis
topic: "Migrazione RugbyRadioWebNext Next.js Tailwind"
slug: nextjs-tailwind-migration
input: "projects/nextjs-tailwind-migration/analysis/analisi-funzionale-nextjs-tailwind.md"
---

# Piano task: Migrazione RugbyRadioWebNext Next.js Tailwind

## Sintesi

Piano operativo per trasformare l'analisi funzionale della migrazione Next.js/Tailwind in lavoro eseguibile. Il piano parte da inventory pagina-per-pagina e design system globale, poi procede con scaffold, servizi API, pagine pubbliche, autenticazione, pagine operative, PWA/analytics/ads e switch controllato.

La priorita non e riscrivere tutto subito, ma ridurre ambiguita prima dello scaffold: ogni route Angular deve avere route Next target, servizi API, componenti design system, stati da testare e note SEO/auth.

## Input usato

- `projects/nextjs-tailwind-migration/analysis/analisi-funzionale-nextjs-tailwind.md`
- `src/RugbyRadioWeb/src/app/app.routes.ts`
- `llm-wiki/wiki/comparisons/Mappatura Pagine e API (comparison).md`
- `llm-wiki/wiki/comparisons/Mappatura Servizi FE e BE (comparison).md`
- `llm-wiki/wiki/comparisons/Mappatura Componenti UI Condivisi (comparison).md`
- `llm-wiki/wiki/comparisons/Mappatura Frontend Pubblico e Autenticato (comparison).md`
- `llm-wiki/wiki/comparisons/Mappatura SEO e Analytics (comparison).md`

## Obiettivo operativo

Creare `src/RugbyRadioWebNext` come nuova WebApp Next.js/Tailwind funzionalmente equivalente a `src/RugbyRadioWeb`, con design system globale e migrazione progressiva verificabile per route, workflow e componenti.

## Decisioni bloccanti

- **Route canoniche** - Decidere se mantenere esattamente gli URL Angular (`/g-match/:matchId`, `/user-login`, ecc.) o introdurre URL piu moderni con redirect. Owner: product/tech lead. 
RISPOSTA: più moderni
- **Hosting Next.js** - Decidere hosting runtime: Firebase Hosting static/export, Firebase + Cloud Functions/Node, Cloudflare, IIS reverse proxy o altro. Owner: tech lead/devops. 
RISPOSTA: Cloudflare
- **Rendering strategy** - Classificare route come statiche, server-rendered, client-rendered o ibride. Owner: frontend/tech lead. RISPOSTA: server-rendered
- **Auth storage** - Decidere gestione token/sessione in Next: localStorage client-only come Angular, cookie httpOnly tramite backend dedicato, o strategia intermedia. Owner: tech lead/security.
RISPOSTA: fase 1 localStorage
- **PWA/TWA switch** - Decidere se la TWA Android passa a Next nel primo rilascio o dopo validazione dedicata. Owner: product/ops.
RISPOSTA: si passa a Next nel primo rilascio
- **Statiche e blog** - Decidere se le statiche in `assets/static` restano asset HTML separati o diventano route Next. Owner: product/SEO.
RISPOSTA: diventano route Next
- **Design system governance** - Decidere se documentarlo solo in codice, in wiki, o con Storybook/demo route. Owner: frontend/product.
RISPOSTA: prevediamo anche uno storybook/demo

## Assunzioni

- Il backend ASP.NET Core e i contratti API restano invariati per l'MVP.
- `RugbyRadioWebNext` verra creato sotto `src/`, accanto a `src/RugbyRadioWeb`.
- L'app Angular resta disponibile fino a parita funzionale verificata.
- La prima versione Next deve preferire route compatibili con le route Angular, salvo decisione esplicita diversa.
- Tailwind sara configurato con theme/token globali, non come insieme di utility duplicate nei singoli componenti.
- Le pagine pubbliche devono preservare SEO, analytics e AdSense dove gia previsti.

## Inventory migrazione pagina-per-pagina

Legenda:

- **Accesso**: Pubblico, Ibrido, Auth, Maintenance.
- **Next route proposta**: route compatibile con URL Angular. Da rivedere dopo decisione su canonical/redirect.
- **DS principali**: componenti design system da creare/riusare prima o durante la migrazione.
- **Stati da testare**: minimo set QA per parita funzionale.

| Angular page | Angular route | Next route proposta | Accesso | API services | DS principali | Stati da testare | Note SEO/auth |
|---|---|---|---|---|---|---|---|
| `HomePage` | `/` | `/` | Pubblico | `ChannelService`, `MatchService`, `AnalyticsService` | `PageShell`, `HomeSection`, `MatchCard`, `ChannelCard`, `Button`, `Ads`, `Skeleton` | loading, empty liste, errore API, desktop, mobile, lingua | SEO home, analytics page view, ads, variante autenticata via `/user-dashboard`. |
| `HomePage` dashboard | `/user-dashboard` | `/user-dashboard` | Auth | `UserService`, `ChannelService`, `MatchService` | `AuthenticatedShell`, `HomeSection`, `MatchCard`, `ChannelCard`, `Toast` | non loggato redirect, logged-in, loading, errore API | Route protetta; possibile riuso della home con contenuti utente. |
| `LoginPage` | `/user-login` | `/user-login` | Pubblico | `UserService`, `AuthService`, `LoginCallbackService` | `AuthShell`, `FormField`, `Button`, `Alert`, `Toast` | credenziali valide, invalide, Google OAuth, callback, loading | Noindex da valutare; deve preservare return URL. |
| `RegistrationPage` | `/user-registration` | `/user-registration` | Pubblico | `UserService`, `AuthService` | `AuthShell`, `FormField`, `Button`, `Alert`, `Toast` | registrazione valida, validazioni, errore API, loading | Noindex da valutare; policy password non deducibile dalla wiki. |
| `ResetPasswordPage` | `/user-reset-password` | `/user-reset-password` | Pubblico | `UserService`, `AuthService` | `AuthShell`, `FormField`, `Button`, `Alert`, `Toast` | richiesta OTP, OTP invalido/scaduto, nuova password, loading | Noindex da valutare; preservare flusso OTP. |
| `ProfilePage` | `/user-profile` | `/user-profile` | Auth | `UserService` | `AuthenticatedShell`, `PageHeader`, `FormField`, `Button`, `Toast`, `Alert` | non loggato, dati profilo, update success/error, loading | Route protetta; nessun SEO pubblico. |
| `DangerPage` | `/user-danger` | `/user-danger` | Auth | `UserService` | `AuthenticatedShell`, `Alert`, `Button`, `ConfirmDialog`, `Toast` | non loggato, conferma, annulla, errore delete | Route protetta; azione distruttiva con conferma chiara. |
| `FavoritesPage` | `/user-favorites` | `/user-favorites` | Auth | `ChannelService`, `UserService` | `AuthenticatedShell`, `ChannelCardList`, `Pagination`, `Skeleton`, `EmptyState` | non loggato, lista vuota, loading, errore API | Route protetta; verificare mapping API puntuale dal codice. |
| `ChannelsPage` | `/user-channels` | `/user-channels` | Auth | `ChannelService` | `AuthenticatedShell`, `PageHeader`, `ChannelCardList`, `Search`, `Pagination`, `Button`, `Toast` | non loggato, lista vuota, create/edit entrypoint, loading, errore | Workflow gestione canali. |
| `ChannelPage` | `/user-channel/:channelId` | `/user-channel/[channelId]` | Auth | `ChannelService`, `ChannelUserService`, `TeamService`, `MatchService` | `AuthenticatedShell`, `PageHeader`, `Tabs`, `TeamList`, `MatchCardList`, `FormField`, `Toast` | non loggato, non owner, tabs, team, match, editors, loading, error | Route protetta; backend resta source of truth permessi. |
| `MatchPage` | `/user-match/:matchId` | `/user-match/[matchId]` | Auth | `MatchService`, `PlayerService`, `LineupService`, `BlogService`, `VoiceService` | `AuthenticatedShell`, `MatchHeader`, `Tabs`, `MatchEvents`, `MatchLineup`, `MatchStats`, `Button`, `Modal`, `Toast` | non loggato, non autorizzato, evento creato, lineup, blog, audio, loading, error | Workflow cronista critico mobile-first. |
| `GChannelPage` | `/g-channel/:channelPublicId` | `/g-channel/[channelPublicId]` | Pubblico/Ibrido | `ChannelService`, `MatchService`, `AnalyticsService` | `PublicShell`, `PageHeader`, `Tabs`, `Share`, `MatchCardList`, `Ads`, `Skeleton` | loading, canale non trovato, tabs, follow/login, empty match, mobile | SEO pubblico, canonical, OG, ads; login opzionale per azioni ibride. |
| `GMatchPage` | `/g-match/:matchId` | `/g-match/[matchId]` | Pubblico/Ibrido | `MatchService`, `BlogService`, `VoiceService`, `AnalyticsService` | `PublicShell`, `MatchHeader`, `Tabs`, `MatchEvents`, `MatchCommentator`, `Share`, `Ads`, `Toast` | loading, match non trovato, eventi vuoti, commenti login, reazioni, voti, TTS, mobile | SEO pubblico ad alto valore; interazioni ibride con callback login. |
| `GMatchRadioPage` | `/g-radio/:matchId` | `/g-radio/[matchId]` | Pubblico/Ibrido | `MatchService`, `VoiceService`, `AnalyticsService` | `PublicShell`, `RadioPlayer`, `MatchCommentator`, `MatchEvents`, `Button`, `Toast` | play, stop, nuovi eventi, audio non disponibile, errore TTS, mobile background | Route reale presente nel routing Angular; verificare AF radio come fonte dedicata. |
| `GMatchesPage` | `/g-matches` | `/g-matches` | Pubblico | `MatchService`, `AnalyticsService` | `PublicShell`, `PageHeader`, `Search`, `MatchCardList`, `Pagination`, `Ads`, `Skeleton` | lista, ricerca, paginazione, empty, errore, mobile | SEO lista pubblica; canonical e metadata. |
| `GChannelsPage` | `/g-channels` | `/g-channels` | Pubblico | `ChannelService`, `AnalyticsService` | `PublicShell`, `PageHeader`, `Search`, `ChannelCardList`, `Pagination`, `Ads`, `Skeleton` | lista, ricerca, paginazione, empty, errore, mobile | SEO lista pubblica; canonical e metadata. |
| `GTeamPage` | `/g-team/:teamId` | `/g-team/[teamId]` | Pubblico | `TeamService`, `MatchService`, `AnalyticsService` | `PublicShell`, `PageHeader`, `Tabs`, `MatchCardList`, `StatsGrid`, `Share`, `Ads` | team non trovato, stats, match vuoti, loading, errore, mobile | SEO pubblico; verificare JSON-LD se presente/necessario. |
| `GStatsPage` | `/g-stats` | `/g-stats` | Pubblico | `StatsService`, `AnalyticsService` | `PublicShell`, `PageHeader`, `StatsGrid`, `Ads`, `Skeleton`, `EmptyState` | loading, stats disponibili, empty, errore, mobile | SEO pubblico e ads documentati. |
| `GFeedbackPage` | `/g-feedback` | `/g-feedback` | Pubblico/Ibrido | `UserService`, `AnalyticsService` | `PublicShell`, `FormField`, `Button`, `Alert`, `Toast` | invio anonimo/loggato se previsto, validazioni, errore, success | Pubblica; policy auth da confermare dal codice. |
| `AdminMaintenancePage` | `/admin-maintenance` | `/admin-maintenance` | Maintenance | Nessuna API diretta documentata | `MaintenanceShell`, `Alert`, `Button` | maintenance on/off, redirect wildcard, mobile | Route attiva solo con `environment.maintenance`; noindex. |
| Redirect maintenance | `/adm-maintenance` | `/adm-maintenance` | Maintenance | Nessuna | `RedirectRule` | redirect corretto | Alias legacy da preservare se maintenance resta. |
| Wildcard | `**` | `not-found` o redirect `/` | Pubblico/Maintenance | Nessuna | `NotFound`, `RedirectRule` | URL inesistente, maintenance on/off | Decidere tra redirect home e 404 SEO-friendly. |

## Inventory design system iniziale

| Area DS | Componenti Next proposti | Origine Angular/wiki | Note |
|---|---|---|---|
| Shell | `PublicShell`, `AuthenticatedShell`, `MaintenanceShell`, `Header`, `Footer`, `BottomNav` | header/footer/base-user/g-base-user/entity-bottom-nav | Separare layout pubblico, autenticato e maintenance. |
| Azioni | `Button`, `IconButton`, `LinkButton`, `ConfirmDialog` | `EntityButtonComponent`, `IconComponent`, modali | Varianti globali e focus state obbligatori. |
| Feedback | `Alert`, `Toast`, `EmptyState`, `ErrorState`, `Skeleton` | `EntityAlert`, `EntityToast`, `EntitySkeleton` | Stati coerenti in tutte le route. |
| Navigazione contenuti | `Tabs`, `Pagination`, `Search`, `ScrollToTop`, `Share` | `EntityTabs`, `EntityPagination`, `EntitySearch`, `EntityShare` | Componenti controllati, senza chiamate API interne. |
| Card/listing | `MatchCard`, `MatchCardSmall`, `MatchCardList`, `ChannelCard`, `ChannelCardList` | match/channel card/list | Usati da home, liste e pagine entita. |
| Entita | `PageHeader`, `StatsGrid`, `InfoList`, `CardInfo` | `EntityPageHeader`, `EntityStatsGrid`, `EntityInfo`, `EntityCardInfo` | Supportare loading e skeleton. |
| Match | `MatchHeader`, `MatchEvents`, `MatchCommentator`, `MatchLineup`, `MatchStats`, `RadioPlayer` | componenti match comuni e globali | Critici per spettatore e cronista. |
| Form | `FormField`, `Select`, `Textarea`, `Checkbox`, `ValidationMessage` | campi user/channel/match | Necessari per auth, profilo, canali e match. |
| Monetizzazione | `AdsSlot` | `EntityAdsComponent` | Rendering non bloccante, client-safe. |

## Milestone

### M0 - Inventory e decisioni

- Scopo: confermare route target, dipendenze API, strategia hosting/rendering/auth e governance DS.
- Output: inventory approvato, decisioni bloccanti documentate, ordine di migrazione confermato.
- Dipendenze: nessuna.

### M1 - Scaffold Next e design system base

- Scopo: creare progetto `RugbyRadioWebNext`, Tailwind theme, shell e componenti DS minimi.
- Output: build Next funzionante, route demo, token e componenti base.
- Dipendenze: M0 almeno per hosting/rendering iniziale.

### M2 - Layer applicativo e integrazioni client

- Scopo: portare env, API client, DTO, sessione, i18n, analytics wrapper, ads wrapper.
- Output: servizi API equivalenti e infrastruttura client-safe.
- Dipendenze: M1.

### M3 - Pagine pubbliche SEO

- Scopo: migrare home e route pubbliche principali.
- Output: pagine pubbliche navigabili con metadata, loading/error/empty e analytics.
- Dipendenze: M1, M2.

### M4 - Auth e account

- Scopo: migrare login, registrazione, reset, profilo, preferiti, danger.
- Output: sessione e route protette funzionanti.
- Dipendenze: M2.

### M5 - Workflow cronista

- Scopo: migrare canali utente, pagina canale e pagina match editor.
- Output: flusso cronista end-to-end verificabile da mobile.
- Dipendenze: M2, M4.

### M6 - PWA/TWA, parity QA e switch

- Scopo: validare PWA, FCM, AdSense, analytics, redirect/canonical, performance e rollout.
- Output: checklist release, ambiente parallelo e piano switch/rollback.
- Dipendenze: M3, M4, M5.

## Backlog prioritizzato

### NXT-T001 - Approvare inventory route e policy URL

- **Priorita** - P0.
- **Milestone** - M0.
- **Tipo** - Decisione / Docs.
- **Sforzo** - Piccolo.
- **Rischio** - Alto.
- **Parallelizzabile** - No.
- **Descrizione** - Rivedere la matrice pagina-per-pagina, decidere se mantenere URL Angular o introdurre URL Next con redirect.
- **Input** - Questo documento, `app.routes.ts`, AF Next.js/Tailwind.
- **Output** - Sezione decisionale aggiornata nel task plan o documento `projects/nextjs-tailwind-migration/decisions/nextjs-url-decisions.md`.
- **File/componenti probabili** - Solo artifact/documentazione.
- **Dipendenze** - Nessuna.
- **Criteri di accettazione** - Ogni route ha decisione `keep`, `redirect`, `rename` o `defer`; wildcard/404 e maintenance sono esplicitati.
- **Validazione consigliata** - Review manuale product/tech/SEO.
- **Prompt AI-ready** - Usa `tasklist-nextjs-tailwind-migration.md` e proponi decisioni URL per ogni route: keep/redirect/rename/defer, impatti SEO/auth, redirect richiesti e open question residue. Non modificare codice.

### NXT-T002 - Decidere hosting e rendering strategy

- **Priorita** - P0.
- **Milestone** - M0.
- **Tipo** - Spike.
- **Sforzo** - Medio.
- **Rischio** - Alto.
- **Parallelizzabile** - Si, dopo NXT-T001.
- **Descrizione** - Valutare opzioni hosting Next compatibili con RRL e classificare route in SSR/SSG/client.
- **Input** - AF, route inventory, `src/RugbyRadioWeb/firebase.json`, vincoli PWA/TWA.
- **Output** - Mini design hosting/rendering con raccomandazione e vincoli.
- **File/componenti probabili** - `src/RugbyRadioWeb/firebase.json`, eventuali config deploy future.
- **Dipendenze** - NXT-T001 consigliata.
- **Criteri di accettazione** - Raccomandazione esplicita; route classificate; impatti su auth, SEO, ads, FCM e deploy chiariti.
- **Validazione consigliata** - Review tech lead/devops.
- **Prompt AI-ready** - Analizza opzioni hosting per `RugbyRadioWebNext` in RRL. Considera Firebase Hosting, Next static export, Node runtime e Cloudflare/IIS. Classifica ogni route come static/server/client/ibrida. Output: raccomandazione, rischi, prerequisiti, no codice.

### NXT-T003 - Decidere strategia auth/sessione Next

- **Priorita** - P0.
- **Milestone** - M0.
- **Tipo** - Spike / Security.
- **Sforzo** - Medio.
- **Rischio** - Alto.
- **Parallelizzabile** - Si, dopo NXT-T001.
- **Descrizione** - Definire come Next gestisce token JWT, route protette, callback post-login e differenze server/client.
- **Input** - `UserService`, `AuthGuardService`, `LoginCallbackService`, workflow autenticazione.
- **Output** - Strategia auth con tradeoff e regole implementative.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/services/user.service.ts`, `auth-guard.service.ts`, `login-callback.service.ts`.
- **Dipendenze** - NXT-T001.
- **Criteri di accettazione** - Strategia scelta; trattamento token esplicito; route protette e callback descritti; rischi XSS/SSR considerati.
- **Validazione consigliata** - Review tech/security.
- **Prompt AI-ready** - Leggi i servizi auth Angular e proponi strategia auth per Next senza cambiare backend. Copri token, localStorage/cookie, middleware, route protette, callback login e rischi SSR. Non modificare codice.

### NXT-T004 - Scaffold `RugbyRadioWebNext`

- **Priorita** - P0.
- **Milestone** - M1.
- **Tipo** - Frontend / Setup.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - No.
- **Descrizione** - Creare progetto Next.js TypeScript con Tailwind CSS sotto `src/RugbyRadioWebNext`.
- **Input** - Decisioni NXT-T001/T002.
- **Output** - Progetto compilabile con script build/dev/lint.
- **File/componenti probabili** - `src/RugbyRadioWebNext/package.json`, `next.config.*`, `tailwind.config.*`, `tsconfig.json`, `app/`.
- **Dipendenze** - NXT-T001, NXT-T002.
- **Criteri di accettazione** - `npm run build` passa; pagina home placeholder; nessuna dipendenza runtime da Angular.
- **Validazione consigliata** - `npm run build` da `src/RugbyRadioWebNext`.
- **Prompt AI-ready** - Crea `src/RugbyRadioWebNext` con Next.js, TypeScript e Tailwind. Mantieni setup minimo, route home placeholder e script build/dev/lint. Non migrare pagine applicative. Verifica build.

### NXT-T005 - Definire Tailwind theme e token DS

- **Priorita** - P0.
- **Milestone** - M1.
- **Tipo** - Frontend / Design system.
- **Sforzo** - Medio.
- **Rischio** - Alto.
- **Parallelizzabile** - Si, dopo NXT-T004.
- **Descrizione** - Creare token globali per colori, tipografia, spacing, radius, shadow, breakpoints e stati.
- **Input** - CSS Angular esistente, componenti comuni, AF.
- **Output** - Theme Tailwind e documento breve DS.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/styles.css`, CSS comuni, `src/RugbyRadioWebNext/tailwind.config.*`, `src/RugbyRadioWebNext/app/globals.css`.
- **Dipendenze** - NXT-T004.
- **Criteri di accettazione** - Token centrali; nessuna palette one-off nelle prime pagine; stati focus/hover/disabled definiti.
- **Validazione consigliata** - Build + review visuale pagina demo.
- **Prompt AI-ready** - Analizza CSS Angular e crea token Tailwind globali per Next. Output: theme, globals CSS e breve nota `projects/nextjs-tailwind-migration/tasks/nextjs-design-system-notes.md`. Non migrare pagine complete.

### NXT-T006 - Implementare componenti DS base

- **Priorita** - P0.
- **Milestone** - M1.
- **Tipo** - Frontend / Design system.
- **Sforzo** - Grande.
- **Rischio** - Alto.
- **Parallelizzabile** - No.
- **Descrizione** - Implementare componenti base condivisi: shell, button, icon, alert, toast, skeleton, tabs, search, pagination, share, ads slot.
- **Input** - Inventory DS, componenti Angular equivalenti.
- **Output** - Componenti DS riusabili in Next.
- **File/componenti probabili** - `src/RugbyRadioWebNext/components/ui/*`, `components/layout/*`.
- **Dipendenze** - NXT-T005.
- **Criteri di accettazione** - Componenti typed; stati principali coperti; nessuna chiamata API dentro componenti atomici; accessibilita base.
- **Validazione consigliata** - Build + pagina demo componenti o screenshot manuale.
- **Prompt AI-ready** - Implementa componenti DS base in `RugbyRadioWebNext` usando token Tailwind. Mantieni componenti atomici senza API. Crea una pagina/demo interna se utile. Verifica build.

### NXT-T007 - Portare DTO e API client base

- **Priorita** - P0.
- **Milestone** - M2.
- **Tipo** - Frontend / Data access.
- **Sforzo** - Grande.
- **Rischio** - Alto.
- **Parallelizzabile** - Si, dopo NXT-T004.
- **Descrizione** - Creare layer API Next equivalente a `BaseService` e ai service Angular principali.
- **Input** - `BaseService`, service Angular, DTO.
- **Output** - API client typed per auth, user, channel, match, team, player, lineup, blog, stats, voice.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/services/*.ts`, `src/RugbyRadioWeb/src/app/dto/*`, `src/RugbyRadioWebNext/lib/api/*`, `src/RugbyRadioWebNext/types/*`.
- **Dipendenze** - NXT-T004.
- **Criteri di accettazione** - Base URL/env centralizzati; token/header gestiti; errori normalizzati; DTO necessari compilano.
- **Validazione consigliata** - Build + test minimi su client utility.
- **Prompt AI-ready** - Porta in Next DTO e client API equivalenti ai service Angular. Non migrare UI oltre eventuali smoke test. Centralizza env, auth header, parsing errori e typed responses. Verifica build.

### NXT-T008 - Implementare i18n Next

- **Priorita** - P1.
- **Milestone** - M2.
- **Tipo** - Frontend / i18n.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo NXT-T004.
- **Descrizione** - Portare le traduzioni IT/EN/FR/ES/JA e definire selezione/persistenza lingua.
- **Input** - `src/RugbyRadioWeb/src/assets/i18n/*.json`.
- **Output** - Sistema i18n Next con fallback e helper typed dove pratico.
- **File/componenti probabili** - `src/RugbyRadioWebNext/messages/*`, `lib/i18n/*`.
- **Dipendenze** - NXT-T004.
- **Criteri di accettazione** - Le 5 lingue sono disponibili; fallback gestito; lingua persistita dove previsto.
- **Validazione consigliata** - Build + smoke test cambio lingua.
- **Prompt AI-ready** - Implementa i18n in Next riusando i JSON Angular. Supporta IT/EN/FR/ES/JA, fallback e persistenza lingua. Verifica build.

### NXT-T009 - Implementare analytics, ads e client-only wrappers

- **Priorita** - P1.
- **Milestone** - M2.
- **Tipo** - Frontend / Integrazioni.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo NXT-T004.
- **Descrizione** - Creare wrapper Next client-safe per analytics Firebase, logging client, error handling, AdSense e platform detection.
- **Input** - `AnalyticsService`, `LoggingService`, `ErrorHandlerService`, `PlatformService`, `EntityAds`.
- **Output** - Utility e componenti client-only non bloccanti.
- **File/componenti probabili** - `src/RugbyRadioWebNext/lib/analytics/*`, `lib/client/*`, `components/ads/*`.
- **Dipendenze** - NXT-T004.
- **Criteri di accettazione** - SDK mancanti o non configurati non rompono render; ads non causano mismatch SSR; errori loggati in modo utile.
- **Validazione consigliata** - Build + test con env Firebase assente.
- **Prompt AI-ready** - Crea wrapper client-safe per analytics, logging, error handling, platform e AdSense in Next. Devono essere no-op se env/SDK non sono disponibili. Verifica build.

### NXT-T010 - Migrare Home e shell pubblica

- **Priorita** - P1.
- **Milestone** - M3.
- **Tipo** - Frontend / Pagina pubblica.
- **Sforzo** - Grande.
- **Rischio** - Medio.
- **Parallelizzabile** - No.
- **Descrizione** - Migrare `/` come prima pagina pilota usando DS, API client, i18n, analytics e ads.
- **Input** - `HomeComponent` e sotto-componenti home Angular.
- **Output** - Home Next funzionante.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/site/home/*`, `src/RugbyRadioWebNext/app/page.tsx`.
- **Dipendenze** - NXT-T006, NXT-T007, NXT-T008, NXT-T009.
- **Criteri di accettazione** - Dati match/canali equivalenti; loading/empty/error; metadata home; mobile/desktop coerenti.
- **Validazione consigliata** - Build + confronto manuale Angular/Next.
- **Prompt AI-ready** - Migra la home in Next usando DS e API client. Copri sezioni principali, i18n, loading/empty/error, metadata, analytics e ads. Verifica build.

### NXT-T011 - Migrare liste pubbliche `g-matches` e `g-channels`

- **Priorita** - P1.
- **Milestone** - M3.
- **Tipo** - Frontend / Pagine pubbliche.
- **Sforzo** - Grande.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo NXT-T010.
- **Descrizione** - Migrare liste pubbliche con search, pagination, card e ads.
- **Input** - `GMatchesComponent`, `GChannelsComponent`, card/list comuni.
- **Output** - `/g-matches` e `/g-channels` Next.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/global/g-matches/*`, `global/g-channels/*`, `common/*card*`.
- **Dipendenze** - NXT-T006, NXT-T007, NXT-T010.
- **Criteri di accettazione** - Ricerca e paginazione equivalenti; empty/error/loading; metadata e analytics.
- **Validazione consigliata** - Build + test manuale search/pagination.
- **Prompt AI-ready** - Migra `/g-matches` e `/g-channels` in Next. Usa DS per card, search e pagination. Mantieni API e stati equivalenti. Verifica build.

### NXT-T012 - Migrare pagine pubbliche entita `g-channel`, `g-team`, `g-stats`

- **Priorita** - P1.
- **Milestone** - M3.
- **Tipo** - Frontend / Pagine pubbliche.
- **Sforzo** - Grande.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo NXT-T011.
- **Descrizione** - Migrare pagine canale pubblico, squadra pubblica e statistiche.
- **Input** - `GChannelComponent`, `GTeamComponent`, `GStatsComponent`.
- **Output** - `/g-channel/[channelPublicId]`, `/g-team/[teamId]`, `/g-stats`.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/global/g-channel/*`, `g-team/*`, `g-stats/*`.
- **Dipendenze** - NXT-T006, NXT-T007, NXT-T011.
- **Criteri di accettazione** - Header, tabs/stats/liste equivalenti; share; ads; metadata; not found gestito.
- **Validazione consigliata** - Build + test manuale route dinamiche.
- **Prompt AI-ready** - Migra pagine pubbliche canale, team e stats in Next. Copri route dinamiche, metadata, share, ads e stati dati. Verifica build.

### NXT-T013 - Migrare `g-match` e `g-radio`

- **Priorita** - P1.
- **Milestone** - M3.
- **Tipo** - Frontend / Workflow spettatore.
- **Sforzo** - Grande.
- **Rischio** - Alto.
- **Parallelizzabile** - No.
- **Descrizione** - Migrare pagina partita pubblica e pagina radio, inclusi eventi, TTS, commentatore, interazioni ibride e audio.
- **Input** - `GMatchComponent`, `GMatchEventsComponent`, `GMatchRadioComponent`, `MatchCommentatorComponent`, radio services.
- **Output** - `/g-match/[matchId]` e `/g-radio/[matchId]`.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/global/g-match/*`, `global/g-match-radio/*`, `common/match-*`, `services/match-radio-*`.
- **Dipendenze** - NXT-T006, NXT-T007, NXT-T009, NXT-T012.
- **Criteri di accettazione** - Eventi, commenti/reazioni/voti dove previsti, TTS manuale/radio, login callback, loading/error/not found, mobile.
- **Validazione consigliata** - Build + test manuale spettatore end-to-end desktop/mobile.
- **Prompt AI-ready** - Migra `/g-match/[matchId]` e `/g-radio/[matchId]` in Next. Mantieni feed eventi, commentator, TTS, radio player e azioni ibride. Verifica build e descrivi test manuali richiesti.

### NXT-T014 - Migrare feedback pubblico

- **Priorita** - P2.
- **Milestone** - M3.
- **Tipo** - Frontend / Pagina pubblica.
- **Sforzo** - Medio.
- **Rischio** - Basso.
- **Parallelizzabile** - Si, dopo NXT-T007.
- **Descrizione** - Migrare `/g-feedback` con form, validazioni e feedback utente.
- **Input** - `GFeedbackComponent`, `UserService`.
- **Output** - `/g-feedback` Next.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/global/g-feedback/*`.
- **Dipendenze** - NXT-T006, NXT-T007, NXT-T008.
- **Criteri di accettazione** - Submit success/error; validazioni; i18n; analytics.
- **Validazione consigliata** - Build + test manuale invio.
- **Prompt AI-ready** - Migra `/g-feedback` in Next con form DS, validazioni, user API, toast/alert e analytics. Verifica build.

### NXT-T015 - Migrare autenticazione pubblica

- **Priorita** - P1.
- **Milestone** - M4.
- **Tipo** - Frontend / Auth.
- **Sforzo** - Grande.
- **Rischio** - Alto.
- **Parallelizzabile** - No.
- **Descrizione** - Migrare login, registrazione e reset password.
- **Input** - `LoginComponent`, `RegistrationComponent`, `ResetPasswordComponent`, servizi auth.
- **Output** - `/user-login`, `/user-registration`, `/user-reset-password`.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/user/login/*`, `registration/*`, `reset-password/*`.
- **Dipendenze** - NXT-T003, NXT-T006, NXT-T007, NXT-T008.
- **Criteri di accettazione** - Login email/password; Google OAuth se configurato; registrazione; OTP reset; callback post-login.
- **Validazione consigliata** - Build + test manuale auth in ambiente dev.
- **Prompt AI-ready** - Migra login, registrazione e reset password in Next seguendo strategia auth decisa. Copri callback, Google OAuth, OTP, validazioni e toast. Verifica build.

### NXT-T016 - Migrare account protetto

- **Priorita** - P1.
- **Milestone** - M4.
- **Tipo** - Frontend / Auth pages.
- **Sforzo** - Grande.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo NXT-T015.
- **Descrizione** - Migrare profilo, preferiti, danger e dashboard autenticata.
- **Input** - `ProfileComponent`, `FavoritesComponent`, `DangerComponent`, home dashboard.
- **Output** - `/user-profile`, `/user-favorites`, `/user-danger`, `/user-dashboard`.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/user/profile/*`, `favorites/*`, `danger/*`, `site/home/*`.
- **Dipendenze** - NXT-T015.
- **Criteri di accettazione** - Guard funziona; dati utente; update profilo; preferiti; cancellazione account con conferma.
- **Validazione consigliata** - Build + test manuale route protette.
- **Prompt AI-ready** - Migra pagine account protette in Next. Mantieni guard, layout autenticato, API user/channel, conferme e stati errore/loading. Verifica build.

### NXT-T017 - Migrare gestione canali

- **Priorita** - P1.
- **Milestone** - M5.
- **Tipo** - Frontend / Workflow cronista.
- **Sforzo** - Grande.
- **Rischio** - Alto.
- **Parallelizzabile** - No.
- **Descrizione** - Migrare `/user-channels` e `/user-channel/[channelId]`.
- **Input** - `ChannelsComponent`, `ChannelComponent`, sotto-componenti channel.
- **Output** - Pagine gestione canali Next.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/user/channels/*`, `user/channel/*`, `common/channel-*`, `common/team-edit/*`.
- **Dipendenze** - NXT-T016.
- **Criteri di accettazione** - Lista canali; gestione canale; team; match; editors/co-owner dove previsto; permessi backend rispettati.
- **Validazione consigliata** - Build + test manuale cronista.
- **Prompt AI-ready** - Migra gestione canali in Next. Copri lista canali, pagina canale, tabs, team, match, editor/co-owner se presenti e permessi. Verifica build.

### NXT-T018 - Migrare gestione partita cronista

- **Priorita** - P1.
- **Milestone** - M5.
- **Tipo** - Frontend / Workflow cronista.
- **Sforzo** - Grande.
- **Rischio** - Alto.
- **Parallelizzabile** - No.
- **Descrizione** - Migrare `/user-match/[matchId]` con editor partita, eventi, lineup, live e blog.
- **Input** - `MatchComponent`, sotto-componenti match user/common.
- **Output** - Pagina match editor Next.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/user/match/*`, `common/match-*`, `common/player-edit/*`.
- **Dipendenze** - NXT-T017.
- **Criteri di accettazione** - Creazione evento; lineup; stats; blog; audio/manuale se presente; mobile-first; feedback errori.
- **Validazione consigliata** - Build + test manuale end-to-end da mobile.
- **Prompt AI-ready** - Migra pagina match cronista in Next. Mantieni evento telecronaca, lineup, stats, blog, modali, feedback e comportamento mobile. Verifica build e indica scenari manuali.

### NXT-T019 - Migrare maintenance e not-found

- **Priorita** - P2.
- **Milestone** - M5.
- **Tipo** - Frontend / Routing.
- **Sforzo** - Piccolo.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo NXT-T004.
- **Descrizione** - Implementare maintenance page, alias `/adm-maintenance` e comportamento wildcard/404.
- **Input** - `AdminMaintenanceComponent`, `environment.maintenance`.
- **Output** - Route maintenance e not-found/redirect.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/common/admin-maintenance/*`, route Next.
- **Dipendenze** - NXT-T004, decisione NXT-T001.
- **Criteri di accettazione** - Maintenance attivabile da config; alias preservato; 404/redirect deciso; noindex.
- **Validazione consigliata** - Build + test route manuale.
- **Prompt AI-ready** - Implementa maintenance e not-found in Next secondo decisioni URL. Preserva `/admin-maintenance` e alias se richiesti. Verifica build.

### NXT-T020 - Validare PWA, FCM e TWA

- **Priorita** - P1.
- **Milestone** - M6.
- **Tipo** - Frontend / Release readiness.
- **Sforzo** - Medio.
- **Rischio** - Alto.
- **Parallelizzabile** - Si, dopo M3/M4.
- **Descrizione** - Portare manifest, service worker/caching e Firebase FCM dove richiesto.
- **Input** - Config Angular PWA/Firebase, TWA constraints.
- **Output** - Piano o implementazione PWA Next con test.
- **File/componenti probabili** - `src/RugbyRadioWeb/ngsw-config.json`, `manifest`, firebase config, Next PWA config.
- **Dipendenze** - NXT-T009, NXT-T015.
- **Criteri di accettazione** - Installabilita verificata; FCM compatibile o gap documentato; impatto TWA deciso.
- **Validazione consigliata** - Browser devtools + test device Android/TWA se disponibile.
- **Prompt AI-ready** - Analizza e porta configurazione PWA/FCM da Angular a Next. Documenta gap TWA e verifica installabilita. Non fare switch produzione.

### NXT-T021 - QA parita pagina-per-pagina

- **Priorita** - P0.
- **Milestone** - M6.
- **Tipo** - QA / Docs.
- **Sforzo** - Grande.
- **Rischio** - Alto.
- **Parallelizzabile** - Si, dopo pagine migrate.
- **Descrizione** - Creare checklist di parita Angular/Next basata sull'inventory e completarla per ogni route.
- **Input** - Inventory, pagine migrate, AF.
- **Output** - `projects/nextjs-tailwind-migration/tasks/nextjs-parity-checklist.md`.
- **File/componenti probabili** - Solo artifact + eventuali test e2e futuri.
- **Dipendenze** - NXT-T010-NXT-T019 secondo route.
- **Criteri di accettazione** - Ogni route ha esito desktop/mobile, auth, SEO, loading/empty/error, API e note regressioni.
- **Validazione consigliata** - Review manuale + eventuale Playwright.
- **Prompt AI-ready** - Crea checklist QA parita Angular/Next usando l'inventory. Per ogni route includi desktop, mobile, auth, API, SEO, loading/empty/error e azioni principali. Non modificare codice.

### NXT-T022 - Preparare switch controllato e rollback

- **Priorita** - P0.
- **Milestone** - M6.
- **Tipo** - Release / Ops.
- **Sforzo** - Medio.
- **Rischio** - Alto.
- **Parallelizzabile** - No.
- **Descrizione** - Definire piano rollout: ambiente parallelo, redirect/canonical, monitoraggio analytics/errori, rollback ad Angular.
- **Input** - QA checklist, hosting decision, SEO decision.
- **Output** - `projects/nextjs-tailwind-migration/tasks/nextjs-rollout-plan.md`.
- **File/componenti probabili** - Config hosting/deploy future.
- **Dipendenze** - NXT-T001, NXT-T002, NXT-T021.
- **Criteri di accettazione** - Step rollout e rollback chiari; owner; checklist pre/post; metriche monitoraggio; freeze Angular/Next definito.
- **Validazione consigliata** - Review product/tech/ops.
- **Prompt AI-ready** - Crea piano rollout e rollback per sostituire Angular con Next. Includi ambiente parallelo, redirect/canonical, monitoraggio, criteri go/no-go e rollback. Non modificare codice.

## Ordine consigliato

1. NXT-T001, NXT-T002, NXT-T003.
2. NXT-T004, NXT-T005, NXT-T006.
3. NXT-T007, NXT-T008, NXT-T009.
4. NXT-T010 come pagina pilota.
5. NXT-T011, NXT-T012, NXT-T014.
6. NXT-T015, NXT-T016.
7. NXT-T017, NXT-T018, NXT-T013.
8. NXT-T019, NXT-T020, NXT-T021, NXT-T022.

Nota: `GMatchPage` e `GMatchRadioPage` sono pubbliche ma ad alto rischio funzionale; conviene migrarle dopo avere stabilizzato DS, API client, auth callback, TTS e wrappers client-only.

## Verifica minima per ogni task codice

- `npm run build` da `src/RugbyRadioWebNext`.
- Lint/typecheck se configurati.
- Smoke test manuale della route o componente toccato.
- Per pagine pubbliche: controllo metadata, canonical, mobile e loading/error/empty.
- Per pagine protette: controllo redirect non autenticato e sessione valida.
- Per flussi audio/FCM/ads/analytics: controllo con SDK assente e configurato, dove possibile.

## Prossimo passo operativo

Eseguire NXT-T001 e NXT-T002 prima di scaffoldare: approvare la matrice route e decidere hosting/rendering. Subito dopo si puo creare `src/RugbyRadioWebNext` con setup minimo e design system globale, evitando di duplicare componenti locali pagina per pagina.

## Stato implementazione

Aggiornato: 2026-07-24T12:05:07+02:00.

| Task | Stato | Evidenza |
|---|---|---|
| NXT-T001 | Done | Decisioni URL prodotte in `projects/nextjs-tailwind-migration/decisions/nextjs-url-decisions.md`; route canonical moderne e redirect legacy configurati in `src/RugbyRadioWebNext/next.config.mjs`. Redirect rilevati: 30, inclusi asset statici HTML legacy e schede team legacy con slug preservato. |
| NXT-T002 | Done parziale | Decisione Cloudflare/SSR prodotta in `projects/nextjs-tailwind-migration/decisions/nextjs-hosting-rendering-decision.md`; `wrangler.toml` e script `cf:*` presenti. Deploy Cloudflare non validato. |
| NXT-T003 | Done parziale | Decisione auth localStorage fase 1 prodotta in `projects/nextjs-tailwind-migration/decisions/nextjs-auth-session-decision.md`; helper sessione in `src/RugbyRadioWebNext/lib/auth/session.ts`; guard client in `AuthenticatedShell`. |
| NXT-T004 | Done parziale | Scaffold `src/RugbyRadioWebNext` creato con Next config, TypeScript, Tailwind, route home e package scripts. `next.config.mjs` importabile e 30 redirect legacy rilevati. Build locale validata con `.\node_modules\.bin\next.cmd build`: compilazione, typecheck e generazione di 47 pagine completate. `package-lock.json` ora contiene le entry opzionali top-level `@next/swc-*` attese da Next, quindi la build non tenta piu patch online del lockfile. `npm run build` resta non utilizzabile per `npm-cli.js` globale mancante nell'utente Windows. |
| NXT-T005 | In progress | Token Tailwind e global CSS presenti; note DS in `nextjs-design-system-notes.md`. La route interna `/design-system` ora espone swatch dei token colore con valori, esempi `shadow-panel`/`shadow-control`, radius globale e superfici operative per review governance. Build locale passata senza warning SWC; smoke HTTP su `next start` via kernel Node conferma `/design-system` status 200 e presenza heading `Rugby Radio UI kit`. Review visuale browser resta pending per assenza del binario Chromium Playwright nella cache locale. |
| NXT-T006 | In progress | Componenti DS base presenti: shell, button, icon button, confirm dialog, toast viewport con `useToastQueue`, alert, empty, skeleton, tabs, search, pagination, share, language selector, select field, ads, form field, card match/canale. `Search` ora e form GET server-friendly; `Pagination` genera link con query string; `Tabs` supporta `href` opzionale per navigazione ad ancore/route mantenendo fallback button; `Share` supporta native share quando disponibile, copia link, WhatsApp e summary per contesto; `/design-system` mostra anche azioni danger, icon action, stati disabled, feedback non bloccante, controlli form (`Search`, `SelectField`, textarea), card dominio, pagination, share, empty e skeleton; smoke HTTP locale su `/design-system` passa; resta noindex e fuori sitemap come route di governance interna. |
| NXT-T007 | In progress | API client base, user auth calls, feedback, stats e servizi pubblici equivalenti presenti in `src/RugbyRadioWebNext/lib/api`; tipi minimi in `types/common.ts` e `types/domain.ts`. Enum/lista eventi Angular portata come `matchEventTypes`. Aggiunta copertura typed per mutazioni Angular rimaste scoperte: `PUT /channels/{channelId}/layout` (`CHL-05`) con `updateChannelLayout`/`ChannelLayoutUpdateDto`, `POST /matches` quick match (`MTC-17`) con `addQuickMatch`/`MatchQuickAddDto`, `DELETE /channels/{channelId}/teams/{teamId}/players/{playerId}` (`PYR-05`) allineata al ritorno `PlayerDto` Angular e `StatsService` dedicato in `lib/api/stats.ts` per `GET /stats/` (`STS-01`). Aggiunti alias/re-export di parita per service Angular: `channels.findChannels/getPublicChannel`, `matches.findMatches/findMatchesByTeam/getOnGoingMatches`, `teams.getTeam`, `user.sendFeedback`; il form feedback ora usa `UserService` Next invece del modulo pubblico generico. Audit statico API/DTO creato in `projects/nextjs-tailwind-migration/tasks/nextjs-api-dto-parity-audit.md`: service Angular `Channel`, `Match`, `Team`, `Player`, `Lineup`, `Blog`, `Stats`, `Voice` e `User` mappati ai moduli Next; aggiunti `ChannelPublicMinDto`, `MatchChannelDto`, `MatchScoreboardDto`, commenti match-level e distinzione corretta tra `channelPublicMinDto` e `channelMinDto`. `getChannelMatches()` e `getTrainingMatch()` ora restituiscono `MatchChannelDto`; consumatori account/studio aggiornati; SEO match accetta `publicId` o `idFull`. Restano da validare payload reali backend/Cloudflare e workflow autenticati deep. |
| NXT-T008 | Done parziale | Cataloghi Angular completi EN/IT/FR/ES/JA copiati in `src/RugbyRadioWebNext/messages`; helper `loadMessages` e fallback presenti. Aggiunto `lib/i18n/auth-copy.ts` per mappare `User.Login`, `User.Register` e `User.ResetPassword` dai cataloghi Angular verso i form Next con fallback typed. Login/register/reset e feedback non caricano piu `loadMessages("IT")` hardcoded: leggono `getRequestLanguage()` da cookie `user_language` server-side con fallback `IT` per preservare il copy corrente senza cookie. `LanguageSelector`, `setSession`, `ProfilePanel` e `getUserLanguage()` sincronizzano `localStorage` e cookie `user_language`, mantenendo compatibilita fase 1 localStorage e rendendo server-aware le route SSR. Documento evidenza creato in `projects/nextjs-tailwind-migration/tasks/nextjs-i18n-server-language-notes.md`. Il form registrazione espone una select lingua basata su `supportedLanguages`, usa `getUserLanguage()` come default e invia al backend la lingua normalizzata invece dell'hardcode `EN`. Resta da collegare il resto delle stringhe UI migrate ai cataloghi e da validare in browser reale cambio lingua/cookie. |
| NXT-T009 | In progress | Wrapper analytics client-safe, logging con rolling buffer sessionStorage, ultimo errore localStorage, platform detection TWA/mobile, AdsSlot, manifest PWA, assetlinks e `firebase-messaging-sw.js` presenti. Firebase client ora copre token FCM e listener foreground via `ForegroundNotificationListener` nella shell autenticata, con alert in-app e link match quando il payload contiene `matchId`. Runtime analytics globale aggiunto e documentato in `projects/nextjs-tailwind-migration/tasks/nextjs-analytics-runtime-notes.md`: `AnalyticsScripts` carica Google tag con `NEXT_PUBLIC_RRL_GA_MEASUREMENT_ID`/fallback `G-J02WL9LF3F`, inizializza `send_page_view: false`, `RouteRuntime` traccia page view su cambi route/query con `page_path`, `page_location` e `page_title`, e resetta scroll sulle navigazioni senza hash come Angular `AppComponent.trackPageViews()`. Robots disallow include account/studio/auth/maintenance e design-system; sitemap resta orientata alle route pubbliche indicizzabili e ai profili team editoriali. Build/smoke locale passati; dispatch GA reale, browser devtools/network, FCM reale e deploy restano pending. |
| NXT-T010 | In progress | Home collegata a `getOngoingMatches`, `findPublicMatches` e `findPublicChannels` con empty state reali quando non ci sono dati pubblici, senza card demo inventate. Metadata home espliciti con canonical `/` e Open Graph. Copy pubblico ripulito da riferimenti a scaffold/migrazione e orientato a partite, canali e creazione telecronache; CTA pubblica verso `/design-system` rimossa dopo noindex/sitemap cleanup. Parita sezioni Angular estesa e documentata in `projects/nextjs-tailwind-migration/tasks/nextjs-home-parity-notes.md`: migrate sezioni `home-logo`, `home-who`, dati partite/canali, `home-features`, `home-help`, `home-why`, `home-tutorial`, `home-faq` e `AdsSlot` home. La home ora legge copy da catalogo Angular `Site.Home` via `loadMessages(await getRequestLanguage())`, quindi rispetta cookie lingua server-aware. Restano pending review visuale desktop/mobile e validazione browser reale della variante autenticata tramite `/account`. |
| NXT-T011 | In progress | `/matches` e `/channels` collegate a search API pubbliche con pagination/fallback e metadata canonical. Ricerca GET e link pagina precedente/successiva cablati; liste pubbliche ora mostrano empty state reali invece di dati demo quando l'API non restituisce risultati. Parita liste pubbliche estesa e documentata in `projects/nextjs-tailwind-migration/tasks/nextjs-public-lists-parity-notes.md`: `/matches` aggiunge filtro stato `status` per tutti/live/programmate/intervallo/concluse, lo passa a `findPublicMatches(text, page, status)` come supportato da `MTC-11`, e la paginazione conserva `q` + `status`; `/matches` e `/channels` mostrano riepilogo risultati `start-end di totalItems`, equivalente al feedback paginazione Angular. Copy pubblico di liste e empty state ripulito da riferimenti a route legacy/scaffold. Restano pending review visuale desktop/mobile e verifica backend reale dei conteggi/filtro stato. |
| NXT-T012 | In progress | Route dettaglio pubbliche match/channel/team caricano dati base da API e generano metadata canonical. Match pubblico ora include feed eventi, blog correlato, link radio/studio e condivisione con native share/copia/WhatsApp; le tab pubbliche navigano alle sezioni eventi, formazioni, statistiche, radio e share invece di essere solo decorative. Channel pubblico ora mostra metriche, squadre, classifica quando presente, match paginati via `/channels/{id}/matches/search`, share contestuale e azione follow/unfollow ibrida con login callback, sessione localStorage fase 1, API `PUT /channels/{channelId}/subscription` (`CHL-06`) e `ToastViewport`. Aggiunti Open Graph e JSON-LD `SportsOrganization` con owner e team membri. Team pubblico mostra metriche, roster, match paginati via `/teams/{id}/matches/search` e share contestuale; aggiunti Open Graph e JSON-LD `SportsTeam` con logo, canale e roster atleti. Layout dettagli pubblici esteso e documentato in `projects/nextjs-tailwind-migration/tasks/nextjs-public-entity-layout-notes.md`: `/channels/[channelPublicId]` ha header visuale con colori canale, owner/avatar, card squadra con logo e summary risultati partite; `/teams/[teamId]` ha header con logo/nickname/canale, CTA `Apri canale`, roster con avatar o fallback numero e summary risultati partite. Route dinamiche pubbliche match/channel/team usano `notFound()` quando l'entita non e disponibile, evitando pagine indicizzabili con empty state generico. `/stats` espone le 8 card principali Angular, breakdown eventi filtrato/ordinato top 20 con icone evento, empty state e AdsSlot. Copy visibile di dettagli pubblici/stats/radio/news ripulito da riferimenti tecnici a migrazione, route legacy e service interni. Restano pending review visuale desktop/mobile e verifica backend reale dei payload asset/paginazione. |
| NXT-T013 | In progress | `/matches/[matchId]` integra feed eventi pubblico e post blog correlato; feed eventi pubblico ora e client-side per interazioni ibride: like partita con `PUT /matches/{matchId}/like` (`MTC-13`), reazioni rapide, conteggi reazioni, toggle commenti, lista commenti, add comment con `addMatchComment`, add reaction con `addMatchReaction` e login callback verso `/login` quando anonimo. Aggiunta sezione rating formazioni casa/trasferta con avatar slot, badge rate, evidenza `userLineupRates`, limite massimo 3 voti come Angular e API `POST /matches/{matchId}/players/{lineupPlayerId}/rate` (`MTC-12`). Aggiunto blocco statistiche pubblico con confronto possesso/punizioni/trasformazioni, riepilogo territorio `zone1..zone4` e timeline episodi chiave derivata dagli eventi. Aggiunto follow pubblico partita con login callback, richiesta/sync token notifiche via `enableNotificationsAndSyncToken`, chiamata `PUT /matches/{matchId}/follow` (`MTC-15`) e feedback `ToastViewport` su like, reazioni, commenti, voti e follow. Metadata match pubblico ora calcolano title/description con score/stato/data, Open Graph image e JSON-LD `SportsEvent` con `EventScheduled`/`EventInProgress`/`EventCompleted`, team, organizer, startDate, location virtuale e risultato full-time. `/radio/[matchId]` carica il match completo, mostra score/stato, coda eventi ordinata, play/pause/resume/stop, opzione includi eventi passati, riproduzione manuale evento e avanzamento automatico via VoiceService TTS; la route radio ora genera metadata canonical, Open Graph e JSON-LD `AudioObject` associato allo `SportsEvent` della partita. Route match/radio usano `notFound()` quando la partita pubblica non e disponibile. `RadioPlayer` ora include selector commentatore con avatar e persistenza `commentator_id`, polling live opzionale ogni 30s via `getPublicMatch`, refresh manuale feed, accodamento dei nuovi eventi e snapshot localStorage per stato/includePast/ultimo evento. UX commentator estesa Angular e validazione runtime restano da completare. |
| NXT-T014 | In progress | `/feedback` usa client form collegato a `submitFeedback` con token localStorage opzionale, rating selezionabile 1-5, validazione client, messaggio opzionale con limite/contatore 1000 caratteri, stato success con invio nuovo, stato errore, tracking `feedback_viewed`/`feedback_submitted` e `ToastViewport` DS per conferma, errore e warning non bloccanti. Aggiunto `lib/i18n/feedback-copy.ts` per mappare `Components.Feedback` dai cataloghi Angular verso il form Next; la route feedback carica copy da `getRequestLanguage()` server-aware e usa aria label/validation/help text da catalogo e metadata canonical `/feedback`. Accessibilita feedback estesa e documentata in `projects/nextjs-tailwind-migration/tasks/nextjs-feedback-accessibility-notes.md`: corretto `aria-labelledby` dello stato successo, form etichettato da heading reale, ripristinato skip link Angular verso `#feedback-rating`, mapping `Components.Feedback.ariaSkipToFeedback` in `FeedbackCopy`. Build/smoke locale passati; invio reale backend, review visuale/browser e screen reader restano pending. |
| NXT-T015 | In progress | Login/register/reset usano client form collegati ad API auth e sessione localStorage fase 1. Google Sign-In e endpoint `/auth/users/google` cablati tramite Google Identity Services senza nuova dependency npm. Registrazione ora usa lingua normalizzata da localStorage/select, sincronizza subito localStorage + cookie `user_language` con `setUserLanguage`, riallinea `setSession` con la lingua scelta se il token non la restituisce e rispetta `popLoginCallback("/account")` come login/reset. Reset password ora ha step richiesta OTP via `/auth/users/forgot`, step cambio password con OTP a 6 cifre, auto-focus progressivo, validazione password 6-20, sessione post-reset e tracking `reset_password_viewed`/`reset_password_completed`. I form auth usano `ToastViewport`/`useToastQueue` DS per errori login, registrazione, richiesta OTP e reset, mantenendo gli alert inline persistenti. Accessibilita/i18n auth estese e documentate in `projects/nextjs-tailwind-migration/tasks/nextjs-auth-accessibility-notes.md`: `FormField` supporta `id`, `aria-describedby` e `aria-invalid`; login/register/reset usano heading reali con `aria-labelledby`; gli errori inline sono collegati ai campi; Google Sign-In e messaggio codice reset usano copy typed invece di stringhe hardcoded. Le tre route auth espongono metadata `noindex` con canonical e caricano copy dai cataloghi Angular via `getAuthCopy(await loadMessages(await getRequestLanguage()))`. Build/smoke locale passati; runtime browser, credenziali reali, Google callback e screen reader completo restano da validare. |
| NXT-T016 | In progress | `/account` ora usa dashboard reale con profilo, contatori, canali studio, squadre e partita training via UserService/ChannelService/TeamService/MatchService. `/account/profile` carica profilo e lista avatar, aggiorna nickname/lingua/avatar e riallinea localStorage fase 1; la lingua profilo ora usa select vincolata a `supportedLanguages` con normalizzazione, sincronizza localStorage + cookie tramite `setUserLanguage`, e il timezone browser viene sincronizzato in modo idempotente via `PUT /user/timezone` quando differisce dal profilo. Include preferenze telecronaca fase 1 con `commentator_id`, `use_ai_emoji`, salvataggio `commentaryLanguage` su profilo e attivazione permessi notifiche tramite helper service worker. Parita account protetto estesa e documentata in `projects/nextjs-tailwind-migration/tasks/nextjs-account-protected-parity-notes.md`: `AuthenticatedShell` aggiunge navigazione a preferiti e logout esplicito, il profilo espone logout locale e form con `aria-labelledby`/`aria-describedby`, le select hanno associazioni label/id esplicite, e `/account/favorites` distingue loading, empty ed errore API invece di trattare un failure ChannelService come lista vuota. `/account/danger` usa cancellazione account a due step con `ConfirmDialog` DS, logout e redirect home. Le quattro route account espongono metadata `noindex` con canonical dedicata. Build/smoke locale passati; verifica runtime/visuale, token FCM completo e flussi con token reale restano da completare. |
| NXT-T017 | In progress | `/studio/channels` usa card con link studio e consente creazione canale. `/studio/channels/[channelId]` ora carica canale, squadre, giocatori per squadra, partite, editor/co-owner e catalogo loghi via API; consente update info canale, add/update team con selezione logo rapida, add/update/delete player scoped per squadra, picker avatar giocatore da asset Angular `/images/avatars/players/{0..23}.png` con percorso custom, create match con default casa/trasferta distinti e guardia minimo due squadre, add/remove editor e accesso alle partite studio. Le tab studio canale navigano alle sezioni `info`, `teams`, `matches`, `editors` e ora inizializzano `activeId="info"` coerentemente con la prima sezione. Salvataggi/creazioni/rimozioni principali usano `ToastViewport`/`useToastQueue`; eliminazione giocatore e rimozione editor passano da `ConfirmDialog` DS con busy state. Accessibilita studio canale estesa e documentata in `projects/nextjs-tailwind-migration/tasks/nextjs-studio-channel-accessibility-notes.md`: `SelectField` supporta `id`, `aria-describedby`, `aria-invalid` e `required`; form info/squadre/partite/editor hanno heading o label ARIA, `noValidate`, id stabili e collegamento degli errori; create match mostra toast warning quando casa/trasferta mancano o coincidono; picker avatar evita id duplicati. Le route `/studio/channels` e `/studio/channels/[channelId]` espongono metadata `noindex` con canonical dedicata, coerenti con robots disallow `/studio`. Eliminazione team non risulta esposta da `TeamsV1Controller`; validazione runtime con token cronista/backend e review mobile restano da completare. |
| NXT-T018 | In progress | `/studio/matches/[matchId]` ora mostra score/stato, consente update dati partita, update stato partita via `PUT /matches/{matchId}/status` e registrazione incrementale di statistiche live via `PUT /matches/{matchId}/stats`. Supporta add/delete evento via MatchService, usa select tipi evento da enum Angular con default valido e form evento esteso a giocatore, secondo giocatore, territorio, sottotipo, extra params, commento e AI emoji. Il feed editor mostra giocatori e territorio quando presenti, espone reazioni rapide, picker reazioni espandibile con preset rugby/social e input custom collegato a `addMatchReaction`, lista commenti evento, add comment, delete comment, audio TTS evento singolo via VoiceService e invio push manuale tramite `POST /matches/{matchId}/notification` (`MTC-16`); eliminazione evento, rimozione commento e rimozione giocatore dalla formazione passano ora da `ConfirmDialog` DS con busy state, mentre eventi/commenti/notifiche e operazioni lineup usano `ToastViewport`/`useToastQueue` per success, warning ed errori non bloccanti. La regia audio studio ora ha coda cronista con play ultimi 3 eventi, play intera cronologia, play singolo evento, pausa/riprendi/stop, avanzamento automatico `onEnded`, stato corrente, contatore coda e riuso/cache degli audio VoiceService per evento. Supporta lineup fase 1: add inline player su slot, assign player ID e remove lineup. La sezione formazioni espone rating post-partita per giocatore con badge `rate`, limite massimo 3 voti basato su `userLineupRates`, chiamata `POST /matches/{matchId}/players/{lineupPlayerId}/rate` (`MTC-12`) e toast di esito. Feedback/ancore studio match rifiniti e documentati in `projects/nextjs-tailwind-migration/tasks/nextjs-studio-match-feedback-notes.md`: `#lineup` punta ora alla sezione Formazioni e il feed eventi usa `#event-feed`; update partita/stato/statistiche/lineup hanno validazioni client e toast coerenti; rimossi messaggi incrociati che parlavano di giocatori durante update partita/statistiche; score, dati partita, nuovo evento, feed eventi, formazioni, statistiche e form slot hanno heading/ARIA/id/noValidate piu espliciti. Blog studio ora ha review del post generato via BlogService, refresh da job, bozza locale titolo/body, preview e contatori editoriali; le tab studio match navigano alle sezioni `events`, `lineup`, `stats`, `blog`. La route `/studio/matches/[matchId]` espone metadata `noindex` con canonical dedicata, coerente con robots disallow `/studio`. Il backend `BlogV1Controller` espone solo `GET /blog` e `GET /blog/matches/{matchId}`, quindi update/generation persistenti restano lato job HF/non esposti. Build/smoke locale passati; validazione runtime con backend reale, token cronista e review mobile restano da completare. |
| Statiche/blog | In progress | Statiche principali convertite in route Next: `/why`, `/tutorial`, `/news`, `/how-to`, `/architecture`, `/team`, `/terms`; sitemap aggiornata e redirect da `/assets/static/*.html` configurati. Le route statiche indicizzabili ora hanno metadata pagina-specifici con canonical e Open Graph locale, allineati a blog/team e all'eredita SEO del layout. Blog dinamico aggiunto con `/blog` e `/blog/[matchId]` via BlogService; il dettaglio blog ora genera metadata canonical, Open Graph, JSON-LD `Article` collegato a `SportsEvent`, share contestuale con native share/copia/WhatsApp e `notFound()` quando il post non e disponibile. Schede team individuali migrate come catalogo `teamMembers`, griglia `/team`, route `/team/[memberSlug]`, metadata/JSON-LD, gallery dove disponibile e redirect legacy `/team-:slug.html` + `/assets/static/team-:slug.html` verso le route canonical. Smoke statiche/team documentato in `projects/nextjs-tailwind-migration/tasks/nextjs-static-team-redirect-smoke-2026-07-24.md`: copre `/team/stefano`, `/team/vox`, 404 scheda inesistente, redirect statici Angular mancanti e redirect dinamici pubblici `/g-match`, `/g-radio`, `/g-channel`, `/g-team`. Copy pubblico di blog/team/news ripulito da note tecniche a migrazione. Build locale passata; verifica visuale/runtime resta pending. |
| NXT-T019 | Done | Maintenance page noindex resa routabile come `/maintenance`, con rewrite middleware da `/_maintenance` per preservare URL tecnico e redirect legacy `/admin-maintenance`/`/adm-maintenance`. Middleware `RRL_MAINTENANCE_MODE=true` validato: `/` e `/channels` redirigono a `/_maintenance`, asset/Next/well-known restano esclusi. Pagina `not-found` globale presente con copy utente e CTA home; smoke locale conferma URL inesistente status 404 e copy `Pagina non trovata`. Robots disallow include sia `/_maintenance` sia `/maintenance`. Build locale passata con 47 pagine. |
| NXT-T020 | In progress | `manifest.ts`, route statica `app/.well-known/assetlinks.json/route.ts`, `public/firebase-messaging-sw.js`, helper registrazione service worker/permesso notifiche e API `saveNotificationToken` presenti; notification click aggiornato a `/matches/:matchId`. Copiate 12 icone PWA Angular in `src/RugbyRadioWebNext/public/assets/icons`; manifest Next include `gcm_sender_id`, `launch_handler`, 12 icone, display standalone e colori PWA. Il client carica Firebase compat senza nuova dependency npm, richiede token FCM con VAPID key Angular, salva `notification_token` in localStorage, sincronizza `PUT /user/notification` quando loggato, fa refresh giornaliero dalla shell autenticata come Angular `refreshTokenNotification` e ascolta notifiche foreground mostrando alert/link match in-app. HTTP smoke PWA completato in `projects/nextjs-tailwind-migration/tasks/nextjs-pwa-http-smoke-2026-07-24.md` e reso ripetibile con `npm run smoke:http` / `node scripts/smoke-http.mjs`: manifest, icone 192/512/1024, assetlinks, service worker, robots e sitemap rispondono con contenuti attesi. Smoke SEO esteso in `projects/nextjs-tailwind-migration/tasks/nextjs-seo-sitemap-smoke-2026-07-24.md`: verifica `robots.txt` e conferma che account, studio, auth, maintenance e design-system non siano pubblicati in `sitemap.xml`. Installabilita, ricezione push reale, runtime browser, Android TWA e deploy Cloudflare restano non validati. |
| NXT-T021 | In progress | Checklist QA parita creata in `projects/nextjs-tailwind-migration/tasks/nextjs-parity-checklist.md`. Prima esecuzione HTTP smoke completata in `projects/nextjs-tailwind-migration/tasks/nextjs-parity-http-smoke-2026-07-24.md`: `next start` locale su porta 3146 ha validato 19 route canonical/tecniche con status e copy attesi e 11 redirect legacy con status/location attesi. Aggiunto smoke ripetibile `src/RugbyRadioWebNext/scripts/smoke-http.mjs` con entry `smoke:http`, validato il 2026-07-24T12:19:38+02:00 su porte 3170/3171: route canonical/404, redirect legacy, asset PWA/TWA e maintenance mode passano con exit code 0. Smoke esteso e documentato in `projects/nextjs-tailwind-migration/tasks/nextjs-parity-auth-studio-http-smoke-2026-07-24.md`, `projects/nextjs-tailwind-migration/tasks/nextjs-seo-sitemap-smoke-2026-07-24.md`, `projects/nextjs-tailwind-migration/tasks/nextjs-seo-metadata-smoke-2026-07-24.md` e `projects/nextjs-tailwind-migration/tasks/nextjs-static-team-redirect-smoke-2026-07-24.md`: copre route protette `/account*` e `/studio*` con guard shell `Verifica sessione` + `noindex`, canonical metadata per route pubbliche/noindex principali, schede team SSG rappresentative con 404 not found, redirect legacy autenticati/pubblici/statici, noindex di design-system/maintenance, `robots.txt` e sitemap senza account/studio/auth/maintenance/design-system. Validato con `node --check`, smoke su porte 3320/3321 e scan statica includendo lo script; build applicativa gia passata sullo stesso codice Next.js prima di questa modifica solo-script. Restano pending QA visuale desktop/mobile, auth con sessione localStorage valida/scaduta, interazioni client-side, backend reale, metadata deep dinamici, push reale e deploy Cloudflare. |
| NXT-T022 | In progress | Piano switch/rollback creato e riallineato in `projects/nextjs-tailwind-migration/tasks/nextjs-rollout-plan.md`: ambienti, checklist pre-switch, go/no-go, sequenza rollout, trigger rollback e monitoraggio ora riflettono lo stato corrente. Il piano non segnala piu build/install come blocco: usa `.\node_modules\.bin\next.cmd build` e `node scripts\smoke-http.mjs` come gate locali, cita l'evidenza smoke auth/studio su porte 3292/3293, include redirect legacy autenticati, guard shell account/studio con `noindex`, rollback immediato se dati account/studio sono visibili senza token, e blocchi residui espliciti per preview/deploy Cloudflare, QA browser/mobile, auth reale valida/scaduta, PWA installabilita, push FCM reale e Android TWA. |
| NXT-T011-NXT-T019 | Started | Route canonical create e progressivamente collegate a servizi/API, DS, metadata, stati empty/notFound e workflow principali. Restano da completare parita Angular fine, QA visuale/runtime e verifiche con backend reale. |

## Stato validazione corrente

La build locale Next passa usando il binario del progetto:

- Comando: `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`.
- Esito: compilazione riuscita, typecheck riuscito, generazione statica completata per 47 pagine.
- Warning residuo: nessun warning SWC/lockfile rilevato dopo l'allineamento di `package-lock.json`.
- `npm run build` resta non utilizzabile per `npm-cli.js` globale mancante in `C:\Users\stefano.bonfiglio\AppData\Roaming\npm`; usare `.\node_modules\.bin\next.cmd build` finche l'installazione npm utente non viene riparata.
- Dopo `npm install` risultano 3 vulnerabilita high da `npm audit`; non e stato eseguito `npm audit fix --force` per evitare upgrade breaking non richiesti.
- Smoke runtime locale: `node scripts\smoke-http.mjs` da `src/RugbyRadioWebNext` passa con exit code 0 su porte 3320/3321, coprendo route canonical/tecniche, canonical metadata per route pubbliche/noindex principali, schede team SSG rappresentative e 404 relativa, guard shell account/studio con noindex, redirect legacy pubblici/autenticati/statici, manifest, icone PWA, assetlinks, service worker, robots, sitemap con URL pubbliche attese ed esclusione di account/studio/auth/maintenance/design-system, e maintenance mode. Entry npm disponibile: `npm run smoke:http`; in questo ambiente resta preferibile il comando diretto `node` finche l'installazione npm utente non viene riparata.
- Review visuale browser: tentata con Playwright bundle, non completata per binario Chromium mancante in `C:\Users\stefano.bonfiglio\AppData\Local\ms-playwright`.

Validazioni statiche eseguite:

- JSON validi e cataloghi completi importati: `package.json`, `messages/en.json`, `messages/it.json`, `messages/fr.json`, `messages/es.json`, `messages/ja.json`.
- `next.config.mjs` importabile via Node; redirect rilevati: 30.
- Route `page.tsx` rilevate in `app`: 31.
- File sorgente nello scaffold Next rilevati, escluso `node_modules` e `.next`: 130.
- Nessun `TODO`, `console.log`, `any` o riferimento `React.` nei sorgenti `app`, `components`, `lib`, `types`.
