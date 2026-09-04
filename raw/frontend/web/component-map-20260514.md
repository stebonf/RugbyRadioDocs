# Frontend Component Map RAW

## Sintesi

- Data analisi: 2026-05-14
- Project: web
- Root frontend analizzata: `src/RugbyRadioWeb/src/app/`
- File output: `llm-wiki/raw/frontend/web/component-map-20260514.md`
- Framework: Angular 18 (standalone components)
- Componenti trovati: 57
- Componenti page-level esclusi: 18
- Input/props trovati: ~165
- Output/eventi trovati: ~36
- Asset collegati: non deducibili singolarmente (stili per file CSS dedicato)
- Candidati esclusi o incerti: 18

---

## Componenti frontend

---

## BaseCardComponent

### Nome nel codice

`BaseCardComponent`

### Nome wiki suggerito

`BaseCardComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/base-card/base-card.component.ts`

### Template

Non applicabile (Directive astratta `@Directive()`)

### Stili collegati

Nessuno (astratto)

### Selector o entrypoint

Non applicabile (classe base astratta)

### Tipo

Altro — Base abstract directive

### Responsabilità

Classe base astratta per tutti i componenti card (`ChannelCard`, `MatchCard`, `MatchCardSmall`). Fornisce navigazione da tastiera (Enter/Space), logging, e flag di clic. Richiede l'implementazione di `handleCardActivation()` nelle sottoclassi.

### Parent pages

Non deducibile (non usata direttamente)

### Parent components

Non deducibile

### Child components

Nessuno

### Input / props

- `showClickEffect` (`boolean`) - Obbligatorietà: opzionale. Default `true`. Abilita effetti visivi e emissione click.
- `compactMobile` (`boolean`) - Obbligatorietà: opzionale. Default `false`. Abilita stile compatto su mobile.

### Output / eventi

Nessuno diretto (definiti nelle sottoclassi)

### Servizi frontend usati

- `LoggingService` — logging del nome componente al `ngOnInit`

### Modelli FE o DTO usati

Nessuno

### Stati UI

Non deducibile

### Note di confidenza

Verificato dal codice

---

## BaseModalComponent

### Nome nel codice

`BaseModalComponent`

### Nome wiki suggerito

`BaseModalComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/base-modal/base-modal.component.ts`

### Template

Non applicabile (Directive astratta)

### Stili collegati

Nessuno (astratto)

### Selector o entrypoint

Non applicabile

### Tipo

Altro — Base abstract directive

### Responsabilità

Classe base astratta per drawer/modal (`MatchCreate`, `PlayerEdit`, `TeamEdit`). Gestisce visibilità, blocco scroll body (`document.body.style.overflow = 'hidden'`), e lifecycle. Richiede l'implementazione di `updateFormData()` e `onClose()` nelle sottoclassi.

### Parent pages

Non deducibile

### Child components

Nessuno

### Input / props

- `isVisible` (`boolean`) - Obbligatorietà: opzionale. Default `false`. Controlla visibilità del drawer/modal.

### Output / eventi

- `closeModal` (`void`) - Emesso quando il modal deve chiudersi.

### Stati UI

- Loading: Non deducibile
- Visibile / nascosto tramite `isVisible`

### Note di confidenza

Verificato dal codice

---

## IconComponent

### Nome nel codice

`IconComponent`

### Nome wiki suggerito

`IconComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/icon/icon.component.ts`

### Template

Inline — `<span [innerHTML]="svgContent"></span>`

### Stili collegati

Inline

### Selector o entrypoint

`app-icon`

### Tipo

Widget

### Responsabilità

Renderizza icone SVG inline da una mappa interna `ICONS`. Ogni icona è un percorso SVG 24×24 identificato da `name`. Sanifica l'HTML SVG tramite `DomSanitizer`.

### Parent components

Usato trasversalmente in quasi tutti i componenti dell'applicazione

### Child components

Nessuno

### Input / props

- `name` (`string`) - Obbligatorietà: obbligatoria. Nome dell'icona nella mappa `ICONS`.
- `size` (`number`) - Obbligatorietà: opzionale. Default `24`. Dimensione SVG in pixel.

### Output / eventi

Nessuno

### Modelli FE o DTO usati

`ICONS` (mappa interna icone SVG)

### Note di confidenza

Verificato dal codice

---

## EntityButtonComponent

### Nome nel codice

`EntityButtonComponent`

### Nome wiki suggerito

`EntityButtonComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-button/entity-button.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-button/entity-button.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-button/entity-button.component.css`

### Selector o entrypoint

`app-entity-button`

### Tipo

Widget — pulsante atomico

### Responsabilità

Pulsante atomico riutilizzabile con tre varianti visive (`pill`, `panel`, `close`) e tre colori (`primary`, `secondary`, `ghost`). Supporta icone, stato disabled, tipi HTML, aria attributes. Genera classi CSS dinamiche (`rrl-btn`, `rrl-panel-btn`, `rrl-sheet__close`).

### Parent components

Usato in: `MatchEventsComponent`, `MatchLineupComponent`, `MatchCreateComponent`, `PlayerEditComponent`, `TeamEditComponent`, `EntitySearchComponent`, `EntityShareComponent`, `GMatchEventsComponent`, e molti altri

### Child components

- `IconComponent` — icona del pulsante

### Input / props

- `variant` (`ButtonVariant`) - Obbligatorietà: opzionale. Default `'pill'`. Valori: `'pill'`, `'panel'`, `'close'`.
- `color` (`ButtonColor`) - Obbligatorietà: opzionale. Default `'secondary'`. Valori: `'primary'`, `'secondary'`, `'ghost'`.
- `label` (`string`) - Obbligatorietà: opzionale. Testo etichetta.
- `icon` (`string`) - Obbligatorietà: opzionale. Nome icona (da `IconComponent`).
- `iconSize` (`number`) - Obbligatorietà: opzionale. Default `18`.
- `ariaLabel` (`string`) - Obbligatorietà: opzionale.
- `ariaDescribedBy` (`string`) - Obbligatorietà: opzionale.
- `ariaExpanded` (`boolean | string | null`) - Obbligatorietà: opzionale.
- `disabled` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `type` (`'button' | 'submit' | 'reset'`) - Obbligatorietà: opzionale. Default `'button'`.
- `buttonClass` (`string`) - Obbligatorietà: opzionale. Classi CSS aggiuntive.

### Output / eventi

- `clicked` (`MouseEvent`) - Emesso al click del pulsante.

### Note sugli stili

Classi generate dinamicamente: `rrl-btn`, `rrl-btn--primary`, `rrl-panel-btn`, `rrl-sheet__close`, `rrl-focus-ring`.

### Note di confidenza

Verificato dal codice

---

## EntityAlertComponent

### Nome nel codice

`EntityAlertComponent`

### Nome wiki suggerito

`EntityAlertComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-alert/entity-alert.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-alert/entity-alert.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-alert/entity-alert.component.css`

### Selector o entrypoint

`app-entity-alert`

### Tipo

Widget — banner di stato/notifica

### Responsabilità

Alert/banner informativo con supporto dismiss persistente via `localStorage` (se `id` valorizzato). Supporta tipi (`info`, `warning`, `success`, `danger`, `neutral`), varianti (`outline`, `filled`), layout (`default`, `centered`, `card`) e aria attributes.

### Child components

- `IconComponent`

### Input / props

- `id` (`string`) - Obbligatorietà: opzionale. Chiave per persistenza dismiss in localStorage.
- `type` (`string`) - Obbligatorietà: opzionale. Default `'info'`. Tipo visivo.
- `variant` (`string`) - Obbligatorietà: opzionale. Default `'outline'`.
- `layout` (`string`) - Obbligatorietà: opzionale. Default `'default'`.
- `icon` (`string`) - Obbligatorietà: opzionale.
- `iconSize` (`number`) - Obbligatorietà: opzionale. Default `16`.
- `ariaLive` (`string`) - Obbligatorietà: opzionale. Default `'polite'`.
- `ariaRole` (`string`) - Obbligatorietà: opzionale. Default `'alert'`.

### Output / eventi

Nessuno

### Stati UI

- Visibile / dismissed (gestito tramite `isDismissed` + localStorage)

### Note di confidenza

Verificato dal codice

---

## EntityToastComponent

### Nome nel codice

`EntityToastComponent`

### Nome wiki suggerito

`EntityToastComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-toast/entity-toast.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-toast/entity-toast.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-toast/entity-toast.component.css`

### Selector o entrypoint

`app-entity-toast`

