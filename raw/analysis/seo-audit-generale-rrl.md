---
type: seo-analysis
created: 2026-05-16T23:20:41+02:00
source: llm-wiki + code-inspection + google-search-central
topic: "Audit SEO generale Rugby Radio Live"
slug: seo-audit-generale-rrl
---

# Analisi SEO: Audit generale Rugby Radio Live

## Sintesi

Rugby Radio Live ha gia una base SEO interessante: dominio verticale chiaro, query organiche coerenti con "live rugby commentary" e "rugby radio", pagine pubbliche indicizzabili, blog statico multilingua e dataset prodotto reale su partite, canali, squadre, eventi e commenti.

Il problema principale non sembra essere mancanza di contenuto, ma dispersione e debolezza tecnica: canonical duplicati tra `www`, non-`www` e `index.html`, molte pagine scansionate ma non indicizzate, sitemap pubblica parziale e datata, pagine Angular client-rendered con metadata generici, pagine statiche con title/description quasi duplicati, blog multilingua con URL case-sensitive inconsistenti nei dati GSC.

Priorita: consolidare canonical e URL, rendere le pagine pubbliche piu comprensibili a Google nel primo HTML o tramite prerender/SSR, aggiornare sitemap e metadata, poi usare il patrimonio di partite/canali/blog per costruire cluster editoriali su query gia dimostrate.

## Ambito

Incluso:

- dati GA, GSC, AdSense e platform stats documentati in wiki;
- sitemap pubblica Angular;
- pagine Angular pubbliche;
- pagine statiche pubbliche;
- blog statico e generazione HTML/sitemap;
- opportunita contenuti, linking interno, multilingua, canonical, structured data, strumenti SEO.

Fuori ambito:

- misurazione live da Google Search Console oltre i CSV presenti;
- crawl reale del dominio in produzione;
- Lighthouse/PageSpeed live;
- competitor research esterna completa;
- keyword volume da tool terzi.

## Fonti usate

Wiki:

- [[Google Analytics Traffic 2026-01 2026-04 (analytic)]]
- [[Search Console Performance 2026-04 (analytic)]]
- [[Search Console Index Coverage 2026-05 (analytic)]]
- [[Platform Stats 2026-05-13 (analytic)]]
- [[AdSense Performance 2026-01 2026-04 (analytic)]]
- [[AdSense Placements 2026-05 (analytic)]]
- [[Public Sitemap (article)]]
- [[Static Blog SEO Headers (article)]]
- [[Pubblicazione Blog Statico (workflow)]]
- [[CreateMatchBlogJob (api)]]
- [[CreateMatchBlogHtmlJob (api)]]
- [[BlogV1Controller (api)]]
- [[HomePage (web)]]
- [[GChannelsPage (web)]]
- [[GMatchesPage (web)]]
- [[GMatchPage (web)]]
- [[GChannelPage (web)]]
- [[GTeamPage (web)]]
- [[GStatsPage (web)]]
- [[Rugby Radio Live (product)]]
- [[Partita (concept)]]
- [[Radio Canale (concept)]]
- [[AI-Talker (concept)]]

Codice ispezionato:

- `src/RugbyRadioWeb/src/sitemap.xml`
- `src/RugbyRadioWeb/src/index.html`
- `src/RugbyRadioWeb/src/app/app.routes.ts`
- `src/RugbyRadioWeb/src/app/global/*`
- `src/RugbyRadioWeb/src/assets/static/*.html`
- `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs`

Fonti esterne ufficiali:

- Google Search Central, JavaScript SEO: https://developers.google.com/search/docs/crawling-indexing/javascript/javascript-seo-basics
- Google Search Central, canonical: https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls
- Google Search Central, sitemap: https://developers.google.com/search/docs/crawling-indexing/sitemaps/build-sitemap
- Google Search Central, localized versions/hreflang: https://developers.google.com/search/docs/advanced/crawling/localized-versions
- Google Search Central, helpful content: https://developers.google.com/search/docs/fundamentals/creating-helpful-content
- Google Search Central, generative AI content: https://developers.google.com/search/docs/fundamentals/using-gen-ai-content
- Google Search Central, title links: https://developers.google.com/search/docs/appearance/title-link
- Google Search Central, Core Web Vitals: https://developers.google.com/search/docs/appearance/core-web-vitals
- Google Search Central, image SEO: https://developers.google.com/search/docs/advanced/guidelines/google-images

