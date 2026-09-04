---
type: task-plan
created: 2026-05-17T18:08:01+02:00
source: task-planner
topic: "Miglioramento SEO Rugby Radio Live"
slug: miglioramento-seo-rrl
input: "projects/seo-improvements/analysis/arch-miglioramento-seo-rrl.md"
---

# Piano task: Miglioramento SEO Rugby Radio Live

## Sintesi

Piano operativo per trasformare il design architetturale SEO in lavoro eseguibile da AI agent e sviluppatori. Sequenza: prima decisioni e inventario URL, poi quick win statici/frontend, poi sitemap/job backend, poi blog statico, infine prerender/SSR, landing e monitoraggio.

Il piano evita di bloccare tutto su SSR: i task P0/P1 danno valore anche con Angular client-rendered, mentre spike e task successivi preparano rendering SEO-first per pagine dinamiche.

## Input usato

- `projects/seo-improvements/analysis/arch-miglioramento-seo-rrl.md`
- `projects/seo-improvements/analysis/functional-miglioramento-seo-rrl.md`
- `projects/seo-improvements/analysis/seo-audit-generale-rrl.md`
- File progetto rilevati:
  - `src/RugbyRadioWeb/src/index.html`
  - `src/RugbyRadioWeb/src/sitemap.xml`
  - `src/RugbyRadioWeb/firebase.json`
  - `src/RugbyRadioWeb/src/app/app.routes.ts`
  - `src/RugbyRadioWeb/src/app/services/*.ts`
  - `src/RugbyRadioWeb/src/app/global/*`
  - `src/RugbyRadioWeb/src/assets/static/*.html`
  - `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs`
  - `src/RugbyRadio/Lib/Repositories/*`

## Obiettivo operativo

- Rendere RRL piu indicizzabile e misurabile tramite URL canoniche, metadata coerenti, sitemap complete, pagine pubbliche SEO-ready, blog statico non duplicativo e monitoraggio mensile.

## Decisioni bloccanti

- **Dominio canonico** - Opzioni: `https://rugbyradiolive.com/` oppure `https://www.rugbyradiolive.com/`. Impatto: redirect, canonical, sitemap, social URL. Owner suggerito: product/tech lead.
- **Gestione redirect hosting** - Capire se redirect si fa in Firebase Hosting, CDN, server web o altro. Impatto: TASK-003, TASK-004. Owner: tech lead/devops.
- **Strategia sitemap** - File statici generati da job oppure endpoint runtime. Architettura consiglia file generati. Owner: tech lead.
- **Soglia indicizzabilita match** - Definire quali `g-match` entrare in sitemap: tutte, solo terminate, solo con eventi, solo con squadre valorizzate, solo con blog. Owner: product/SEO.
- **Fonte `lastmod`** - Scegliere campi affidabili per match/canali/squadre/blog. Owner: backend.
- **Prerender/SSR** - Decidere tecnologia dopo spike: Angular prerender, Angular SSR, generatore statico dedicato. Owner: frontend/tech lead.

## Assunzioni

- Il dominio canonico consigliato operativo e `https://rugbyradiolive.com/`, ma va confermato.
- Quick win metadata/canonical/statiche sono utili anche prima di SSR.
- Le API pubbliche esistenti sono sufficienti finche non emerge un costo eccessivo per prerender o sitemap.
- `CreateMatchBlogHtmlJob` resta owner del blog statico; nuovo job sitemap resta owner del sito principale.
- Task con accesso GSC/GA/AdSense sono manuali finche non sono disponibili credenziali/API.

## Milestone

### M0 - Fondazioni SEO

- Scopo: decisioni, inventario URL, regole canonical e piano redirect.
- Output: matrice URL, decisioni documentate, task infra sbloccati.
- Dipendenze: nessuna.

### M1 - Quick Win Frontend Statico

- Scopo: metadata/canonical/robots/sitemap statici e servizio SEO Angular.
- Output: pagine statiche e principali route pubbliche con metadata coerenti.
- Dipendenze: M0 almeno per dominio canonico.

### M2 - Sitemap Dinamiche e Backend Job

- Scopo: generare sitemap root/sezionali e inventory URL da dati pubblici.
- Output: job idempotente, sitemap statiche/match/canali/squadre, test XML.
- Dipendenze: soglia indicizzabilita, fonte `lastmod`.

### M3 - Blog Statico SEO

- Scopo: ridurre duplicazione blog, URL lowercase, canonical/hreflang, link reciproci, Article JSON-LD.
- Output: blog statico piu coerente e integrato con sitemap.
- Dipendenze: dominio canonico e policy lowercase.