### Tipo

Widget — sistema notifiche toast

### Responsabilità

Renderizza l'elenco di toast attivi tramite `ToastService.toasts$`. Mappa il tipo di toast a un'icona (`circle-check`, `circle-info`, `triangle-alert`, `circle-x`). Espone funzione `dismiss(id)`.

### Parent components

- `AppComponent` — incluso nel root layout

### Child components

- `IconComponent`

### Input / props

Nessuno

### Output / eventi

Nessuno

### Servizi frontend usati

- `ToastService` — subscribe a `toasts$`; chiama `dismiss(id)`

### Modelli FE o DTO usati

- `Toast` (interfaccia da `ToastService`)

### Note di confidenza

Verificato dal codice

---

## EntitySearchComponent

### Nome nel codice

`EntitySearchComponent`

### Nome wiki suggerito

`EntitySearchComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-search/entity-search.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-search/entity-search.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-search/entity-search.component.css`

### Selector o entrypoint

`app-entity-search`

### Tipo

Form — campo di ricerca

### Responsabilità

Campo di ricerca con label, placeholder, bottone di ricerca e bottone clear. Sincronizza il valore esterno tramite `value` input e emette `valueChange`, `search`, `clear`. Supporta Enter per inviare la ricerca.

### Parent components

- `GChannelsComponent`, `GMatchesComponent`

### Child components

- `EntityButtonComponent`, `EntityFieldComponent`, `IconComponent`

### Input / props

- `value` (`string`) - Obbligatorietà: opzionale. Valore corrente del campo.
- `fieldId` (`string`) - Obbligatorietà: opzionale. ID per label/accessibilità. Default `'entity-search'`.
- `label` (`string`) - Obbligatorietà: opzionale.
- `placeholder` (`string`) - Obbligatorietà: opzionale.
- `searchButtonLabel` (`string`) - Obbligatorietà: opzionale.
- `title` (`string`) - Obbligatorietà: opzionale. Titolo sezione ricerca.
- `subtitle` (`string`) - Obbligatorietà: opzionale.

### Output / eventi

- `valueChange` (`string`) - Emesso ad ogni input dell'utente.
- `search` (`void`) - Emesso al click del bottone ricerca o Enter.
- `clear` (`void`) - Emesso al click clear.

### Note di confidenza

Verificato dal codice

---

## EntityPaginationComponent

### Nome nel codice

`EntityPaginationComponent`

### Nome wiki suggerito

`EntityPaginationComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-pagination/entity-pagination.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-pagination/entity-pagination.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-pagination/entity-pagination.component.css`

### Selector o entrypoint

`app-entity-pagination`

### Tipo

Widget — navigazione pagine

### Responsabilità

Paginazione con ellissi adattiva. Calcola pagine visibili in base a `currentPage` e `totalItems`/`pageSize`. Comportamento responsive: mostra max 5 pagine su mobile, 7 su desktop. Mostra info risultati opzionale.

### Parent components

- `ChannelCardListComponent`, `MatchCardListComponent`

### Child components

- `IconComponent`

### Input / props

- `currentPage` (`number`) - Obbligatorietà: opzionale. Default `1`.
- `totalItems` (`number`) - Obbligatorietà: opzionale. Default `0`.
- `pageSize` (`number`) - Obbligatorietà: opzionale. Default `10`.
- `itemName` (`string`) - Obbligatorietà: opzionale. Nome dell'entità per info risultati. Default `'elementi'`.
- `isLoading` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `showResultsInfo` (`boolean`) - Obbligatorietà: opzionale. Default `true`.

### Output / eventi

- `pageChange` (`number`) - Emesso al cambio pagina.

### Note di confidenza

Verificato dal codice

---

## EntityTabsComponent

### Nome nel codice

`EntityTabsComponent`

### Nome wiki suggerito

`EntityTabsComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-tabs/entity-tabs.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-tabs/entity-tabs.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-tabs/entity-tabs.component.css`

### Selector o entrypoint

`app-entity-tabs`

### Tipo

Navigation — tab bar

### Responsabilità

Barra tab configurabile. Supporta tab disabilitati con icona blocco. Genera ID accessibili (`sectionId-tab-{tabId}`, `sectionId-panel-{tabId}`).

### Modelli FE o DTO usati

- `EntityTab` (`{ id, label, icon }`)

### Child components

- `IconComponent`

### Input / props

- `tabs` (`EntityTab[]`) - Obbligatorietà: obbligatoria. Array di definizioni tab.
- `selectedTab` (`string`) - Obbligatorietà: obbligatoria. ID tab selezionata.
- `sectionId` (`string`) - Obbligatorietà: opzionale. Default `'entity-tabs'`.
- `sectionClass` (`string`) - Obbligatorietà: opzionale. Default `'rrl-section'`.
- `ariaLabel` (`string`) - Obbligatorietà: opzionale.
- `disabledTabIds` (`string[]`) - Obbligatorietà: opzionale. Tab non selezionabili.
- `disabledIconName` (`string`) - Obbligatorietà: opzionale. Icona su tab disabilitata.

### Output / eventi

- `selectedTabChange` (`string`) - Emesso al cambio tab (ID tab selezionata).

### Note di confidenza

Verificato dal codice

---

## EntitySectionComponent

### Nome nel codice

`EntitySectionComponent`

### Nome wiki suggerito

`EntitySectionComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-section/entity-section.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-section/entity-section.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-section/entity-section.component.css`

### Selector o entrypoint

`app-entity-section`

### Tipo

Layout — sezione con titolo e descrizione

### Responsabilità

Wrapper sezione con titolo e descrizione opzionali. Supporta classi CSS aggiuntive tramite `sectionClass`.

### Input / props

- `title` (`string`) - Obbligatorietà: opzionale.
- `description` (`string`) - Obbligatorietà: opzionale.
- `sectionClass` (`string`) - Obbligatorietà: opzionale.

### Output / eventi

Nessuno

### Note di confidenza

Verificato dal codice

---

## EntitySkeletonComponent

### Nome nel codice

`EntitySkeletonComponent`

### Nome wiki suggerito

`EntitySkeletonComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-skeleton/entity-skeleton.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-skeleton/entity-skeleton.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-skeleton/entity-skeleton.component.css`

### Selector o entrypoint

`app-entity-skeleton`

### Tipo

Widget — placeholder di caricamento

### Responsabilità

Skeleton loader animato con 4 layout: `header` (media + testo + azioni), `card` (cover + testo), `list` (righe compatte), `text` (solo testo). Parametri per numero di righe testo, chip, azioni e item lista.

### Input / props

- `layout` (`SkeletonLayout`) - Obbligatorietà: opzionale. Default `'header'`. Valori: `'header'`, `'card'`, `'list'`, `'text'`.
- `actionsCount` (`number`) - Obbligatorietà: opzionale. Default `0`. Numero placeholder pulsanti.
- `chipsCount` (`number`) - Obbligatorietà: opzionale. Default `0`. Numero placeholder chip.
- `hideActionsMobile` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `textLines` (`number`) - Obbligatorietà: opzionale. Default `0` (usa default del layout).
- `listCount` (`number`) - Obbligatorietà: opzionale. Default `3`. Item in layout `list`.

### Output / eventi

Nessuno

### Stati UI

- Loading (è esso stesso il loading state)

### Note di confidenza

Verificato dal codice

---

## EntityScrollToTopComponent

### Nome nel codice

`EntityScrollToTopComponent`

### Nome wiki suggerito

`EntityScrollToTopComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-scroll-to-top/entity-scroll-to-top.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-scroll-to-top/entity-scroll-to-top.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-scroll-to-top/entity-scroll-to-top.component.css`

### Selector o entrypoint

`app-entity-scroll-to-top`

### Tipo

Widget — bottone torna in cima

### Responsabilità

Pulsante FAB per scrollare la pagina in cima. La visibilità è controllata dall'esterno tramite `isVisible`. Usa `window.scrollTo({ top: 0, behavior: 'smooth' })`.

### Child components

- `IconComponent`

### Input / props

- `isVisible` (`boolean`) - Obbligatorietà: obbligatoria. Controlla visibilità del bottone.

### Output / eventi

Nessuno

### Note di confidenza

Verificato dal codice

---

## EntityShareComponent

### Nome nel codice

`EntityShareComponent`

### Nome wiki suggerito

`EntityShareComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-share/entity-share.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-share/entity-share.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-share/entity-share.component.css`

### Selector o entrypoint

`app-entity-share`

### Tipo

Widget — condivisione social/link

