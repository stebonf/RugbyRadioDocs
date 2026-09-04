---
type: decision-record
created: 2026-07-23T21:38:00+02:00
source: tasklist-nextjs-tailwind-migration
topic: "Decisioni URL RugbyRadioWebNext"
---

# Decisioni URL RugbyRadioWebNext

## Decisione

La migrazione Next.js adotta URL piu moderni come canonical, mantenendo redirect dagli URL Angular legacy per non rompere link esistenti, social share, TWA e indicizzazione gia acquisita.

## Policy

- Le URL pubbliche Next sono SEO-first, leggibili e senza prefisso tecnico `g-`.
- Le URL utente usano prefisso `/account` o `/studio` in base al contesto.
- Le URL Angular legacy restano raggiungibili tramite redirect permanente dove il contenuto e equivalente.
- Le pagine auth e account restano `noindex`.
- Le pagine non trovate diventano 404 esplicito, non redirect silenzioso alla home.
- La maintenance page resta disponibile come route tecnica `/_maintenance`; gli alias legacy vengono reindirizzati.

## Matrice decisionale

| Angular route | Next canonical | Decisione | Note |
|---|---|---|---|
| `/` | `/` | keep | Home pubblica. |
| `/user-dashboard` | `/account` | redirect | Dashboard utente autenticato. |
| `/user-login` | `/login` | redirect | Preservare callback post-login. |
| `/user-registration` | `/register` | redirect | Auth pubblica, noindex. |
| `/user-reset-password` | `/reset-password` | redirect | Auth pubblica, noindex. |
| `/user-profile` | `/account/profile` | redirect | Route protetta. |
| `/user-danger` | `/account/danger` | redirect | Route protetta, conferma distruttiva. |
| `/user-favorites` | `/account/favorites` | redirect | Route protetta. |
| `/user-channels` | `/studio/channels` | redirect | Area cronista. |
| `/user-channel/:channelId` | `/studio/channels/:channelId` | redirect | Area cronista. |
| `/user-match/:matchId` | `/studio/matches/:matchId` | redirect | Workflow cronista critico. |
| `/g-channel/:channelPublicId` | `/channels/:channelPublicId` | redirect | Pagina pubblica SEO. |
| `/g-match/:matchId` | `/matches/:matchId` | redirect | Pagina pubblica SEO ad alto valore. |
| `/g-radio/:matchId` | `/radio/:matchId` | redirect | Pagina radio pubblica. |
| `/g-matches` | `/matches` | redirect | Lista pubblica. |
| `/g-channels` | `/channels` | redirect | Lista pubblica. |
| `/g-team/:teamId` | `/teams/:teamId` | redirect | Pagina pubblica SEO. |
| `/g-stats` | `/stats` | redirect | Pagina pubblica. |
| `/g-feedback` | `/feedback` | redirect | Pubblica/ibrida. |
| `/admin-maintenance` | `/_maintenance` | redirect | Tecnica, noindex. |
| `/adm-maintenance` | `/_maintenance` | redirect | Alias legacy. |

## Impatti

- `next.config.mjs` deve contenere redirect legacy.
- Metadata canonical devono puntare alle URL Next moderne.
- Sitemap e route statiche dovranno usare le URL moderne.
- QA parita deve testare sia canonical sia redirect legacy.
