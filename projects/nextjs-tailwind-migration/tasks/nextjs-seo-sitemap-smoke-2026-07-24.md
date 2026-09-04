# Next.js SEO sitemap smoke - 2026-07-24

## Obiettivo

Rafforzare lo smoke HTTP della migrazione Next.js/Tailwind con controlli SEO automatici su `robots.txt` e `sitemap.xml`, in particolare per verificare che le route protette o noindex non finiscano nella sitemap pubblica.

## Modifica

- Esteso `src/RugbyRadioWebNext/scripts/smoke-http.mjs` con una whitelist di URL pubbliche attese in sitemap:
  - home;
  - `/matches`;
  - `/channels`;
  - `/stats`;
  - `/blog`;
  - `/team`.
- Aggiunta una denylist di URL che non devono comparire in sitemap:
  - `/account`;
  - `/account/profile`;
  - `/studio`;
  - `/studio/channels`;
  - `/login`;
  - `/register`;
  - `/reset-password`;
  - `/_maintenance`;
  - `/maintenance`;
  - `/design-system`.
- Reso piu esplicito il controllo di `robots.txt`, verificando i `Disallow` per account, studio, auth, maintenance e design-system.

## Evidenza locale

- `node --check scripts\smoke-http.mjs`: passato.
- `.\node_modules\.bin\next.cmd build`: passato.
- `SMOKE_PORT=3300 node scripts\smoke-http.mjs`: passato su porte 3300/3301.
- Scan statica con `rg -n "TODO|console\.log|any|React\." ... scripts\smoke-http.mjs`: nessun match.

## Limiti residui

- Non sostituisce la QA browser desktop/mobile.
- Non valida la preview Cloudflare o la sitemap servita da ambiente deployato.
- Non valida metadata dinamici deep con dati backend reali.