### Responsabilità

UI condivisione contenuto. Supporta share nativo (API Web Share), copia link negli appunti, condivisione WhatsApp. Mostra feedback "Copiato" tramite `hasCopiedLink`/`copiedMessage`.

### Child components

- `EntityCardBigComponent`

### Input / props

- `shareUrl` (`string`) - Obbligatorietà: obbligatoria. URL da condividere.
- `summaryText` (`string`) - Obbligatorietà: opzionale. Testo di anteprima.
- `canUseNativeShare` (`boolean`) - Obbligatorietà: opzionale. Abilita bottone share nativo.
- `hasCopiedLink` (`boolean`) - Obbligatorietà: opzionale. Stato dopo copia link.
- `copiedMessage` (`string`) - Obbligatorietà: opzionale. Testo feedback copia.

### Output / eventi

- `nativeShare` (`void`) - Emesso al click share nativo.
- `copyLink` (`void`) - Emesso al click copia link.

### Note di confidenza

Verificato dal codice

---

## EntityAdsComponent

### Nome nel codice

`EntityAdsComponent`

### Nome wiki suggerito

`EntityAdsComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-ads/entity-ads.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-ads/entity-ads.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-ads/entity-ads.component.css`

### Selector o entrypoint

`app-entity-ads`

### Tipo

Widget — banner pubblicitario

### Responsabilità

Wrapper per Google AdSense (`ng2-adsense`). Supporta modalità card e compatta mobile. Applica classe host `entity-ads--card` tramite `@HostBinding`.

### Input / props

- `adClient` (`string`) - Obbligatorietà: obbligatoria. ID publisher AdSense.
- `adSlot` (`number`) - Obbligatorietà: obbligatoria. ID slot AdSense.
- `cardMode` (`boolean`) - Obbligatorietà: opzionale. Default `false`. Modalità card.
- `compactMobile` (`boolean`) - Obbligatorietà: opzionale. Default `false`.

### Output / eventi

Nessuno

### Note di confidenza

Verificato dal codice

---

## EntityBottomNavComponent

### Nome nel codice

`EntityBottomNavComponent`

### Nome wiki suggerito

`EntityBottomNavComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-bottom-nav/entity-bottom-nav.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-bottom-nav/entity-bottom-nav.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-bottom-nav/entity-bottom-nav.component.css`

### Selector o entrypoint

`app-entity-bottom-nav`

### Tipo

Navigation — barra navigazione inferiore (mobile)

### Responsabilità

Bottom navigation bar mobile. Mostra link a home, canali, partite. Il pulsante "Crea" apre il drawer `MatchCreate` tramite `BusService.setQuickMatchOpen(true)`. Adatta i link in base allo stato di login.

### Parent components

- `AppComponent`

### Child components

- `IconComponent`

### Input / props

Nessuno

### Output / eventi

Nessuno

### Servizi frontend usati

- `UserService` — `isLoggedIn$`
- `BusService` — `setQuickMatchOpen(true)` al click "Crea"

### Note di confidenza

Verificato dal codice

---

## EntityFieldComponent

### Nome nel codice

`EntityFieldComponent`

### Nome wiki suggerito

`EntityFieldComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-field/entity-field.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-field/entity-field.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-field/entity-field.component.css`

### Selector o entrypoint

`app-entity-field`

### Tipo

Form — wrapper campo input

### Responsabilità

Wrapper accessibile per campi form. Genera `id`, `help-id`, `error-id` automatici da `fieldId`. Mostra label (opzionalmente nascosta), testo di aiuto e messaggio di errore.

### Input / props

- `fieldId` (`string`) - Obbligatorietà: opzionale.
- `label` (`string`) - Obbligatorietà: opzionale.
- `labelHidden` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `helpText` (`string`) - Obbligatorietà: opzionale.
- `helpTextVisible` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `hasError` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `errorMessage` (`string`) - Obbligatorietà: opzionale.

### Output / eventi

Nessuno

### Note di confidenza

Verificato dal codice

---

## EntityInfoComponent

### Nome nel codice

`EntityInfoComponent`

### Nome wiki suggerito

`EntityInfoComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-info/entity-info.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-info/entity-info.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-info/entity-info.component.css`

### Selector o entrypoint

`app-entity-info`

### Tipo

Widget — messaggio stato vuoto/informativo

### Responsabilità

Messaggio centralizzato con icona (default `circle-alert`), titolo e sottotitolo. Usato come stato vuoto nelle liste.

### Child components

- `IconComponent`

### Input / props

- `icon` (`string`) - Obbligatorietà: opzionale. Default `'circle-alert'`.
- `title` (`string`) - Obbligatorietà: opzionale.
- `subtitle` (`string`) - Obbligatorietà: opzionale.

### Output / eventi

Nessuno

### Note di confidenza

Verificato dal codice

---

## EntityCardBigComponent

### Nome nel codice

`EntityCardBigComponent`

### Nome wiki suggerito

`EntityCardBigComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-card-big/entity-card-big.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-card-big/entity-card-big.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-card-big/entity-card-big.component.css`

### Selector o entrypoint

`app-entity-card-big`

### Tipo

Widget — card grande con icona e testo

### Responsabilità

Card statica con icona grande, titolo e descrizione. Altezza minima configurabile.

### Child components

- `IconComponent`

### Input / props

- `icon` (`string`) - Obbligatorietà: opzionale.
- `title` (`string`) - Obbligatorietà: opzionale.
- `description` (`string`) - Obbligatorietà: opzionale.
- `minHeight` (`string`) - Obbligatorietà: opzionale. Altezza minima CSS.

### Output / eventi

Nessuno

### Note di confidenza

Verificato dal codice

---

## EntityCardSmallComponent

### Nome nel codice

`EntityCardSmallComponent`

### Nome wiki suggerito

`EntityCardSmallComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-card-small/entity-card-small.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-card-small/entity-card-small.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-card-small/entity-card-small.component.css`

### Selector o entrypoint

`app-entity-card-small`

### Tipo

Widget — card cliccabile compatta

### Responsabilità

Card cliccabile con icona colorata, titolo e descrizione. Supporto stato disabled e classi CSS aggiuntive.

### Child components

- `IconComponent`

### Input / props

- `icon` (`string`) - Obbligatorietà: opzionale.
- `iconBackgroundColor` (`string`) - Obbligatorietà: opzionale. Default `'transparent'`.
- `iconColor` (`string`) - Obbligatorietà: opzionale.
- `title` (`string`) - Obbligatorietà: opzionale.
- `description` (`string`) - Obbligatorietà: opzionale.
- `ariaLabel` (`string`) - Obbligatorietà: opzionale.
- `disabled` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `cardClass` (`string`) - Obbligatorietà: opzionale.

### Output / eventi

- `cardClick` (`MouseEvent`) - Emesso al click della card.

### Note di confidenza

Verificato dal codice

---

## EntityCardInfoComponent

### Nome nel codice

`EntityCardInfoComponent`

### Nome wiki suggerito

`EntityCardInfoComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-card-info/entity-card-info.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-card-info/entity-card-info.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-card-info/entity-card-info.component.css`

### Selector o entrypoint

`app-entity-card-info`

### Tipo

Widget — coppia label/valore

### Responsabilità

Coppia label+valore per visualizzare info sintetiche in card o header.

### Input / props

- `label` (`string`) - Obbligatorietà: opzionale.
- `value` (`string`) - Obbligatorietà: opzionale.

### Output / eventi

Nessuno

### Note di confidenza

Verificato dal codice

---

## EntityPageHeaderComponent

### Nome nel codice

`EntityPageHeaderComponent`

### Nome wiki suggerito

`EntityPageHeaderComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-page-header/entity-page-header.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-page-header/entity-page-header.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-page-header/entity-page-header.component.css`

### Selector o entrypoint

`app-entity-page-header`

### Tipo

Layout — header di pagina entità

### Responsabilità

Header strutturato per pagine di dettaglio (canale, squadra, partita). Supporta skeleton loading, immagine di sfondo, media clicabile (immagine o icona), badge, status dot, titolo, sottotitolo. Gestisce stato loading tramite `EntitySkeletonComponent`.

### Child components

- `IconComponent`, `EntitySkeletonComponent`

### Input / props

