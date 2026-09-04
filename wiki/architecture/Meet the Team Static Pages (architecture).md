---
title: "Meet the Team Static Pages (architecture)"
type: architecture
layer: architecture
---

# Meet the Team Static Pages (architecture)

## Sintesi
Architettura proposta per pubblicare Meet the Team come contenuto statico frontend, con index `/team` e dettagli membro `/team-{slug}.html`.

## Scope
La soluzione riguarda solo frontend web, hosting statico, SEO, analytics e monetizzazione. Sono fuori scope database, API backend, job di generazione eventi, logica AI realtime e nuove funzionalita di scelta Talker nella partita.

## Componenti coinvolti
- [[Meet the Team (article)]]
- [[AI-Talker (concept)]]
- [[Static Blog SEO Headers (article)]]
- [[Public Sitemap (article)]]
- [[SeoMetadataService (web)]]
- [[AdSense Performance 2026-01 2026-06 (analytic)]]

## Relazioni principali
- `src/RugbyRadioWeb/src/assets/static/team.html` contiene la pagina index.
- I dettagli membro sono file statici `team-*.html` pubblicati alla root del build.
- Firebase Hosting deve riscrivere `/team` verso `/team.html`.
- Non sono previsti redirect o alias per `/ai-talkers`.
- I link interni osservati verso `assets/static/ai-talkers.html` devono essere sostituiti con `/team`.

## Decisioni architetturali
- Mantenere le sorgenti HTML sotto `src/RugbyRadioWeb/src/assets/static/` per continuita con pagine statiche esistenti.
- Aggiungere un asset glob `team*.html` con output `/` per servire i dettagli alla root.
- Usare `static-common.css`, `static-common.js` e footer statico condiviso.
- Estendere il tracking statico con eventi `team_member_click`, `team_video_play`, `team_discovery_click` e `team_social_click` basati su attributi `data-*`.
- Usare slot AdSense `2308901507` per index e dettagli.

## Rischi
- Le pagine statiche manuali possono duplicare contenuti editoriali se non sostenute da una struttura dati locale.
- La rimozione pura di `/ai-talkers` puo creare link rotti se i riferimenti interni non vengono aggiornati.
- Structured data avanzati oltre `Person` e `ProfilePage` sono rimandati.

## Note
Fonte: `llm-wiki/raw/analysis/architettura-meet-team.md`.
