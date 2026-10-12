# Inventario UI frontend (fase 2)

**Stato:** analisi statica del frontend effettivo, 24 settembre 2026. Non sono state apportate modifiche al codice. I percorsi di codice sono relativi a `src/RugbyRadioWeb/`; quelli wiki sono relativi a `docs/wiki/`.

## Sintesi

Il frontend Angular esiste in `src/RugbyRadioWeb/` (Angular 18, componenti standalone). La UI combina un set di componenti condivisi `common/`, uno strato visuale globale in `src/assets/css/rrl.css` e override/regole in `src/styles.css`, oltre a CSS specifici per componenti e pagine. Si può riusare davvero una parte sostanziale di controlli, skeleton, header pagina, tab, ricerca, card/lista, paginazione, alert e toast; tuttavia l’uso non è uniforme: pagine e widget mantengono CSS propri e alcuni pattern si somigliano soltanto per l’uso di classi comuni (`rrl-card`, `rrl-form`, `rrl-btn`). Le classi condivise costituiscono un vocabolario visuale, ma non provano che markup e comportamento siano intercambiabili.

## Superfici e navigazione verificate

Le route effettive sono in `src/app/app.routes.ts`:

- Home pubblica `''` e dashboard autenticata `/user-dashboard` usano entrambe `HomeComponent`.
- Autenticazione pubblica: `/user-login`, `/user-registration`, `/user-reset-password`.
- Route protette da `AuthGuardService`: profilo, canali dell’utente, dettaglio canale, editor partita, preferiti e area pericolosa (`/user-profile`, `/user-channels`, `/user-channel/:channelId`, `/user-match/:matchId`, `/user-favorites`, `/user-danger`).
- Superfici pubbliche: canale, partita, radio, elenco partite/canali, squadra, statistiche e feedback (`/g-channel/:channelPublicId`, `/g-match/:matchId`, `/g-radio/:matchId`, `/g-matches`, `/g-channels`, `/g-team/:teamId`, `/g-stats`, `/g-feedback`). La route catch-all torna alla home; in modalità manutenzione le route vengono sostituite dal flusso maintenance.

Il guscio in `src/app/app.component.html` monta header e router outlet, bottom navigation se `showBottomNav`, footer solo fuori da TWA e mobile, quick-create partita e toast globali. `src/app/site/header/header.component.html` implementa barra superiore fissa, ritorno/home, menu laterale e selettore lingua (EN/IT/FR/ES/JA); il menu offre esplorazione pubblica e azioni account. `src/app/common/entity-bottom-nav/` mostra a utenti autenticati Home/Radio/Create/Matches/Profile. Il footer è `src/app/site/footer/`. Le condizioni responsive e TWA sono collegate a `PlatformService`, ma non è stata eseguita una verifica visuale su device.

La home cambia per stato utente e TWA in `src/app/site/home/home.component.html`: splash TWA, pannello `home-user` per autenticati, contenuti promozionali per anonimi non-TWA, e caroselli di partite in corso/prossime/precedenti e canali recenti. I contenuti promozionali includono logo, audience, aiuto, features, perché, tutorial e FAQ. L’elenco pubblico di partite/canali usa ricerca + liste paginabili (`src/app/global/g-matches/g-matches.component.html`, `src/app/global/g-channels/g-channels.component.html`). La pagina pubblica partita (`src/app/global/g-match/g-match.component.html`) riusa header partita e tab per eventi, formazioni, statistiche e condivisione.

L’editor autenticato di partita (`src/app/user/match/match.component.html`) usa gli stessi `EntityTabs`, `MatchHeader`, `MatchLineup`, `MatchStats`, `EntityShare`, ma aggiunge schede Live ed Events in modalità operativa. `src/app/user/match/match-live/match-live.component.html` mostra suggerimenti condizionali per iniziare/riprendere la partita, azioni evento ad ampia superficie, gruppi avanzati/falli, controllo sezione AI e drawer per inizio/ripresa. Questo è riuso di componenti condivisi, ma con logica, stili e densità specifici dell’editor. Wiki di confronto: `docs/wiki/comparisons/Mappatura Frontend Pubblico e Autenticato (comparison).md`; flussi: `docs/wiki/workflows/Cronista Telecronaca (workflow).md` e `docs/wiki/workflows/Spettatore Partita (workflow).md`.