- `sectionClass` (`string`) - Obbligatorietà: opzionale.
- `isLoading` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `skeletonActionsCount` (`number`) - Obbligatorietà: opzionale. Default `0`.
- `skeletonChipsCount` (`number`) - Obbligatorietà: opzionale. Default `0`.
- `skeletonHideActionsMobile` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `title` (`string`) - Obbligatorietà: opzionale.
- `subtitle` (`string`) - Obbligatorietà: opzionale.
- `badgeText` (`string`) - Obbligatorietà: opzionale.
- `headerTopIcon` (`string`) - Obbligatorietà: opzionale.
- `headerTopDescription` (`string`) - Obbligatorietà: opzionale.
- `backgroundImageUrl` (`string`) - Obbligatorietà: opzionale.
- `mediaImageUrl` (`string`) - Obbligatorietà: opzionale.
- `mediaImageAlt` (`string`) - Obbligatorietà: opzionale.
- `mediaImageClass` (`string`) - Obbligatorietà: opzionale.
- `mediaIconName` (`string`) - Obbligatorietà: opzionale.
- `mediaIconSize` (`number`) - Obbligatorietà: opzionale. Default `24`.
- `mediaClickable` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `mediaAriaLabel` (`string`) - Obbligatorietà: opzionale.
- `showStatusDot` (`boolean`) - Obbligatorietà: opzionale. Default `false`.

### Output / eventi

- `mediaClick` (`void`) - Emesso al click della media area (solo se `mediaClickable`).

### Stati UI

- Loading (via `EntitySkeletonComponent`)

### Note di confidenza

Verificato dal codice

---

## EntityPageHeaderSkeletonComponent

### Nome nel codice

`EntityPageHeaderSkeletonComponent`

### Nome wiki suggerito

`EntityPageHeaderSkeletonComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-page-header/entity-page-header-skeleton.component.ts`

### Selector o entrypoint

`app-entity-page-header-skeleton`

### Tipo

Widget — skeleton header di pagina

### Responsabilità

Skeleton dedicato per l'header di pagina. Separato da `EntitySkeletonComponent` per ragioni di layout specifico.

### Input / props

- `asideCount` (`number`) - Obbligatorietà: opzionale. Default `4`. Pulsanti skeleton nell'aside.
- `copyBottomCount` (`number`) - Obbligatorietà: opzionale. Default `2`. Chip skeleton sotto il testo.
- `hideAsideMobile` (`boolean`) - Obbligatorietà: opzionale. Default `false`.

### Output / eventi

Nessuno

### Note di confidenza

Verificato dal codice

---

## EntityStatsGridComponent

### Nome nel codice

`EntityStatsGridComponent`

### Nome wiki suggerito

`EntityStatsGridComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/entity-stats-grid/entity-stats-grid.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/entity-stats-grid/entity-stats-grid.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/entity-stats-grid/entity-stats-grid.component.css`

### Selector o entrypoint

`app-entity-stats-grid`

### Tipo

Widget — griglia statistiche

### Responsabilità

Griglia di card statistiche cliccabili, ciascuna con icona, label e valore. Supporta modalità `fluid` (full-width).

### Modelli FE o DTO usati

- `StatsGridItem` (`{ icon, label, value }`)

### Input / props

- `items` (`StatsGridItem[]`) - Obbligatorietà: obbligatoria. Array di statistiche.
- `ariaLabel` (`string`) - Obbligatorietà: opzionale.
- `fluid` (`boolean`) - Obbligatorietà: opzionale. Default `false`.

### Output / eventi

- `itemSelected` (`number`) - Emesso al click di un item (indice).

### Note di confidenza

Verificato dal codice

---

## ChannelCardComponent

### Nome nel codice

`ChannelCardComponent`

### Nome wiki suggerito

`ChannelCardComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/channel-card/channel-card.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/channel-card/channel-card.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/channel-card/channel-card.component.css`

### Selector o entrypoint

`app-channel-card`

### Tipo

Widget — card canale

### Responsabilità

Card di anteprima canale pubblico. Estende `BaseCardComponent`. Mostra immagine canale da `environment.storageUrl`. Supporta click e navigazione da tastiera. Mostra opzionalmente le date delle partite.

### Parent components

- `ChannelCardListComponent`, `HomeLastChannelsComponent`

### Child components

Nessuno diretto (usa `DatePipe`, `UpperCasePipe`)

### Input / props

- `channel` (`channelPublicDto`) - Obbligatorietà: obbligatoria. Dati del canale.
- `showMatchDates` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `showClickEffect` (`boolean`) - Obbligatorietà: opzionale (da `BaseCard`). Default `true`.
- `compactMobile` (`boolean`) - Obbligatorietà: opzionale (da `BaseCard`). Default `false`.

### Output / eventi

- `channelClick` (`string`) - Emesso con `channel.id` al click.

### Modelli FE o DTO usati

- `channelPublicDto`

### Note di confidenza

Verificato dal codice

---

## ChannelCardListComponent

### Nome nel codice

`ChannelCardListComponent`

### Nome wiki suggerito

`ChannelCardListComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/channel-card-list/channel-card-list.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/channel-card-list/channel-card-list.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/channel-card-list/channel-card-list.component.css`

### Selector o entrypoint

`app-channel-card-list`

### Tipo

Section — lista paginata canali

### Responsabilità

Lista paginata di `ChannelCard` con skeleton loading, stato vuoto configurabile e banner AdSense opzionale con frequenza configurabile.

### Parent components

- `GChannelsComponent`

### Child components

- `ChannelCardComponent`, `EntityInfoComponent`, `EntityPaginationComponent`, `EntitySkeletonComponent`, `EntityAdsComponent`

### Input / props

- `channels` (`pageDto<channelPublicDto>`) - Obbligatorietà: obbligatoria.
- `isLoading` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `sectionId` (`string`) - Obbligatorietà: opzionale.
- `showMatchDates` (`boolean`) - Obbligatorietà: opzionale. Default `true`.
- `compactMobile` (`boolean`) - Obbligatorietà: opzionale. Default `true`.
- `emptyIcon` (`string`) - Obbligatorietà: opzionale. Default `'radio'`.
- `emptyTitle` (`string`) - Obbligatorietà: opzionale.
- `emptySubtitle` (`string`) - Obbligatorietà: opzionale.
- `paginationItemName` (`string`) - Obbligatorietà: opzionale. Default `'canali'`.
- `showResultsInfo` (`boolean`) - Obbligatorietà: opzionale. Default `true`.
- `adClient` (`string`) - Obbligatorietà: opzionale.
- `adSlot` (`number | null`) - Obbligatorietà: opzionale.
- `adsFrequency` (`number`) - Obbligatorietà: opzionale. Default `0`. Frequenza inserimento ads (ogni N card).

### Output / eventi

- `openChannel` (`string`) - Emesso con `channelId`.
- `pageChange` (`number`) - Emesso al cambio pagina.

### Modelli FE o DTO usati

- `pageDto<channelPublicDto>`

### Stati UI

- Loading (skeleton), Empty, Normal

### Note di confidenza

Verificato dal codice

---

## ChannelTablesComponent

### Nome nel codice

`ChannelTablesComponent`

### Nome wiki suggerito

`ChannelTablesComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/channel-tables/channel-tables.component.ts`

### Selector o entrypoint

`app-channel-tables`

### Tipo

Widget — classifica canale

### Responsabilità

Tabella classifica squadre del canale (partite giocate, vinte, pareggiate, perse, punti fatti/subiti/differenza).

### Child components

- `EntityInfoComponent`

### Input / props

- `tables` (`channelTableDto[] | undefined`) - Obbligatorietà: opzionale.

### Output / eventi

Nessuno

### Modelli FE o DTO usati

- `channelTableDto`

### Note di confidenza

Verificato dal codice

---

## ChannelTeamsComponent

### Nome nel codice

`ChannelTeamsComponent`

### Nome wiki suggerito

`ChannelTeamsComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/channel-teams/channel-teams.component.ts`

### Selector o entrypoint

`app-channel-teams`

### Tipo

Widget — lista squadre canale

### Responsabilità

Lista squadre di un canale con logo e nome. Cliccando su una squadra emette `openTeam`. Logo da `storage-sh.rugbyradiolive.com`.

### Child components

- `EntityInfoComponent`

### Input / props

- `teams` (`teamChannelDto[] | null | undefined`) - Obbligatorietà: opzionale.

### Output / eventi

- `openTeam` (`string`) - Emesso con `teamId` al click squadra.

### Modelli FE o DTO usati

- `teamChannelDto`

### Note di confidenza

Verificato dal codice

---

## MatchCardComponent

### Nome nel codice

`MatchCardComponent`

### Nome wiki suggerito

`MatchCardComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/match-card/match-card.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/match-card/match-card.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/match-card/match-card.component.css`