## Contesto SEO rilevante

- RRL e piattaforma per telecronache testuali di rugby amatoriale/giovanile create da telefono.
- Asset organici forti: canali, partite, squadre, eventi, blog post multilingua, immagini e contenuti AI-Talker.
- Pubblico deducibile: cronisti/club che creano partite, spettatori che cercano aggiornamenti, utenti che cercano "live rugby commentary" o "rugby radio".
- Traffico organico esistente: 302 clic e 8422 impressioni nel periodo 2026-01-01 / 2026-04-30.
- Mobile e canale dominante: 260 clic su 302 da mobile.
- Monetizzazione AdSense presente ma ancora minima: 0.33 EUR totali gennaio-aprile 2026.

## Evidenze

- GSC mostra query coerenti con valore prodotto: `live rugby commentary on radio free`, `rugby radio live`, `live rugby commentary today`, `live rugby on radio today`, `live rugby commentary`.
- Home non-`www` genera 207 clic e 4754 impressioni; home `www` genera 86 clic e 3136 impressioni. Questo segnala duplicazione/canonical non pienamente consolidata.
- `https://rugbyradiolive.com/index.html` genera ancora impressioni e clic, ulteriore variante duplicata.
- GSC Coverage segnala 109 pagine "scansionata ma attualmente non indicizzata".
- GSC Coverage segnala 5 pagine duplicate senza canonical selezionato e 18 alternative con canonical appropriato.
- GSC raw mostra URL blog con directory maiuscole (`/EN/`, `/ES/`) e minuscole (`/en/`, `/es/`), potenziale duplicazione case-sensitive.
- Sitemap Angular pubblica contiene solo poche URL statiche e indici blog; non contiene `g-channel/:id`, `g-match/:id`, `g-team/:id`, ne sitemap index blog generato dal job.
- `lastmod` della sitemap Angular e fermo al 2024-09 per sito e 2025-10 per blog.
- `index.html` Angular ha title e description generici globali; molte pagine pubbliche aggiornano solo `Title` client-side via Angular.
- Pagine statiche `why`, `tutorial`, `how-to`, `ai-talkers` usano title diversi, ma description e keywords quasi uguali.
- Pagine statiche contengono piu lingue nello stesso URL con blocchi `data-lang`; non emergono URL separati ne `hreflang` per queste varianti.
- Blog statico genera canonical e hreflang per EN/IT/FR/ES/JA/x-default, quindi architettura piu SEO-friendly rispetto all'app Angular.
- Blog statico genera sitemap per lingua e sitemap index, ma la sitemap Angular principale non li referenzia.
- GSC pagine principali mostra molte pagine partita con posizioni buone ma CTR 0: esempio varie `g-match` tra posizione 3 e 8 ma zero clic.

## Problemi e opportunita

### Canonical e varianti URL disperdono segnali

- **Tipo** - Indicizzazione, tecnica.
- **Evidenza** - Home `rugbyradiolive.com`, `www.rugbyradiolive.com` e `/index.html` sono tutte presenti nei dati GSC.
- **Impatto** - Link equity e segnali utente divisi; rischio duplicati; title/description scelti da Google in modo non prevedibile.
- **Severita** - Critica.
- **Note** - Scegliere una canonical assoluta unica: raccomandato `https://rugbyradiolive.com/` oppure `https://www.rugbyradiolive.com/`, poi redirect 301 coerente.

### App Angular pubblica troppo dipendente da rendering JS

