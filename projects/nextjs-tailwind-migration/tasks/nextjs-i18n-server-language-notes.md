---
type: task-evidence
created: 2026-07-24T12:43:39+02:00
source: tasklist-nextjs-tailwind-migration
topic: "Lingua server-aware Next.js"
slug: nextjs-i18n-server-language-notes
tasks:
  - NXT-T008
---

# Lingua server-aware Next.js

## Scopo

Ridurre il gap NXT-T008 in cui la lingua migrata era salvata solo in `localStorage`, quindi non leggibile dalle route server-rendered.

## Implementazione

- La chiave resta compatibile con Angular fase 1: `user_language`.
- Il client continua a scrivere `localStorage`, preservando sessione e comportamento Angular.
- Il client scrive anche un cookie `user_language` `Path=/`, `SameSite=Lax`, `Max-Age=365 giorni`.
- Il server legge il cookie tramite `getRequestLanguage()` in `src/RugbyRadioWebNext/lib/i18n/server.ts`.
- In assenza di cookie, le pagine server mantengono fallback `IT` per non cambiare il copy pubblico corrente; quando l'utente seleziona lingua, il cookie prevale.

## Route collegate

| Route | Prima | Dopo |
|---|---|---|
| `/login` | `loadMessages("IT")` | `loadMessages(await getRequestLanguage())` |
| `/register` | `loadMessages("IT")` | `loadMessages(await getRequestLanguage())` |
| `/reset-password` | `loadMessages("IT")` | `loadMessages(await getRequestLanguage())` |
| `/feedback` | `loadMessages("IT")` | `loadMessages(await getRequestLanguage())` |

## Punti client sincronizzati

- `LanguageSelector`: aggiorna `localStorage` e cookie, poi ricarica la pagina.
- `setSession`: quando il backend restituisce `language`, aggiorna `localStorage` e cookie.
- `ProfilePanel`: quando l'utente salva la lingua profilo, aggiorna `localStorage` e cookie.
- `getUserLanguage`: inizializza `EN` in `localStorage` e cookie quando non trova una lingua locale, coerente con la fase Angular client-side.

## Impatto rendering

Le route `/login`, `/register`, `/reset-password` e `/feedback` diventano dinamiche in build Next perche leggono `cookies()`. Questo e coerente con la strategia server-rendered scelta nella tasklist.

## Validazione

- `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`: passata, 47 pagine generate.
- `node scripts\smoke-http.mjs` con `SMOKE_PORT=3190`: passato, route/redirect/PWA/maintenance validati su porte 3190/3191.
- Scan statico `rg "TODO|console\.log|any|React\."` su `app`, `components`, `lib`, `types`, `middleware.ts` e service worker: nessun match.
- Scan `loadMessages("IT")` su `app`, `components`, `lib`: nessun hardcode residuo nelle route collegate.

## Residui

- Il resto delle stringhe UI migrate e ancora progressivamente da collegare ai cataloghi Angular.
- La selezione lingua server-aware deve essere validata anche via browser reale cambiando lingua e verificando refresh/cookie.