### Selector o entrypoint

`app-match-card`

### Tipo

Widget — card partita (editor)

### Responsabilità

Card partita per l'area editor (utente loggato). Estende `BaseCardComponent`. Naviga a `/g-match/{id}` al click. Mostra bottone "LIVE" per partite in corso/programmate e bottone "Modifica". Naviga a `/user-match/{id}` al click LIVE.

### Parent components

- Usato nell'area editor utente

### Child components

- `EntityButtonComponent`, `IconComponent`

### Input / props

- `match` (`matchMinDto`) - Obbligatorietà: obbligatoria.
- `isEditEnabled` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `showClickEffect` (`boolean`) - Obbligatorietà: opzionale (da `BaseCard`).
- `compactMobile` (`boolean`) - Obbligatorietà: opzionale (da `BaseCard`).

### Output / eventi

- `editMatch` (`string`) - Emesso con `match.id` al click modifica.

### Modelli FE o DTO usati

- `matchMinDto`, `matchStatus`

### Note di confidenza

Verificato dal codice

---

## MatchCardSmallComponent

### Nome nel codice

`MatchCardSmallComponent`

### Nome wiki suggerito

`MatchCardSmallComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/match-card-small/match-card-small.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/match-card-small/match-card-small.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/match-card-small/match-card-small.component.css`

### Selector o entrypoint

`app-match-card-small`

### Tipo

Widget — card partita compatta (pubblica)

### Responsabilità

Card partita compatta per visualizzazione pubblica e home page. Estende `BaseCardComponent`. Mostra immagine partita con fallback a originale. Emette `matchClick` senza navigare direttamente (navigazione delegata al parent).

### Parent components

- `MatchCardListComponent`, `HomeLastMatchesComponent`, `HomeNextMatchesComponent`, `HomeOngoingMatchesComponent`

### Input / props

- `match` (`ExtendedMatchMinDto`) - Obbligatorietà: obbligatoria. Estende `matchMinDto` con colori canale.
- `showClickEffect` (`boolean`) - Obbligatorietà: opzionale (da `BaseCard`).
- `compactMobile` (`boolean`) - Obbligatorietà: opzionale (da `BaseCard`).

### Output / eventi

- `matchClick` (`string`) - Emesso con `match.id`.

### Modelli FE o DTO usati

- `matchMinDto`

### Note di confidenza

Verificato dal codice

---

## MatchCardListComponent

### Nome nel codice

`MatchCardListComponent`

### Nome wiki suggerito

`MatchCardListComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/match-card-list/match-card-list.component.ts`

### Selector o entrypoint

`app-match-card-list`

### Tipo

Section — lista paginata partite

### Responsabilità

Lista paginata di `MatchCardSmall` con skeleton loading, stato vuoto e AdSense opzionale.

### Parent components

- `GChannelComponent`, `GMatchesComponent`, `GTeamComponent`

### Child components

- `MatchCardSmallComponent`, `EntityPaginationComponent`, `EntityInfoComponent`, `EntitySkeletonComponent`, `EntityAdsComponent`

### Input / props

- `matches` (`pageDto<matchMinDto>`) - Obbligatorietà: obbligatoria.
- `isLoading` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `wrapInSection` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `sectionId` (`string`) - Obbligatorietà: opzionale.
- `compactMobile` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `emptyIcon` (`string`) - Obbligatorietà: opzionale. Default `'calendar-days'`.
- `emptyTitle` (`string`) - Obbligatorietà: opzionale.
- `emptySubtitle` (`string`) - Obbligatorietà: opzionale.
- `adClient` (`string`) - Obbligatorietà: opzionale.
- `adSlot` (`number | null`) - Obbligatorietà: opzionale.
- `adsFrequency` (`number`) - Obbligatorietà: opzionale. Default `0`.

### Output / eventi

- `openMatch` (`string`) - Emesso con `matchId`.
- `pageChange` (`number`) - Emesso al cambio pagina.

### Stati UI

- Loading, Empty, Normal

### Note di confidenza

Verificato dal codice

---

## MatchCommentatorComponent

### Nome nel codice

`MatchCommentatorComponent`

### Nome wiki suggerito

`MatchCommentatorComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/match-commentator/match-commentator.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/match-commentator/match-commentator.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/match-commentator/match-commentator.component.css`

### Selector o entrypoint

`app-match-commentator`

### Tipo

Widget — selettore telecronista

### Responsabilità

Drawer per selezionare il telecronista (talker) e la lingua. Supporta 10 stili di telecronista (Arcaico, Influencer, Adolescente, Alieno, ExPlayer, Chef, Milanese, Rapper, Romano, Telecronista) per 5 lingue (IT, EN, FR, ES, JA). Riproduce preview audio tramite `VoiceService`. Persiste la scelta tramite `UserService`.

### Parent components

- `GMatchEventsComponent`

### Child components

- `EntityButtonComponent`, `IconComponent`

### Input / props

Nessuno

### Output / eventi

- `commentatorChanged` (`string`) - Emesso con ID del telecronista selezionato.

### Servizi frontend usati

- `UserService` — `getCommentatorId()`
- `VoiceService` — riproduzione audio preview
- `LoggingService`

### Stati UI

- Drawer aperto/chiuso (`isDrawerVisible`)
- Audio in riproduzione (`isPlayingAudio`)
- Lingua tab attiva (`activeLanguage`)
- Descrizione espansa (`expandedDescriptionId`)

### Note di confidenza

Verificato dal codice

---

## MatchEventsComponent

### Nome nel codice

`MatchEventsComponent`

### Nome wiki suggerito

`MatchEventsComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/match-events/match-events.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/match-events/match-events.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/match-events/match-events.component.css`

### Selector o entrypoint

`app-match-events`

### Tipo

Section — feed eventi partita

### Responsabilità

Feed degli eventi di una partita in tempo reale. Supporta modalità editor (aggiunta/eliminazione eventi, reazioni emoji) e visualizzazione pubblica. Riproduce audio telecronaca tramite `VoiceService`. Mostra commenti, reazioni, blog. Usa emoji picker (`@chit-chat/ngx-emoji-picker`).

### Parent components

- `GMatchEventsComponent`

### Child components

- `EntityAdsComponent`, `EntityAlertComponent`, `EntityButtonComponent`, `IconComponent`, `EmojiPickerComponent`

### Input / props

- `match` (`matchDto | null`) - Obbligatorietà: obbligatoria (setter che aggiorna disponibilità audio).
- `blog` (`blogDto | null`) - Obbligatorietà: opzionale.
- `isEditMode` (`boolean`) - Obbligatorietà: opzionale. Default `false`.

### Output / eventi

- `matchChange` (`matchDto`) - Emesso dopo operazioni che modificano la partita.

### Servizi frontend usati

- `MatchService` — aggiunta/eliminazione eventi, reazioni, commenti
- `UserService` — stato login, ID utente
- `VoiceService` — riproduzione audio evento
- `AnalyticsService`, `ErrorHandlerService`, `LoggingService`

### Modelli FE o DTO usati

- `matchDto`, `matchEventDto`, `playerDto`, `blogDto`

### Stati UI

- Audio in riproduzione (`isPlayingAudio`)
- Blog espanso (`isBlogExpanded`)
- Disponibilità audio commentatore (`isCommentatorAudioAvailable`)

### Note di confidenza

Verificato dal codice

---

## MatchHeaderComponent

### Nome nel codice

`MatchHeaderComponent`

### Nome wiki suggerito

`MatchHeaderComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/match-header/match-header.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/match-header/match-header.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/match-header/match-header.component.css`

### Selector o entrypoint

`app-match-header`

### Tipo

Layout — header partita

### Responsabilità

Header visuale della partita. Mostra squadre, punteggio, minuto, stato, immagine sfondo. Colori derivati da `channel.headerBgColor`/`headerFtColor` con gradiente semi-trasparente. Immagine da `environment.storageUrl`.

### Parent components

- `GMatchComponent`, `MatchComponent` (user)

### Input / props

- `match` (`matchDto | null`) - Obbligatorietà: opzionale.
- `isLoading` (`boolean | null`) - Obbligatorietà: opzionale.
- `isStarted` (`boolean | null`) - Obbligatorietà: opzionale.
- `isHalfTime` (`boolean | null`) - Obbligatorietà: opzionale.
- `isFullTime` (`boolean | null`) - Obbligatorietà: opzionale.
- `isEditor` (`boolean | null`) - Obbligatorietà: opzionale. Default `false`.
- `showBackgroundImage` (`boolean`) - Obbligatorietà: opzionale. Default `true`.