## Componenti e riuso reale

Componenti standalone in `src/app/common/` importati da più pagine includono:

- Controlli e feedback: `entity-button`, `entity-field`, `entity-alert`, `entity-toast` + `ToastService`, `icon` (SVG da mappa interna), `entity-info`, `entity-share`.
- Layout/navigazione: `entity-page-header` e variante skeleton, `entity-tabs`, `entity-bottom-nav`, `entity-section`, `entity-pagination`, `entity-search`, `entity-scroll-to-top`.
- Contenuti: `match-card`/`match-card-small`, `match-card-list`, `channel-card`/`channel-card-list`, `entity-card-big`, `entity-card-small`, `entity-stats-grid`, `match-header`, `match-events`, `match-lineup`, `match-stats`, `match-commentator`.
- Stati/integrazioni: `entity-skeleton`, `entity-ads`, `match-create`.

Le prove del riuso sono gli stessi selector Angular montati dai template, non soltanto classi CSS. Esempi: `EntityTabsComponent` compare nel match pubblico e nel match editor; `MatchHeaderComponent`, `MatchLineupComponent`, `MatchStatsComponent` e `EntityShareComponent` sono condivisi tra le due superfici; `MatchCardListComponent` e `ChannelCardListComponent` sono usati per le liste pubbliche e alcuni contenuti di canale/squadra; `EntityPageHeaderComponent` ricorre su pagine profilo/canale/squadra; skeleton, ricerca, paginazione e feedback hanno componenti dedicati. La wiki `docs/wiki/comparisons/Mappatura Componenti UI Condivisi (comparison).md` conferma parte del catalogo ma dichiara che consumer e varianti non sono completi; il codice resta la fonte per l’uso effettivo.

**Somiglianze da non conteggiare come riuso di componente:** le sezioni promozionali della home hanno componenti e CSS autonomi; menu header e bottom nav sono due pattern di navigazione distinti; card operativo evento (`button.rrl-card` nel Live editor) non è la card partita pubblica (`MatchCardSmallComponent`); numerose pagine legacy compongono form e pannelli direttamente usando le classi globali. `BaseCardComponent` è una base comportamentale effettivamente estesa da `MatchCardComponent`, `MatchCardSmallComponent` e `ChannelCardComponent`; non implica però una card visuale unica. `BaseModalComponent` va valutato tramite i consumer specifici prima di assumerlo come pattern trasversale.

## Stile visuale, tipografia e responsive

`src/assets/css/rrl.css` definisce token CSS su `:root`: palette (`--rrl-color-bg #f4fbfb`, superfici bianche/teal chiaro, bordo, testo teal, primary `#1D8391`, varianti primary, accent, live, success, warning, danger), ombre `sm/md/lg`, raggi `10/16/24px` e pill, spaziatura `4/8/12/16/20/24/32/40px`, max-width `1120px`. Font stack dichiarato: `Inter, Roboto, Arial, sans-serif`; nel codice letto non è stato verificato il caricamento effettivo di Inter. Le classi globali offrono container, topbar, sezioni, hero, griglie, card, badge, match score, radio, form, input/error, sheet/drawer, skeleton shimmer e footer. `src/styles.css` è caricato dopo `rrl.css` secondo `angular.json`, quindi può sovrascriverne le regole. CSS component-specifici affiancano entrambi.

Responsive globale: breakpoint principali 768px, con griglie card 2/3 colonne da tablet/desktop, bottom nav nascosta da 768px, hero a una colonna sotto 768px, card e pulsanti adattati; header lingua ha regola <=640px. Body riserva spazio top e bottom per barre/safe-area e modifica padding in presenza di splash/footer. Il guscio esclude footer da mobile/TWA. La PWA è configurata tramite `src/manifest.json`, service worker Angular in `ngsw-config.json`/`app.config.ts`; `PlatformService` distingue mobile e TWA. Android TWA ha riferimenti in `angular.json` (`assetlinks.json`) e link Play Store nel footer. Queste configurazioni indicano target tecnici, non attestano la qualità o completezza dell’esperienza installata.

