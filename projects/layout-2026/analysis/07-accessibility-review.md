# Revisione accessibilità — fase 6a

Data: 24 settembre 2026  
Stato: revisione statica parziale; nessuna modifica al codice.

## Ambito e fonti

Indice: docs/projects/layout-2026/analysis/02-ui-inventory.md. Verificati template/TS/CSS di src/RugbyRadioWeb/app.component.html, site/header, common/entity-button, entity-field, entity-alert, entity-toast, entity-tabs, entity-search, entity-pagination, entity-bottom-nav, user/match/match-live, assets/css/rrl.css e styles.css. Esame mirato, non copertura di tutte le route, traduzioni o varianti. Nessun browser o AT è stato usato.

## Sintesi

Sono presenti primitive utili: label in alcuni campi, controlli nativi, focus ring in vari componenti, target nominali da 44 px per controlli comuni e annunci live. Restano lacune verificabili nel markup e verifiche che richiedono browser/AT. Priorità: gestione tastiera/focus di menu e dialoghi; nomi e stato accessibile delle scelte icon-only del cronista; misura dei contrasti renderizzati; uniformità di etichette, errori e annunci.

## Rilievi statici

### Tastiera, semantica e focus

| Priorità | Evidenza | Criterio controllabile |
|---|---|---|
| Alta | site/header/header.component.html usa molte div role=button tabindex=0 per voci menu, con handler Enter e Space. Non è mostrata prevenzione del default Space né uno stile focus specifico in header.component.css. | Usare link per navigazione e button per azioni. Verificare attivazione con Enter/Space, niente scroll involontario e focus sempre visibile. |
| Alta | Menu laterale dichiarato role=dialog aria-modal=true. header.component.ts mostra openMenu/closeMenu che commutano lo stato, ma non gestione focus iniziale/confinato, Esc o ritorno al trigger. | Focus iniziale nel dialogo; contenimento Tab/Shift+Tab; chiusura con Esc; focus ripristinato al trigger; contenuto retrostante non focalizzabile. |
| Alta | Selettore lingua usa role=menu/menuitem, ma l’interazione letta è via click senza navigazione a frecce o focus management. Chiusura con aria-hidden e trasparenza/pointer-events; non si vede display:none o inert. | Scegliere pattern menu con frecce/focus oppure disclosure con normali pulsanti. Menu chiuso fuori dalla sequenza Tab; aria-expanded coerente. |
| Alta | Drawer inizio/secondo tempo in match-live.component.html dichiarati dialoghi modali; non emerge gestione focus, Esc o ripristino. app-match-event-modal da verificare separatamente. | Verificare focus iniziale, contenimento, chiusura e ritorno su ogni dialogo; rendere inerte lo sfondo. |
| Alta | Scelte meteo, temperatura e genere sono pulsanti con solo app-icon, senza nome o aria-pressed. TS contiene valori/icone ma il template non espone le etichette. | Nome localizzato per ogni opzione, gruppi nominati e stato selezione esposto, per esempio aria-pressed. |
| Media | entity-tabs espone tablist/tab/tabpanel e aria-selected; TS gestisce selezione al click senza navigazione frecce o roving tabindex visibile. | Verificare frecce, Home/End e Tab secondo pattern tabs; altrimenti usare semantica button/disclosure. |
| Positivo da verificare | app.component.html contiene main; rrl.css definisce skip link visibile al focus, ma non compare nel template shell letto. | Verificare se è montato altrove; primo Tab lo mostra e il target esiste/focalizzabile. Controllare landmark e gerarchia titoli sulle route principali. |

### Contrasti

Token da assets/css/rrl.css: text #1f4c4e, text-soft #527172, primary #1D8391, primary-strong #166874, primary-soft #d6eef1, danger #d64545, success #1f9d63, background #f4fbfb. Rapporti indicativi sui colori pieni, senza alpha:

| Coppia | Rapporto |
|---|---:|
| text / background | 9,10:1 |
| text-soft / bianco | 5,30:1 |
| primary / bianco | 4,46:1 |
| danger / bianco | 4,38:1 |
| success / bianco | 3,46:1 |
| primary-strong / primary-soft | 5,31:1 |