### Output / eventi

Nessuno

### Modelli FE o DTO usati

- `matchDto`

### Note di confidenza

Verificato dal codice

---

## MatchLineupComponent

### Nome nel codice

`MatchLineupComponent`

### Nome wiki suggerito

`MatchLineupComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/match-lineup/match-lineup.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/match-lineup/match-lineup.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/match-lineup/match-lineup.component.css`

### Selector o entrypoint

`app-match-lineup`

### Tipo

Section — formazione partita

### Responsabilità

Visualizza e gestisce la formazione di una squadra. In modalità editor consente di assegnare/rimuovere giocatori ai ruoli (1–23), creare nuovi giocatori inline, votare i giocatori post-partita. Usa drawer animato (`rrlSheetAnimations`) e `NgSelect` per selezione giocatori.

### Parent components

- `GMatchComponent`

### Child components

- `EntityAlertComponent`, `EntityButtonComponent`, `EntityInfoComponent`, `IconComponent`

### Input / props

- `match` (`matchDto | null`) - Obbligatorietà: opzionale.
- `team` (`teamDto | undefined`) - Obbligatorietà: opzionale.
- `lineup` (`lineupPlayerDto[] | undefined`) - Obbligatorietà: opzionale.
- `lineupRates` (`string[] | undefined`) - Obbligatorietà: opzionale.
- `players` (`playerDto[] | null`) - Obbligatorietà: opzionale.
- `isStarted` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `isFullTime` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `isEditMode` (`boolean`) - Obbligatorietà: opzionale. Default `false`.

### Output / eventi

- `matchChange` (`matchDto`) - Emesso dopo operazioni che modificano la partita.
- `playersChange` (`void`) - Emesso dopo aggiornamento lista giocatori.

### Servizi frontend usati

- `MatchService` — aggiornamento ruolo, aggiunta giocatore, rimozione, voto
- `LineupService`
- `UserService`, `ErrorHandlerService`, `ToastService`, `LoggingService`

### Modelli FE o DTO usati

- `matchDto`, `teamDto`, `lineupPlayerDto`, `playerDto`

### Note di confidenza

Verificato dal codice

---

## MatchStatsComponent

### Nome nel codice

`MatchStatsComponent`

### Nome wiki suggerito

`MatchStatsComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/match-stats/match-stats.component.ts`

### Selector o entrypoint

`app-match-stats`

### Tipo

Section — statistiche partita

### Responsabilità

Sezione statistiche comparative (barre percentuali home/away) per: meta, conversione, punizione, cartellini giallo/rosso, infortuni. Timeline cronologica degli eventi di punteggio.

### Parent components

- `GMatchComponent`

### Input / props

- `match` (`matchDto | null`) - Obbligatorietà: opzionale.

### Output / eventi

Nessuno

### Modelli FE o DTO usati

- `matchDto`, `matchScoreboardTimelineItemDto`

### Note di confidenza

Verificato dal codice

---

## MatchCreateComponent

### Nome nel codice

`MatchCreateComponent`

### Nome wiki suggerito

`MatchCreateComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/match-create/match-create.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/match-create/match-create.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/match-create/match-create.component.css`

### Selector o entrypoint

`app-match-create`

### Tipo

Modal/Form — wizard creazione partita rapida

### Responsabilità

Drawer full-screen wizard a step per la creazione rapida di una partita. Step 0: selezione canale; Step 1: selezione squadre; Step 2: riepilogo e conferma. Supporta canali/squadre esistenti o nuovi. Blocco scroll body (`enableBodyScrollLock = true`). Usa animazioni drawer.

### Parent components

- `AppComponent`, `HomeUserComponent`

### Child components

- `EntityButtonComponent`, `EntityFieldComponent`, `IconComponent`

### Input / props

- `channels` (`channelDto[]`) - Obbligatorietà: opzionale. Default `[]`.
- `teams` (`teamMinDto[]`) - Obbligatorietà: opzionale. Default `[]`.
- `isVisible` (`boolean`) - Obbligatorietà: opzionale (da `BaseModal`).

### Output / eventi

- `closeModal` (`void`) - Da `BaseModal`.
- `visibleChange` (`boolean`) - Emesso al cambio visibilità.
- `matchCreated` (`string`) - Emesso con ID partita creata.
- `dataRefreshNeeded` (`void`) - Emesso quando i dati devono essere ricaricati.

### Servizi frontend usati

- `MatchService` — `addMatchQuick`
- `LoggingService`

### Modelli FE o DTO usati

- `channelDto`, `teamMinDto`, `matchQuickAddDto`, `matchQuickItemAddDto`

### Stati UI

- Step wizard (0, 1, 2)
- Saving (`quickMatchOnSaving`)

### Note di confidenza

Verificato dal codice

---

## PlayerEditComponent

### Nome nel codice

`PlayerEditComponent`

### Nome wiki suggerito

`PlayerEditComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/player-edit/player-edit.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/player-edit/player-edit.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/player-edit/player-edit.component.css`

### Selector o entrypoint

`app-player-edit`

### Tipo

Modal/Form — drawer modifica/eliminazione giocatore

### Responsabilità

Drawer per creazione/modifica/eliminazione giocatore. Form reattivo con validazione (`maxLength(20)`, numero ruolo 1-23). Supporta modalità delete (`isDeleteMode`).

### Parent components

- Usato nell'area editor partita

### Child components

- `EntityAlertComponent`, `EntityButtonComponent`, `EntityFieldComponent`, `IconComponent`

### Input / props

- `player` (`playerDto`) - Obbligatorietà: opzionale (default `{}` as playerDto).
- `isDeleteMode` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `isVisible` (`boolean`) - Obbligatorietà: opzionale (da `BaseModal`).

### Output / eventi

- `closeModal` (`void`) - Da `BaseModal`.
- `savePlayer` (`PlayerSaveData`) - Emesso con dati giocatore al salvataggio.
- `deletePlayer` (`void`) - Emesso alla conferma eliminazione.

### Modelli FE o DTO usati

- `playerDto`, `PlayerSaveData` (`{ name, nickname, avatarUrl, defaultNumber }`)

### Note di confidenza

Verificato dal codice

---

## TeamEditComponent

### Nome nel codice

`TeamEditComponent`

### Nome wiki suggerito

`TeamEditComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/team-edit/team-edit.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/team-edit/team-edit.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/team-edit/team-edit.component.css`

### Selector o entrypoint

`app-team-edit`

### Tipo

Modal/Form — drawer modifica squadra

### Responsabilità

Drawer per creazione/modifica squadra. Form reattivo con validazione (`required`, `maxLength(20)`). Selettore logo da lista disponibile (`teamLogoDto`). Il titolo del drawer differisce tra creazione e modifica in base a `team.id`.

### Parent components

- Usato nell'area editor canale

### Child components

- `EntityButtonComponent`, `EntityFieldComponent`, `IconComponent`

### Input / props

- `team` (`teamChannelDto`) - Obbligatorietà: opzionale. Default `{}`.
- `teamLogos` (`teamLogoDto`) - Obbligatorietà: opzionale. Dizionario logo disponibili.
- `isVisible` (`boolean`) - Obbligatorietà: opzionale (da `BaseModal`).

### Output / eventi

- `closeModal` (`void`) - Da `BaseModal`.
- `saveTeam` (`{ name, nickname, logoUrl }`) - Emesso al salvataggio.
- `logoChange` (`string`) - Emesso al cambio logo.

### Modelli FE o DTO usati

- `teamChannelDto`, `teamLogoDto`

### Note di confidenza

Verificato dal codice

---

## HomeGridComponent

### Nome nel codice

`HomeGridComponent<T>`

### Nome wiki suggerito

`HomeGridComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/home-grid/home-grid.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/common/home-grid/home-grid.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/common/home-grid/home-grid.component.css`

### Selector o entrypoint

`app-home-grid`

### Tipo

Layout — griglia/carosello home

### Responsabilità

Componente generico `<T>` per le sezioni home. Renderizza item tramite `TemplateRef` con supporto carosello orizzontale scrollabile, navigazione frecce, skeleton loading, pulsante "Vedi tutti". Configurato tramite `HomeListConfig`.

### Parent components

- `HomeLastChannelsComponent`, `HomeLastMatchesComponent`, `HomeNextMatchesComponent`, `HomeOngoingMatchesComponent`

### Child components

Nessuno diretto (usa `NgTemplateOutlet`)

