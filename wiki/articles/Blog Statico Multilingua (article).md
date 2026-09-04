---
title: "Blog Statico Multilingua (article)"
type: article
layer: concept
---

# Blog Statico Multilingua (article)

## Sintesi

Il blog statico multilingua pubblica post editoriali generati per partite terminate e disponibili in IT, EN, FR, ES e JA.

## Scope

Questa pagina collega il modello blog, il workflow di pubblicazione statica, la SEO e lo slot AdSense unico del blog.

## Componenti coinvolti

- [[Blog (concept)]]
- [[Pubblicazione Blog Statico (workflow)]]
- [[CreateMatchBlogJob (api)]]
- [[CreateMatchBlogHtmlJob (api)]]
- [[BlogStaticFilePublishingIntegration (api)]]
- [[Static Blog SEO Headers (article)]]
- [[Public Sitemap (article)]]
- [[AdSense Blog Alignment 2026-06 (analytic)]]

## Relazioni principali

- [[CreateMatchBlogJob (api)]] genera contenuti blog per partite `FullTime` e salva versioni linguistiche come record [[Blog (api)]].
- [[CreateMatchBlogHtmlJob (api)]] trasforma i post in pagine dettaglio, landing, indici paginati e sitemap XML.
- [[Static Blog SEO Headers (article)]] documenta canonical, hreflang, Open Graph e Twitter card delle pagine statiche.
- [[AdSense Blog Alignment 2026-06 (analytic)]] stabilisce `BLOG-HOME: 6223722056` come slot unico per tutte le superfici del blog.

## Note

Articolo creato usando solo pagine wiki esistenti. Cron dei job, performance economica specifica del blog e revisione editoriale umana non sono deducibili.

