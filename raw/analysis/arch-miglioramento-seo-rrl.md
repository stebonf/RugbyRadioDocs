---
type: architecture-design
created: 2026-05-16T23:48:43+02:00
source: functional-analysis
topic: "Miglioramento SEO Rugby Radio Live"
slug: miglioramento-seo-rrl
functional_input: "llm-wiki/artifacts/analysis/functional-miglioramento-seo-rrl.md"
---

# Design tecnico: Miglioramento SEO Rugby Radio Live

## Sintesi

Il design tecnico propone un percorso incrementale per rendere RRL piu indicizzabile senza stravolgere subito l'architettura. La soluzione separa quattro responsabilita:

- canonical e redirect a livello hosting/app;
- metadata e contenuto SEO per pagine pubbliche Angular e statiche;
- generazione sitemap/robots e inventory URL pubbliche;
- monitoraggio SEO ricorrente basato su GSC, GA, AdSense e dati piattaforma.

La scelta architetturale consigliata e procedere in tre fasi: quick win statici e canonical, generazione sitemap dinamica, poi prerender/SSR per `g-match`, `g-channel`, `g-team` e landing editoriali.

## Analisi funzionale di riferimento

- Input: `llm-wiki/artifacts/analysis/functional-miglioramento-seo-rrl.md`.
- Requisiti trasformati:
  - governance URL canoniche;
  - metadata specifici per pagine pubbliche;
  - sitemap pubblica completa;
  - pagine partita/canale/squadra SEO-ready;
  - blog recap distinto da pagina live;
  - landing editoriali;
  - linking interno;
  - monitoraggio SEO operativo.

## Scope tecnico

### Incluso

- Configurazione canonical domain e redirect funzionali.
- Metadata service frontend condiviso per pagine Angular.
- Aggiornamento pagine statiche con metadata unici.
- Generazione sitemap index e sitemap sezionali.
- Integrazione sitemap blog generata da [[CreateMatchBlogHtmlJob (api)]].
- Nuovo job/backend service per sitemap pubbliche non-blog.
- Valutazione prerender/SSR per pagine pubbliche.
- Modelli tecnici per inventario URL indicizzabili.
- Monitoraggio SEO tramite artifact/report mensile o job dedicato.

### Escluso

- Migrazione completa immediata a SSR universale.
- Refactor UX delle pagine pubbliche.
- Integrazione diretta live con API Google Search Console/GA/AdSense, salvo futura automazione.
- Content management editoriale completo.
- Nuovo database SEO dedicato, salvo necessita futura.

## Sistemi coinvolti

- **RugbyRadioWeb Angular** - Renderizza home, pagine pubbliche, statiche e metadata lato client; candidato a prerender/SSR per URL SEO.
- **RugbyRadio API** - Espone dati pubblici di match, canali, squadre, blog e statistiche gia usati dal frontend.
- **Hangfire / RugbyRadio HF** - Gia genera blog statico; candidato per generazione sitemap pubbliche e report SEO batch.
- **Storage/hosting statico** - Serve sitemap, blog statico, asset e pagine statiche; deve applicare redirect/canonical dove configurabile.
- **Firebase Analytics / GA** - Traccia page view ed eventi tramite [[AnalyticsService (web)]].
- **Google Search Console** - Fonte esterna per performance, copertura e problemi indicizzazione.
- **AdSense** - Fonte esterna per monetizzazione e possibile impatto UX.

## Componenti da modificare

### Backend

- **Nuovo `SeoUrlInventoryService (api)`** - Servizio applicativo per costruire elenco URL pubbliche indicizzabili da match, canali, squadre, statiche e blog sitemap reference. Nome proposto; non presente oggi in wiki.
- **Nuovo `GenerateSeoSitemapJob (api)`** - Job schedulato per generare sitemap root e sitemap sezionali non-blog. Separato da [[CreateMatchBlogHtmlJob (api)]] per non mischiare blog statico e sito principale.
- **[[CreateMatchBlogHtmlJob (api)]]** - Estendere output per garantire URL lowercase, canonical coerenti, sitemap index blog referenziabile e link verso `g-match`.
- **[[BlogV1Controller (api)]]** - Nessun obbligo immediato; resta fonte runtime per blog in pagina match.
- **[[MatchesV1Controller (api)]]** - Usare endpoint pubblici esistenti per dati `g-match`; possibile aggiunta di proiezione SEO solo se gli endpoint attuali risultano troppo pesanti.
- **[[ChannelsV1Controller (api)]]** - Usare endpoint pubblici esistenti per dati canale; possibile proiezione SEO se necessario.
- **[[TeamsV1Controller (api)]]** - Usare endpoint pubblico squadra per pagina `g-team`.