### Input / props

- `items` (`pageDto<T>`) - Obbligatorietà: obbligatoria. Dati da renderizzare.
- `config` (`HomeListConfig`) - Obbligatorietà: obbligatoria. Configurazione titolo, route "vedi tutti", larghezza item, comportamento mobile.
- `itemTemplate` (`TemplateRef<{ $implicit: T }>`) - Obbligatorietà: obbligatoria. Template per ogni item.
- `showClickEffect` (`boolean`) - Obbligatorietà: opzionale. Default `true`.
- `isLoading` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `skeletonCount` (`number`) - Obbligatorietà: opzionale. Default `4`.

### Output / eventi

- `itemClick` (`T`) - Emesso al click su un item.

### Modelli FE o DTO usati

- `pageDto<T>`, `HomeListConfig`

### Stati UI

- Loading (skeleton), Normale (carosello con indicatori slide)

### Note di confidenza

Verificato dal codice

---

## HeaderComponent

### Nome nel codice

`HeaderComponent`

### Nome wiki suggerito

`HeaderComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/header/header.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/site/header/header.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/site/header/header.component.css`

### Selector o entrypoint

`app-header`

### Tipo

Navigation — header globale

### Responsabilità

Header globale dell'applicazione. Gestisce menu burger, menu lingua (IT, EN, FR, ES, JA), stato login utente, back button, titolo pagina, compatibilità TWA. Collapse al scroll. Si chiude al click esterno tramite `@HostListener('document:click')`.

### Parent components

- `AppComponent`

### Child components

- `IconComponent`

### Input / props

Nessuno

### Output / eventi

Nessuno

### Servizi frontend usati

- `UserService` — `isLoggedIn$`, `userNickname$`, lingua
- `BusService` — gestione eventi globali
- `PlatformService` — `isTwa`, `isMobile`
- `LoggingService`

### Note di confidenza

Verificato dal codice

---

## FooterComponent

### Nome nel codice

`FooterComponent`

### Nome wiki suggerito

`FooterComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/footer/footer.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/site/footer/footer.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/site/footer/footer.component.css`

### Selector o entrypoint

`app-footer`

### Tipo

Layout — footer globale

### Responsabilità

Footer statico dell'applicazione.

### Parent components

- `AppComponent`

### Child components

- `IconComponent`

### Input / props

Nessuno

### Output / eventi

Nessuno

### Note di confidenza

Verificato dal codice

---

## HomeSplashComponent

### Nome nel codice

`HomeSplashComponent`

### Nome wiki suggerito

`HomeSplashComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-splash/home-splash.component.ts`

### Selector o entrypoint

`app-home-splash`

### Tipo

Section — schermata di benvenuto

### Responsabilità

Schermata splash di onboarding mostrata al primo accesso. Selettore lingua, pulsanti "Accedi" e "Continua". Persiste la scelta "splash nascosto" tramite `UserService`. Naviga a `/user-login` al click "Accedi".

### Parent pages

- `HomeComponent`

### Child components

- `EntityButtonComponent`

### Servizi frontend usati

- `UserService` — `setSplashHidden`, `getUserLanguage`, `setUserLanguage`
- `BusService`

### Note di confidenza

Verificato dal codice

---

## HomeLogoComponent

### Nome nel codice

`HomeLogoComponent`

### Nome wiki suggerito

`HomeLogoComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-logo/home-logo.component.ts`

### Selector o entrypoint

`app-home-logo`

### Tipo

Section — hero logo home

### Responsabilità

Sezione hero con logo e branding principale della home page.

### Parent pages

- `HomeComponent`

### Note di confidenza

Parzialmente dedotto (corpo non letto nel dettaglio)

---

## HomeFaqComponent

### Nome nel codice

`HomeFaqComponent`

### Nome wiki suggerito

`HomeFaqComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-faq/home-faq.component.ts`

### Selector o entrypoint

`app-home-faq`

### Tipo

Section — FAQ

### Responsabilità

Sezione FAQ della home page. Contenuto statico.

### Parent pages

- `HomeComponent`

### Note di confidenza

Parzialmente dedotto

---

## HomeFeaturesComponent

### Nome nel codice

`HomeFeaturesComponent`

### Nome wiki suggerito

`HomeFeaturesComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-features/home-features.component.ts`

### Selector o entrypoint

`app-home-features`

### Tipo

Section — features prodotto

### Responsabilità

Sezione con le funzionalità principali della piattaforma. Contenuto statico.

### Parent pages

- `HomeComponent`

### Note di confidenza

Parzialmente dedotto

---

## HomeHelpComponent

### Nome nel codice

`HomeHelpComponent`

### Nome wiki suggerito

`HomeHelpComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-help/home-help.component.ts`

### Selector o entrypoint

`app-home-help`

### Tipo

Section — supporto/aiuto

### Responsabilità

Sezione di supporto/help della home page.

### Parent pages

- `HomeComponent`

### Note di confidenza

Parzialmente dedotto

---

## HomeLastChannelsComponent

### Nome nel codice

`HomeLastChannelsComponent`

### Nome wiki suggerito

`HomeLastChannelsComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-last-channels/home-last-channels.component.ts`

### Selector o entrypoint

`app-home-last-channels`

### Tipo

Section — ultimi canali (home)

### Responsabilità

Carosello ultimi canali nella home page. Carica i canali via `ChannelService.findChannels`. Usa `HomeGridComponent` con template `ChannelCardComponent`. Navigazione a `/g-channels` per "Vedi tutti".

### Parent pages

- `HomeComponent`

### Child components

- `HomeGridComponent`, `ChannelCardComponent`

### Servizi frontend usati

- `ChannelService` — `findChannels('', 1)`

### Modelli FE o DTO usati

- `pageDto<channelPublicDto>`

### Note di confidenza

Verificato dal codice

---

## HomeLastMatchesComponent

### Nome nel codice

`HomeLastMatchesComponent`

### Nome wiki suggerito

`HomeLastMatchesComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-last-matches/home-last-matches.component.ts`

### Selector o entrypoint

`app-home-last-matches`

### Tipo

Section — ultime partite (home)

### Responsabilità

Carosello ultime partite disputate. Carica via `MatchService.findMatches('', 1, 30)`. Usa `HomeGridComponent` con `MatchCardSmallComponent`.

### Parent pages

- `HomeComponent`

### Child components

- `HomeGridComponent`, `MatchCardSmallComponent`

### Servizi frontend usati

- `MatchService` — `findMatches`

### Note di confidenza

Verificato dal codice

---

## HomeNextMatchesComponent

### Nome nel codice

`HomeNextMatchesComponent`

### Nome wiki suggerito

`HomeNextMatchesComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-next-matches/home-next-matches.component.ts`

### Selector o entrypoint

`app-home-next-matches`

### Tipo

Section — prossime partite (home)

### Responsabilità

Carosello prossime partite programmate. Carica via `MatchService.findMatches('', 1, 10)`.

### Parent pages

- `HomeComponent`

### Child components

- `HomeGridComponent`, `MatchCardSmallComponent`

### Servizi frontend usati

- `MatchService` — `findMatches`

### Note di confidenza

Verificato dal codice

---

## HomeOngoingMatchesComponent

### Nome nel codice

`HomeOngoingMatchesComponent`

### Nome wiki suggerito

`HomeOngoingMatchesComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-ongoing-matches/home-ongoing-matches.component.ts`

### Selector o entrypoint

`app-home-ongoing-matches`

### Tipo

Section — partite in corso (home)

### Responsabilità

Carosello partite in corso. Carica via `MatchService.findMatches('', 1, 20)` con filtro stato in progress.

### Parent pages

- `HomeComponent`

### Child components

- `HomeGridComponent`, `MatchCardSmallComponent`

### Servizi frontend usati

- `MatchService` — `findMatches`

### Note di confidenza

Verificato dal codice

---

## HomeTutorialComponent

### Nome nel codice

`HomeTutorialComponent`

### Nome wiki suggerito

`HomeTutorialComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-tutorial/home-tutorial.component.ts`

### Selector o entrypoint

`app-home-tutorial`

### Tipo

Section — tutorial

### Responsabilità

Sezione tutorial/guida per nuovi utenti. Contenuto probabilmente statico.

### Parent pages

- `HomeComponent`

### Note di confidenza

Parzialmente dedotto

---

## HomeUserComponent

### Nome nel codice

`HomeUserComponent`

### Nome wiki suggerito

`HomeUserComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-user/home-user.component.ts`

### Selector o entrypoint

