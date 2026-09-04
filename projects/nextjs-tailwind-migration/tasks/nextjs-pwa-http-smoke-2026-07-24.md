---
type: qa-smoke-report
created: 2026-07-24T12:05:07+02:00
source: tasklist-nextjs-tailwind-migration
topic: "HTTP smoke PWA, TWA, SEO technical routes"
---

# HTTP smoke PWA/TWA Next.js

## Sintesi

Validazione tecnica locale delle superfici PWA/TWA/SEO di `src/RugbyRadioWebNext`.

La verifica copre manifest, icone PWA, Digital Asset Links, Firebase messaging service worker, robots e sitemap tramite `next start` locale. Non sostituisce test browser DevTools, installabilita reale, ricezione push FCM, Android TWA o deploy Cloudflare.

## Ambiente

- Data: 2026-07-24T12:05:07+02:00
- App: `src/RugbyRadioWebNext`
- Server: `.\node_modules\.bin\next.cmd start -p 3149`
- Build di riferimento: `.\node_modules\.bin\next.cmd build` passata, 47 pagine generate.

## Fix eseguiti prima dello smoke

- Copiate 12 icone PWA da `src/RugbyRadioWeb/src/assets/icons` a `src/RugbyRadioWebNext/public/assets/icons`.
- Aggiornato `app/manifest.ts` con `gcm_sender_id` e `launch_handler.client_mode` equivalente al manifest Angular, usando forma typed compatibile con Next.
- Confermato che Digital Asset Links e servito da route statica `app/.well-known/assetlinks.json/route.ts`, non da file `public`.

## Esito controlli

| Controllo | Esito |
|---|---|
| `/manifest.webmanifest` status 200 | Pass |
| Manifest `display=standalone` | Pass |
| Manifest `gcm_sender_id=891639843656` | Pass |
| Manifest `launch_handler.client_mode` contiene `auto` e `focus-existing` | Pass |
| Manifest contiene 12 icone | Pass |
| `/.well-known/assetlinks.json` status 200 | Pass |
| Assetlinks package `com.rugbyradiolive.www.twa` | Pass |
| `/firebase-messaging-sw.js` status 200 | Pass |
| Service worker apre route Next `/matches/:matchId` | Pass |
| `/robots.txt` status 200 | Pass |
| Robots disallow include maintenance route | Pass |
| `/sitemap.xml` status 200 | Pass |
| Sitemap include route pubblica `/matches` | Pass |
| `/assets/icons/192.png` status 200 e dimensione > 1000 byte | Pass |
| `/assets/icons/512.png` status 200 e dimensione > 1000 byte | Pass |
| `/assets/icons/1024.png` status 200 e dimensione > 1000 byte | Pass |

## Residuo

- Verifica installabilita in browser DevTools.
- Registrazione reale service worker nel browser.
- Richiesta permesso notifiche.
- Ottenimento token FCM con VAPID key.
- Sincronizzazione token con backend reale.
- Ricezione push foreground/background.
- Verifica Android TWA/device.
- Verifica deploy Cloudflare per header, cache e routing.

## Conclusione

NXT-T020 avanza: la superficie tecnica PWA/TWA esposta via HTTP e coerente e validata localmente. Installabilita, push reale e TWA restano pending perche richiedono browser/device/backend/deploy.
