# Architettura proposta — mockup e design system layout-2026

**Stato:** mockup autonomo implementato e compilato; in attesa di validazione. Nessuna modifica ai progetti runtime o alle API di produzione è inclusa. La validazione del mockup precede tali interventi.

## Nota di implementazione — 24 settembre 2026

La prima versione è disponibile in `src/RugbyRadioLayout2026`. Usa Angular 18 autonomo, un `HttpInterceptor` locale per intercettare le route `/v1`, fixture sintetiche, selettore di scenario e fogli CSS riutilizzabili. Build verificata con `npm run build`. L’interceptor non inoltra le chiamate `/v1` a servizi reali e risponde esplicitamente alle route non supportate. Il prototipo include catalogo dei componenti, home anonima/autenticata, autenticazione, demo, pagine pubbliche, live, wizard di creazione e live editor. Le scritture mock restano in memoria.

La struttura effettiva è stata adattata al prototipo snello descritto nel README (`src/app/pages`, `src/styles`, `mocks`); non è stato introdotto MSW. Le schermate selezionate sono una prima passata visiva, non ancora validata dal responsabile. Lo scenario `privacy-target` mostra la proposta di protezione, senza presentarla come comportamento attuale dell’API.

### Revisione visuale dopo feedback stakeholder

È stata eseguita una revisione mirata su tipografia, palette, contrasti, proporzioni mobile e copertine. Il mockup riprende la palette del sito RRL (`#f4fbfb`, `#ffffff`, `#ecf8f8`, `#1f4c4e`, `#1d8391`, `#166874`, `#d6eef1`, `#7fd6d2`, `#49c3be`, `#ff5a5f`), mantenendo una direzione editoriale per layout e copertine; le CTA con testo bianco usano il teal strong per il contrasto. Il frontend corrente costruisce le immagini match dallo storage usando l’ID (`matches/{id}.webp`, `matches/{id}-original.webp` a partita conclusa) e le immagini canale (`channels/{id}.webp`). Poiché le fixture del prototipo usano ID sintetici e non devono chiamare lo storage reale, sei artwork JPEG locali distinti, creati appositamente per il mockup, rappresentano le copertine (tre match e tre radio, 1280×720). Sono dimostrativi e non riproducono i dipinti associati ai record di produzione. Build Angular e presenza delle immagini nelle schermate principali sono verificate; resta necessaria la validazione estetica stakeholder.

## Esito

La strada è percorribile e adatta allo scopo. **Al momento dell’analisi iniziale** `src/RugbyRadioLayout2026` era vuota; è stata poi inizializzata come applicazione dimostrativa autonoma Angular, separata dal build e dal deploy di produzione.

L’obiettivo concordato e implementato nella prima versione è un design system navigabile e un’anteprima dei principali percorsi RRL, con fixture inventate e senza richieste a servizi reali.

## Struttura suggerita

```text
src/RugbyRadioLayout2026/
├── package.json, angular.json, tsconfig*.json   # app standalone, comandi run/build
├── src/
│   ├── index.html, main.ts
│   ├── styles/
│   │   ├── tokens.css                           # token CSS RRL e loro stato
│   │   ├── base.css                             # reset, tipografia, accessibilità
│   │   ├── components.css                       # primitive condivise
│   │   └── layouts.css                          # shell e responsive
│   └── app/
│       ├── shell/                               # anonimo, desktop, nav mobile/TWA
│       ├── pages/                               # schermate mappate in qa/08
│       ├── components/                          # pattern riusabili del prototipo
│       ├── scenarios/                           # selettore fixture/stati
│       └── api/                                 # DTO/client allineati ai contratti
└── mocks/
    ├── handlers/                                # MSW per metodo e route API
    ├── fixtures/                                # risposte camelCase tipizzate
    └── scenarios/                               # utente anonimo/auth, errori, empty
```

La struttura è una proposta, da adattare solo per esigenze di bootstrap reali. Evitare riferimenti runtime a `RugbyRadioWeb` che impediscano di avviare il mockup indipendentemente.

## Mock API compatibili

Raccomandazione: usare Mock Service Worker (MSW) a livello HTTP. Gli handler rispondono alle medesime richieste che il client reale invierebbe: metodo, path `/v1`, query, header rilevanti, body, shape JSON, status e comportamento di autenticazione. Una piccola interfaccia client/DTO documentata mantiene chiara la compatibilità senza legare il mock agli endpoint reali in rete.

Contratto di riferimento: controller/DTO C# e Swagger/OpenAPI del backend, confrontati con servizi, DTO e interceptor Angular correnti. Il mapping iniziale è `qa/06-prototype-technical-review.md`; l’ambito schermate è `qa/08-prototype-screen-map.md`.

Regole:

- MSW parte solo nel progetto prototipo e su build/avvio locale. Non configurare un fallback a API di produzione.
- Le richieste non implementate devono fallire esplicitamente in diagnostica di sviluppo, mai tornare `[]` per default.
- Fixture e scritture restano in memoria, con comando di reset scenario; login e token sono simulati.
- Supportare scenari distinti per successo, loading/latency opzionale, empty (`200` con lista vuota), errore HTTP, guasto isolato di una route e sessione non autorizzata (`401` dove previsto dal controller).
- Mantenere nomi e tipi JSON effettivi, paginazione e wrapper reali; mascherare dettagli interni che il filtro eccezioni può esporre.
- Le mutazioni demo non chiamano API/analytics/feedback reali. I controlli che non hanno un comportamento simulabile dichiarano il limite.
- Il mock documenta sempre se rappresenta **parità attuale** o **comportamento target**.