### M4 - Rendering SEO-First e Landing

- Scopo: valutare/implementare prerender o SSR incrementale e creare landing editoriali.
- Output: pagine strategiche renderizzate con head e contenuto leggibili nel primo HTML.
- Dipendenze: M1/M2, spike SSR.

### M5 - Monitoraggio e QA SEO

- Scopo: rendere misurabile il ciclo SEO.
- Output: checklist QA, report mensile, baseline e confronto.
- Dipendenze: accesso dati o export manuale.

## Backlog prioritizzato

### TASK-001 - Decidere dominio canonico e policy URL

- **Priorita** - P0.
- **Milestone** - M0.
- **Tipo** - Decisione.
- **Sforzo** - Piccolo.
- **Rischio** - Alto.
- **Parallelizzabile** - No.
- **Descrizione** - Formalizzare dominio canonico, trattamento `/index.html`, policy lowercase blog e regole base per canonical.
- **Input** - `arch-miglioramento-seo-rrl.md`, dati GSC duplicazione home/blog.
- **Output** - Decisione scritta in `projects/seo-improvements/tasks/seo-url-decisions.md` o sezione aggiornata nel piano task.
- **File/componenti probabili** - Solo artifact/documentazione.
- **Dipendenze** - Nessuna.
- **Criteri di accettazione** - Dominio canonico esplicito; regole per `www`, non-`www`, `/index.html`, `/EN/` vs `/en/`; owner decisione indicato.
- **Verifica consigliata** - Review manuale product/tech.
- **Prompt AI-ready** - Usa `projects/seo-improvements/analysis/arch-miglioramento-seo-rrl.md` e crea un breve documento decisionale per dominio canonico e policy URL. Non modificare codice. Output: decisione proposta, alternative, impatti su redirect/canonical/sitemap/blog, punti da approvare manualmente.

### TASK-002 - Creare matrice URL pubbliche indicizzabili