Primary, danger e success non raggiungono 4,5:1 contro bianco per testo normale. Il CSS Live applica danger al testo di azioni; sfondo e override determinano il rapporto effettivo. I calcoli non descrivono la UI resa: alpha, immagini, overlay, dimensione testo e CSS locale possono modificarli.

Criteri: misurare ogni combinazione renderizzata, inclusi hover, focus, selected, disabled, error e toast; almeno 4,5:1 per testo normale, 3:1 per testo grande e indicatori/componenti grafici necessari. Non distinguere stato soltanto col colore.

### Testi, nomi e feedback

- entity-field associa label a fieldId e rende errore come alert live. Per consumer verificare ID coincidente, collegamento istruzioni/errori via aria-describedby e invalidità esposta.
- entity-button supporta aria-label/aria-describedby; entity-search nomina input e pulsante clear; paginazione nomina prev/next e marca pagina corrente. Verificare utilizzo effettivo.
- entity-toast combina container aria-live=polite e ogni toast role=alert; pulsante close ha etichetta inglese fissa “Close”. Localizzare etichette; definire status/polite per messaggi ordinari e alert assertive solo per urgenze, evitando annunci duplicati.
- entity-alert usa etichetta fissa italiana “Nascondi avviso”: verificarla nelle altre lingue. Scegliere role/live appropriati affinché note statiche non siano annunciate ripetutamente.
- L’inventario segnala errori lista talvolta ricondotti a vuoto e retry non uniforme. Per query significative distinguere loading, risultati, vuoto, errore e retry con testo/azione. Annunciare cambi asincroni senza spostare il focus negli aggiornamenti ordinari.
- Per eventi Live verificare conferma, errore e aggiornamento senza dipendere da colore/toast temporaneo; impedire invii duplicati durante la richiesta.

### Target touch

- Positivo: .rrl-btn e .rrl-input hanno min-height 44px; trigger menu 44x44; opzioni lingua alte 44px; scelte evento 56px. Sono valori CSS, non misure renderizzate.
- Trigger lingua è alto 38px, larghezza minima 44px. Link bottom nav ha icona 32px e area dipendente dal layout. menu-item-modern ha padding 10px, nessuna min-height; hit area deriva dal contenuto.
- Azioni Live hanno icona 44px e padding, ma dimensioni finali dipendono da card e viewport.

Criteri: misurare bounding box e distanza fra controlli su mobile, zoom e orientamento ridotto; puntare a 44x44 per azioni frequenti/critiche e soddisfare il criterio di target/spaziatura applicabile. Verificare safe area, bottom nav e tastiera virtuale senza copertura o clipping.

## Verifiche necessarie con browser e AT

1. Tastiera su header, lingua, bottom nav, tab, ricerca, paginazione, editor, drawer e modal: ordine, focus visibile, Enter/Space/frecce/Esc, contenimento e ritorno.
2. NVDA con Firefox/Chrome e VoiceOver con Safari iOS: nomi/ruoli/stati, opzioni icon-only, form/errori, toast e annunci dinamici.
3. Contrasto renderizzato su home, pagine pubbliche ed editor, lingue/stati, focus, disabled, immagini e trasparenze.
4. Smartphone web e PWA/TWA: portrait/landscape, schermo basso, safe area, tastiera, zoom e target vicini.
5. Reflow a 320 CSS px, zoom testo 200%, traduzioni lunghe, text spacing e prefers-reduced-motion. Toast e sheet hanno transizioni/animazioni; supporto riduzione movimento non verificato.

## Criteri per il design system

- Ogni controllo ha semantica corretta, nome localizzato, stato esposto e focus visibile.
- Ogni overlay/modale definisce gestione focus, tastiera, chiusura e ripristino.
- Token e coppie renderizzate rispettano contrasti applicabili; registrare colori e dimensione testo.
- Target e spaziatura misurati su mobile, con priorità alle azioni frequenti del cronista.
- Stati distinguibili per testo/azione, non solo tinta/icona; annunci tempestivi e non duplicati.
- Verifica tastiera e screen reader documentata con browser, AT, device ed eccezioni.

## Limiti

Revisione statica e parziale. Rapporti colore dai token, non stili computati. Non verificati runtime, focus, contrasto renderizzato, screen reader, traduzioni, touch, PWA/TWA o reflow. ARIA e stili focus non dimostrano conformità; non si dichiara conformità complessiva.