Icone: `app-icon` usa SVG inline tramite mappa in `src/app/common/icon/icon.map.ts`; coesistono immagini remote per loghi/avatar e icone evento. I template usano lazy loading in vari contenuti, mentre azioni Live caricano immagini eager e prevedono fallback nel componente. Design tokens e classi sono presenti ma l’uso di valori inline e CSS locale va verificato pagina per pagina prima di assumere copertura completa del design system.

## Form, card e feedback

`EntityButtonComponent` fornisce varianti `pill`, `panel`, `close` e colori `primary`, `secondary`, `ghost` (`src/app/common/entity-button/`). `EntityFieldComponent` associa label/ID, help text e messaggio errore (`src/app/common/entity-field/`); `rrl.css` definisce `rrl-form`, `rrl-field`, `rrl-input`, focus, disabled ed errore. Login, registrazione, reset password, profilo e wizard/modali usano combinazioni non necessariamente uniformi di Reactive Forms/`ngModel`, input Angular Material/NgSelect o markup proprio. I componenti button/field sono autentici ma non costituiscono un form renderer comune.

`EntityCardBig` e `EntityCardSmall` sono wrapper riusabili; `MatchCard` e `ChannelCard` sono componenti di dominio distinti con pattern da card cliccabile, status, score/metadata e immagini. Le card liste montano skeleton, elementi, ads e paginazione; `compactMobile` cambia il layout per card in mobile. Ads AdSense sono componentizzati in `EntityAds` e inseriti anche tra risultati, quindi redesign delle card/feed deve considerare slot e frequenze configurati nel template.

Feedback: `EntityAlertComponent` supporta toni, varianti filled/card/centered, icona, dismiss e ruoli ARIA; `EntityToastComponent` renderizza una coda di toast con success/info/warning/error e chiusura, gestita dal `ToastService`; pagine chiamano inoltre `ngx-toastr` direttamente, quindi il sistema di notifiche ha almeno due superfici tecniche. Il wrapper error handler registra errori e mostra messaggi generici in molte pagine. Icone, aria-live e ruoli sono presenti in alcuni componenti; non è stata eseguita audit accessibilità.

## Stati osservati

- **Loading:** `EntitySkeletonComponent` implementa `header`, `card`, `list`, `text`, usato da header/list components. Le liste pubbliche mostrano griglia card-skeleton prima dei risultati (`match-card-list`, `channel-card-list`). Le pagine entità mostrano skeleton nell’header e in alcune sezioni; i widget home hanno loader dedicati/riuso `HomeGrid` e possono mantenere uno skeleton minimo di 400 ms.
- **Vuoto/nessun risultato:** le liste condivise mostrano `EntityInfo` con icona/titolo/sottotitolo configurabili. I titoli differiscono tra “nessun risultato” di ricerca e assenza di dati solo dove il parent imposta copy differente; la semantica va confermata per ogni pagina. Pagine live distinguono anche partita non iniziata/intervallo/terminata con avvisi operativi.
- **Errore:** i componenti lista ricevono `isLoading` e dati, ma non un input errore dedicato; i metodi catchError delle pagine spesso chiamano `ErrorHandlerService` o `ngx-toastr`, poi restituiscono `of(error)`. I widget home intercettano l’errore e terminano il loading senza mostrare necessariamente errore/empty distinto: la vista può ricadere nello stato vuoto. Il recupero, retry e distinzione errore vs dati assenti non è uniforme. Toast è feedback effimero e non un errore persistente inline.
- **Assenza/non disponibilità:** alcuni contenuti condizionali usano alert o omissione del blocco; il match pubblico ha alert per accesso richiesto/non ancora disponibile, mentre l’editor mostra notice contestuali a stati della partita. Non è emerso un contratto cross-app unico di stato.

Evidenze puntuali: `src/app/common/entity-skeleton/entity-skeleton.component.html`; `src/app/common/match-card-list/match-card-list.component.html`; `src/app/common/channel-card-list/channel-card-list.component.html`; `src/app/common/entity-info/`; `src/app/site/home/home-ongoing-matches/home-ongoing-matches.component.ts`; `src/app/user/base-user/base-user.component.ts`; `src/app/global/g-base-user/g-base-user.component.ts`; `src/app/user/match/match-live/match-live.component.ts`.

## Dipendenze e vincoli per il redesign