- **Priorita** - P0.
- **Milestone** - M0.
- **Tipo** - Docs.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - No.
- **Descrizione** - Inventariare tipi URL pubblici, sorgente dati, canonical, sitemap target, indicizzabilita e `lastmod`.
- **Input** - Architettura SEO, `app.routes.ts`, `sitemap.xml`, statiche, blog job.
- **Output** - `projects/seo-improvements/tasks/seo-url-inventory.md`.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/app.routes.ts`, `src/RugbyRadioWeb/src/sitemap.xml`, `src/RugbyRadioWeb/src/assets/static/*.html`, `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs`.
- **Dipendenze** - TASK-001.
- **Criteri di accettazione** - Ogni tipo URL ha: pattern, canonical, owner, sorgente dati, sitemap, `lastmod`, indicizzabile si/no/condizionato.
- **Verifica consigliata** - Cross-check con route Angular e sitemap attuale.
- **Prompt AI-ready** - Leggi `arch-miglioramento-seo-rrl.md`, `src/RugbyRadioWeb/src/app/app.routes.ts`, `src/RugbyRadioWeb/src/sitemap.xml` e le statiche in `src/RugbyRadioWeb/src/assets/static`. Crea `projects/seo-improvements/tasks/seo-url-inventory.md` con tabella URL pattern, canonical, indicizzabile, sitemap target, lastmod source, owner e note. Non modificare codice.

### TASK-003 - Analizzare configurazione hosting e redirect

- **Priorita** - P0.
- **Milestone** - M0.
- **Tipo** - Spike.
- **Sforzo** - Piccolo.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo TASK-001.
- **Descrizione** - Capire dove implementare redirect 301 e robots/sitemap per sito principale.
- **Input** - `firebase.json`, eventuali config hosting/CDN disponibili.
- **Output** - Mini design infra con punto di intervento e modifiche proposte.
- **File/componenti probabili** - `src/RugbyRadioWeb/firebase.json`, eventuali file deployment.
- **Dipendenze** - TASK-001.
- **Criteri di accettazione** - Indica chiaramente se Firebase Hosting basta; lista regole redirect; rischi su blog subdomain.
- **Verifica consigliata** - Review config e, se implementato dopo, test HTTP manuale/curl.
- **Prompt AI-ready** - Analizza `src/RugbyRadioWeb/firebase.json` e file deployment disponibili per capire dove configurare redirect SEO (`www`, `/index.html`, sitemap, robots). Non applicare modifiche. Output: proposta tecnica con regole, limiti e file da modificare.

### TASK-004 - Implementare redirect/canonical base hosting

- **Priorita** - P1.
- **Milestone** - M1.
- **Tipo** - Infra.
- **Sforzo** - Medio.
- **Rischio** - Alto.
- **Parallelizzabile** - No.
- **Descrizione** - Applicare redirect/canonical base dove supportato da hosting; includere `/index.html` e dominio non canonico.
- **Input** - TASK-001, TASK-003.
- **Output** - Config hosting aggiornata o istruzioni operative se richiede console esterna.
- **File/componenti probabili** - `src/RugbyRadioWeb/firebase.json`, config hosting/CDN.
- **Dipendenze** - TASK-001, TASK-003.
- **Criteri di accettazione** - URL duplicate non restano servite come equivalenti; configurazione documentata; rollback chiaro.
- **Verifica consigliata** - `curl -I` su varianti URL in ambiente deploy/stage.
- **Prompt AI-ready** - Usa decisioni URL e spike hosting per implementare redirect SEO nel file di configurazione appropriato. Lavora solo su config hosting del sito principale. Non toccare logica app. Verifica sintassi config e documenta test HTTP da eseguire dopo deploy.

### TASK-005 - Aggiornare metadata base in `index.html`

- **Priorita** - P1.
- **Milestone** - M1.
- **Tipo** - Frontend.
- **Sforzo** - Piccolo.
- **Rischio** - Basso.
- **Parallelizzabile** - Si, dopo TASK-001.
- **Descrizione** - Migliorare title/description/canonical/Open Graph base della shell Angular.
- **Input** - Query GSC da audit, dominio canonico.
- **Output** - `index.html` con metadata home/base coerenti.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/index.html`.
- **Dipendenze** - TASK-001.
- **Criteri di accettazione** - Title e description non generici; canonical home; OG/Twitter base; nessuna rottura build.
- **Verifica consigliata** - `npm run -s build`.
- **Prompt AI-ready** - Aggiorna `src/RugbyRadioWeb/src/index.html` con metadata SEO base per Rugby Radio Live usando dominio canonico deciso. Includi title, description, canonical, Open Graph e Twitter card base. Non modificare componenti Angular. Verifica con build frontend.

### TASK-006 - Creare `SeoMetadataService`

- **Priorita** - P1.
- **Milestone** - M1.
- **Tipo** - Frontend.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo TASK-001.
- **Descrizione** - Centralizzare gestione head Angular: title, description, canonical, OG, Twitter, JSON-LD.
- **Input** - Architettura SEO, pattern servizi esistenti.
- **Output** - Nuovo servizio frontend idempotente.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/services/seo-metadata.service.ts`, `src/RugbyRadioWeb/src/app/services`.
- **Dipendenze** - TASK-001.
- **Criteri di accettazione** - API servizio chiara; aggiorna/rimuove tag senza duplicati; gestisce canonical link e script JSON-LD; test o build ok.
- **Verifica consigliata** - `npm run -s build`; eventuali unit test se presenti.
- **Prompt AI-ready** - Crea `SeoMetadataService` in `src/RugbyRadioWeb/src/app/services` seguendo stile dei servizi esistenti. Deve gestire title, meta description, canonical link, Open Graph/Twitter e JSON-LD in modo idempotente durante navigazione SPA. Non applicarlo ancora alle pagine. Verifica con build.

### TASK-007 - Applicare metadata SEO a home, liste e stats

- **Priorita** - P1.
- **Milestone** - M1.
- **Tipo** - Frontend.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - No.
- **Descrizione** - Usare `SeoMetadataService` sulle pagine pubbliche staticamente determinabili.
- **Input** - TASK-006, query GSC, dominio canonico.
- **Output** - Metadata coerenti su home, `g-matches`, `g-channels`, `g-stats`.
- **File/componenti probabili** - `home.component.ts`, `g-matches.component.ts`, `g-channels.component.ts`, `g-stats.component.ts`.
- **Dipendenze** - TASK-006.
- **Criteri di accettazione** - Ogni route imposta title/description/canonical specifici; nessun tag duplicato dopo navigazione; build ok.
- **Verifica consigliata** - `npm run -s build`; test manuale navigazione con DevTools head.
- **Prompt AI-ready** - Applica `SeoMetadataService` a home, `GMatchesPage`, `GChannelsPage` e `GStatsPage`. Usa title/description specifici e canonical assoluti. Non toccare pagine dinamiche match/canale/squadra. Verifica build e descrivi come controllare head tags.

### TASK-008 - Applicare metadata dinamici a `g-match`

- **Priorita** - P1.
- **Milestone** - M1.
- **Tipo** - Frontend.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo TASK-006.
- **Descrizione** - Generare title/description/canonical/JSON-LD per pagina partita usando dati match.
- **Input** - TASK-006, `matchDto`, `g-match.component.ts`.
- **Output** - `g-match` con metadata dinamici.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.ts`, `g-match.component.html`.
- **Dipendenze** - TASK-006.
- **Criteri di accettazione** - Metadata includono squadre, stato/data o punteggio quando disponibile; canonical usa `matchId`; fallback sicuro se dati mancanti; build ok.
- **Verifica consigliata** - `npm run -s build`; visita una partita e controlla head.
- **Prompt AI-ready** - In `GMatchComponent`, usa `SeoMetadataService` per impostare metadata dinamici dopo caricamento match. Usa squadre, data/stato/punteggio se disponibili, canonical `/g-match/{matchId}`, e JSON-LD solo con dati disponibili. Gestisci fallback. Non cambiare API. Verifica build.

### TASK-009 - Applicare metadata dinamici a `g-channel` e `g-team`

- **Priorita** - P1.
- **Milestone** - M1.
- **Tipo** - Frontend.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo TASK-006.
- **Descrizione** - Generare metadata per hub canale e squadra.
- **Input** - TASK-006, `channelPublicDto`, `teamPublicDto`.
- **Output** - `g-channel` e `g-team` con metadata dinamici.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/app/global/g-channel/g-channel.component.ts`, `src/RugbyRadioWeb/src/app/global/g-team/g-team.component.ts`.
- **Dipendenze** - TASK-006.
- **Criteri di accettazione** - Title/description usano nome canale/squadra e contesto; canonical corretto; fallback sicuro; build ok.
- **Verifica consigliata** - `npm run -s build`; controllo head su route campione.
- **Prompt AI-ready** - Applica `SeoMetadataService` a `GChannelComponent` e `GTeamComponent` dopo caricamento dati. Crea title/description/canonical specifici con fallback. Non cambiare API o layout. Verifica build.

### TASK-010 - Aggiornare metadata pagine statiche

- **Priorita** - P1.
- **Milestone** - M1.
- **Tipo** - Content.
- **Sforzo** - Medio.
- **Rischio** - Basso.
- **Parallelizzabile** - Si, dopo TASK-001.
- **Descrizione** - Dare title/description/canonical/OG unici a statiche.
- **Input** - Audit SEO, dominio canonico.
- **Output** - Statiche con metadata distinti.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/assets/static/why.html`, `tutorial.html`, `how-to.html`, `ai-talkers.html`, `news.html`, `terms.html`.
- **Dipendenze** - TASK-001.
- **Criteri di accettazione** - Nessuna description duplicata tra statiche principali; canonical assoluti; title coerenti; HTML valido.
- **Verifica consigliata** - `npm run -s build`; controllo manuale head.
- **Prompt AI-ready** - Aggiorna metadata head delle pagine statiche in `src/RugbyRadioWeb/src/assets/static`. Ogni pagina deve avere title, description, canonical e OG/Twitter coerenti col suo intento. Non modificare body o layout salvo necessario. Verifica build.

### TASK-011 - Creare/aggiornare `robots.txt`

- **Priorita** - P1.
- **Milestone** - M1.
- **Tipo** - Infra.
- **Sforzo** - Piccolo.
- **Rischio** - Basso.
- **Parallelizzabile** - Si, dopo TASK-001.
- **Descrizione** - Esporre robots con sitemap root e senza bloccare risorse necessarie.
- **Input** - Dominio canonico, strategia sitemap.
- **Output** - `robots.txt` servibile dal sito.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/robots.txt` o `public/robots.txt`, config Angular assets.
- **Dipendenze** - TASK-001.
- **Criteri di accettazione** - Robots include `Sitemap: {canonical}/sitemap.xml`; non blocca JS/CSS/assets; incluso in build output.
- **Verifica consigliata** - `npm run -s build`; controllare output dist.
- **Prompt AI-ready** - Aggiungi o aggiorna `robots.txt` nel progetto Angular in modo che venga pubblicato nella build. Deve dichiarare sitemap canonica e non bloccare risorse necessarie. Aggiorna config assets se serve. Verifica build e presenza file output.

### TASK-012 - Aggiornare sitemap statica iniziale

- **Priorita** - P1.
- **Milestone** - M1.
- **Tipo** - Infra.
- **Sforzo** - Piccolo.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo TASK-001/TASK-002.
- **Descrizione** - Correggere sitemap attuale con URL canoniche, `lastmod` realistici e reference blog se disponibile.
- **Input** - TASK-002.
- **Output** - `sitemap.xml` transitorio coerente prima del job dinamico.
- **File/componenti probabili** - `src/RugbyRadioWeb/src/sitemap.xml`.
- **Dipendenze** - TASK-001, TASK-002.
- **Criteri di accettazione** - Nessuna URL non canonica; include statiche principali; non include URL duplicate; XML valido.
- **Verifica consigliata** - XML parse/check manuale; build.
- **Prompt AI-ready** - Aggiorna `src/RugbyRadioWeb/src/sitemap.xml` come sitemap transitoria usando inventory URL e dominio canonico. Mantieni solo URL canoniche e statiche principali, aggiungi riferimento blog solo se supportato dal formato scelto. Non generare sitemap dinamiche in questo task. Verifica XML e build.

### TASK-013 - Definire modello `SeoPublicUrl` e regole inventory backend

- **Priorita** - P1.
- **Milestone** - M2.
- **Tipo** - Backend.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - No.
- **Descrizione** - Preparare modello e regole dati per URL pubbliche indicizzabili.
- **Input** - TASK-002, decisioni `lastmod`, soglia match.
- **Output** - Modello interno e documentazione regole.
- **File/componenti probabili** - `src/RugbyRadio/Lib` o `src/RugbyRadio/HF`, nuovo DTO/model SEO.
- **Dipendenze** - TASK-002, TASK-018.
- **Criteri di accettazione** - Modello include `loc`, `type`, `lastmod`, `isIndexable`, `canonicalLoc`, `source`; nessuna persistenza DB se non necessaria.
- **Verifica consigliata** - `dotnet build`.
- **Prompt AI-ready** - Implementa un modello interno `SeoPublicUrl` per generazione sitemap, seguendo architettura. Non creare tabella DB. Collocalo nel progetto più coerente con job/sitemap. Includi campi necessari e documenta regole in commenti essenziali. Verifica con build.

### TASK-014 - Implementare `SeoUrlInventoryService`

- **Priorita** - P1.
- **Milestone** - M2.
- **Tipo** - Backend.
- **Sforzo** - Grande.
- **Rischio** - Alto.
- **Parallelizzabile** - No.
- **Descrizione** - Servizio per produrre URL statiche, match, canali, squadre e reference blog.
- **Input** - TASK-013, repository esistenti.
- **Output** - Servizio query URL pubbliche indicizzabili.
- **File/componenti probabili** - `src/RugbyRadio/Lib/Repositories/MatchBox/*`, `ChannelBox/*`, `TeamBox/*`, `BlogBox/*`, nuovo service in `src/RugbyRadio/Lib/Services` o HF.
- **Dipendenze** - TASK-013.
- **Criteri di accettazione** - Restituisce liste per tipo; applica soglia indicizzabilita; non carica dati inutili; test/build ok.
- **Verifica consigliata** - `dotnet build`; test unit repository/service se presenti.
- **Prompt AI-ready** - Implementa `SeoUrlInventoryService` o equivalente per generare URL pubbliche indicizzabili da dati esistenti. Usa repository esistenti; evita nuove API pubbliche. Applica regole di indicizzabilità definite. Output: servizio testabile che restituisce `SeoPublicUrl` per statiche, match, canali, squadre e blog reference. Verifica con build.

### TASK-015 - Implementare writer XML sitemap

- **Priorita** - P1.
- **Milestone** - M2.
- **Tipo** - Backend.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo TASK-013.
- **Descrizione** - Creare generatore XML per sitemap index e URL set.
- **Input** - `SeoPublicUrl`, standard sitemap.
- **Output** - Writer XML con escaping e chunking base.
- **File/componenti probabili** - Nuova classe in `src/RugbyRadio/HF` o `src/RugbyRadio/Lib/Services`.
- **Dipendenze** - TASK-013.
- **Criteri di accettazione** - XML valido; escaping corretto; supporta sitemap index e urlset; testabile senza filesystem.
- **Verifica consigliata** - Unit test se progetto test pronto; `dotnet build`.
- **Prompt AI-ready** - Implementa componente writer XML sitemap per `SeoPublicUrl`. Deve generare sitemap index e urlset validi, con escaping URL e date ISO. Non accedere direttamente a DB o filesystem. Verifica con build e, se semplice, test unitario.

### TASK-016 - Implementare `GenerateSeoSitemapJob`

- **Priorita** - P1.
- **Milestone** - M2.
- **Tipo** - Backend.
- **Sforzo** - Grande.
- **Rischio** - Alto.
- **Parallelizzabile** - No.
- **Descrizione** - Job idempotente per generare sitemap root/sezionali.
- **Input** - TASK-014, TASK-015, output path configurato.
- **Output** - File `sitemap.xml`, `sitemap-static.xml`, `sitemap-matches.xml`, `sitemap-channels.xml`, `sitemap-teams.xml`.
- **File/componenti probabili** - `src/RugbyRadio/HF/Jobs`, settings in `src/RugbyRadio/Lib/Settings`, DI/config.
- **Dipendenze** - TASK-014, TASK-015.
- **Criteri di accettazione** - Job idempotente; scrittura atomica o fallback sicuro; log ok; output XML valido; build ok.
- **Verifica consigliata** - `dotnet build`; esecuzione job in ambiente dev se possibile.
- **Prompt AI-ready** - Crea `GenerateSeoSitemapJob` usando inventory service e sitemap writer. Deve generare sitemap root e sezionali su filesystem configurato, in modo idempotente e sicuro. Non modificare blog job in questo task. Verifica con build e descrivi come eseguire job manualmente.

### TASK-017 - Estendere blog statico lowercase/canonical/linking

- **Priorita** - P1.
- **Milestone** - M3.
- **Tipo** - Backend.
- **Sforzo** - Medio.
- **Rischio** - Alto.
- **Parallelizzabile** - Si, dopo TASK-001.
- **Descrizione** - Rendere blog statico coerente con policy URL e collegato a `g-match`.
- **Input** - TASK-001, architettura blog.
- **Output** - Blog HTML con canonical lowercase, hreflang coerente, link a pagina partita.
- **File/componenti probabili** - `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs`.
- **Dipendenze** - TASK-001.
- **Criteri di accettazione** - URL generate lowercase; canonical e hreflang coerenti; link verso `g-match/{matchId}`; build ok.
- **Verifica consigliata** - `dotnet build`; generazione HTML campione se possibile.
- **Prompt AI-ready** - Modifica `CreateMatchBlogHtmlJob` per garantire URL lingua lowercase, canonical/hreflang coerenti e link dal blog alla pagina `g-match`. Non cambiare generazione testo AI. Verifica build e indica output HTML atteso.

### TASK-018 - Definire soglia indicizzabilita match

- **Priorita** - P0.
- **Milestone** - M0.
- **Tipo** - Decisione.
- **Sforzo** - Piccolo.
- **Rischio** - Alto.
- **Parallelizzabile** - Si.
- **Descrizione** - Definire regola prodotto/SEO per includere match in sitemap.
- **Input** - Audit SEO, dati GSC "scansionata ma non indicizzata", modello match.
- **Output** - Regola documentata.
- **File/componenti probabili** - `projects/seo-improvements/tasks/seo-indexability-policy.md`.
- **Dipendenze** - Nessuna.
- **Criteri di accettazione** - Regola chiara con fallback: es. match pubblico con squadre, data, almeno N eventi o blog; esclusione draft/vuoti.
- **Verifica consigliata** - Review product/SEO.
- **Prompt AI-ready** - Crea proposta `seo-indexability-policy.md` per decidere quali `g-match` includere in sitemap. Usa audit e modelli wiki. Non modificare codice. Output: opzioni, raccomandazione, impatti e regola pronta per backend.

### TASK-019 - Spike prerender/SSR Angular

- **Priorita** - P2.
- **Milestone** - M4.
- **Tipo** - Spike.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo M1.
- **Descrizione** - Valutare fattibilita tecnica di prerender/SSR incrementale nel progetto Angular.
- **Input** - `angular.json`, `package.json`, route pubbliche, servizi dati.
- **Output** - Raccomandazione tecnica e piano di implementazione.
- **File/componenti probabili** - `src/RugbyRadioWeb/angular.json`, `package.json`, `app.routes.ts`.
- **Dipendenze** - TASK-006, TASK-007 opzionali.
- **Criteri di accettazione** - Confronta almeno: Angular prerender, Angular SSR, generatore statico custom; indica costo/rischi.
- **Verifica consigliata** - Nessuna modifica o branch spike; build se prova locale.
- **Prompt AI-ready** - Analizza progetto Angular per valutare prerender/SSR incrementale delle route pubbliche SEO. Non implementare migrazione. Output: opzioni, modifiche richieste, rischi, route candidate, raccomandazione.

### TASK-020 - Implementare prerender pilota per pagine statiche/landing

- **Priorita** - P2.
- **Milestone** - M4.
- **Tipo** - Frontend.
- **Sforzo** - Grande.
- **Rischio** - Alto.
- **Parallelizzabile** - No.
- **Descrizione** - Implementare pilota rendering SEO-first su subset basso rischio.
- **Input** - TASK-019.
- **Output** - Una o piu pagine pubbliche prerenderizzate o generate staticamente.
- **File/componenti probabili** - `angular.json`, `package.json`, route/landing nuove.
- **Dipendenze** - TASK-019.
- **Criteri di accettazione** - HTML generato contiene head e contenuto principale senza attendere runtime; build/deploy compatibile.
- **Verifica consigliata** - Build; aprire file prerender; controllo head HTML.
- **Prompt AI-ready** - Implementa pilota prerender/SSR secondo raccomandazione dello spike su un subset di pagine pubbliche. Mantieni scope piccolo. Verifica che HTML prodotto contenga metadata e contenuto principale. Riporta limiti e passi successivi.

### TASK-021 - Creare prima landing "Live rugby commentary today"

- **Priorita** - P2.
- **Milestone** - M4.
- **Tipo** - Content.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - Si, dopo TASK-006 o statiche.
- **Descrizione** - Creare landing editoriale basata su query GSC validata.
- **Input** - Audit SEO query, product value.
- **Output** - Pagina statica/route con contenuto, metadata, link a `g-matches`, CTA.
- **File/componenti probabili** - Nuova pagina in `src/RugbyRadioWeb/src/assets/static` o route Angular dedicata.
- **Dipendenze** - TASK-001, TASK-010 o TASK-019 se route.
- **Criteri di accettazione** - Title/description/canonical; contenuto utile non duplicato; link interni; sitemap aggiornata.
- **Verifica consigliata** - Build; controllo HTML; link crawl manuale.
- **Prompt AI-ready** - Crea una landing SEO per query "live rugby commentary today" coerente con RRL. Usa formato statico o route indicata dal piano. Deve includere metadata, contenuto utile, link a partite/canali e CTA. Aggiorna sitemap se necessario. Verifica build.

### TASK-022 - Creare checklist QA SEO

- **Priorita** - P1.
- **Milestone** - M5.
- **Tipo** - QA.
- **Sforzo** - Piccolo.
- **Rischio** - Basso.
- **Parallelizzabile** - Si.
- **Descrizione** - Definire controlli pre/post deploy SEO.
- **Input** - Architettura, task precedenti.
- **Output** - `projects/seo-improvements/tasks/seo-qa-checklist.md`.
- **File/componenti probabili** - Artifact docs.
- **Dipendenze** - Nessuna.
- **Criteri di accettazione** - Include controlli canonical, sitemap, robots, metadata, XML, GSC URL Inspection, build.
- **Verifica consigliata** - Review manuale.
- **Prompt AI-ready** - Crea checklist QA SEO per RRL basata su architettura e tasklist. Deve coprire pre-deploy, post-deploy, GSC URL Inspection, sitemap, robots, canonical, metadata e rollback. Non modificare codice.

### TASK-023 - Definire report SEO mensile

- **Priorita** - P2.
- **Milestone** - M5.
- **Tipo** - Analytics.
- **Sforzo** - Medio.
- **Rischio** - Medio.
- **Parallelizzabile** - Si.
- **Descrizione** - Strutturare report mensile da export GSC/GA/AdSense.
- **Input** - Analytic wiki esistenti e audit.
- **Output** - Template report e KPI.
- **File/componenti probabili** - `projects/seo-improvements/tasks/seo-monthly-report-template.md`.
- **Dipendenze** - Nessuna.
- **Criteri di accettazione** - KPI: clic, impressioni, CTR, coverage, pagine zero clic, organic landing, AdSense, CWV se disponibile.
- **Verifica consigliata** - Review con dati storici.
- **Prompt AI-ready** - Crea template `seo-monthly-report-template.md` per monitoraggio SEO RRL. Usa metriche da audit e wiki analytics. Include sezioni dati richiesti, formule semplici, interpretazione e task derivabili. Non integrare API.

### TASK-024 - Valutare endpoint SEO dedicati

- **Priorita** - P3.
- **Milestone** - M4.
- **Tipo** - Spike.
- **Sforzo** - Piccolo.
- **Rischio** - Basso.
- **Parallelizzabile** - Si, dopo TASK-019 o TASK-014.
- **Descrizione** - Decidere se servono `/v1/*/seo` o bastano endpoint pubblici attuali.
- **Input** - Performance/complessita endpoint pubblici, bisogni prerender/job.
- **Output** - Decisione tecnica.
- **File/componenti probabili** - `MatchesV1Controller`, `ChannelsV1Controller`, `TeamsV1Controller`.
- **Dipendenze** - TASK-014 o TASK-019.
- **Criteri di accettazione** - Decisione documentata con pro/contro e trigger futuro.
- **Verifica consigliata** - Review backend/frontend.
- **Prompt AI-ready** - Analizza se servono endpoint SEO dedicati per match/canale/squadra. Confronta uso degli endpoint pubblici esistenti con esigenze sitemap/prerender. Non implementare endpoint. Output: decisione e condizioni per crearli.

## Sequenza consigliata

1. TASK-001
2. TASK-018
3. TASK-002
4. TASK-003
5. TASK-005
6. TASK-006
7. TASK-010
8. TASK-011
9. TASK-012
10. TASK-007
11. TASK-008
12. TASK-009
13. TASK-013
14. TASK-015
15. TASK-014
16. TASK-016
17. TASK-017
18. TASK-022
19. TASK-023
20. TASK-019
21. TASK-021
22. TASK-020
23. TASK-024
24. TASK-004

Nota: TASK-004 e messo tardi solo per cautela deploy; tecnicamente puo andare appena TASK-003 e approvazioni sono pronte.

## Task parallelizzabili

- **Gruppo decisioni/docs** - TASK-001, TASK-018, TASK-022, TASK-023.
- **Gruppo frontend statico** - TASK-005, TASK-010, TASK-011 dopo dominio canonico.
- **Gruppo frontend dinamico** - TASK-008 e TASK-009 in parallelo dopo TASK-006.
- **Gruppo backend sitemap** - TASK-015 in parallelo con preparazione TASK-014 dopo TASK-013.
- **Gruppo spike futuri** - TASK-019 e TASK-024 dopo milestone base.

## Task manuali o non delegabili

- TASK-001 richiede decisione product/tech.
- TASK-003/TASK-004 possono richiedere accesso hosting/CDN.
- Verifica `curl -I` produzione/stage richiede ambiente deploy.
- GSC URL Inspection e submission sitemap richiedono accesso Search Console.
- TASK-023 richiede export aggiornati o accessi GA/GSC/AdSense.

## Definition of Done

- Dominio canonico deciso e applicato.
- URL inventory completa e usata da sitemap.
- Home/statiche/liste pubbliche hanno metadata e canonical coerenti.
- `g-match`, `g-channel`, `g-team` impostano metadata dinamici senza duplicati head.
- `robots.txt` e sitemap root sono serviti e validi.
- Sitemap sezionali includono solo URL canoniche e indicizzabili.
- Blog statico usa URL lowercase, canonical/hreflang coerenti e link a `g-match`.
- QA checklist completata su campione URL.
- Report SEO mensile baseline creato.
- Decisione prerender/SSR documentata con prossimo passo.

## Rischi e mitigazioni

- **Decisione canonical ritardata** - Blocca lavori infra e sitemap. Mitigare con task P0 e default proposto.
- **Sitemap troppo ampia** - Aumenta pagine non indicizzate. Mitigare con soglia TASK-018.
- **Metadata client-side non basta** - Mitigare con M4 prerender/SSR, senza bloccare quick win.
- **Redirect errati** - Rischio perdita traffico. Mitigare con test stage, checklist e rollback.
- **Blog e match competono** - Mitigare con intenti distinti e niente canonical incrociato improprio.
- **Job sitemap rompe deploy/output** - Mitigare con generazione atomica e validazione XML.

## Dati mancanti e domande aperte

- Dominio canonico finale.
- Accesso e tipo hosting/CDN.
- Dove pubblicare output sitemap generate.
- Campi affidabili per `lastmod`.
- Soglia match indicizzabile.
- Compatibilita Angular SSR/prerender.
- Strategia lingua per statiche multilingua.
- Accessi GSC/GA/AdSense o export aggiornati.

## Note per agenti AI

- Non modificare `llm-wiki/wiki` durante implementazione task, salvo richiesta esplicita.
- Ogni task deve leggere `arch-miglioramento-seo-rrl.md` e, se rilevante, `functional-miglioramento-seo-rrl.md`.
- Non creare endpoint `/seo` finche TASK-024 non li giustifica.
- Non canonicalizzare blog verso `g-match`; mantenere recap e live page distinti.
- Non indicizzare automaticamente tutte le partite senza policy TASK-018.
- Dopo ogni modifica frontend eseguire build Angular.
- Dopo ogni modifica backend/HF eseguire build .NET pertinente.
