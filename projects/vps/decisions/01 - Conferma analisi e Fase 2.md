# 01 - Conferma analisi e Fase 2

## Data

2026-09-05

## Decisioni confermate

- Partire da `src/RugbyRadio/Api` come prima applicazione da containerizzare.
- Tenere `src/RugbyRadioWeb` fuori dalla VPS perche' resta su Firebase Hosting.
- Trattare `src/RugbyRadioSitemap` come componente statico SEO/sitemap, da sistemare piu' avanti.
- Non toccare ancora PostgreSQL, Hangfire, Blog, Storage, DNS o CI.

## Scope operativo autorizzato

- Containerizzazione minima dell'API.
- Build/startup/config/logging in Docker locale.
- Nessuna modifica architetturale oltre allo stretto necessario per rendere configurabile lo startup container.
