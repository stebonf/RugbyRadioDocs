# Next.js Account Protected Parity Notes

Data: 2026-07-24

## Contesto

Rifinitura NXT-T016 sulle pagine account protette dopo la prima migrazione di dashboard, profilo, preferiti e danger zone. L'obiettivo e avvicinare la parita Angular su guard, logout, stati API e accessibilita dei form senza richiedere un backend autenticato reale nella validazione locale.

## Modifiche implementate

- `AuthenticatedShell` espone navigazione account piu completa con link a profilo, preferiti, canali studio, area pubblica e logout esplicito.
- Il logout chiama `clearSession()`, aggiorna lo stato locale della shell e rimanda alla home, allineandosi al comportamento account/header Angular.
- `ProfilePanel` aggiunge logout anche nel form profilo, mantiene il link alla zona pericolosa e sincronizza la lingua con `setUserLanguage()` invece di duplicare la scrittura localStorage/cookie.
- Il form profilo usa `aria-labelledby`, `aria-describedby`, `noValidate`, `id` campo e `aria-invalid` tramite `FormField`, cosi l'errore UserService/salvataggio e associato ai controlli principali.
- Le select profilo/telecronista hanno `htmlFor`/`id` espliciti.
- `FavoritesPanel` distingue loading, empty ed errore API: un errore di `ChannelService` non viene piu mostrato come lista preferiti vuota.

## Impatto funzionale

- Nessun cambio agli endpoint backend.
- Nessuna nuova dependency npm.
- Migliora la parita con `ProfilePage (web)` per logout e link danger.
- Migliora la QA page-per-page per `/account/favorites`, separando lo stato empty dallo stato error richiesto dalla checklist.
- Mantiene la strategia auth fase 1 basata su localStorage.

## Validazione locale

- `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`: compilazione, typecheck e generazione statica completati.
- `node scripts\smoke-http.mjs` da `src/RugbyRadioWebNext` con `SMOKE_PORT=3260`: passato su porte 3260/3261.
- `rg -n "TODO|console\.log|any|React\." ...`: nessun match nei sorgenti Next scansionati.

## Pending

- Validazione browser reale con token valido su dashboard, profilo, preferiti e danger.
- Verifica FCM completa su permesso notifiche e sincronizzazione token.
- Review visuale desktop/mobile delle route account protette.
