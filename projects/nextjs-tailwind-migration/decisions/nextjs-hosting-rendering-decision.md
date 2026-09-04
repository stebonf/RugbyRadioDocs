---
type: decision-record
created: 2026-07-23T21:38:00+02:00
source: tasklist-nextjs-tailwind-migration
topic: "Hosting e rendering RugbyRadioWebNext"
---

# Hosting e rendering RugbyRadioWebNext

## Decisione

`RugbyRadioWebNext` usa Next.js con rendering server-side e target operativo Cloudflare.

## Strategia iniziale

- Runtime target: Cloudflare, tramite OpenNext Cloudflare quando verra configurata la pipeline di deploy.
- Build locale minima: `next build`.
- Deploy script previsto: `opennextjs-cloudflare build` e `opennextjs-cloudflare deploy`.
- Rendering: SSR per default, con client components solo per stato browser, auth localStorage, analytics, ads, audio e FCM.
- Statiche/blog: diventano route Next, non asset HTML separati, con migrazione progressiva.

## Classificazione route

| Area | Rendering | Motivazione |
|---|---|---|
| Home e liste pubbliche | SSR | SEO, metadata e contenuto crawlable. |
| Pagine pubbliche dettaglio | SSR | Canonical/social preview e contenuto indicizzabile. |
| Auth pubblica | SSR shell + client form | Noindex, ma caricamento rapido e form client. |
| Account/studio | SSR shell + client auth guard fase 1 | Token in localStorage impedisce auth affidabile server-side nell'MVP. |
| Radio/audio | SSR shell + client player | Audio, queue e storage sono browser-only. |
| Design system demo | SSR/static | Documentazione interna del DS. |

## Vincoli

- La fase 1 usa localStorage per compatibilita col backend attuale.
- Le route protette non devono renderizzare dati sensibili server-side finche auth resta localStorage.
- Cloudflare deployment richiedera una verifica dedicata dopo il primo build locale.
