---
type: task-board
created: 2026-05-17T18:43:32+02:00
source: task-planner
topic: "Miglioramento SEO Rugby Radio Live"
slug: miglioramento-seo-rrl
tasklist: "projects/seo-improvements/tasks/tasklist-miglioramento-seo-rrl.md"
---

# Taskboard: Miglioramento SEO Rugby Radio Live

## Regole tracking

- Stati ammessi: `Todo`, `In Progress`, `Blocked`, `Review`, `Done`, `Dropped`.
- Aggiornare questo file quando un task parte, si blocca, passa in review o finisce.
- Non modificare la tasklist per tracking ordinario: tasklist = piano, taskboard = stato.
- Ogni update deve compilare `Ultimo update`.
- Owner: `AI` = delegabile a modello, `Human` = decisione/accesso/approvazione, `Mixed` = AI prepara e human approva/deploya.

## Stato sintetico

- Totale task: 24
- Todo: 0
- In Progress: 0
- Blocked: 0
- Review: 0
- Done: 20
- Dropped: 4

## Board

| Task | Titolo | Milestone | Priorita | Owner | Stato | Started | Done | Blocco | Ultimo update |
|---|---|---|---|---|---|---|---|---|---|
| TASK-001 | Decidere dominio canonico e policy URL | M0 | P0 | Human | Done | | 2026-05-17T18:48:25+02:00 | | 2026-05-17T18:48:25+02:00 - Canonical deciso: `https://rugbyradiolive.com`; regola implementata su Cloudflare |
| TASK-002 | Creare matrice URL pubbliche indicizzabili | M0 | P0 | AI | Done | | 2026-05-17T20:56:57+02:00 | | 2026-05-17T20:56:57+02:00 - Inventory prodotto in `projects/seo-improvements/tasks/seo-url-inventory.md` |
| TASK-003 | Analizzare configurazione hosting e redirect | M0 | P0 | AI | Dropped | | 2026-05-17T21:21:18+02:00 | | 2026-05-17T21:21:18+02:00 - Skippato: redirect gia gestito con regola Cloudflare; non bloccante |
| TASK-004 | Implementare redirect/canonical base hosting | M1 | P1 | Mixed | Done | | 2026-05-19T16:30:27+02:00 | | 2026-05-19T16:30:27+02:00 - Segnato fatto su richiesta utente |
| TASK-005 | Aggiornare metadata base in `index.html` | M1 | P1 | AI | Done | 2026-05-17T21:25:20+02:00 | 2026-05-17T21:26:32+02:00 | | 2026-05-17T21:26:32+02:00 - Metadata base aggiornati in `src/RugbyRadioWeb/src/index.html`; build Angular ok con warning budget |
| TASK-006 | Creare `SeoMetadataService` | M1 | P1 | AI | Done | 2026-05-17T21:34:09+02:00 | 2026-05-17T21:35:02+02:00 | | 2026-05-17T21:35:02+02:00 - Creato `src/RugbyRadioWeb/src/app/services/seo-metadata.service.ts`; build Angular ok con warning budget |
| TASK-007 | Applicare metadata SEO a home, liste e stats | M1 | P1 | AI | Done | 2026-05-17T21:55:21+02:00 | 2026-05-17T21:56:35+02:00 | | 2026-05-17T21:56:35+02:00 - Applicato `SeoMetadataService` a home, `g-matches`, `g-channels` e `g-stats`; build ok con warning budget |
| TASK-008 | Applicare metadata dinamici a `g-match` | M1 | P1 | AI | Done | 2026-05-17T21:59:31+02:00 | 2026-05-17T22:00:42+02:00 | | 2026-05-17T22:00:42+02:00 - Metadata dinamici e JSON-LD `SportsEvent` applicati a `g-match`; build ok con warning budget |
| TASK-009 | Applicare metadata dinamici a `g-channel` e `g-team` | M1 | P1 | AI | Done | 2026-05-17T22:07:43+02:00 | 2026-05-17T22:08:55+02:00 | | 2026-05-17T22:08:55+02:00 - Metadata dinamici e JSON-LD applicati a `g-channel` e `g-team`; build ok con warning budget |
| TASK-010 | Aggiornare metadata pagine statiche | M1 | P1 | AI | Done | 2026-05-17T21:39:13+02:00 | 2026-05-17T21:42:04+02:00 | | 2026-05-17T21:42:04+02:00 - Metadata statiche aggiornate; build Angular ok con warning budget |
| TASK-011 | Creare/aggiornare `robots.txt` | M1 | P1 | AI | Done | 2026-05-17T21:44:19+02:00 | 2026-05-17T21:44:59+02:00 | | 2026-05-17T21:44:59+02:00 - Creato `src/RugbyRadioWeb/src/robots.txt`, incluso negli assets Angular; build ok con warning budget |
| TASK-012 | Aggiornare sitemap statica iniziale | M1 | P1 | AI | Done | 2026-05-17T21:50:32+02:00 | 2026-05-17T21:51:55+02:00 | | 2026-05-17T21:51:55+02:00 - Sitemap statica aggiornata con sole URL canoniche principali; XML e build ok |
| TASK-013 | Definire modello `SeoPublicUrl` e regole inventory backend | M2 | P1 | AI | Done | 2026-05-17T22:17:37+02:00 | 2026-05-17T22:20:05+02:00 | | 2026-05-17T22:20:05+02:00 - Creati modello e regole SEO in `src/RugbyRadio/HF/Dto`; build HF ok con warning esistenti |
| TASK-014 | Implementare `SeoUrlInventoryService` | M2 | P1 | AI | Done | 2026-05-17T22:27:47+02:00 | 2026-05-17T22:37:16+02:00 | | 2026-05-17T22:37:16+02:00 - Creato `SeoUrlInventoryService`, query repository SEO-specifiche e registrazione DI; build HF ok con warning esistenti |
| TASK-015 | Implementare writer XML sitemap | M2 | P1 | AI | Done | 2026-05-17T22:27:47+02:00 | 2026-05-17T22:29:22+02:00 | | 2026-05-17T22:29:22+02:00 - Creato writer XML sitemap testabile senza filesystem; build HF ok con warning esistenti |
| TASK-016 | Implementare `GenerateSeoSitemapJob` | M2 | P1 | AI | Done | 2026-05-18T20:11:46+02:00 | 2026-05-18T20:11:46+02:00 | | 2026-05-18T20:11:46+02:00 - Creato job sitemap SEO con output root/sezionali, config filesystem, scrittura atomica e build HF ok |
| TASK-017 | Estendere blog statico lowercase/canonical/linking | M3 | P1 | AI | Done | 2026-05-18T20:33:35+02:00 | 2026-05-18T20:33:35+02:00 | | 2026-05-18T20:33:35+02:00 - Blog statico allineato a URL lowercase, canonical/hreflang coerenti e link `g-match` canonici; build HF ok |
| TASK-018 | Definire soglia indicizzabilita match | M0 | P0 | Human | Done | | 2026-05-17T19:55:44+02:00 | | 2026-05-17T19:55:44+02:00 - Policy prodotta in `projects/seo-improvements/tasks/seo-indexability-policy.md` |
| TASK-019 | Spike prerender/SSR Angular | M4 | P2 | AI | Done | 2026-05-19T15:07:53+02:00 | 2026-05-19T15:07:53+02:00 | | 2026-05-19T15:07:53+02:00 - Spike prodotto in `projects/seo-improvements/tasks/seo-angular-prerender-ssr-spike.md`; build Angular ok con warning budget |
| TASK-020 | Implementare prerender pilota per pagine statiche/landing | M4 | P2 | AI | Dropped | | 2026-05-19T16:28:04+02:00 | Annullato su richiesta | 2026-05-19T16:28:04+02:00 - Annullato su richiesta utente |
| TASK-021 | Creare prima landing "Live rugby commentary today" | M4 | P2 | Mixed | Dropped | | 2026-05-19T16:28:04+02:00 | Annullato su richiesta | 2026-05-19T16:28:04+02:00 - Annullato su richiesta utente |
| TASK-022 | Creare checklist QA SEO | M5 | P1 | AI | Done | 2026-05-18T20:35:27+02:00 | 2026-05-18T20:35:27+02:00 | | 2026-05-18T20:35:27+02:00 - Checklist QA SEO creata con controlli pre/post deploy, GSC, sitemap, robots, canonical, metadata, XML e rollback |
| TASK-023 | Definire report SEO mensile | M5 | P2 | AI | Done | 2026-05-18T20:42:14+02:00 | 2026-05-18T20:42:14+02:00 | | 2026-05-18T20:42:14+02:00 - Template report mensile SEO creato con KPI GSC, GA, AdSense, coverage, zero-click, organic landing e CWV |
| TASK-024 | Valutare endpoint SEO dedicati | M4 | P3 | AI | Dropped | | 2026-05-19T16:28:54+02:00 | Annullato su richiesta | 2026-05-19T16:28:54+02:00 - Annullato su richiesta utente |