`app-home-user`

### Tipo

Section — dashboard utente loggato (home)

### Responsabilità

Dashboard utente nella home page. Mostra profilo, statistiche canali/partite, lista partite in corso, pulsante "Crea partita" che apre `MatchCreateComponent`. Carica profilo, canali, squadre e partita training.

### Parent pages

- `HomeComponent`

### Child components

- `MatchCreateComponent`, `EntityPageHeaderComponent`, `EntitySectionComponent`, `EntityStatsGridComponent`, `EntityButtonComponent`

### Servizi frontend usati

- `UserService`, `MatchService`, `ChannelService`, `TeamService`, `LoggingService`, `AnalyticsService`

### Modelli FE o DTO usati

- `channelDto`, `teamMinDto`, `matchChannelDto`, `userProfileDto`

### Note di confidenza

Verificato dal codice

---

## HomeWhoComponent

### Nome nel codice

`HomeWhoComponent`

### Nome wiki suggerito

`HomeWhoComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-who/home-who.component.ts`

### Selector o entrypoint

`app-home-who`

### Tipo

Section — chi siamo (home)

### Responsabilità

Sezione "Chi siamo" della home page. Contenuto statico.

### Parent pages

- `HomeComponent`

### Note di confidenza

Parzialmente dedotto

---

## HomeWhyComponent

### Nome nel codice

`HomeWhyComponent`

### Nome wiki suggerito

`HomeWhyComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home-why/home-why.component.ts`

### Selector o entrypoint

`app-home-why`

### Tipo

Section — perché sceglierci (home)

### Responsabilità

Sezione "Perché Rugby Radio Live" della home page. Contenuto statico.

### Parent pages

- `HomeComponent`

### Note di confidenza

Parzialmente dedotto

---

## GBaseUserComponent

### Nome nel codice

`GBaseUserComponent`

### Nome wiki suggerito

`GBaseUserComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-base-user/g-base-user.component.ts`

### Selector o entrypoint

`app-g-base-user`

### Tipo

Altro — Base component per pagine globali

### Responsabilità

Classe base per le pagine globali pubbliche (`GChannel`, `GMatch`, `GMatches`, `GChannels`, `GTeam`, `GStats`). Fornisce gestione titolo pagina, stato loading, profilo utente, bus service, error handler, toast.

### Servizi frontend usati

- `UserService`, `BusService`, `ErrorHandlerService`, `ToastService`, `LoggingService`, `TranslateService`, `Title`

### Note di confidenza

Verificato dal codice

---

## GMatchEventsComponent

### Nome nel codice

`GMatchEventsComponent`

### Nome wiki suggerito

`GMatchEventsComponent (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.ts`

### Template

- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.html`

### Stili collegati

- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.css`

### Selector o entrypoint

`app-g-match-events`

### Tipo

Section — sezione eventi della partita pubblica

### Responsabilità

Wrapper degli eventi partita nella vista pubblica `GMatch`. Aggrega `MatchEventsComponent` e `MatchCommentatorComponent`. Gestisce FAB del commentatore (immagine telecronista corrente), apertura/chiusura pannello settings telecronista.

### Parent pages

- `GMatchComponent`

### Child components

- `MatchEventsComponent`, `MatchCommentatorComponent`, `EntityAlertComponent`, `EntityButtonComponent`, `IconComponent`

### Input / props

- `match` (`matchDto | null`) - Obbligatorietà: opzionale.
- `blog` (`blogDto | null`) - Obbligatorietà: opzionale.
- `isUserLoggedIn` (`boolean | null`) - Obbligatorietà: opzionale. Default `false`.
- `isStarted` (`boolean`) - Obbligatorietà: opzionale. Default `false`.
- `isFullTime` (`boolean`) - Obbligatorietà: opzionale. Default `false`.

### Output / eventi

- `editor` (`void`) - Richiesta apertura modalità editor.
- `login` (`void`) - Richiesta apertura login.
- `follow` (`void`) - Richiesta follow partita.
- `like` (`void`) - Richiesta like partita.
- `commentatorChange` (`void`) - Cambio telecronista avvenuto.
- `matchChange` (`matchDto`) - Partita aggiornata.

### Modelli FE o DTO usati

- `matchDto`, `blogDto`

### Stati UI

- Settings telecronista aperto/chiuso (`isSettingsOpen`)
- URL immagine telecronista corrente (`talkerFabImageUrl`)

### Note di confidenza

Verificato dal codice

---

## Candidati esclusi o incerti

---

## HomeComponent

### Motivo

Pagina route-level — registrata in `app.routes.ts` su path `/` e `/user-dashboard`

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home.component.ts`

---

## LoginComponent

### Motivo

Pagina route-level — `/user-login`

### File sorgente

- `src/RugbyRadioWeb/src/app/user/login/login.component.ts`

---

## RegistrationComponent

### Motivo

Pagina route-level — `/user-registration`

### File sorgente

- `src/RugbyRadioWeb/src/app/user/registration/registration.component.ts`

---

## ResetPasswordComponent

### Motivo

Pagina route-level — `/user-reset-password`

### File sorgente

- `src/RugbyRadioWeb/src/app/user/reset-password/reset-password.component.ts`

---

## ProfileComponent

### Motivo

Pagina route-level — `/user-profile`

### File sorgente

- `src/RugbyRadioWeb/src/app/user/profile/profile.component.ts`

---

## ChannelsComponent

### Motivo

Pagina route-level — `/user-channels`

### File sorgente

- `src/RugbyRadioWeb/src/app/user/channels/channels.component.ts`

---

## ChannelComponent

### Motivo

Pagina route-level — `/user-channel/:channelId`

### File sorgente

- `src/RugbyRadioWeb/src/app/user/channel/channel.component.ts`

---

## MatchComponent

### Motivo

Pagina route-level — `/user-match/:matchId`

### File sorgente

- `src/RugbyRadioWeb/src/app/user/match/match.component.ts`

---

## DangerComponent

### Motivo

Pagina route-level — `/user-danger`

### File sorgente

- `src/RugbyRadioWeb/src/app/user/danger/danger.component.ts`

---

## FavoritesComponent

### Motivo

Pagina route-level — `/user-favorites`

### File sorgente

- `src/RugbyRadioWeb/src/app/user/favorites/favorites.component.ts`

---

## GChannelComponent

### Motivo

Pagina route-level — `/g-channel/:channelPublicId`

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-channel/g-channel.component.ts`

---

## GMatchComponent

### Motivo

Pagina route-level — `/g-match/:matchId`

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.ts`

---

## GMatchesComponent

### Motivo

Pagina route-level — `/g-matches`

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-matches/g-matches.component.ts`

---

## GChannelsComponent

### Motivo

Pagina route-level — `/g-channels`

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-channels/g-channels.component.ts`

---

## GTeamComponent

### Motivo

Pagina route-level — `/g-team/:teamId`

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-team/g-team.component.ts`

---

## GStatsComponent

### Motivo

Pagina route-level — `/g-stats`

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-stats/g-stats.component.ts`

---

## GFeedbackComponent

### Motivo

Pagina route-level — `/g-feedback`

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-feedback/g-feedback.component.ts`

---

## AdminMaintenanceComponent

### Motivo

Pagina route-level (attiva solo in modalità maintenance) — `/admin-maintenance`

### File sorgente

- `src/RugbyRadioWeb/src/app/common/admin-maintenance/admin-maintenance.component.ts`

---

## Note finali

- Limiti dell'analisi: i template HTML, i file CSS e le sezioni home con contenuto solo statico (`HomeFaq`, `HomeFeatures`, `HomeHelp`, `HomeTutorial`, `HomeWho`, `HomeWhy`, `HomeLogo`) sono stati letti solo per il file TypeScript; i componenti `user/channel/*` (ChannelEditors, ChannelInfo, ChannelLayout, ChannelMatches, ChannelTeams), `user/match/*` (MatchEventModal, MatchEvents, MatchLive) sono presenti nel codebase ma non analizzati — sono sub-componenti interni alle pagine route-level editor.
- Elementi non deducibili: stili interni (variabili CSS, breakpoint specifici) senza lettura dei file CSS; asset SVG icone (dalla mappa `ICONS` non letta nel dettaglio); configurazione specifica AdSense (slot e client nei componenti chiamanti).
- Possibili approfondimenti: analisi componenti `user/channel/*` e `user/match/*` se classificati come componenti riusabili; lettura file CSS per note sugli stili; analisi `app.component.ts` come root layout.
- Wiki non modificata: confermato.
