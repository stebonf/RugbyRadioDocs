---
title: "Mappatura SEO e Analytics (comparison)"
type: comparison
layer: comparisons
---

# Mappatura SEO e Analytics (comparison)

## Sintesi

Confronto tra superficie SEO pubblica, contenuti indicizzabili e report analytics documentati nella wiki, con lo scopo di chiarire quali pagine o sistemi producono visibilita organica, misurazione traffico e monetizzazione.

## Scope

Include sitemap, header SEO, contenuti statici, report Search Console, report Google Analytics/Firebase e report AdSense gia presenti nella wiki. Non include dati grezzi non canonici o metriche non formalizzate come pagine wiki.

## Mappatura

### Superficie indicizzabile

| Superficie | Pagine o sistemi collegati | Osservabilita documentata |
|---|---|---|
| Sitemap pubblica | [[Public Sitemap (article)]], [[GenerateSeoSitemapJob (api)]], [[SeoUrlInventoryService (api)]], [[SitemapXmlWriter (api)]] | [[Search Console Index Coverage 2026-05 (analytic)]], [[Search Console Performance 2026-06 (analytic)]] |
| Blog statico | [[Static Blog SEO Headers (article)]], [[CreateMatchBlogHtmlJob (api)]], [[Pubblicazione Blog Statico (workflow)]], [[Blog (concept)]] | Search Console documenta performance, copertura e pagine blog con impressioni. |
| Pagine pubbliche Angular | [[GMatchesPage (web)]], [[GChannelsPage (web)]], [[GTeamPage (web)]], [[GMatchPage (web)]], [[HomePage (web)]] | [[Google Analytics Traffic 2026-01 2026-06 (analytic)]], [[Search Console Performance 2026-06 (analytic)]] |
| Pagine statiche editoriali | [[Meet the Team (article)]], [[Product Updates 2026 (article)]], [[Static Blog SEO Headers (article)]] | [[Google Analytics Traffic 2026-01 2026-06 (analytic)]] cita traffico su Meet the Team. |

### Report analytics

| Report | Fonte logica | Uso nella wiki |
|---|---|---|
| [[Search Console Performance 2026-04 (analytic)]] | Performance organica Search Console | Query, click, impressioni, device e pagine organiche. |
| [[Search Console Performance 2026-06 (analytic)]] | Performance organica Search Console | Conferma domanda su live rugby commentary e mostra pagine con impressioni senza clic. |
| [[Search Console Index Coverage 2026-04 (analytic)]] | Copertura Search Console | Problemi di indicizzazione e canonical nel periodo aprile. |
| [[Search Console Index Coverage 2026-05 (analytic)]] | Copertura Search Console | Canonical, redirect, duplicati, pagine scansionate non indicizzate e backlink profile. |
| [[Google Analytics Traffic 2026-01 2026-06 (analytic)]] | GA/Firebase | Utenti attivi, nuovi utenti, engagement e pagine principali. |
| [[AdSense Performance 2026-01 2026-06 (analytic)]] | AdSense | Earnings, impressions, click e richieste pubblicitarie. |
| [[AdSense Placements 2026-05 (analytic)]] | AdSense placement | Mappa slot annunci su pagine pubbliche, globali, statiche e blog. |

## Pattern

- [[Superficie SEO Pubblica (concept)]] collega sitemap, blog statico, metadata runtime e report Search Console.
- [[Public Sitemap (article)]] descrive la scoperta URL; i report Search Console descrivono indicizzazione e rendimento organico.
- [[Google Analytics Traffic 2026-01 2026-06 (analytic)]] misura traffico e coinvolgimento, ma non dimostra causalita tra modifiche tecniche e andamento organico.
- [[Monetizzazione (monetization)]] usa report AdSense e placement per documentare copertura annunci e performance economica.
- [[Meet the Team (article)]] rappresenta una superficie editoriale pubblica collegata sia a SEO/header sia a traffico GA.

## Gap noti

- Workflow analytics specifici non deducibili dalle pagine wiki.
- Conversioni da visita organica a registrazione, follow, commento o monetizzazione non deducibili.
- Causalita tra sitemap/header/contenuti e metriche Search Console o GA non deducibile.
- Obiettivi KPI formali per SEO, traffico e monetizzazione non documentati nella wiki.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`: analytics, articoli SEO/statici, concept SEO, monetizzazione e pagine frontend pubbliche gia canoniche. Nessun RAW letto.
