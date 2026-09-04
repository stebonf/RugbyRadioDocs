---
type: task-evidence
created: 2026-07-24T13:18:42+02:00
source: tasklist-nextjs-tailwind-migration
topic: "Accessibilita feedback Next.js"
slug: nextjs-feedback-accessibility-notes
tasks:
  - NXT-T014
---

# Accessibilita feedback Next.js

## Scopo

Ridurre il gap NXT-T014 tra `GFeedbackPage` Angular e `/feedback` Next, con focus su accessibilita del form e dello stato successo.

## Implementazione

- Corretto lo stato success: `aria-labelledby="feedback-success-heading"` ora punta a un heading reale.
- Il form usa `aria-labelledby="feedback-form-heading"` con heading visibile e stabile.
- Reintrodotto skip link verso il gruppo rating, come nella pagina Angular.
- Il gruppo rating ha anchor `id="feedback-rating"` e mantiene `role="group"` con label da catalogo.
- `FeedbackCopy` ora espone `skipToFeedback`, letto da `Components.Feedback.ariaSkipToFeedback`.

## Validazione

- `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`: passata, 47 pagine generate.
- `node scripts\smoke-http.mjs` con `SMOKE_PORT=3240`: passato, route/redirect/PWA/maintenance validati su porte 3240/3241.
- Scan statico `rg "TODO|console\.log|any|React\."` su `app`, `components`, `lib`, `types`, `middleware.ts` e service worker: nessun match.
- Scan sorgenti conferma `feedback-success-heading`, `feedback-form-heading`, `feedback-rating`, `skipToFeedback` e mapping `ariaSkipToFeedback`.

## Residui

- Invio reale feedback richiede backend disponibile.
- Review visuale/browser e screen reader resta pending.
