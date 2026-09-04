---
title: "Mappatura Blog e Pubblicazione Social (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Blog e Pubblicazione Social (comparison)

## Sintesi

Confronto tra generazione blog, staticizzazione HTML, SEO, condivisione e pubblicazione social dei contenuti post-partita.

## Scope

Include blog automatico, pipeline contenuti, staticizzazione, sitemap blog, link social e pubblicazione Facebook documentati nella wiki. Non include strategie editoriali manuali non formalizzate.

## Mappatura

| Fase | Pagine collegate | Output |
|---|---|---|
| Generazione contenuto | [[Blog (concept)]], [[CreateMatchBlogJob (api)]], [[AiOllamaService (api)]] | Record [[Blog (api)]] multilingua per partita FullTime. |
| Staticizzazione | [[CreateMatchBlogHtmlJob (api)]], [[BlogStaticFilePublishingIntegration (api)]], [[Static Blog SEO Headers (article)]] | HTML statici, indici, landing e sitemap blog. |
| SEO | [[Public Sitemap (article)]], [[Superficie SEO Pubblica (concept)]], [[GenerateSeoSitemapJob (api)]] | Riferimenti sitemap blog e superficie indicizzabile. |
| Condivisione | [[SocialShareUrlIntegration (api)]], [[EntityShareComponent (web)]] | Link social negli HTML e copia link lato frontend. |
| Pubblicazione Facebook | [[Pubblicazione Social (concept)]], [[FacebookJob (api)]], [[FacebookGraphAPI (api)]] | Post Facebook con immagine e tabellino visuale. |

## Pattern

- La pipeline parte da partite FullTime e produce contenuti testuali, HTML, immagini e social post.
- Generazione contenuto e staticizzazione sono due fasi separate.
- I link di condivisione negli HTML statici sono distinti dalla pubblicazione server-side su Facebook.
- Il blog statico e parte della superficie SEO pubblica ma resta separato dal runtime Angular.
- Il flag `Blog.IsFacebookPosted` evita pubblicazioni duplicate secondo le pagine wiki.

## Gap noti

- Frequenze cron dei job non deducibili.
- Analytics specifici del blog statico e delle condivisioni non deducibili.
- Relazione tra job Instagram e pubblicazione social non completamente deducibile.
- Strategia editoriale manuale o revisione umana dei post blog non documentata.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`: [[Blog (concept)]], [[Pipeline Contenuti (concept)]], [[Pubblicazione Social (concept)]], [[Pubblicazione Blog Statico (workflow)]] e [[Static Blog SEO Headers (article)]]. Nessun RAW letto.
