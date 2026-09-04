---
type: task-evidence
created: 2026-07-24T13:10:38+02:00
source: tasklist-nextjs-tailwind-migration
topic: "Layout dettagli pubblici Next.js"
slug: nextjs-public-entity-layout-notes
tasks:
  - NXT-T012
---

# Layout dettagli pubblici Next.js

## Scopo

Ridurre il gap NXT-T012 su layout/interazioni delle route pubbliche entita, in particolare dettagli canale e squadra.

## Implementazione

- `/channels/[channelPublicId]`
  - Aggiunto header visuale con colori canale `headerBgColor/headerFtColor`.
  - Mostra owner/avatar quando disponibili.
  - Le card squadra includono logo normalizzato tramite helper `assetUrl()`.
  - La sezione partite canale mostra `ResultSummary` con intervallo e totale risultati.

- `/teams/[teamId]`
  - Aggiunto header squadra con logo, nickname, nome canale e CTA `Apri canale`.
  - Roster reso piu visivo con avatar giocatore o fallback numero.
  - La sezione partite squadra mostra `ResultSummary` con intervallo e totale risultati.

## Validazione

- `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`: passata, 47 pagine generate.
- `node scripts\smoke-http.mjs` con `SMOKE_PORT=3230`: passato, route/redirect/PWA/maintenance validati su porte 3230/3231.
- Scan statico `rg "TODO|console\.log|any|React\."` su `app`, `components`, `lib`, `types`, `middleware.ts` e service worker: nessun match.
- Scan sorgenti conferma `assetUrl`, `ResultSummary`, header canale, CTA canale e roster visuale.

## Residui

- Review visuale desktop/mobile resta pending.
- Validazione backend reale deve confermare presenza e formato di `ownerAvatar`, `logoUrl`, `avatarUrl`, `pageSize` e `totalItems`.