1. **API e dati:** liste, header, match e canali dipendono da `MatchService`, `ChannelService`, `StatsService`, `UserService` e relativi DTO. Ricomporre contenuti o stati può richiedere richieste API, paginazione, dati score/status o query; inventario UI da solo non conferma disponibilità di un endpoint.
2. **Dominio editor:** azioni Live invocano `MatchService`/logica eventi, stato temporale, formazione e co-editor; mantenere semantica e autorizzazioni. Gli eventi non sono semplici pulsanti estetici. Workflow wiki segnala ownership e creazione evento come punti di fallimento.
3. **Auth/ritorno:** route protette da `AuthGuardService`, azioni ibride del pubblico usano autenticazione/callback; preservare destinazione e contesto di partita.
4. **Media e audio:** immagini di squadre/canali e Talker sono risorse remote; player audio/TTS usa servizi e stati dedicati, dipende da disponibilità file e dati di evento.
5. **Ads, analytics, SEO e localizzazione:** `EntityAds`, Analytics, `SeoMetadataService` e file `assets/i18n/*.json` sono integrati nell’UI. Le pagine pubbliche impostano metadati e la distribuzione contiene sitemap/robots/ads; cambi layout/route vanno valutati con chi cura SEO/analytics e monetizzazione.
6. **PWA/TWA e viewport:** safe area, bottom navigation, splash e condizioni `isMobile`/`isTwa` cambiano il guscio. Serve validazione visuale su web mobile e TWA, landscape/altezza ridotta; questa analisi statica non prova installazione o comportamento runtime.
7. **CSS legacy e token:** molte classi globali e CSS per componente convivono. Prima di cambiare token globali, cercare i consumer delle classi condivise: la modifica può propagarsi a superfici non previste.

## Discrepanze, lacune e raccomandazioni tecniche

- La wiki documenta i componenti condivisi ma dichiara gap nella copertura dei consumer e delle varianti; gli elenchi sopra sono campionati e basati sui percorsi pertinenti, non un audit di ogni template dell’app.
- La mappa funzionale wiki è coerente con le route principali ma non sostituisce `app.routes.ts`; la route mostra in particolare radio pubblica e route pericolosa oltre al riepilogo wiki.
- Lo stato di errore non è una variante standard dei componenti card-list e non è garantito che gli utenti distinguano fallimento di caricamento da assenza di risultati in tutti i casi. La proposta UX dovrebbe richiedere per ogni query almeno loading/loaded-empty/error/retry dove il flusso lo giustifica.
- Per la proposta di design system, prendere come base i token di `rrl.css`, verificare override in `styles.css` e component CSS, poi produrre una matrice dei consumer prima di cambiare i valori globali.
- Priorità di verifica UX: editor partita mobile (tap rapidi, densità, drawer e stato partita), partita pubblica (eventi/audio/tab), home anonima con contenuto dinamico e menu mobile.

## Limiti dell’analisi

Esame di route, template, TypeScript, CSS e documentazione wiki mirata; nessuna esecuzione in browser, misura contrasto, test con screen reader/tastiera, verifica su Android TWA, test funzionali o prova di disponibilità API/media. Non è stato inventariato ogni singolo componente/pagina. Le descrizioni qui sono osservazioni del codice letto; gli impatti UX e le priorità sono raccomandazioni, da confrontare con le altre analisi e con la decisione del coordinatore.

## Fonti principali

- `src/RugbyRadioWeb/src/app/app.routes.ts`, `app.component.html`, `app.config.ts`
- `src/RugbyRadioWeb/src/app/site/header/`, `site/footer/`, `site/home/`
- `src/RugbyRadioWeb/src/app/common/` (componenti condivisi citati)
- `src/RugbyRadioWeb/src/app/global/g-matches/`, `g-channels/`, `g-match/`
- `src/RugbyRadioWeb/src/app/user/match/`, `user/base-user/`, `global/g-base-user/`
- `src/RugbyRadioWeb/src/assets/css/rrl.css`, `src/RugbyRadioWeb/src/styles.css`, `src/RugbyRadioWeb/angular.json`, `package.json`, `src/manifest.json`, `ngsw-config.json`
- `docs/wiki/comparisons/Mappatura Componenti UI Condivisi (comparison).md`
- `docs/wiki/comparisons/Mappatura Frontend Pubblico e Autenticato (comparison).md`
- `docs/wiki/workflows/Cronista Telecronaca (workflow).md`, `Spettatore Partita (workflow).md`
