---
type: seo-spike
task: TASK-019
created: 2026-05-19
topic: "Spike prerender/SSR Angular Rugby Radio Live"
---

# Spike prerender/SSR Angular

## Sintesi

Raccomandazione: procedere con **prerender Angular incrementale per route statiche e liste pubbliche**, non con SSR completo immediato.

SSR completo e possibile tecnicamente, ma oggi richiede hardening browser/server su servizi globali, componenti pubblici e bootstrap. Generatore statico custom resta utile solo per pagine gia fuori Angular o per fallback mirati.

## Contesto analizzato

- `src/RugbyRadioWeb/angular.json`
- `src/RugbyRadioWeb/package.json`
- `src/RugbyRadioWeb/src/app/app.routes.ts`
- `src/RugbyRadioWeb/src/app/app.config.ts`
- route pubbliche `g-*`
- servizi dati e SEO: `MatchService`, `ChannelService`, `SeoMetadataService`, `UserService`, `PlatformService`, `AuthInterceptor`
- hosting Firebase: `src/RugbyRadioWeb/firebase.json`

## Stato attuale Angular

- Angular 18 con builder `@angular-devkit/build-angular:application`.
- Build browser SPA configurata con output `dist/rugby-radio-web/browser`.
- `provideClientHydration()` gia presente.
- `provideHttpClient(withFetch())` gia presente.
- Firebase Hosting serve tutto via rewrite SPA:
  - `**` -> `/index.html`
- Nessuna configurazione server/prerender presente in `angular.json`.
- Service worker attivo in produzione.

## Route pubbliche candidate

Priorita alta:

- `/`
- `/g-matches`
- `/g-channels`
- `/g-stats`
- `/g-feedback`

Priorita media:

- `/g-match/:matchId`
- `/g-channel/:channelPublicId`
- `/g-team/:teamId`

Route private o non candidate:

- `/user-dashboard`
- `/user-profile`
- `/user-channels`
- `/user-channel/:channelId`
- `/user-match/:matchId`
- `/user-danger`
- `/user-favorites`

## Opzione A - Angular prerender

### Modifiche richieste

- Aggiungere setup Angular SSR/prerender:
  - `@angular/ssr`
  - entry server
  - configurazione `server` e `prerender` in `angular.json`
- Definire lista route prerender iniziale.
- Per route dinamiche, generare route list da inventory SEO o file esportato dal backend:
  - match indicizzabili
  - canali pubblici
  - team pubblici
- Aggiornare Firebase Hosting per servire HTML prerenderizzato quando presente, mantenendo fallback SPA.
- Disabilitare/neutralizzare side effect browser-only durante prerender.

### Vantaggi

- Migliora HTML iniziale per crawler.
- Mantiene hosting statico Firebase.
- Approccio incrementale, adatto a M4.
- Riduce rischio rispetto a SSR runtime.

### Rischi

- `PlatformService` usa `window`, `navigator` e `matchMedia` in constructor: non compatibile con prerender server senza guard.
- `UserService` inizializza `BehaviorSubject` leggendo `localStorage`: non compatibile server senza guard.
- `AuthInterceptor` legge lingua, commentator e token da `UserService`: rischio accesso `localStorage` durante fetch server.
- Alcuni componenti pubblici usano `window`, `document`, `navigator`, `sessionStorage`, `setInterval` e analytics in lifecycle.
- Firebase, Ads, Sentry e service worker vanno confinati lato browser.

### Fit

Buono come prima scelta se prima si fa hardening browser/server minimo.

## Opzione B - Angular SSR runtime

### Modifiche richieste

- Aggiungere Angular SSR con server Node.
- Sostituire hosting statico puro o aggiungere backend SSR compatibile con deploy.
- Gestire caching HTML lato edge/server.
- Rendere server-safe tutti i servizi singleton e componenti caricati da route pubbliche.
- Evitare side effect per analytics, service worker, Firebase messaging, Ads e storage durante render server.

### Vantaggi

- HTML sempre aggiornato per route dinamiche.
- Non richiede pregenerare tutte le URL indicizzabili.
- Utile per match live e canali aggiornati spesso.

### Rischi

- Cambia modello hosting/deploy.
- Costi operativi e complessita maggiori.
- Rischio alto su regressioni runtime per TWA/PWA, notifiche, analytics e login.
- Necessita cache e invalidazione.