### Frontend

- **Nuovo `SeoMetadataService (web)`** - Servizio frontend per impostare title, description, canonical, Open Graph, Twitter card e, quando utile, JSON-LD.
- **[[HomePage (web)]]** - Metadata home orientati a query "free live rugby commentary" e link verso hub pubblici.
- **[[GMatchesPage (web)]]** - Metadata e contenuto introduttivo per query live commentary; link a partite indicizzabili.
- **[[GMatchPage (web)]]** - Metadata dinamici basati su [[matchDto (web)]], canonical, JSON-LD, link a canale/squadre/blog.
- **[[GChannelsPage (web)]]** - Metadata lista canali e linking verso canali principali.
- **[[GChannelPage (web)]]** - Metadata dinamici basati su [[channelPublicDto (web)]], link a partite e squadre.
- **[[GTeamPage (web)]]** - Metadata dinamici basati su [[teamPublicDto (web)]], link a partite e canale.
- **[[GStatsPage (web)]]** - Metadata proof-of-activity usando metriche pubbliche aggregate.
- **Pagine statiche** - `why`, `tutorial`, `how-to`, `ai-talkers`, `news`, `terms`: title/description/canonical unici e coerenti.
- **Landing editoriali** - Nuove route/statiche o pagine prerender dedicate alle query validate.

### Data

- **[[Match (api)]] / [[matchDto (web)]]** - Lettura per comporre URL, title, description, `lastmod`, contenuto minimo.
- **[[Channel (api)]] / [[channelPublicDto (web)]]** - Lettura per URL canale, metadata, link verso match/squadre.
- **[[Team (api)]] / [[teamPublicDto (web)]]** - Lettura per URL squadra, metadata, link verso canale/match.
- **[[Blog (api)]] / [[blogDto (web)]]** - Lettura/scrittura gia esistente per blog e staticizzazione.
- **Nuovo modello `SeoPublicUrl`** - Modello interno, non necessariamente entity DB, con `loc`, `type`, `lastmod`, `priorityCandidate`, `isIndexable`, `canonicalLoc`, `source`.
- **Nuovo modello `SeoMetadata`** - Modello interno/frontend con `title`, `description`, `canonical`, `ogImage`, `structuredData`, `lang`, `alternateLinks`.

### Infra

- **Redirect dominio** - Regole 301 per `www`/non-`www`, `/index.html`, blog uppercase/lowercase.
- **`robots.txt`** - Dichiarazione sitemap root e blog sitemap index.
- **Sitemap files** - `sitemap.xml` come sitemap index, piu sitemap sezionali.
- **Prerender/SSR hosting** - Da scegliere: Angular prerender build, Angular SSR, oppure generazione statica dedicata per pagine pubbliche ad alto valore.
- **Cache** - Sitemap e SEO pages devono essere cacheabili; invalidazione legata a job o deploy.

## API da creare o modificare

### GET /sitemap.xml

- **Tipo** - Nuova o sostituzione file statico attuale.
- **Responsabilita** - Esporre sitemap index root.
- **Input** - Nessuno.
- **Output** - XML sitemap index con link a sitemap statiche, match, canali, squadre, blog.
- **Autorizzazione** - Pubblico.
- **Note tecniche** - Preferibile come file generato statico per evitare carico runtime. Se servito da API, cache HTTP lunga e rigenerazione batch.

### GET /sitemap-static.xml

- **Tipo** - Nuova.
- **Responsabilita** - URL statiche canoniche: home, statiche, landing editoriali, liste pubbliche.
- **Input** - Nessuno.
- **Output** - XML sitemap URL set.
- **Autorizzazione** - Pubblico.
- **Note tecniche** - `lastmod` aggiornato solo su modifica contenuto/deploy.

