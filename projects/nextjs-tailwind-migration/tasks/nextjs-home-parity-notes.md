---
type: task-evidence
created: 2026-07-24T12:56:56+02:00
source: tasklist-nextjs-tailwind-migration
topic: "Parita home Next.js"
slug: nextjs-home-parity-notes
tasks:
  - NXT-T010
---

# Parita home Next.js

## Scopo

Ridurre il gap NXT-T010 tra `HomeComponent` Angular e la route Next `/`, mantenendo dati reali da API e riportando le sezioni editoriali principali della home Angular.

## Sezioni migrate

| Sezione Angular | Stato Next |
|---|---|
| `home-logo` | Hero Next con logo reale da storage, CTA login e partite. |
| `home-who` | Sezione destinatari con due card e immagini `who1.webp` / `who4.webp`. |
| `home-ongoing-matches` / `home-next-matches` / `home-last-matches` | Blocco partite in evidenza alimentato da `getOngoingMatches()` con fallback `findPublicMatches()`. |
| `home-last-channels` | Blocco canali pubblici alimentato da `findPublicChannels()`. |
| `home-features` | Quattro feature da catalogo Angular `Site.Home.lblSection*`. |
| `home-help` | Sezione AI talkers/help con gruppi Telecronista e Spettatore, immagine `help.png` e CTA team. |
| `home-why` | Sezione origine progetto con gallery immagini `rrl-why-1..4.jpg`. |
| `home-tutorial` | Sezione tutorial con `logo-tutorial.png` e CTA `/tutorial`. |
| `home-faq` | FAQ da chiavi Angular `lblFaq01..07`. |
| `EntityAdsComponent` | `AdsSlot` home slot `1006277790`. |

## Implementazione

- `app/page.tsx` continua a usare solo dati reali o empty state, senza card demo.
- La home legge i cataloghi con `loadMessages(await getRequestLanguage())`, quindi rispetta il cookie lingua server-aware introdotto in NXT-T008.
- `getHomeCopy()` estrae le chiavi Angular `Site.Home` con fallback typed e rimuove markup HTML dal sottotitolo/esempio AI talkers.
- La route resta server-rendered/dinamica, coerente con strategia SSR e lettura cookie.

## Validazione

- `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`: passata, 47 pagine generate.
- `node scripts\smoke-http.mjs` con `SMOKE_PORT=3210`: passato, route/redirect/PWA/maintenance validati su porte 3210/3211.
- Scan statico `rg "TODO|console\.log|any|React\."` su `app`, `components`, `lib`, `types`, `middleware.ts` e service worker: nessun match.
- Smoke home conferma status 200 e copy `Rugby Radio`.

## Residui

- Review visuale desktop/mobile resta pending.
- Variante autenticata della home resta coperta dalla dashboard `/account`, ma non ancora validata in browser reale con sessione localStorage.