### Fit

Non raccomandato come primo step. Valido solo dopo prerender pilota e hardening server-safe.

## Opzione C - Generatore statico custom

### Modifiche richieste

- Creare job o script che produce HTML statici per route SEO.
- Riutilizzare inventory SEO backend e template HTML.
- Pubblicare file statici su hosting prima del fallback SPA.
- Mantenere canonical, OG, Twitter e JSON-LD lato template.

### Vantaggi

- Massimo controllo SEO.
- Nessun vincolo SSR Angular.
- Coerente con blog statico gia esistente.

### Rischi

- Duplica template e logica metadata gia presenti in Angular.
- Rischio drift UI/SEO.
- Non migliora rendering Angular per utente, solo crawler.

### Fit

Buono come fallback per pagine match ad alto valore se Angular prerender risulta troppo costoso.

## Rischi tecnici principali

### Browser API non protette

Esempi rilevati:

- `PlatformService`: `window.matchMedia`, `navigator.userAgent`
- `UserService`: molte letture/scritture `localStorage`
- `GMatchesComponent`: `sessionStorage`
- `GMatchComponent`, `GChannelComponent`, `GTeamComponent`: `window.location`, `window.scrollY`, `navigator.share`, `navigator.clipboard`
- `main.ts`: `navigator.serviceWorker`

Serve wrapper `isPlatformBrowser` o storage abstraction.

### Side effect durante prerender

Componenti pubblici chiamano API, analytics e logging in `ngOnInit`. Per prerender serve decidere:

- dati veri via API pubblica durante build;
- oppure shell HTML per route statiche;
- oppure route dinamiche generate solo quando API disponibile.

### Hosting Firebase

Oggi `firebase.json` fa rewrite globale a `/index.html`. Con prerender, route statiche devono essere servite come file reali prima del fallback SPA.

### Bundle budget

`npm run -s build` passa, ma mostra warning budget:

- initial bundle 2.21 MB supera warning 2.10 MB;
- diversi CSS component superano warning.

Non blocca spike, ma SSR/prerender non risolve questo costo client.

## Piano implementazione raccomandato

### Fase 1 - Hardening server-safe

- Rendere `PlatformService` sicuro con `PLATFORM_ID`.
- Introdurre `BrowserStorageService` con no-op/server fallback per `localStorage` e `sessionStorage`.
- Proteggere `main.ts` con check `typeof navigator !== 'undefined'`.
- Spostare analytics, service worker, Ads e Firebase messaging su ramo browser-only.
- Verificare route pubbliche con build browser normale.

### Fase 2 - Prerender pilota statico

- Aggiungere Angular SSR/prerender.
- Prerenderizzare solo:
  - `/`
  - `/g-matches`
  - `/g-channels`
  - `/g-stats`
- Verificare HTML generato:
  - `<title>`
  - description
  - canonical
  - OG/Twitter
  - JSON-LD dove presente
- Aggiornare Firebase Hosting mantenendo fallback SPA.

### Fase 3 - Route dinamiche SEO

- Usare inventory SEO backend per produrre lista route:
  - `/g-match/{matchId}`
  - `/g-channel/{channelPublicId}`
  - `/g-team/{teamId}`
- Applicare regola di indicizzabilita match gia definita.
- Limitare volume iniziale alle URL ad alto valore.

### Fase 4 - Decisione SSR runtime

- Valutare SSR runtime solo se:
  - prerender non basta per freshness;
  - route dinamiche cambiano troppo spesso;
  - hosting/deploy Node e caching sono accettabili.

## Raccomandazione finale

Procedere con **Angular prerender pilota** per route pubbliche statiche/lista, dopo hardening server-safe minimo.

Non avviare SSR runtime ora.

Usare generatore statico custom solo come piano B per match/canali se prerender dinamico diventa fragile o troppo lento.

## Impatto su task successive

- TASK-020 puo essere sbloccato come prerender pilota statico.
- TASK-021 puo restare indipendente: landing statica Angular prerenderabile.
- TASK-024 resta utile per generare inventory route dinamiche SEO-safe.

## Verifica

- `npm run -s build` in `src/RugbyRadioWeb`: OK.
- Warning build: budget initial e vari CSS component, non bloccanti per TASK-019.