### GET /sitemap-matches.xml

- **Tipo** - Nuova.
- **Responsabilita** - URL `g-match` indicizzabili.
- **Input** - Nessuno.
- **Output** - XML con URL partita canoniche.
- **Autorizzazione** - Pubblico.
- **Note tecniche** - Se URL > limite sitemap, generare chunk `sitemap-matches-1.xml`, ecc. Includere solo match che superano soglia qualita definita.

### GET /sitemap-channels.xml

- **Tipo** - Nuova.
- **Responsabilita** - URL `g-channel` indicizzabili.
- **Input** - Nessuno.
- **Output** - XML con URL canali pubblici.
- **Autorizzazione** - Pubblico.
- **Note tecniche** - `lastmod` da aggiornamento canale o ultima partita collegata, se dato affidabile.

### GET /sitemap-teams.xml

- **Tipo** - Nuova.
- **Responsabilita** - URL `g-team` indicizzabili.
- **Input** - Nessuno.
- **Output** - XML con URL squadre pubbliche.
- **Autorizzazione** - Pubblico.
- **Note tecniche** - Includere solo squadre con contenuto sufficiente: nome, canale e dati minimi.

### GET /robots.txt

- **Tipo** - Nuova o modifica file statico.
- **Responsabilita** - Dichiarare sitemap ufficiali e regole base crawler.
- **Input** - Nessuno.
- **Output** - Plain text.
- **Autorizzazione** - Pubblico.
- **Note tecniche** - Non bloccare risorse JS/CSS necessarie al rendering.

### GET /v1/seo/public-urls

- **Tipo** - Opzionale, nuova.
- **Responsabilita** - Esporre inventario URL a tool interni, job o report.
- **Input** - Query opzionali `type`, `page`, `pageSize`.
- **Output** - Lista `SeoPublicUrl`.
- **Autorizzazione** - Da decidere; consigliato protetto/admin se contiene diagnostica.
- **Note tecniche** - Non necessario se sitemap e report vengono generati direttamente da job/repository.

### GET /v1/matches/{matchId}/seo

- **Tipo** - Opzionale, nuova.
- **Responsabilita** - Proiezione leggera SEO per prerender o generatore statico.
- **Input** - `matchId`.
- **Output** - `SeoMetadata` + dati minimi match.
- **Autorizzazione** - Pubblico solo se dati gia pubblici.
- **Note tecniche** - Creare solo se [[MatchesV1Controller (api)]] `GET /v1/matches/{matchId}` e troppo pesante per prerender batch.

### GET /v1/channels/{publicId}/seo

- **Tipo** - Opzionale, nuova.
- **Responsabilita** - Proiezione leggera SEO canale.
- **Input** - `publicId`.
- **Output** - `SeoMetadata` + dati minimi canale.
- **Autorizzazione** - Pubblico solo se dati gia pubblici.
- **Note tecniche** - Stessa logica: creare solo se endpoint pubblico corrente non basta.

### GET /v1/teams/{teamId}/seo

- **Tipo** - Opzionale, nuova.
- **Responsabilita** - Proiezione leggera SEO squadra.
- **Input** - `teamId`.
- **Output** - `SeoMetadata` + dati minimi squadra.
- **Autorizzazione** - Pubblico solo se dati gia pubblici.
- **Note tecniche** - Da evitare se [[TeamsV1Controller (api)]] pubblico e sufficiente.

## Entity BE, model FE e dati coinvolti

- **[[Match (api)]]** - Lettura per sitemap match, metadata match, blog recap e `lastmod`.
- **[[MatchEvent (api)]]** - Lettura indiretta per contenuto minimo, timeline e qualita pagina match.
- **[[Channel (api)]]** - Lettura per sitemap canali e metadata canale.
- **[[Team (api)]]** - Lettura per sitemap squadre e metadata squadra.
- **[[Blog (api)]]** - Lettura/scrittura per staticizzazione, canonical, hreflang, sitemap blog.
- **[[matchDto (web)]]** - Fonte frontend per title, description, structured data e link interni pagina match.
- **[[channelPublicDto (web)]]** - Fonte frontend per metadata e linking pagina canale.
- **[[teamPublicDto (web)]]** - Fonte frontend per metadata e linking pagina squadra.
- **[[blogDto (web)]]** - Fonte frontend per snippet recap su match e link al blog.
- **`SeoPublicUrl`** - Modello interno per generazione sitemap e report; non richiede persistenza se ricostruibile.
- **`SeoMetadata`** - Modello condivisibile come helper tra frontend/prerender e job.