- **Tipo** - Crawlability, metadata, contenuto.
- **Evidenza** - `src/RugbyRadioWeb/src/index.html` contiene metadata generici; le pagine pubbliche settano title lato Angular. Google puo renderizzare JS, ma la coda di rendering e la chiarezza canonical restano punti critici.
- **Impatto** - Pagine dinamiche `g-match`, `g-channel`, `g-team` meno comprensibili e meno appetibili in SERP.
- **Severita** - Alta.
- **Note** - Per pagine pubbliche con valore SEO conviene prerender/SSR o HTML server-side per metadata, canonical, OG, JSON-LD e contenuto above-the-fold.

### Sitemap incompleta e non aggiornata

- **Tipo** - Crawl discovery.
- **Evidenza** - Sitemap Angular contiene solo root, poche pagine statiche e indici blog; `lastmod` vecchi; mancano URL dinamiche pubbliche e sitemap index blog.
- **Impatto** - Google scopre meno bene partite, canali, squadre e blog; peggiora recrawl di contenuti aggiornati.
- **Severita** - Alta.
- **Note** - Sitemap deve riflettere URL canoniche e contenuti realmente indicizzabili. `lastmod` solo quando cambia contenuto sostanziale.

### 109 pagine scansionate ma non indicizzate

- **Tipo** - Qualita/indicizzazione.
- **Evidenza** - [[Search Console Index Coverage 2026-05 (analytic)]], raw GSC.
- **Impatto** - Budget di crawl speso su pagine che Google non ritiene abbastanza valide o distinte.
- **Severita** - Alta.
- **Note** - Molte sono `g-match` e blog. Possibili cause: contenuto sottile, duplicazione app/blog, metadata generici, no internal links forti, URL case mismatch.

### Pagine partita con ranking ma CTR nullo

- **Tipo** - SERP snippet, intent, contenuto.
- **Evidenza** - GSC pagine: varie `g-match` in posizione 3-8 con zero clic.
- **Impatto** - Opportunita immediata: migliorare title/meta/snippet e match intent.
- **Severita** - Alta.
- **Note** - Title tipo "Home Team vs Away Team live rugby commentary | Rugby Radio Live" puo battere title generico "Match | Rugby Radio Live".

### Pagine statiche con metadata duplicati

- **Tipo** - Metadata, contenuto.
- **Evidenza** - `why.html`, `tutorial.html`, `how-to.html`, `ai-talkers.html` condividono description quasi identica.
- **Impatto** - Google puo ignorare snippet, ridurre differenziazione pagine e abbassare CTR.
- **Severita** - Media.
- **Note** - Ogni pagina deve rispondere a un intento distinto: perche usarlo, come creare match, AI commentators, tutorial.

### Multilingua mista nello stesso URL

- **Tipo** - Hreflang, internazionalizzazione.
- **Evidenza** - Pagine statiche contengono blocchi EN/IT/FR/ES/JA nello stesso HTML e `html lang="en"` fisso.
- **Impatto** - Google deve dedurre lingua; snippet e targeting possono essere confusi.
- **Severita** - Media.
- **Note** - Google dichiara che usa algoritmi per rilevare lingua; `hreflang` serve a collegare varianti localizzate. RRL oggi non offre varianti URL per statiche.

### Blog statico buono ma rischia duplicazione con g-match

- **Tipo** - Architettura contenuti.
- **Evidenza** - Esistono `g-match/:id` e blog statici `/lang/{matchId}.html`; raw GSC mostra entrambi per stesse partite.
- **Impatto** - Due URL competono per query simili: live match vs recap/story.
- **Severita** - Media.
- **Note** - Serve ruolo chiaro: `g-match` per live score/eventi, blog per recap indicizzabile post partita. Linking e canonical devono riflettere questa distinzione, non fonderla.

### Contenuti AI: opportunita, ma serve qualita editoriale

- **Tipo** - Contenuto, reputazione.
- **Evidenza** - Blog generato via AI e tradotto; AI-Talker e asset centrale del prodotto.
- **Impatto** - Scalabilita alta, ma rischio contenuti ripetitivi o poco utili.
- **Severita** - Media.
- **Note** - Google non penalizza contenuto AI in quanto AI; penalizza contenuto non utile, massivo, manipolativo o privo di valore originale.

