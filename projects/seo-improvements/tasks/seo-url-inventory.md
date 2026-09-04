# SEO URL INVENTORY

## Scope

Inventario delle URL pubbliche SEO rilevanti di Rugby Radio Live.

Obiettivo:

- definire quali URL sono indicizzabili
- definire canonical URL
- definire ownership tecnica
- definire strategia sitemap
- definire fonte `lastmod`

Dominio canonico:

https://rugbyradiolive.com

Documento correlato:

seo-indexability-policy.md

---

## URL Inventory

| URL Pattern            | Public | Indexable   | Canonical | Sitemap Target | LastMod Source | Owner | Notes |
|------------------------|--------|-------------|-----------|----------------|----------------|-------|-------|
| /                      | YES    | YES         | self | sitemap-static.xml | frontend deploy/build date | Frontend | Homepage |
| /g-matches             | YES    | YES         | self | sitemap-static.xml | frontend deploy/build date | Frontend | Public matches list |
| /g-channels            | YES    | YES         | self | sitemap-static.xml | frontend deploy/build date | Frontend | Public channels list |
| /g-stats               | YES    | YES         | self | sitemap-static.xml | frontend deploy/build date | Frontend | Public statistics |
| /g-feedback            | YES    | NO          | self + noindex | none | n/a | Frontend | Utility page |
| /user-login            | YES    | NO          | self + noindex | none | n/a | Frontend | Utility/auth |
| /user-registration     | YES    | NO          | self + noindex | none | n/a | Frontend | Utility/auth |
| /user-reset-password   | YES    | NO          | self + noindex | none | n/a | Frontend | Utility/auth |
| /user-*                | NO     | NO          | none | none | n/a | Frontend | Private area |
| /g-match/{matchId}     | YES    | CONDITIONAL | self | sitemap-matches.xml | match updated date | Backend | Subject to SEO indexability policy |
| /g-channel/{channelId} | YES    | YES         | self | sitemap-channels.xml | channel updated date | Backend | Public channel detail |
| /g-team/{teamId}       | YES    | YES    | self        | sitemap-teams.xml | team updated date | Backend | Public team detail |

---

## Static Content Pages

NOTA:
Questa sezione assume URL SEO-friendly pulite.
Se oggi usi ancora /assets/static/*.html, queste vanno considerate target futuri.

| URL Pattern | Public | Indexable | Canonical | Sitemap Target | LastMod Source | Owner | Notes |
|------------|--------|-----------|-----------|----------------|----------------|-------|-------|
| /tutorial | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | Tutorial page |
| /how-to | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | How it works |
| /news | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | Platform news |
| /why | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | Why Rugby Radio Live |
| /team | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | Meet the Team |
| /team-stefano.html | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | Founder profile |
| /team-vox.html | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | AI-Talker profile |
| /team-nitro.html | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | AI-Talker profile |
| /team-beat-breaker.html | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | AI-Talker profile |
| /team-orfeo.html | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | AI-Talker profile |
| /team-zoe.html | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | AI-Talker profile |
| /team-maul.html | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | AI-Talker profile |
| /team-zorblax.html | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | AI-Talker profile |
| /team-elixir.html | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | AI-Talker profile |
| /team-bulldog.html | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | AI-Talker profile |
| /team-el-mangiapolenta.html | YES | NO | self | none | static file modified date | Frontend | Hidden AI-Talker profile |
| /team-trasteverino.html | YES | NO | self | none | static file modified date | Frontend | Hidden AI-Talker profile |
| /team-newsly.html | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | AI-Talker profile |
| /team-brushy.html | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | AI-Talker profile |
| /terms | YES | YES | self | sitemap-static.xml | static file modified date | Frontend | Legal page |

---

## Legacy Static URLs

Durante transizione, mantenere raggiungibili ma canonicalizzare verso URL pulite.

| Legacy URL | Canonical Target |
|-----------|------------------|
| /assets/static/tutorial.html | /tutorial |
| /assets/static/how-to.html | /how-to |
| /assets/static/news.html | /news |
| /assets/static/why.html | /why |
| /assets/static/team.html | /team |

---

## Blog URLs

| URL Pattern | Public | Indexable | Canonical | Sitemap Target | LastMod Source | Owner | Notes |
|------------|--------|-----------|-----------|----------------|----------------|-------|-------|
| https://blog.rugbyradiolive.com/{lang}/{slug} | YES | YES | self | blog sitemap | blog generation date | HF Job | Static SEO content |
| https://blog.rugbyradiolive.com/ | YES | YES | self | blog sitemap | blog generation date | HF Job | Blog index |

Blog rules:

- lowercase URLs only
- valid canonical
- hreflang between language variants
- backlink verso `/g-match/{matchId}`

---

## URL Exclusions

Mai includere in sitemap:

- /user-*
- pagine autenticazione
- pagine utility
- risorse private
- route di test
- route debug
- route temporanee
- error pages

---

## Canonical Rules

Global rules:

- dominio canonico sempre https://rugbyradiolive.com
- no www
- no http duplicate
- no /index.html
- no uppercase URLs
- evitare duplicati con trailing slash

Dynamic rules:

- ogni pagina pubblica canonicalizza verso sé stessa
- pagine escluse possono avere canonical self + noindex

---

## Sitemap Strategy

Sitemap root:

/sitemap.xml

Sitemap sezionali:

/sitemap-static.xml
/sitemap-matches.xml
/sitemap-channels.xml
/sitemap-teams.xml

Blog sitemap:

https://blog.rugbyradiolive.com/sitemap.xml

---

## Source Of Truth

Questo documento guida:

- SeoPublicUrl
- SeoUrlInventoryService
- GenerateSeoSitemapJob
- SEO metadata implementation