## Backend job coinvolti

- **[[CreateMatchBlogJob (api)]]** - Gia genera blog multilingua. Nessuna modifica funzionale obbligatoria, ma servono controlli qualita contenuto e failure visibility.
- **[[CreateMatchBlogHtmlJob (api)]]** - Da estendere per canonical lowercase, sitemap blog coerenti, link verso `g-match`, JSON-LD article se implementato.
- **Nuovo `GenerateSeoSitemapJob (api)`** - Trigger schedulato o post-deploy. Genera sitemap root e sezionali; deve essere idempotente e sovrascrivere output in modo atomico.
- **Nuovo `SeoMonthlyReportJob (api)`** - Opzionale. Se gli export GSC/GA/AdSense restano manuali, puo solo aggregare CSV importati in `llm-wiki/raw`. Se si integra API Google, servono credenziali e policy non documentate.

## Frontend pages/components coinvolti

- **[[HomePage (web)]]** - Aggiornare metadata, link interni e CTA verso partite/canali/landing.
- **[[GMatchesPage (web)]]** - Hub query live. Stati: loading, results, empty. Deve avere contenuto introduttivo indicizzabile.
- **[[GMatchPage (web)]]** - Asset principale. Stati SEO distinti: partita futura, in corso, terminata, senza blog, con blog.
- **[[GChannelsPage (web)]]** - Hub canali pubblici. Metadata statici e linking.
- **[[GChannelPage (web)]]** - Hub canale. Metadata dinamici e link verso match/team.
- **[[GTeamPage (web)]]** - Hub squadra. Metadata dinamici e link verso canale/match.
- **[[GStatsPage (web)]]** - Proof platform. Metadata e dati aggregati.
- **Pagine statiche** - Aggiornare head HTML manualmente o tramite template statico.
- **Nuovo `SeoMetadataService (web)`** - Wrappa Angular `Title` e `Meta`; gestisce canonical link element e structured data script.
- **Nuovo `SeoStructuredDataComponent/Service (web)`** - Opzionale. Utile se JSON-LD diventa complesso; altrimenti restare in `SeoMetadataService`.

## Dipendenze

- Decisione dominio canonico.
- Accesso a hosting/CDN/Firebase config per redirect.
- Fonte affidabile per `lastmod` di match, canali, squadre e blog.
- Scelta tra static file sitemap e endpoint runtime.
- Scelta tra Angular prerender, SSR o generazione HTML statica dedicata.
- Definizione soglia qualita per indicizzare `g-match`.
- Accesso aggiornato a GSC/GA/AdSense per monitoraggio.
- Revisione copy per metadata statiche e landing editoriali.

## Rischi tecnici

- **SSR/prerender troppo costoso** - Alto impatto, probabilita media. Mitigare con rollout per sole pagine ad alto valore: home, landing, top match/canali/squadre.
- **Sitemap include contenuti deboli** - Impatto alto, probabilita alta se si indicizza tutto. Mitigare con soglia qualita e report "scansionata non indicizzata".
- **Canonical errati** - Impatto alto, probabilita media. Mitigare con matrice URL e test campione prima del deploy.
- **Duplicazione g-match/blog** - Impatto medio, probabilita media. Mitigare con intenti distinti e linking reciproco, non canonical incrociato improprio.
- **Job sitemap lento** - Impatto medio, probabilita bassa/media. Mitigare con query paginata, chunk sitemap, output atomico.
- **Metadata solo client-side** - Impatto alto per SEO dinamica. Mitigare con prerender/SSR o HTML statico per URL strategiche.
- **Ads peggiorano Web Vitals mobile** - Impatto medio, probabilita media. Mitigare con lazy-load, posizionamento sotto contenuto principale e misurazione CWV.

