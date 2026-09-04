---
type: qa-checklist
created: 2026-07-23T23:00:00+02:00
source: tasklist-nextjs-tailwind-migration
topic: "QA parita Angular Next.js Tailwind"
---

# QA parita Angular/Next.js

## Obiettivo

Checklist operativa per verificare che `src/RugbyRadioWebNext` raggiunga parita funzionale, SEO e UX con `src/RugbyRadioWeb` prima dello switch a Cloudflare.

## Regole di esecuzione

- Testare sempre route canonical Next e redirect Angular legacy.
- Testare desktop e mobile per ogni route pubblica o operativa.
- Per le route pubbliche controllare metadata, canonical, contenuto crawlable e stato API vuoto/errore.
- Per le route protette controllare utente non autenticato, sessione localStorage valida e token scaduto/non valido.
- Annotare gap e regressioni nel campo esito prima di considerare una route `Done`.

## Matrice route

| Area | Angular legacy | Next canonical | Desktop | Mobile | Auth | API/data | SEO | Stati minimi | Esito |
|---|---|---|---|---|---|---|---|---|---|
| Home | `/` | `/` | Pending | Pending | Ibrido | Pending | Pending | loading, empty, errore, liste dati | Pending |
| Login | `/user-login` | `/login` | Pending | Pending | Pubblico | Pending | Noindex | valido, invalido, callback | Pending |
| Registrazione | `/user-registration` | `/register` | Pending | Pending | Pubblico | Pending | Noindex | validazioni, success, errore | Pending |
| Reset password | `/user-reset-password` | `/reset-password` | Pending | Pending | Pubblico | Pending | Noindex | richiesta OTP, reset, errore | Pending |
| Account | `/user-dashboard` | `/account` | Pending | Pending | Auth | Pending | Noindex | non loggato, logged-in | Pending |
| Profilo | `/user-profile` | `/account/profile` | Pending | Pending | Auth | Pending | Noindex | load, update, errore | Pending |
| Preferiti | `/user-favorites` | `/account/favorites` | Pending | Pending | Auth | Pending | Noindex | lista vuota, lista dati, errore | Pending |
| Danger | `/user-danger` | `/account/danger` | Pending | Pending | Auth | Pending | Noindex | conferma, annulla, delete error | Pending |
| Canali studio | `/user-channels` | `/studio/channels` | Pending | Pending | Auth | Pending | Noindex | lista, empty, errore | Pending |
| Canale studio | `/user-channel/:channelId` | `/studio/channels/:channelId` | Pending | Pending | Auth | Pending | Noindex | owner, non owner, tabs | Pending |
| Match studio | `/user-match/:matchId` | `/studio/matches/:matchId` | Pending | Pending | Auth | Pending | Noindex | eventi, lineup, blog, audio | Pending |
| Lista match | `/g-matches` | `/matches` | Pending | Pending | Pubblico | Pending | Pending | search, pagination, empty, errore | Pending |
| Match pubblico | `/g-match/:matchId` | `/matches/:matchId` | Pending | Pending | Ibrido | Pending | Pending | not found, eventi, interazioni | Pending |
| Radio match | `/g-radio/:matchId` | `/radio/:matchId` | Pending | Pending | Ibrido | Pending | Pending | play, stop, audio assente, errore | Pending |
| Lista canali | `/g-channels` | `/channels` | Pending | Pending | Pubblico | Pending | Pending | search, pagination, empty, errore | Pending |
| Canale pubblico | `/g-channel/:channelPublicId` | `/channels/:channelPublicId` | Pending | Pending | Ibrido | Pending | Pending | not found, follow, tabs | Pending |
| Team pubblico | `/g-team/:teamId` | `/teams/:teamId` | Pending | Pending | Pubblico | Pending | Pending | not found, stats, match vuoti | Pending |
| Statistiche | `/g-stats` | `/stats` | Pending | Pending | Pubblico | Pending | Pending | dati, empty, errore | Pending |
| Feedback | `/g-feedback` | `/feedback` | Pending | Pending | Ibrido | Pending | Pending | validazioni, success, errore | Pending |
| Why | `/assets/static/why.html` | `/why` | Pending | Pending | Pubblico | Static | Pending | contenuto, redirect | Pending |
| Tutorial | `/assets/static/tutorial.html` | `/tutorial` | Pending | Pending | Pubblico | Static | Pending | contenuto, redirect | Pending |
| News | `/assets/static/news.html` | `/news` | Pending | Pending | Pubblico | Static | Pending | contenuto, redirect | Pending |
| How-to | `/assets/static/how-to.html` | `/how-to` | Pending | Pending | Pubblico | Static | Pending | contenuto, redirect | Pending |
| Architettura | `/assets/static/architecture.html` | `/architecture` | Pending | Pending | Pubblico | Static | Pending | contenuto, redirect | Pending |
| Team | `/assets/static/team.html` | `/team` | Pending | Pending | Pubblico | Static | Pending | contenuto, redirect | Pending |
| Termini | `/assets/static/terms.html` | `/terms` | Pending | Pending | Pubblico | Static | Pending | contenuto, redirect | Pending |
| Maintenance | `/admin-maintenance` | `/_maintenance` | Pending | Pending | Maintenance | N/A | Noindex | alias, mobile | Pending |
| 404 | `**` | `not-found` | Pending | Pending | Pubblico | N/A | 404 | URL inesistente | Pending |

## Verifica tecnica minima

- `pnpm install` o `npm install` completato senza errori.
- `pnpm build` o `npm run build` da `src/RugbyRadioWebNext`.
- Smoke test manuale delle route canonical.
- Smoke test redirect legacy principali.
- Browser devtools: manifest PWA, service worker, no errori runtime evidenti.
- Controllo mobile: header, form, card, tabs, pagination e radio player.

## Stato corrente

Prima esecuzione tecnica parziale completata: `next start` locale ha validato status/copy/location per 19 route canonical/tecniche e 11 redirect legacy. Report: `projects/nextjs-tailwind-migration/tasks/nextjs-parity-http-smoke-2026-07-24.md`.

Smoke ripetibile esteso: `src/RugbyRadioWebNext/scripts/smoke-http.mjs` valida anche guard shell e `noindex` per `/account*` e `/studio*`, canonical metadata per route pubbliche/noindex principali, schede team SSG rappresentative, redirect legacy autenticati/pubblici/statici, noindex di design-system/maintenance, `robots.txt` e l'esclusione da `sitemap.xml` di account, studio, auth, maintenance e design-system. Ultime evidenze: `projects/nextjs-tailwind-migration/tasks/nextjs-parity-auth-studio-http-smoke-2026-07-24.md`, `projects/nextjs-tailwind-migration/tasks/nextjs-seo-sitemap-smoke-2026-07-24.md`, `projects/nextjs-tailwind-migration/tasks/nextjs-seo-metadata-smoke-2026-07-24.md` e `projects/nextjs-tailwind-migration/tasks/nextjs-static-team-redirect-smoke-2026-07-24.md`, passato con `SMOKE_PORT=3320` su porte 3320/3321.

Restano pending:

- QA visuale desktop e mobile;
- sessione auth localStorage valida/scaduta;
- interazioni client-side;
- backend reale;
- metadata deep per tutte le route;
- PWA, FCM e TWA.
