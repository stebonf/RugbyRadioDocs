---
title: "Public Sitemap (article)"
type: article
layer: articles
---

# Public Sitemap (article)

## Sintesi
Sitemap XML pubblica rilasciata con il deploy Firebase come indice di sitemap per sito principale, generazione SEO e blog statico.

## Scope
Include riferimenti a sitemap generate da `seo-sh.rugbyradiolive.com` per contenuti statici, match, canali e team, piu sitemap del blog statico per lingua.

## Componenti coinvolti
- [[GChannelsPage (web)]]
- [[GMatchesPage (web)]]
- [[Static Blog SEO Headers (article)]]
- [[GenerateSeoSitemapJob (api)]]
- [[SeoSitemapFilePublishingIntegration (api)]]
- [[BlogSitemapReferenceIntegration (api)]]

## Relazioni principali
- File root: `/sitemap.xml` come `sitemapindex`, incluso nel deploy Firebase.
- Sitemap generate da [[GenerateSeoSitemapJob (api)]] su `seo-sh.rugbyradiolive.com`:
  - `sitemap-static.xml` — URL statiche: home, g-matches, g-channels, g-stats
  - `sitemap-matches.xml` — Match pubblici con contenuto sufficiente
  - `sitemap-channels.xml` — Canali pubblici
  - `sitemap-teams.xml` — Squadre pubbliche
- Sitemap blog statico: `https://blog.rugbyradiolive.com/sitemap-it.xml`, `sitemap-en.xml`, `sitemap-fr.xml`, `sitemap-es.xml`, `sitemap-ja.xml`.
- `robots.txt` deve indicare `Sitemap: https://rugbyradiolive.com/sitemap.xml`.
- Il namespace XML e quello standard sitemap `http://www.sitemaps.org/schemas/sitemap/0.9`.
- Chunking URL a 50.000 per file sitemap.
- `lastmod` in formato ISO, `priority` limitata, `changefreq` lowercase.
- Workflow correlato: [[Pubblicazione Blog Statico (workflow)]].

## Decisioni architetturali
La sitemap root e un `sitemapindex` statico rilasciato da Firebase, mentre le sitemap operative sono generate dal job [[GenerateSeoSitemapJob (api)]] su host SEO separato. La generazione usa [[SitemapXmlWriter (api)]] per XML strutturato e validato. L'inventory URL e prodotta da [[SeoUrlInventoryService (api)]] con policy di indicizzabilita match (almeno 10 eventi, stato FullTime, blog associato, canale non test).

## Rischi
Il RAW segnala che la soluzione e sufficiente nel breve periodo, ma andra rivista al crescere di partite o canali. La generazione sitemap e offline (job Hangfire) e l'output va pubblicato su seo-sh prima che Googlebot possa leggerlo.

## Note
Fonti: `sitemap.xml`, `rrl-202605-seo.md`, `llm-wiki/raw/dev/seo-20260519.md`.
