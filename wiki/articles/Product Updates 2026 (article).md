---
title: "Product Updates 2026 (article)"
type: article
layer: articles
---

# Product Updates 2026 (article)

## Sintesi
Raccolta degli aggiornamenti prodotto documentati nei RAW dev per il 2026.

## Scope
Aggiornamenti funzionali, UI, analytics e monetizzazione descritti nei file mensili.

## Componenti coinvolti
- [[GChannelsPage (web)]]
- [[AnalyticsService (web)]]
- [[AdSense Placements 2026-05 (analytic)]]
- [[Rugby Radio Live (architecture)]]

## Relazioni principali
- Gennaio 2026: card Radio in `g-channels` aggiornate con lastMatchDate e nextMatchDate.
- Marzo 2026: layout rifatto, template vecchio rimosso, Bootstrap e nz rimossi, CSS custom e revisione mobile.
- Marzo 2026: script GA inserito su ogni pagina; introdotto Sentry per gestione errori.
- Maggio 2026: nuovi annunci AdSense.
- Maggio 2026: `sitemap.xml` incluso nel deploy Firebase come `sitemapindex` per ridurre anomalie GSC legate ai redirect.
- Fine maggio 2026: aggiunta pagina statica `architecture.html` per raccontare l'architettura di RRL; banner pubblicitario `PAGE-ARCHITECTURE: 4750353703`.
- Fine maggio 2026: Sentry introdotto anche lato API per tracciare anomalie; RAW cita bug fixing collegato a segnalazioni Sentry.
- Giugno 2026: allineamento AdSense blog statico su slot unico `BLOG-HOME: 6223722056` per home, landing, indici paginati e pagine match/post ([[AdSense Blog Alignment 2026-06 (analytic)]]).

## Decisioni architetturali
Il RAW indica migrazione verso CSS custom e componenti mobile-oriented; il RAW SEO di maggio indica anche una scelta operativa di pubblicare la sitemap root direttamente dal deploy Firebase.

## Rischi
Dettaglio dei bug corretti, configurazione Sentry API e implementazione del banner architecture non deducibili dai RAW.

## Note
Fonti: `rrl-202601.md`, `rrl-202603.md`, `rrl-202605.md`, `rrl-202605-seo.md`, `rrl-202605-arch.md`, `rrl-2026-06.md`.