### AdSense prima del valore organico

- **Tipo** - Monetizzazione/UX.
- **Evidenza** - AdSense esteso a molte pagine; revenue molto bassa.
- **Impatto** - Annunci possono peggiorare UX mobile e Core Web Vitals prima che il traffico renda.
- **Severita** - Media.
- **Note** - Con 302 clic organici in 4 mesi, crescita traffico e UX valgono piu dell'ottimizzazione ads.

## Raccomandazioni prioritarie

### 1. Consolidare dominio, canonical e redirect

- **Priorita** - Critica.
- **Sforzo** - Medio.
- **Impatto** - Alto.
- **Confidenza** - Alta.
- **Azione** - Scegliere dominio canonico. Applicare 301 da variante non scelta, da `/index.html` a `/`, da path case non canonici a lowercase dove possibile. Inserire `rel=canonical` coerente in home, statiche, blog e pagine pubbliche renderizzate.
- **Dipendenze** - Hosting/Firebase config, eventuale Cloudflare/CDN, generatore blog, Angular/prerender.

### 2. Rendere SEO-first le pagine pubbliche Angular

- **Priorita** - Critica.
- **Sforzo** - Grande.
- **Impatto** - Trasformativo.
- **Confidenza** - Alta.
- **Azione** - Introdurre prerender/SSR per `g-match/:id`, `g-channel/:id`, `g-team/:id`, `g-matches`, `g-channels`, `g-stats`; generare title, description, canonical, Open Graph, Twitter card e JSON-LD nel primo HTML.
- **Dipendenze** - Angular builder/SSR, API pubbliche, cache, routing server.

### 3. Rigenerare sitemap completa

- **Priorita** - Alta.
- **Sforzo** - Medio.
- **Impatto** - Alto.
- **Confidenza** - Alta.
- **Azione** - Creare sitemap index root che referenzia: pagine statiche, sitemap blog index, sitemap canali, sitemap partite, sitemap squadre. Aggiornare `lastmod` da data reale modifica/partita/blog. Includere solo URL canoniche 200 e indicizzabili.
- **Dipendenze** - DB/API export, job schedulato, hosting file XML, robots.txt.

### 4. Correggere metadata unici per pagine statiche

- **Priorita** - Alta.
- **Sforzo** - Piccolo.
- **Impatto** - Moderato.
- **Confidenza** - Alta.
- **Azione** - Scrivere title/description dedicati per `why`, `tutorial`, `how-to`, `ai-talkers`, `news`, `terms`; aggiungere canonical e Open Graph. Eliminare reliance su `meta keywords`.
- **Dipendenze** - Copy SEO, file statici.

### 5. Definire schema contenuti per pagine partita

- **Priorita** - Alta.
- **Sforzo** - Medio.
- **Impatto** - Alto.
- **Confidenza** - Alta.
- **Azione** - Per ogni `g-match`: title con squadre/data/stato, description con punteggio/eventi/canale, H1 esplicito, link a canale/squadre/blog, dati strutturati `SportsEvent` se dati disponibili, fallback `Article`/`WebPage` per recap.
- **Dipendenze** - DTO `matchDto`, `teamPublicDto`, generazione HTML.

### 6. Definire schema contenuti per canali e squadre

- **Priorita** - Alta.
- **Sforzo** - Medio.
- **Impatto** - Alto.
- **Confidenza** - Media.
- **Azione** - Per `g-channel`: title con nome canale + "rugby live commentary"; description con numero partite, prossima/ultima partita, squadre. Per `g-team`: title con squadra + partite/risultati. Aggiungere link interni da canale a partite, da partita a squadre, da squadra a partite.
- **Dipendenze** - API canale/squadra, dati disponibili.

### 7. Risolvere duplicazione blog case-sensitive

- **Priorita** - Alta.
- **Sforzo** - Medio.
- **Impatto** - Moderato.
- **Confidenza** - Media.
- **Azione** - Standardizzare directory blog lowercase (`/en/`, `/it/`, `/fr/`, `/es/`, `/ja/`). Redirect 301 da `/EN/`, `/ES/` ecc. Aggiornare link generati, sitemap e social posting.
- **Dipendenze** - Hosting blog, job `CreateMatchBlogHtmlJob`, link esistenti.

