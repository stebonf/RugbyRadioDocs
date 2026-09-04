---
type: qa-smoke-report
created: 2026-07-24T11:56:10+02:00
source: nextjs-parity-checklist
topic: "HTTP smoke parita route Next.js"
---

# HTTP smoke parita route Next.js

## Sintesi

Prima esecuzione tecnica della checklist QA `nextjs-parity-checklist.md` tramite `next start` locale e richieste HTTP.

Questa verifica conferma che le route canonical principali, alcune route tecniche e i redirect legacy rispondono con status/copy/location attesi. Non sostituisce QA browser visuale desktop/mobile, test interattivi client-side, sessioni auth reali, backend reale, PWA/FCM o TWA.

## Ambiente

- Data: 2026-07-24T11:56:10+02:00
- App: `src/RugbyRadioWebNext`
- Server: `.\node_modules\.bin\next.cmd start -p 3146`
- Build di riferimento: `.\node_modules\.bin\next.cmd build` passata, 47 pagine generate.
- Modalita maintenance: non attiva per questa matrice; maintenance mode dedicata validata in NXT-T019.

## Esito route canonical

| Route | Status atteso | Status rilevato | Controllo contenuto | Esito |
|---|---:|---:|---|---|
| `/` | 200 | 200 | `Rugby Radio` | Pass |
| `/login` | 200 | 200 | `Accedi` | Pass |
| `/register` | 200 | 200 | `Registr` | Pass |
| `/reset-password` | 200 | 200 | `password` | Pass |
| `/matches` | 200 | 200 | `Partite` | Pass |
| `/channels` | 200 | 200 | `Canali` | Pass |
| `/stats` | 200 | 200 | `Statistiche` | Pass |
| `/feedback` | 200 | 200 | `feedback` | Pass |
| `/why` | 200 | 200 | `Rugby` | Pass |
| `/tutorial` | 200 | 200 | `Rugby` | Pass |
| `/news` | 200 | 200 | `Rugby` | Pass |
| `/how-to` | 200 | 200 | `Rugby` | Pass |
| `/architecture` | 200 | 200 | `Rugby` | Pass |
| `/team` | 200 | 200 | `Team` | Pass |
| `/terms` | 200 | 200 | `Rugby` | Pass |
| `/blog` | 200 | 200 | `Blog` | Pass |
| `/design-system` | 200 | 200 | `Rugby Radio UI kit` | Pass |
| `/_maintenance` | 200 | 200 | `Manutenzione` | Pass |
| `/route-that-does-not-exist` | 404 | 404 | `Pagina non trovata` | Pass |

## Esito redirect legacy

| Legacy route | Status atteso | Status rilevato | Location attesa | Location rilevata | Esito |
|---|---:|---:|---|---|---|
| `/user-login` | 308 | 308 | `/login` | `/login` | Pass |
| `/user-registration` | 308 | 308 | `/register` | `/register` | Pass |
| `/user-reset-password` | 308 | 308 | `/reset-password` | `/reset-password` | Pass |
| `/g-matches` | 308 | 308 | `/matches` | `/matches` | Pass |
| `/g-channels` | 308 | 308 | `/channels` | `/channels` | Pass |
| `/g-stats` | 308 | 308 | `/stats` | `/stats` | Pass |
| `/g-feedback` | 308 | 308 | `/feedback` | `/feedback` | Pass |
| `/admin-maintenance` | 307 | 307 | `/_maintenance` | `/_maintenance` | Pass |
| `/adm-maintenance` | 307 | 307 | `/_maintenance` | `/_maintenance` | Pass |
| `/assets/static/why.html` | 308 | 308 | `/why` | `/why` | Pass |
| `/assets/static/terms.html` | 308 | 308 | `/terms` | `/terms` | Pass |

## Copertura

| Area checklist | Copertura con questo smoke | Residuo |
|---|---|---|
| Route canonical pubbliche/statiche | Parziale: status e contenuto base | Layout, mobile, metadata deep, stati API errore/empty reali |
| Redirect legacy principali | Parziale: 11 redirect verificati | Redirect dinamici con parametri reali e tutti gli asset statici legacy |
| 404 | Status e copy verificati | Browser/mobile visual |
| Maintenance | `/_maintenance` verificata in modo normale; mode on gia validato in NXT-T019 | Verifica preview/Cloudflare |
| Auth/account/studio | Non coperta da sessione reale | Sessione localStorage valida/scaduta e backend reale |
| PWA/FCM/TWA | Non coperta | Browser devtools e device |

## Conclusione

HTTP smoke passato su 30 controlli route/redirect. `NXT-T021` puo avanzare da `Ready` a `In progress`, ma non a `Done`: desktop/mobile, browser runtime, auth reale, backend reale e PWA/FCM restano pending.
