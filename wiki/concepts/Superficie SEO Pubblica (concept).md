---
title: "Superficie SEO Pubblica (concept)"
type: concept
layer: concept
---

# Superficie SEO Pubblica (concept)

## Sintesi

Insieme delle pagine, sitemap, header SEO e report analytics che rendono Rugby Radio Live scopribile e monitorabile dai motori di ricerca.

## Scope

La superficie SEO pubblica comprende:

- sitemap root e sitemap operative documentate in [[Public Sitemap (article)]];
- pagine HTML statiche del blog e relativi header documentati in [[Static Blog SEO Headers (article)]];
- generazione backend delle sitemap tramite [[GenerateSeoSitemapJob (api)]], [[SeoUrlInventoryService (api)]] e [[SeoSitemapFilePublishingIntegration (api)]];
- riferimento alle sitemap blog tramite [[BlogSitemapReferenceIntegration (api)]];
- monitoraggio Search Console tramite [[Search Console Performance 2026-04 (analytic)]], [[Search Console Performance 2026-06 (analytic)]], [[Search Console Index Coverage 2026-04 (analytic)]] e [[Search Console Index Coverage 2026-05 (analytic)]].

## Componenti coinvolti

- [[SeoMetadataService (web)]]
- [[Public Sitemap (article)]]
- [[Static Blog SEO Headers (article)]]
- [[Pubblicazione Blog Statico (workflow)]]
- [[GenerateSeoSitemapJob (api)]]
- [[SeoUrlInventoryService (api)]]
- [[SitemapXmlWriter (api)]]
- [[SeoSitemapFilePublishingIntegration (api)]]
- [[BlogSitemapReferenceIntegration (api)]]
- [[BlogStaticFilePublishingIntegration (api)]]
- [[Search Console Performance 2026-04 (analytic)]]
- [[Search Console Performance 2026-06 (analytic)]]
- [[Search Console Index Coverage 2026-04 (analytic)]]
- [[Search Console Index Coverage 2026-05 (analytic)]]

## Relazioni principali

- [[Public Sitemap (article)]] descrive la sitemap root come `sitemapindex` pubblico e collega sitemap statiche, match, canali, team e blog statico.
- [[GenerateSeoSitemapJob (api)]] legge candidati URL da [[SeoUrlInventoryService (api)]] e scrive sitemap XML pubbliche.
- [[SeoSitemapFilePublishingIntegration (api)]] rappresenta la pubblicazione filesystem delle sitemap SEO generate.
- [[Static Blog SEO Headers (article)]] descrive canonical, alternate hreflang, Open Graph e Twitter card delle pagine blog statiche.
- [[Pubblicazione Blog Statico (workflow)]] collega generazione del contenuto, staticizzazione HTML, endpoint blog, header SEO e sitemap pubblica.
- I report Search Console documentano performance, copertura, canonical, redirect, duplicati, pagine scansionate non indicizzate e query organiche su live rugby commentary.

## Decisioni architetturali

- La sitemap root e documentata come file statico rilasciato con il deploy Firebase.
- Le sitemap operative sono generate da [[GenerateSeoSitemapJob (api)]] usando [[SeoUrlInventoryService (api)]] e [[SitemapXmlWriter (api)]] su host `seo-sh.rugbyradiolive.com`.
- Le pagine blog statiche usano header SEO dedicati generati dal job di staticizzazione, con URL lowercase, canonical e hreflang.
- I metadata SEO dinamici (title, description, canonical, OG, Twitter card, JSON-LD) sono gestiti runtime da [[SeoMetadataService (web)]].
- Il monitoraggio SEO e separato dal runtime applicativo e vive nelle pagine analytics.

## Rischi

- [[Public Sitemap (article)]] segnala che la soluzione sitemap andra rivista al crescere di partite o canali.
- [[Search Console Index Coverage 2026-05 (analytic)]] evidenzia criticita su canonical, redirect, duplicati e pagine scansionate non indicizzate.
- Le metriche analytics e Search Console non dimostrano causalita tra modifiche tecniche e andamento organico.

## Note

Aggiornata con evidenze da `llm-wiki/raw/dev/seo-20260519.md`. La policy di indicizzabilita match richiede: match pubblico, stato FullTime, entrambe le squadre presenti, almeno 10 eventi, blog statico associato, canale non test. Le URL escluse da sitemap includono route private, test, debug, error pages e `/g-feedback`, `/user-*`.