### 8. Rafforzare blog come recap editoriale, non clone live

- **Priorita** - Alta.
- **Sforzo** - Medio.
- **Impatto** - Alto.
- **Confidenza** - Media.
- **Azione** - Template blog con sezioni ricorrenti: risultato finale, momenti chiave, timeline, migliori eventi, contesto squadre/canale, link alla pagina live. Aggiungere `Article` JSON-LD, autore/brand, data pubblicazione/modifica.
- **Dipendenze** - Prompt AI, dati match/eventi, job blog.

### 9. Creare landing editoriali per query gia validate

- **Priorita** - Alta.
- **Sforzo** - Medio.
- **Impatto** - Alto.
- **Confidenza** - Alta.
- **Azione** - Creare pagine statiche/prerender dedicate:
  - "Live rugby commentary today"
  - "Free live rugby commentary on radio"
  - "Rugby radio commentary"
  - "How to create live rugby commentary for amateur rugby"
  - "AI rugby commentators"
- **Dipendenze** - Content design, internal links, aggiornamento sitemap.

### 10. Migliorare CTR SERP

- **Priorita** - Alta.
- **Sforzo** - Piccolo.
- **Impatto** - Moderato.
- **Confidenza** - Alta.
- **Azione** - Riscrivere title/meta per home e pagine principali usando query GSC reali. Esempio home: "Rugby Radio Live - Free Live Rugby Commentary for Clubs". Testare CTR mensile su GSC.
- **Dipendenze** - Metadata server/prerender.

### 11. Separare strategie mobile UX e AdSense

- **Priorita** - Media.
- **Sforzo** - Medio.
- **Impatto** - Moderato.
- **Confidenza** - Media.
- **Azione** - Ridurre peso ads sopra la piega su mobile, misurare Core Web Vitals, lazy-load iframe/video/ads, evitare layout shift.
- **Dipendenze** - Web Vitals, PageSpeed/CrUX, componenti ads.

### 12. Aggiungere monitoraggio SEO operativo

- **Priorita** - Media.
- **Sforzo** - Piccolo.
- **Impatto** - Moderato.
- **Confidenza** - Alta.
- **Azione** - Attivare routine mensile: export GSC query/pagine/copertura, GA landing organiche, AdSense per pagina, sitemap status, pagine non indicizzate, CTR top 20 query.
- **Dipendenze** - Accesso GSC/GA/AdSense, script export.

## Piano operativo

### Breve termine: 1-2 settimane

- Scegliere dominio canonico e correggere redirect `www`/non-`www`/`index.html`.
- Aggiornare sitemap Angular con `lastmod` realistici e link a sitemap index blog.
- Aggiungere `robots.txt` con riferimento esplicito a sitemap root e blog sitemap index.
- Correggere title/description/canonical delle pagine statiche.
- Standardizzare lowercase per URL blog e predisporre redirect da varianti uppercase.
- Riscrivere home title/description usando query GSC reali.
- Aprire GSC URL Inspection su campione: home, `g-match`, blog post, statiche.

### Medio termine: 3-8 settimane

- Introdurre prerender/SSR per pagine pubbliche principali.
- Generare sitemap dinamiche da DB per `g-match`, `g-channel`, `g-team`.
- Implementare metadata dinamici e JSON-LD per match/canali/squadre/blog.
- Creare 5 landing editoriali da query validate.
- Migliorare template blog con recap strutturato e link interni.
- Creare dashboard mensile SEO con GSC + GA + AdSense.

### Lungo termine: 2-6 mesi

- Costruire topic authority su rugby amatoriale: guide per club, genitori, allenatori, cronisti.
- Creare pagine hub per paesi/lingue con query localizzate.
- Creare calendario contenuti legato a stagioni, tornei, weekend match.
- Valutare integrazione newsletter/social per amplificare blog post e link earning.
- Valutare partnership con club e federazioni locali per backlink e adozione prodotto.

