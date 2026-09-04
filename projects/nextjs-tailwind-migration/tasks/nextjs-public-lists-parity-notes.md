---
type: task-evidence
created: 2026-07-24T13:03:16+02:00
source: tasklist-nextjs-tailwind-migration
topic: "Parita liste pubbliche Next.js"
slug: nextjs-public-lists-parity-notes
tasks:
  - NXT-T011
---

# Parita liste pubbliche Next.js

## Scopo

Ridurre il gap NXT-T011 tra `GMatchesPage` / `GChannelsPage` Angular e le route canonical Next `/matches` e `/channels`.

## Implementazione

- `/matches` mantiene ricerca GET con query `q`, aggiunge filtro stato `status` e lo passa a `findPublicMatches(text, page, status)`, allineato al supporto `MTC-11`.
- Il filtro stato espone: tutti, live `20`, programmate `10`, intervallo `25`, concluse `30`.
- La paginazione conserva `q` e `status`, rendendo link pagina precedente/successiva condivisibili e SEO-friendly.
- `/matches` e `/channels` mostrano riepilogo risultati `Risultati start-end di totalItems`, equivalente al feedback paginazione Angular.
- Empty state e alert restano reali e dipendono dalla risposta API, senza dati demo.

## Validazione

- `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`: passata, 47 pagine generate.
- `node scripts\smoke-http.mjs` con `SMOKE_PORT=3220`: passato, route/redirect/PWA/maintenance validati su porte 3220/3221.
- Scan statico `rg "TODO|console\.log|any|React\."` su `app`, `components`, `lib`, `types`, `middleware.ts` e service worker: nessun match.
- Scan sorgenti conferma `parseStatus`, select stato, `ResultSummary` e `Pagination params={{ status }}`.

## Residui

- Review visuale desktop/mobile resta pending.
- Validazione con backend reale deve confermare semantica dei filtri stato e conteggi `totalItems/pageSize`.
