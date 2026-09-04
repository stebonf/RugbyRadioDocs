---
type: task-evidence
created: 2026-07-24T12:49:30+02:00
source: tasklist-nextjs-tailwind-migration
topic: "Runtime analytics Next.js"
slug: nextjs-analytics-runtime-notes
tasks:
  - NXT-T009
  - NXT-T021
---

# Runtime analytics Next.js

## Scopo

Ridurre il gap tra `AppComponent.trackPageViews()` Angular e la shell Next, portando nel root layout il tracciamento page view su navigazioni client-side.

## Implementazione

- `components/domain/analytics-scripts.tsx` carica Google tag con `NEXT_PUBLIC_RRL_GA_MEASUREMENT_ID`, fallback `G-J02WL9LF3F`.
- L'inizializzazione usa `send_page_view: false` per evitare doppio conteggio: il page view viene inviato dal runtime route.
- `components/domain/route-runtime.tsx` usa `usePathname()` e `useSearchParams()` per rilevare cambi route e query string.
- Il runtime invia `trackPageView(routeUrl, document.title)` e resetta lo scroll quando l'URL non contiene hash, allineato al comportamento Angular.
- `lib/client/analytics.ts` ora pulisce i parametri `undefined` e include `page_path`, `page_location` e `page_title`, come `AnalyticsService.trackPageView()` Angular.
- `app/layout.tsx` monta `AnalyticsScripts` e `RouteRuntime` globalmente; `RouteRuntime` e incapsulato in `Suspense` per compatibilita con `useSearchParams()`.

## Validazione

- `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`: passata, 47 pagine generate.
- `node scripts\smoke-http.mjs` con `SMOKE_PORT=3200`: passato, route/redirect/PWA/maintenance validati su porte 3200/3201.
- Scan statico `rg "TODO|console\.log|any|React\."` su `app`, `components`, `lib`, `types`, `middleware.ts` e service worker: nessun match.
- Scan sorgenti conferma wiring globale di `AnalyticsScripts`, `RouteRuntime`, `trackPageView()` e `send_page_view: false`.

## Residui

- Il dispatch reale verso Google Analytics deve essere validato in browser con network/devtools o ambiente deploy.
- Eventi prodotto granulari non ancora collegati in tutte le pagine migrate; oggi restano coperti soprattutto auth e feedback piu il page view globale.