## Strategia contenuti proposta

### Cluster 1: Live rugby commentary

- Intent: utenti cercano ascolto/aggiornamenti live.
- Pagine: home, "live rugby commentary today", `g-matches`, pagine match live.
- CTA: cerca partita, crea canale, condividi live.

### Cluster 2: Rugby radio for clubs

- Intent: club/amatori cercano modo facile per aggiornare famiglie e tifosi.
- Pagine: "how to create live rugby commentary", "rugby match updates for clubs", tutorial.
- CTA: crea radio/canale.

### Cluster 3: AI rugby commentators

- Intent: curiosita e differenziazione prodotto.
- Pagine: AI-Talkers, singole sezioni/personaggi, demo video.
- CTA: prova AI-Talker in una partita.

### Cluster 4: Match recaps and results

- Intent: risultato, recap, timeline partita.
- Pagine: blog statico, `g-match`, pagine squadra/canale.
- CTA: leggi recap, segui canale.

### Cluster 5: Rugby youth/amateur community

- Intent: contenuti evergreen per pubblico reale.
- Pagine: guide per genitori, allenatori, manager, volontari.
- CTA: usa RRL per la prossima partita.

## Impatto atteso

- Consolidamento canonical: miglioramento chiarezza indicizzazione e possibile recupero segnale disperso tra home duplicate.
- SSR/prerender + metadata dinamici: piu pagine dinamiche eleggibili per query long-tail e snippet migliori.
- Sitemap completa: discovery piu rapida di partite/canali/squadre/blog.
- Metadata e landing query-based: aumento CTR sulle query gia in posizione 5-10.
- Blog strutturato: maggiore differenziazione tra live page e recap, meno rischio contenuto sottile.
- Linking interno: migliore distribuzione PageRank interno da home/statiche/blog verso pagine prodotto.

## KPI da monitorare

- Clic organici totali GSC mensili.
- Impressioni e CTR top query.
- Numero pagine indicizzate vs scansionate non indicizzate.
- CTR home canonical vs varianti duplicate.
- Pagine `g-match` con impressioni e zero clic.
- Traffico organico mobile e durata coinvolgimento GA.
- Conversioni soft: follow canale, share, creazione account, creazione canale.
- Revenue AdSense per 1000 sessioni organiche, senza sacrificare CWV.

## Dati mancanti e domande aperte

- Dominio canonico desiderato: `www` o non-`www`.
- Stato produzione di `robots.txt`.
- Accesso a GSC live per validare URL Inspection e coverage aggiornata.
- Core Web Vitals reali da GSC/CrUX.
- Landing page organiche GA per sorgente `google / organic`.
- Eventi conversione GA gia tracciati o da definire.
- Frequenza reale dei job blog/staticizzazione/sitemap.
- Regole hosting per redirect uppercase/lowercase e `index.html`.
- Qualita media dei contenuti blog generati: serve sample review editoriale.
- Dati geografia/lingua completi oltre note su UK, Francia, Spagna, Italia, Irlanda.

## Rischi

- Indicizzare troppe pagine partita povere puo aumentare "crawled currently not indexed".
- Blog AI massivo senza valore originale puo ridurre fiducia e performance.
- Canonical errati tra `g-match` e blog possono far sparire URL utili.
- Hreflang incompleto o incoerente puo peggiorare targeting internazionale.
- Ads aggressivi su mobile possono ridurre engagement e Web Vitals.
- Sitemap con `lastmod` finto o troppo frequente puo perdere fiducia operativa.

## Note per analisi successiva

- Preparare backlog tecnico SEO: redirect, canonical, sitemap, SSR/prerender, JSON-LD.
- Preparare content brief per 5 landing prioritarie basate su query GSC.
- Preparare checklist template blog post e prompt AI orientato helpful content.
- Preparare script mensile per import GSC/GA/AdSense e generazione report.
- Eseguire crawl locale/produzione con Screaming Frog, Sitebulb o crawler custom.
- Usare Rich Results Test e URL Inspection su campione di pagine.
