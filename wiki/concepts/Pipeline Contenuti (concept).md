---
title: "Pipeline Contenuti (concept)"
type: concept
layer: concept
---

# Pipeline Contenuti (concept)

## Sintesi

Pipeline backend che genera contenuti testuali e multimediali a partire da partite terminate. Prodotta da job Hangfire asincroni, la pipeline attraversa generazione AI blog, traduzione multilingua, generazione immagini, staticizzazione HTML, pubblicazione social e generazione sitemap SEO.

## Scope

L'intera catena di generazione contenuti post-partita: dal match in stato `FullTime` ai contenuti pubblicati su canali statici, social e indicizzazione SEO.

## Attori coinvolti

- [[Cronista (actor)]] — genera eventi di telecronaca che alimentano la fonte dati
- [[Spettatore (actor)]] — fruitore finale dei contenuti pubblicati

## Fasi della pipeline

### 1. Generazione blog AI

- [[CreateMatchBlogJob (api)]] recupera partite `FullTime` con meno di 5 post blog
- [[AiOllamaService (api)]] genera post IT via [[OllamaAI (api)]] con contesto tabellino partita
- Traduce in EN, FR, ES, JA sequenzialmente
- Salva ogni versione come record [[Blog (api)]]

### 2. Generazione immagini

- [[CreateMatchImageJob (api)]] genera WebP 1200x630 per partite via Tailoor Painter AI
- [[CreateMatchImageInstagramJob (api)]] converte WebP in JPG 1080x1350 per Instagram
- [[CreateChannelImageJob (api)]] genera immagini canale con prompt dedicati
- [[CreateChannelImageInstagramJob (api)]] converte immagini canale per Instagram

### 3. Staticizzazione HTML blog

- [[CreateMatchBlogHtmlJob (api)]] genera per ogni lingua: pagine dettaglio post, indici paginati (20 post per pagina), landing page e sitemap blog XML
- [[BlogStaticFilePublishingIntegration (api)]] scrive HTML su filesystem configurato
- [[PublicMediaUrlReferenceIntegration (api)]] inserisce URL immagini pubbliche da `storage-sh.rugbyradiolive.com`
- [[SocialShareUrlIntegration (api)]] inserisce link condivisione (WhatsApp, X/Twitter, Facebook)

### 4. [[Pubblicazione Social (concept)]]

- [[FacebookJob (api)]] genera immagine partita via Tailoor Painter e compone tabellino visuale
- [[FacebookService (api)]] pubblica post su pagina Facebook via [[FacebookGraphAPI (api)]]
- Aggiorna `Blog.IsFacebookPosted`

### 5. Generazione sitemap SEO

- [[SeoUrlInventoryService (api)]] produce candidati URL pubblici da Match, Channel, Team, Blog
- [[GenerateSeoSitemapJob (api)]] scrive sitemap static, matches, channels, teams
- [[SeoSitemapFilePublishingIntegration (api)]] gestisce scrittura XML su filesystem
- [[BlogSitemapReferenceIntegration (api)]] include riferimento sitemap blog nel sitemap index

## Entita dati coinvolte

- [[Match (api)]] — fonte primaria: partita terminata
- [[MatchEvent (api)]] — eventi di telecronaca per contesto AI
- [[Blog (api)]] — output intermedio della generazione testuale
- [[Channel (api)]] — canale di appartenenza della partita
- [[Team (api)]] — squadre coinvolte

## Servizi backend coinvolti

- [[MatchService (api)]] — dati partita
- [[AiOllamaService (api)]] — generazione testi AI
- [[BlogService (api)]] — CRUD blog
- [[SeoUrlInventoryService (api)]] — inventory URL SEO
- [[FacebookService (api)]] — pubblicazione social

## Integrazioni coinvolte

- [[OllamaAI (api)]] — LLM self-hosted per generazione testi
- [[BlogStaticFilePublishingIntegration (api)]] — scrittura HTML su filesystem
- [[SeoSitemapFilePublishingIntegration (api)]] — scrittura sitemap su filesystem
- [[BlogSitemapReferenceIntegration (api)]] — riferimento sitemap blog
- [[SocialShareUrlIntegration (api)]] — link social negli HTML
- [[PublicMediaUrlReferenceIntegration (api)]] — URL media pubblici
- [[FacebookGraphAPI (api)]] — Facebook Graph API per post

## Job coinvolti

- [[CreateMatchBlogJob (api)]]
- [[CreateMatchBlogHtmlJob (api)]]
- [[CreateMatchImageJob (api)]]
- [[CreateMatchImageInstagramJob (api)]]
- [[CreateChannelImageJob (api)]]
- [[CreateChannelImageInstagramJob (api)]]
- [[FacebookJob (api)]]
- [[GenerateSeoSitemapJob (api)]]

## Workflow correlati

- [[Pubblicazione Blog Statico (workflow)]]

## Gap noti

- Cron espressioni dei job Hangfire non deducibili dalla wiki
- Dettaglio `WritePost` in `CreateMatchImageInstagramJob` parzialmente dedotto
- Analytics tracking delle singole fasi non deducibile
- Relazione tra generazione immagini Instagram e pubblicazione social non completamente deducibile

## Note

Pagina creata da pagine wiki esistenti. Nessun RAW letto. La pipeline descrive il flusso asincrono di generazione contenuti gestito da job backend Hangfire.
