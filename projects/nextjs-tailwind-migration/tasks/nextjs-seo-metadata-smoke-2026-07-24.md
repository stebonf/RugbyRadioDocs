# Next.js SEO metadata smoke - 2026-07-24

## Obiettivo

Rendere piu forte la copertura QA di `NXT-T021` verificando nello smoke HTTP anche i canonical generati da Next.js per le route principali, oltre a status, copy, redirect, PWA e noindex.

## Modifica

Esteso `src/RugbyRadioWebNext/scripts/smoke-http.mjs` con:

- campo `canonical` per le route pubbliche canonical:
  - `/`;
  - `/matches`;
  - `/channels`;
  - `/stats`;
  - `/feedback`;
  - `/why`;
  - `/tutorial`;
  - `/news`;
  - `/how-to`;
  - `/architecture`;
  - `/team`;
  - `/terms`;
  - `/blog`.
- campo `canonical` anche sulle guard shell noindex dove il metadata e dichiarato:
  - `/login`;
  - `/register`;
  - `/reset-password`;
  - `/account*`;
  - `/studio*`.
- controllo `robots` piu esplicito sulle pagine noindex: lo smoke ora richiede sia il meta `name="robots"` sia `noindex`.

## Evidenza locale

- `node --check scripts\smoke-http.mjs`: passato.
- `SMOKE_PORT=3310 node scripts\smoke-http.mjs`: passato su porte 3310/3311.
- Scan statica con `rg -n "TODO|console\.log|any|React\." ... scripts\smoke-http.mjs`: nessun match.

## Limiti residui

- La build applicativa non e stata rilanciata in questo incremento perche la modifica riguarda solo lo script smoke; la build era gia passata sullo stesso codice Next.js applicativo.
- Non copre ancora metadata dinamici con payload backend reali per match, canali, team, blog e radio.
- Non sostituisce QA visuale desktop/mobile o validazione su deploy Cloudflare.