### Differenze API da mantenere visibili

Non correggere silenziosamente le discrepanze individuate:

1. Le ricerche della home non inviano `status`; il mock non deve fingere categorie live/prossime/storiche realmente filtrate finché il contratto o l’ordinamento non è definito.
2. Le route anonime di dettaglio per ID possono esporre canale/match test. Lo scenario **target privacy demo** può restituire 404/403 all’anonimo solo se è chiaramente etichettato come comportamento proposto, da realizzare e verificare nel backend prima di promuovere la soluzione. Evitare dati reali nella fixture.
3. Il payload effettivo di aggiornamento statistiche Live è più ampio del tipo dichiarato dal servizio Angular; confrontare sempre col DTO backend e documentare la discrepanza, senza restringere il mock al typing errato.
4. Atomicità/idempotenza del wizard e alcuni body di errore 401 richiedono verifica ulteriore. Evitare retry di scritture che possano duplicare contenuti.
5. Le regole di accesso per tutte le azioni devono riflettere attributi e comportamento API verificati, non solo guard visuali. La policy di accesso resta un gate per passare dal mock alle modifiche reali.

Il registro dettagliato dei contratti e delle incertezze è `qa/06-prototype-technical-review.md`.

## CSS e componenti riutilizzabili

- Definire un piccolo sistema CSS nel prototipo con variabili `--rrl-*`, scale di spaziatura/tipografia/radius, colori semantici e stati documentati.
- Costruire componenti HTML riusabili per bottoni, campi, card, badge, tab, navigazione, stati e feedback. Ogni componente espone stati/varianti dimostrati nelle pagine.
- Etichettare token e pattern come **esistenti**, **proposta** o **da validare**. Le decisioni visuali del mockup non attestano automaticamente l’esistenza di un componente Angular condiviso.
- Tenere CSS per componenti e shell isolato sotto namespace del prototipo; media query responsive locali. Documentare quali token possono essere portati in `RugbyRadioWeb` dopo approvazione.
- Curare keyboard/focus, nomi accessibili, target touch, contrasto, zoom/reflow e `prefers-reduced-motion`; la revisione attuale segnala combinazioni colore che richiedono verifica nel render effettivo.
- Copy errore locale, approvato in Q&A 03: “Al momento non è possibile recuperare le informazioni”. L’errore di una sezione resta distinto da una lista vuota e dal guasto globale.

## Fasi, responsabilità e gate

| Fase | Owner principale | Output / criterio d’uscita |
|---|---|---|
| 1. Baseline contratti | Frontend engineer Angular | Matrice endpoint, DTO, auth/errori, differenze FE/API e fixture; review `qa/06`. |
| 2. Bootstrap prototipo | Frontend engineer Angular | App autonoma eseguibile in `src/RugbyRadioLayout2026`, script locale e mock network-only; nessun link a servizi reali. |
| 3. CSS e componenti base | UI designer + frontend engineer; accessibility review | Token e primitive responsive, stati accessibili, catalogo componenti con etichette esistente/proposta. |
| 4. Schermate e scenari | UX/information architect + frontend engineer | Pagine principali e 24 schermate/varianti prioritarie della mappa `qa/08`; scenario anonimo/auth, empty/error e flussi demo/wizard/live/pubblici. |
| 5. Revisione esperta | UX, UI, accessibilità, frontend, prodotto | Percorsi coerenti, controlli interattivi circoscritti, limiti API visibili, CSS riusabile e nessun side effect reale. |
| 6. Validazione mockup | Responsabile prodotto/stakeholder | Conferma o feedback registrato su pagine, navigazione, componenti e flussi prima del rollout nei progetti effettivi. |
| 7. Adeguamento prodotto (successivo) | Frontend engineer + owner API per dipendenze | Piano di migrazione approvato; chiusura privacy demo/policy accesso e delle differenze API; implementazione incrementale in `RugbyRadioWeb`/backend. Fuori dall’incarico mockup corrente. |

Il lavoro deve procedere con raccomandazioni esperte e scenari ragionevoli senza trasformare ogni incertezza in domanda al responsabile. Chiedere input solo quando una decisione non può essere rappresentata come alternativa/scenario o impedisce il completamento del mockup.

## Gate per promuovere il mockup

- È avviabile in modo indipendente e non invia dati a sistemi RRL reali.
- Ogni chiamata simulata ha un riferimento al contratto reale o un’etichetta esplicita “target/proposta”.
- Le pagine principali, le varianti responsive e le navigazioni anonima/autenticata sono percorribili.
- I componenti e i token sono definiti in CSS e riusati fra schermate, con stati/loading/empty/error osservabili.
- La privacy demo è rappresentata senza affermare che l’API attuale la garantisca.
- La validazione di prodotto precede ogni lavoro di redesign nei progetti runtime.