## Decisioni architetturali

- **Sitemap via job/file statici, non runtime API primaria** - Motivo: sitemap cambia meno del traffico runtime e deve essere stabile/cacheabile. Alternativa endpoint dinamico; tradeoff: piu semplice ma rischia carico/query timeout.
- **Nuovo `SeoMetadataService (web)`** - Motivo: centralizza head management e riduce duplicazione tra pagine pubbliche. Alternativa metadata inline in ogni component; tradeoff: veloce ma fragile.
- **Separare `GenerateSeoSitemapJob` da `CreateMatchBlogHtmlJob`** - Motivo: blog statico e sito principale hanno cicli dati diversi. Alternativa estendere blog job; tradeoff: meno file ma responsabilita confusa.
- **Endpoint SEO specifici opzionali** - Motivo: evitare API nuove finche endpoint pubblici bastano. Alternativa creare subito `/seo`; tradeoff: ottimizzazione prematura.
- **Prerender/SSR incrementale** - Motivo: massimizza valore SEO senza migrazione rischiosa. Alternativa SSR totale; tradeoff: piu pulito ma piu costoso.
- **URL lowercase canoniche** - Motivo: riduce duplicazione blog evidenziata da GSC. Alternativa supportare case multipli con canonical; tradeoff: piu complessita.

## Sequencing

1. Decidere dominio canonico e mappa redirect: `www`, non-`www`, `/index.html`, uppercase/lowercase blog.
2. Creare matrice URL pubbliche: tipo, sorgente dati, canonical, indicizzabile, sitemap, `lastmod`.
3. Implementare quick win statici: metadata unici, canonical, robots.txt, sitemap root aggiornata.
4. Implementare `SeoMetadataService (web)` e applicarlo a home, liste pubbliche, `g-stats`.
5. Applicare metadata dinamici client-side a `g-match`, `g-channel`, `g-team` come primo passo.
6. Implementare `SeoUrlInventoryService (api)` o equivalente interno al job.
7. Implementare `GenerateSeoSitemapJob (api)` con sitemap statiche, match, canali, squadre e reference blog.
8. Estendere [[CreateMatchBlogHtmlJob (api)]] per lowercase/canonical/linking/Article JSON-LD.
9. Definire e implementare soglia indicizzabilita match.
10. Valutare prerender/SSR per `g-match`, `g-channel`, `g-team` e landing prioritarie.
11. Creare landing editoriali validate da GSC e inserirle in sitemap/linking.
12. Attivare ciclo monitoraggio mensile e confrontare GSC/GA/AdSense prima/dopo.

## Dati mancanti e domande aperte

- Dominio canonico definitivo.
- Hosting effettivo di sito principale, blog e redirect.
- Dove vengono serviti oggi `sitemap.xml` e eventuale `robots.txt` in produzione.
- Campi data affidabili per `lastmod`: entity update date, match date, blog staticization date o file timestamp.
- Soglia qualita per indicizzare match: eventi minimi, blog presente, punteggio, squadre, canale?
- Numero reale di match/canali/squadre pubblici e crescita attesa.
- Vincoli deploy per generare file sitemap su filesystem o storage remoto.
- Compatibilita Angular attuale con prerender/SSR.
- Strategia lingua per pagine statiche multilingua nello stesso URL.
- Policy credenziali per eventuale integrazione API GSC/GA/AdSense.

## Note per sviluppo

- Prima task tecnica: inventario URL e decisione canonical. Senza questo, sitemap e metadata rischiano correzioni successive.
- Evitare nuove API `/seo` finche endpoint pubblici esistenti sono sufficienti.
- Trattare sitemap come prodotto dati: generazione ripetibile, output validabile, log, fallback se job fallisce.
- Per `SeoMetadataService`, prevedere rimozione/aggiornamento idempotente dei tag head per navigazione SPA.
- Per JSON-LD, generare solo dati supportati da entity/DTO esistenti.
- Per blog, non canonicalizzare verso `g-match`: mantenere ruolo recap e collegamento reciproco.
- Ogni fase deve avere verifica GSC: URL Inspection campione, coverage, CTR query/pagine.
