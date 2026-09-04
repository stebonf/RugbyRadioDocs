---
type: rollout-plan
created: 2026-07-23T23:00:00+02:00
source: tasklist-nextjs-tailwind-migration
topic: "Rollout e rollback RugbyRadioWebNext"
---

# Piano rollout e rollback RugbyRadioWebNext

## Decisione di rilascio

Il primo rilascio passa a Next.js/Tailwind su Cloudflare con rendering server-side, URL canonical moderni e redirect permanenti dalle route Angular legacy. La TWA Android punta a Next nel primo rilascio, dopo verifica dedicata di PWA, asset links e notification click.

## Ambienti

| Ambiente | Scopo | Requisiti |
|---|---|---|
| Locale | Sviluppo e build iniziale | Dipendenze installate, `.\node_modules\.bin\next.cmd build` verde, `node scripts\smoke-http.mjs` verde, `.env.local` o `wrangler.toml` con API URL. |
| Preview Cloudflare | QA integrata | `cf:build`/OpenNext build, variabili ambiente, redirect, PWA, smoke route, noindex account/studio. |
| Produzione Cloudflare | Switch pubblico | Checklist parita approvata, monitoraggio attivo, rollback pronto. |
| Angular corrente | Rollback | Mantenere deploy precedente disponibile fino a stabilizzazione Next. |

## Checklist pre-switch

- Build Next verde in locale e preview Cloudflare.
- Smoke HTTP ripetibile verde: `node scripts\smoke-http.mjs`, includendo route canonical, 404, redirect legacy pubblici/autenticati, PWA/TWA, maintenance mode, guard shell account/studio e `noindex`.
- `next.config.mjs` con redirect legacy verificati, inclusi `/user-dashboard`, `/user-profile`, `/user-favorites`, `/user-danger`, `/user-channels`, `/user-channel/:id`, `/user-match/:id`.
- Sitemap e canonical puntano alle route moderne.
- Route auth/account/studio sono `noindex`.
- Sessione fase 1 localStorage testata con login, logout e token non valido.
- Home, liste pubbliche e dettaglio match/canale/team testati su desktop e mobile.
- Radio player e TTS testati con audio disponibile e audio assente.
- Manifest, assetlinks e service worker verificati da browser e device Android/TWA.
- Analytics, ads e logging non rompono il rendering se SDK o env sono assenti.

## Go/no-go

| Segnale | Go | No-go |
|---|---|---|
| Build/deploy | Build locale, smoke locale e Cloudflare verdi | Errori build, smoke o deploy non spiegati |
| Route pubbliche | Canonical e redirect principali validati | 404 o redirect errati su route SEO |
| Auth | Login e route protette funzionano; route account/studio anonime mostrano solo guard shell noindex | Sessione bloccata o dati sensibili visibili senza token |
| PWA/TWA | Manifest, asset links e notification click validati | TWA non apre o notifiche puntano a route rotte |
| UX mobile | Flussi spettatore/cronista usabili | Layout sovrapposti o azioni critiche non accessibili |
| Monitoraggio | Analytics/errori attivi | Nessuna osservabilita post-switch |

## Sequenza rollout

1. Congelare nuove feature Angular non necessarie allo switch.
2. Completare `nextjs-parity-checklist.md` sulle route canonical.
3. Eseguire `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`.
4. Eseguire `node scripts\smoke-http.mjs` da `src/RugbyRadioWebNext`; ultima evidenza locale: `nextjs-parity-auth-studio-http-smoke-2026-07-24.md`.
5. Verificare redirect legacy piu trafficati: `/g-match`, `/g-channel`, `/g-matches`, `/user-login`, piu legacy autenticati `/user-dashboard`, `/user-channels`, `/user-match/:id`.
6. Pubblicare preview Cloudflare con variabili ambiente non produzione o ambiente staging.
7. Eseguire QA mobile/TWA e smoke test PWA.
8. Validare login reale, account, canali studio e match studio con token valido/scaduto.
9. Aggiornare DNS/routing produzione verso Cloudflare Next.
10. Monitorare errori client, errori API, page views, bounce su route pubbliche e conversione login.
11. Tenere Angular pronto come fallback fino a chiusura finestra di stabilizzazione.

## Rollback

| Trigger | Azione |
|---|---|
| Build produzione non servibile | Ripristinare routing/DNS verso Angular precedente. |
| Redirect SEO critici errati | Rollback routing e correggere `next.config.mjs` in preview. |
| Login o account non funzionanti | Rollback se impatta utenti reali; altrimenti hotfix se circoscritto. |
| Guard account/studio espone dati senza token | Rollback immediato o maintenance mode, poi hotfix auth. |
| TWA non apre route pubbliche | Rollback TWA o routing pubblico in base a impatto. |
| Errori API diffusi | Verificare env API; rollback se il problema e nel frontend Next. |

## Monitoraggio post-switch

- Errori runtime client e server-side.
- 404 per route legacy e route canonical.
- Traffico su `/matches`, `/channels`, `/matches/:matchId`, `/channels/:channelPublicId`.
- Login success/fail e callback post-login.
- Eventi radio/audio: play, errore audio, audio non disponibile.
- Metriche PWA/TWA: apertura da app, notification click, asset links.

## Stato corrente

Rollout non ancora avviabile in produzione, ma non piu bloccato dalla build locale.

Evidenze disponibili:

- Build locale Next verde con `.\node_modules\.bin\next.cmd build`.
- Smoke HTTP ripetibile verde con `node scripts\smoke-http.mjs` su porte 3292/3293, coprendo route canonical/tecniche, guard shell account/studio con `noindex`, redirect legacy pubblici e autenticati, PWA/TWA e maintenance mode.
- `wrangler.toml` e script `cf:*` presenti.

Blocchi residui prima dello switch:

- Preview/deploy Cloudflare non validati.
- QA browser desktop/mobile non completata.
- Login reale, token valido/scaduto, account/studio con backend reale non completati.
- PWA installabilita, push FCM reale e Android TWA non completati.