## Log avanzamenti

| Data | Task | Stato | Nota |
|---|---|---|---|
| 2026-05-17T18:43:32+02:00 | ALL | Created | Board iniziale creato da `tasklist-miglioramento-seo-rrl.md`. |
| 2026-05-17T18:48:25+02:00 | TASK-001 | Done | Canonical deciso: `https://rugbyradiolive.com`; regola implementata su Cloudflare. Task dipendenti dal dominio canonico sbloccati. |
| 2026-05-17T19:55:44+02:00 | TASK-018 | Done | Policy indicizzabilita match prodotta in `projects/seo-improvements/tasks/seo-indexability-policy.md`: FullTime, squadre presenti, almeno 10 eventi, blog statico associato, no test channel. |
| 2026-05-17T20:56:57+02:00 | TASK-002 | Done | URL inventory prodotta in `projects/seo-improvements/tasks/seo-url-inventory.md`. Sbloccati TASK-012 e TASK-013. |
| 2026-05-17T21:21:18+02:00 | TASK-003 | Dropped | Task skippato su richiesta: redirect gia gestito con Cloudflare. Non piu bloccante; TASK-004 sbloccato per eventuale verifica/documentazione residua. |
| 2026-05-19T16:30:27+02:00 | TASK-004 | Done | Segnato fatto su richiesta utente. |
| 2026-05-17T21:25:20+02:00 | TASK-005 | In Progress | Avviato aggiornamento metadata base in `src/RugbyRadioWeb/src/index.html`. |
| 2026-05-17T21:26:32+02:00 | TASK-005 | Done | Aggiornati title, description, canonical, Open Graph, Twitter card e script AdSense con protocollo esplicito. Verifica: `npm run -s build` ok, con warning budget esistenti. |
| 2026-05-17T21:34:09+02:00 | TASK-006 | In Progress | Avviata creazione `SeoMetadataService`. |
| 2026-05-17T21:35:02+02:00 | TASK-006 | Done | Creato `SeoMetadataService` idempotente per title, description, canonical, Open Graph, Twitter card e JSON-LD. Verifica: `npm run -s build` ok, con warning budget esistenti. |
| 2026-05-17T21:39:13+02:00 | TASK-010 | In Progress | Avviato aggiornamento metadata pagine statiche. |
| 2026-05-17T21:42:04+02:00 | TASK-010 | Done | Aggiornati title, description, canonical, Open Graph e Twitter card per pagine statiche. Verifica: `npm run -s build` ok, con warning budget esistenti. |
| 2026-05-17T21:44:19+02:00 | TASK-011 | In Progress | Avviata creazione `robots.txt` e inclusione nel build Angular. |
| 2026-05-17T21:44:59+02:00 | TASK-011 | Done | Creato `robots.txt` permissivo con sitemap root e blog sitemap; verificata presenza in `dist/rugby-radio-web/browser/robots.txt`. Build ok con warning budget esistenti. |
| 2026-05-17T21:50:32+02:00 | TASK-012 | In Progress | Avviato aggiornamento sitemap statica iniziale da inventory URL e dominio canonico. |
| 2026-05-17T21:51:55+02:00 | TASK-012 | Done | Aggiornato `src/RugbyRadioWeb/src/sitemap.xml`: rimosse URL legacy e blog dal root, inserite URL canoniche statiche principali con `lastmod` 2026-05-17. Verifica XML e build ok con warning budget esistenti. |
| 2026-05-17T21:55:21+02:00 | TASK-007 | In Progress | Avviata applicazione `SeoMetadataService` a home, liste pubbliche e stats. |
| 2026-05-17T21:56:35+02:00 | TASK-007 | Done | Applicati title, description, canonical, Open Graph e Twitter card tramite `SeoMetadataService` su home, liste match/canali e stats. Verifica: `npm run -s build` ok, con warning budget esistenti. |
| 2026-05-17T21:59:31+02:00 | TASK-008 | In Progress | Avviata applicazione metadata dinamici a `g-match`. |
| 2026-05-19T15:07:53+02:00 | TASK-019 | Done | Spike prerender/SSR Angular prodotto in `projects/seo-improvements/tasks/seo-angular-prerender-ssr-spike.md`. Raccomandazione: prerender Angular incrementale, non SSR runtime immediato. TASK-020 sbloccato. Build Angular ok con warning budget. |
| 2026-05-19T16:28:04+02:00 | TASK-020 | Dropped | Annullato su richiesta utente. |
| 2026-05-19T16:28:04+02:00 | TASK-021 | Dropped | Annullato su richiesta utente. |
| 2026-05-19T16:28:54+02:00 | TASK-024 | Dropped | Annullato su richiesta utente. |
| 2026-05-17T22:00:42+02:00 | TASK-008 | Done | Applicati title/description/canonical dinamici, immagine fallback e JSON-LD `SportsEvent` usando squadre, stato, data e score disponibili. Verifica: `npm run -s build` ok, con warning budget esistenti. |
| 2026-05-17T22:07:43+02:00 | TASK-009 | In Progress | Avviata applicazione metadata dinamici a `g-channel` e `g-team`. |
| 2026-05-17T22:08:55+02:00 | TASK-009 | Done | Applicati title/description/canonical dinamici, immagine fallback e JSON-LD `SportsOrganization`/`SportsTeam` usando nome, contesto, conteggi, team e giocatori disponibili. Verifica: `npm run -s build` ok, con warning budget esistenti. |
| 2026-05-17T22:17:37+02:00 | TASK-013 | In Progress | Avviata definizione modello interno `SeoPublicUrl` per sitemap backend. |
| 2026-05-17T22:20:05+02:00 | TASK-013 | Done | Creati `SeoPublicUrl` e `SeoPublicUrlRules` in `src/RugbyRadio/HF/Dto`, senza persistenza DB. Verifica: `dotnet build src/RugbyRadio/HF/HF.csproj -v minimal` ok con warning esistenti. Sbloccati TASK-014 e TASK-015. |
| 2026-05-17T22:27:47+02:00 | TASK-015 | In Progress | Avviata implementazione writer XML sitemap testabile senza filesystem. |
| 2026-05-17T22:29:22+02:00 | TASK-015 | Done | Creato `SitemapXmlWriter` con generazione `urlset`, `sitemapindex`, escaping via LINQ to XML, `lastmod` ISO, priority bounded e chunking base 50k URL. Verifica: `dotnet build src/RugbyRadio/HF/HF.csproj -v minimal` ok con warning esistenti. |
| 2026-05-17T22:27:47+02:00 | TASK-014 | In Progress | Avviata implementazione `SeoUrlInventoryService` e query repository per URL pubbliche indicizzabili. |
| 2026-05-17T22:37:16+02:00 | TASK-014 | Done | Creato servizio inventory SEO per statiche, match, canali, squadre e blog reference; aggiunte query repository mirate; registrato `HF.Services` nel DI. Verifica: `dotnet build src/RugbyRadio/HF/HF.csproj -v minimal` ok con warning esistenti. Sbloccati TASK-016 e TASK-024. |
| 2026-05-18T20:11:46+02:00 | TASK-016 | In Progress | Avviata implementazione `GenerateSeoSitemapJob` usando inventory SEO e writer XML sitemap. |
| 2026-05-18T20:11:46+02:00 | TASK-016 | Done | Creato job Hangfire per generare `sitemap.xml`, `sitemap-static.xml`, `sitemap-matches.xml`, `sitemap-channels.xml`, `sitemap-teams.xml` su `SeoSitemap:OutputPath`; aggiunta scrittura atomica con validazione XML, config DI e log. Verifica: `dotnet build src/RugbyRadio/HF/HF.csproj -v minimal` ok con warning esistenti. |
| 2026-05-18T20:33:35+02:00 | TASK-017 | In Progress | Avviata normalizzazione SEO del blog statico in `CreateMatchBlogHtmlJob`. |
| 2026-05-18T20:33:35+02:00 | TASK-017 | Done | Aggiornato `CreateMatchBlogHtmlJob` per generare post, canonical, hreflang, card e sitemap con `matchId` lowercase; link alla partita su `https://rugbyradiolive.com/g-match/{matchId}`; rimozione file legacy con case precedente; template footer allineato al dominio canonico. Verifica: `dotnet build src/RugbyRadio/HF/HF.csproj -v minimal` ok con warning esistenti. |
| 2026-05-18T20:35:27+02:00 | TASK-022 | In Progress | Avviata creazione checklist QA SEO per deploy e monitoraggio post-release. |
| 2026-05-18T20:35:27+02:00 | TASK-022 | Done | Creato `projects/seo-improvements/tasks/seo-qa-checklist.md` con controlli build, canonical, metadata, sitemap, robots, XML, HTTP live, GSC URL Inspection e rollback. Verifica: review manuale del documento. |
| 2026-05-18T20:42:14+02:00 | TASK-023 | In Progress | Avviata definizione template report mensile SEO da export GSC, GA, AdSense e dati piattaforma. |
| 2026-05-18T20:42:14+02:00 | TASK-023 | Done | Creato `projects/seo-improvements/tasks/seo-monthly-report-template.md` con fonti richieste, baseline, KPI, formule, interpretazione e backlog derivabile. Verifica: review con metriche storiche wiki 2026-01/2026-05. |
