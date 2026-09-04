---
title: "Blog (concept)"
type: concept
layer: concept
---

# Blog (concept)

## Sintesi

Post editoriali generati automaticamente per partite terminate, disponibili in 5 lingue (IT, EN, FR, ES, JA) e pubblicati come pagine HTML statiche indicizzabili.

## Scope

Il blog copre la generazione del contenuto testuale via AI, la traduzione multilingua, la staticizzazione HTML, l'esposizione via API pubblica, la pubblicazione su filesystem e l'inclusione nella superficie SEO del prodotto.

## Componenti coinvolti

- [[Blog (api)]] — entita che rappresenta il post, con titolo, corpo, lingua e flag di stato
- [[BlogService (api)]] — servizio backend di lettura (lista paginata, post singolo per match e lingua)
- [[BlogRepository (api)]] — repository per persistenza e query blog
- [[BlogV1Controller (api)]] — controller pubblico `/v1/blog` per lettura blog
- [[CreateMatchBlogJob (api)]] — job HF che genera post EN via Tailoor Talker e traduce in IT, FR, ES, JA
- [[CreateMatchBlogHtmlJob (api)]] — job HF che genera HTML statici, indici paginati e sitemap blog
- [[BlogStaticFilePublishingIntegration (api)]] — integrazione filesystem per pubblicazione HTML statico
- [[BlogSitemapReferenceIntegration (api)]] — integrazione che produce riferimenti sitemap blog
- [[BlogService (web)]] — API client frontend per lettura blog
- [[blogDto (web)]] — DTO di risposta con titolo, corpo e riferimento partita
- [[Pubblicazione Blog Statico (workflow)]] — workflow end-to-end di generazione e pubblicazione
- [[Static Blog SEO Headers (article)]] — header canonical, hreflang, OG e Twitter card delle pagine blog
- [[Superficie SEO Pubblica (concept)]] — contesto SEO in cui il blog statico e inserito
- [[Match (api)]] — partita da cui il post blog e generato
- [[SeoUrlInventoryService (api)]] — servizio che include URL blog nell'inventario SEO
- [[GenerateSeoSitemapJob (api)]] — job che include sitemap blog nel sitemap index principale
- [[SeoSitemapFilePublishingIntegration (api)]] — integrazione che pubblica sitemap SEO su filesystem
- [[PublicMediaUrlReferenceIntegration (api)]] — integrazione che produce URL media pubblici per HTML blog
- [[SocialShareUrlIntegration (api)]] — integrazione che produce URL social per pagine blog

## Relazioni principali

- [[CreateMatchBlogJob (api)]] seleziona partite `FullTime` con meno di 5 post blog, genera contenuto EN via Tailoor Talker e traduce nelle altre 4 lingue.
- Ogni versione linguistica e salvata come record [[Blog (api)]] separato, collegato alla stessa partita tramite `MatchId`.
- [[CreateMatchBlogHtmlJob (api)]] elabora i post non ancora staticizzati e genera HTML statici per ogni lingua: pagina dettaglio, indice paginato (20 post), landing root e sitemap XML.
- [[BlogStaticFilePublishingIntegration (api)]] scrive i file HTML e XML su filesystem nel path configurato da `BlogSettings.OutputPath`.
- [[BlogV1Controller (api)]] espone endpoint pubblici `GET /v1/blog` (lista paginata) e `GET /v1/blog/{matchId}` (post singolo), entrambi `[AllowAnonymous]`.
- [[BlogService (web)]] consuma le API blog dal frontend, usato principalmente da [[GMatchPage (web)]] per mostrare contenuti editoriali correlati alla partita.
- [[BlogSitemapReferenceIntegration (api)]] costruisce URL sitemap blog per [[SeoUrlInventoryService (api)]], che alimenta [[GenerateSeoSitemapJob (api)]] per il sitemap index principale.
- [[Static Blog SEO Headers (article)]] documenta header canonical e hreflang per le pagine blog statiche, con fallback EN per le lingue senza contenuto.
- Il flag `IsFacebookPosted` su [[Blog (api)]] traccia la pubblicazione Facebook, gestita da [[FacebookJob (api)]].

## Decisioni architetturali

- La generazione del contenuto e separata dalla staticizzazione HTML: due job HF distinti consentono di monitorare e ritentare le fasi indipendentemente.
- Il contenuto EN e generato per primo via Tailoor Talker; le altre lingue sono ottenute per traduzione sequenziale, non per generazione indipendente.
- Il blog e multilingua ma ogni partita puo avere al massimo un post per lingua (5 record Blog per partita).
- Le pagine blog statiche sono pubblicate su filesystem e servite come HTML puri, separati dal runtime applicativo Angular.
- Le API di lettura blog rimangono attive per eventuali consumer frontend che necessitano dati strutturati oltre all'HTML statico.
- Il riferimento sitemap blog e separato dalle sitemap principali (match, canali, team) e aggregato tramite [[BlogSitemapReferenceIntegration (api)]].

## Rischi

- Cron di esecuzione dei job HF non deducibile dalla wiki.
- [[CreateMatchBlogJob (api)]] non ha retry automatico (`AutomaticRetry(Attempts = 0)`): una risposta AI vuota causa skip della partita.
- [[CreateMatchBlogHtmlJob (api)]] non ha retry automatico: un errore di scrittura filesystem lascia post non staticizzati.
- URL social Instagram e YouTube hardcoded nei template HTML del blog (`CreateMatchBlogHtmlJob`).
- `matchBlogDto` non documentato come pagina wiki separata (esiste solo come DTO annidato in [[blogDto (web)]]).

## Note

Pagina ponte creata usando solo pagine gia presenti in `llm-wiki/wiki`. Il blog e generato esclusivamente per partite terminate (`FullTime`) e non esiste flusso di creazione manuale di post blog. La pubblicazione Facebook e citata dal flag `IsFacebookPosted` ma i dettagli implementativi sono nella pagina [[FacebookJob (api)]].
