# Next.js static/team redirect smoke - 2026-07-24

## Obiettivo

Ampliare la copertura ripetibile di `NXT-T021` sulle route statiche e sulle schede team migrate, riducendo il rischio di regressioni SEO/redirect nello switch da Angular a Next.js.

## Modifica

Esteso `src/RugbyRadioWebNext/scripts/smoke-http.mjs` con:

- route scheda team indicizzabili:
  - `/team/stefano`;
  - `/team/vox`.
- controllo 404 per una scheda team inesistente:
  - `/team/not-a-real-member`.
- redirect legacy pubblici dinamici:
  - `/g-match/smoke-match` -> `/matches/smoke-match`;
  - `/g-radio/smoke-match` -> `/radio/smoke-match`;
  - `/g-channel/smoke-channel` -> `/channels/smoke-channel`;
  - `/g-team/smoke-team` -> `/teams/smoke-team`.
- redirect statici Angular mancanti nello smoke:
  - `/assets/static/tutorial.html`;
  - `/assets/static/news.html`;
  - `/assets/static/how-to.html`;
  - `/assets/static/architecture.html`;
  - `/assets/static/team.html`;
  - `/team.html`;
  - `/team-stefano.html`;
  - `/assets/static/team-vox.html`.
- controllo sitemap anche per `/team/stefano` e `/team/vox`.

## Evidenza locale

- `node --check scripts\smoke-http.mjs`: passato.
- `SMOKE_PORT=3320 node scripts\smoke-http.mjs`: passato su porte 3320/3321.
- Scan statica con `rg -n "TODO|console\.log|any|React\." ... scripts\smoke-http.mjs`: nessun match.

## Limiti residui

- Non valida visualmente le pagine team.
- Non copre tutte le schede team una per una, ma verifica il pattern SSG con due slug rappresentativi e la sitemap.
- Non sostituisce la validazione su ambiente Cloudflare.
