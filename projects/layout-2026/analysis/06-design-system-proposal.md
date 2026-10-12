# Proposta di design system — layout 2026

**Stato:** proposta preliminare non approvata, basata su analisi statica al 24 settembre 2026. Nessuna modifica al frontend. I valori numerici sotto riportati sono una base da validare e non attestano conformità accessibile.

## Ambito e metodo

Obiettivo: consolidare l’identità e i pattern visuali già presenti nel frontend Angular, mantenendo compatibilità con le classi CSS e i componenti riusabili. Le evidenze sono separate dalle raccomandazioni. Wiki e codice descrivono alcuni pattern; l’inventario non copre ogni pagina o consumer.

## Identità e sistema esistenti — fatti verificati

- `src/RugbyRadioWeb/src/assets/css/rrl.css` definisce già palette teal e superfici chiare, colori semantici, ombre, raggi, spaziatura e larghezza massima del contenuto come custom properties `--rrl-*`.
- Lo stack font dichiarato è `Inter, Roboto, Arial, sans-serif`; il caricamento effettivo di Inter non è stato verificato. Le regole globali impostano corpo a 1rem/line-height 1.4 e pesi robusti per brand e titoli.
- In `src/RugbyRadioWeb/src/styles.css` non risultano override globali (file vuoto nel checkout esaminato). `angular.json` carica `rrl.css` prima di `styles.css`; fogli dei componenti Angular possono comunque avere regole locali.
- `src/RugbyRadioDesignSystem/` contiene un prototipo documentale (`index.html`, `example.html`, `rrl.css`) con fondazioni, palette e componenti. La sua relazione di build con l’app Angular non è stata verificata: considerarlo riferimento, non prova di una libreria integrata.
- Il frontend ha componenti Angular condivisi reali: `EntityButton`, `EntityField`, `EntityAlert`, `EntityToast`, `EntityTabs`, `EntityPageHeader`, `EntitySearch`, `EntityPagination`, `EntitySkeleton`, card per match/canali e componenti specifici di match. La wiki `docs/wiki/comparisons/Mappatura Componenti UI Condivisi (comparison).md` conferma il catalogo parziale e segnala che le varianti/consumer non sono completamente documentati.
- Il mobile usa safe-area, bottom navigation e varianti con breakpoint principali intorno a 640/768px. Il flusso cronista ha griglie a due colonne nei controlli live sotto 768px e 520px. La prova d’uso reale su dispositivi e TWA non è stata eseguita.
- L’inventario UI segnala una distinzione da preservare tra componenti di dominio, come card partita e card canale, e controlli visualmente simili composti direttamente nel template.

Riferimenti di prodotto: `docs/wiki/comparisons/Mappatura Frontend Pubblico e Autenticato (comparison).md`, `docs/wiki/workflows/Cronista Telecronaca (workflow).md`, `docs/wiki/workflows/Spettatore Partita (workflow).md`. La wiki dei componenti non definisce da sola un design system completo.

## Principi proposti

1. **Consolidare prima di ridisegnare:** trattare i token `rrl.css` come base; cambiare i valori solo dopo mappa dei consumer e verifica degli override.
2. **Semantica prima del colore:** azioni, stato live, errore e successo devono essere comprensibili anche senza colore, usando testo, icona o forma coerente.
3. **Componenti condivisi con API esplicite:** estendere varianti documentate dei componenti esistenti quando markup e comportamento coincidono; non forzare un unico componente sulle entità di dominio.
4. **Responsive per spazio disponibile e contesto:** mantenere gerarchia e azioni essenziali su mobile; ridurre densità solo dopo aver valutato il flusso operativo del cronista.
5. **Accessibilità verificabile:** trattare contrasto, focus, tastiera, zoom e target touch come criteri di accettazione da provare, non come qualità presunta dei token attuali.

## Token proposti

La raccomandazione è conservare inizialmente i valori esistenti e formalizzarne lo scopo semantico. L’intera tabella è una **proposta di mantenimento**, da approvare e verificare.

| Famiglia | Token esistente | Valore nel codice | Uso proposto |
|---|---|---:|---|
| Sfondo | `--rrl-color-bg` | `#f4fbfb` | Fondo pagina |
| Superficie | `--rrl-color-surface` | `#ffffff` | Card, input e pannelli |
| Superficie secondaria | `--rrl-color-surface-alt` | `#ecf8f8` | Sezioni selezionate o informative |
| Bordo | `--rrl-color-border` | `#d7eceb` | Separazioni e contorni non interattivi |
| Testo principale | `--rrl-color-text` | `#1f4c4e` | Titoli, testo e controlli |
| Testo secondario | `--rrl-color-text-soft` | `#527172` | Descrizioni e metadati; verificarne il contrasto sulle superfici reali |
| Testo inverso | `--rrl-color-text-inverse` | `#ffffff` | Testo su fondi scuri, da usare solo con abbinamenti verificati |
| Primario | `--rrl-color-primary` | `#1D8391` | CTA, selezione e link solo quando il contrasto è verificato |
| Primario forte | `--rrl-color-primary-strong` | `#166874` | Link e testo teal su fondi chiari |
| Primario tenue | `--rrl-color-primary-soft` | `#d6eef1` | Fondo focus/selezione; non come unico segnale di stato |
| Accento | `--rrl-color-accent`, `--rrl-color-accent-strong` | `#7fd6d2`, `#49c3be` | Elementi decorativi o evidenziazioni, dopo verifica contrasto |
| Live | `--rrl-color-live` | `#ff5a5f` | Indicatore live accompagnato da label/testo e simbolo |
| Semantici | `--rrl-color-success`, `-warning`, `-danger` | `#1f9d63`, `#f2b94b`, `#d64545` | Feedback con icona e testo; definire coppie superficie/testo accessibili |
| Spazio | `--rrl-space-1..8` | 4, 8, 12, 16, 20, 24, 32, 40px | Scala base, gap e padding |
| Raggi | `--rrl-radius-sm/md/lg/pill` | 10, 16, 24, 999px | Controlli, card, contenitori e chip |
| Ombre | `--rrl-shadow-sm/md/lg` | valori in `rrl.css` | Elevazione leggera per card, menu e overlay; non sostituisce bordo/focus |
| Larghezza | `--rrl-max-width` | 1120px | Contenuto desktop centrato |

Non aggiungere ora nuovi hex o scale di colore locali. Dove una coppia testo/sfondo non supera il controllo previsto, introdurre un token semantico dedicato solo dopo aver identificato i consumer e provato alternative. Non usare live/status come unico indicatore.

### Tipografia proposta

Mantenere lo stack dichiarato finché si verifica quale font viene effettivamente caricato e la resa nelle lingue supportate. Documentare una scala iniziale che corrisponda alle regole globali esistenti: titolo pagina 2rem, secondo livello 1.8rem, terzo 1.3rem, quarto 1.05rem, corpo 1rem, micro-label circa 0.8rem. Le dimensioni devono poter crescere con zoom/testo utente; evitare testo operativo sotto 0.875rem senza una ragione validata. Per i controlli live su mobile, le riduzioni locali a 0.76rem osservate nell’analisi mobile richiedono revisione con prove di leggibilità prima di riuso.

### Layout e responsive proposti

- Conservare gli attuali breakpoint (640/768px e soglie locali) nella prima iterazione; prima di unificarli, inventariare tutte le media query nei CSS di pagina e componente.
- Documentare tre classi di layout: mobile stretto, tablet/intermedio, desktop; non assumere che il breakpoint da solo risolva tablet, landscape o altezze ridotte.
- Riutilizzare il container 1120px; su mobile mantenere gutter almeno pari a 12px (il container globale usa 24px complessivi), safe-area e scorrimento orizzontale solo per contenuti intrinsecamente tabellari/tab.
- Cronista: conservare i gruppi di azioni e assicurare priorità, etichette e feedback; non ridurre target o nascondere azioni solo per farle entrare nella griglia. Validare la densità con cronisti su device piccoli/medi.
- Spettatore: trattare il pannello radio come stato e controllo persistente comprensibile in Events; mantenere accessibili tab e feed anche a larghezza stretta.
- Drawer/sheet: proporre contenuto scrollabile, comandi finali raggiungibili con tastiera virtuale aperta e padding safe-area; richiede verifica runtime.

## Componenti e varianti proposte

| Pattern attuale | Direzione proposta | Varianti da documentare |
|---|---|---|
| `EntityButton` / `.rrl-btn` | Un solo vocabolario per intenti comuni, mantenendo wrapper Angular e classi esistenti compatibili | primary, secondary, ghost, destructive; dimensioni standard/ampia; icona sola solo con nome accessibile; loading, disabled, pressed |
| `EntityField`, `.rrl-form` | Riutilizzare label, help e errore; distinguere required, invalid e disabled semanticamente | testo, password, ricerca, select; focus, errore, successo solo se utile |
| `EntityAlert`, `EntityToast`, `ngx-toastr` | Definire quando usare messaggio persistente inline e quando toast; ridurre la doppia implementazione visibile al chiamante | info, warning, success, error; dismiss; annunci screen reader adeguati |
| `EntityTabs` | Conservare componenti condivisi per pagine entità e verificare selezione/scroll su mobile | icona+testo desktop; tab scrollabili o label compattate mobile senza perdere nome accessibile |
| Header pagina e navigazioni | Distinguere header entità, header globale, menu e bottom navigation; non fonderli in un solo pattern | con/senza media; desktop/mobile; nav attiva; safe-area |
| Card match/canale | Mantenere identità e semantica di dominio; riusare solo shell visuali dove struttura e azioni coincidono | standard/compact mobile; loading; ads come slot esplicito e separato |
| `EntitySkeleton`, `EntityInfo`, liste | Stabilire stati vuoto e loading coerenti; aggiungere errore persistente/retry dove la query può fallire | skeleton header/card/list/text; empty senza risultati vs nessun contenuto; error+retry |
| Match Live | Trattare azioni evento come controlli di dominio con feedback rapido e prevenzione errori | primarie, avanzate, falli; selezionato/pressed, in invio, registrato, errore e correzione; nessun cambio di semantica |
| Pannello radio | Riutilizzare pattern di controllo media tra stati, mantenendo logica di riproduzione fuori dagli stili | idle, loading, playing, paused, unavailable/error |
| `EntityPagination`, ricerca, share | Conservare controlli atomici già condivisi, documentando focus, disabled e risultati | mobile compatti ma con nome/contesto; risultati zero; caricamento |

La tabella è proposta di direzione e non richiede di creare tutti i componenti o varianti prima di verificare i consumer reali.

## Stati e regole d’uso proposte

- **Focus:** visibile e persistente in navigazione da tastiera; non rimuovere l’outline senza sostituto con contrasto verificato. Lo stile `.rrl-focus-ring` usa un alone primario tenue: testarlo su tutte le superfici, incluse card e menu.
- **Hover/pressed:** hover solo dove il puntatore lo supporta; pressed non deve essere l’unico feedback. Il live richiede conferma testuale/visiva dopo salvataggio e un percorso di correzione.
- **Loading:** skeleton coerenti con la forma finale, con annunci/attributi di stato per aggiornamenti che interessano l’utente; non bloccare azioni indipendenti.
- **Empty vs error:** distinguere “nessun risultato” da errore di rete o dati non disponibili. Per errori recuperabili mostrare messaggio persistente e retry contestuale; toast da solo non è sufficiente per errori che impediscono il compito.
- **Successo e warning:** usare icona più testo, colore come rinforzo; warning e live non devono dipendere dalla sola tonalità.
- **Disabled:** mantenere comprensibile il motivo quando il controllo è rilevante; non fare affidamento sulla sola opacità.
- **Reduced motion:** rispettare `prefers-reduced-motion` per shimmer e transizioni, da verificare nei CSS globali e locali.

## Criteri accessibilità provvisori — da allineare con la review 07

Questi sono criteri proposti di verifica, non dichiarazione di conformità. La review dedicata deve confermare, correggere o ampliare il set.

1. Misurare contrasto di testo e componenti per ogni coppia effettiva, inclusi primary, testo soft, warning, live, focus e stati disabilitati; verificare le soglie WCAG 2.2 AA pertinenti prima di approvare i colori. La review accessibilità ha calcolato rapporti indicativi dai token nominali: primary `#1D8391` su bianco 4,46:1; danger `#d64545` su bianco 4,38:1; success `#1f9d63` su bianco 3,46:1. Per testo normale il criterio di verifica è almeno 4,5:1; per testo grande e indicatori/componenti non testuali si applica il criterio pertinente di almeno 3:1. Questi valori vanno ricontrollati sulle coppie e sugli stati effettivamente renderizzati.
2. Verificare operabilità da tastiera, ordine di focus e indicatore sempre percepibile; per dialoghi e drawer verificare focus iniziale, confinamento, chiusura con Esc e ripristino al chiamante, oltre a tab, menu, dismiss toast e azioni evento.
3. Usare come target di progetto 44×44 CSS px per i controlli touch frequenti e importanti; la soglia è proposta ergonomica, da confrontare con WCAG 2.2 e il contesto. I 44px già presenti in alcune classi non dimostrano che tutti i controlli la rispettino.
4. Verificare reflow/zoom, testi ingranditi, landscape/altezza ridotta, safe-area e tastiera visibile su mobile; nessuna verifica runtime è stata effettuata in questa analisi.
5. Verificare nome accessibile, semantica e stato localizzati per i controlli solo icona e gli altri controlli; associare gli errori ai campi. Distinguere loading, error, empty e successo con testo; validare annunci live senza duplicazioni e con urgenza appropriata.
6. Provare animazioni e shimmer con `prefers-reduced-motion`; il codice esaminato non è stato sottoposto ad audit esaustivo di questa preferenza.

## Compatibilità e migrazione proposta

1. Trattare `rrl.css` come sorgente canonica dei token solo dopo una mappa di override e consumer, inclusi CSS dei componenti, pagina e widget.
2. Non rinominare subito le variabili `--rrl-*`: introdurre semantica/documentazione mantenendo alias per evitare rotture diffuse.
3. Inventariare hex, valori `!important` e tipografia hard-coded; migrare un pattern riusabile alla volta e confrontare le pagine pubbliche, autenticate, home e live.
4. Verificare che le varianti proposte corrispondano agli input/API dei componenti standalone; dove un componente è solo wrapper o i consumer divergono, documentare prima la scelta e non uniformare per somiglianza.
5. Eseguire validazione visuale e accessibilità dopo approvazione della direzione. Nessuna implementazione è inclusa in questa fase.

## Questioni aperte

- Il prototipo `RugbyRadioDesignSystem` è mantenuto e aggiornato insieme a `RugbyRadioWeb` oppure è un riferimento storico/manuale?
- Inter è davvero fornito all’app, oppure il browser renderizza Roboto/Arial?
- Quali componenti e classi sono effettivamente fuori dal campione dell’inventario, in particolare i componenti Angular Material/NgSelect e i fogli legacy?
- Quali stati di errore devono esporre azione di retry per ciascun flusso e API?
- Quali browser/device costituiscono il set minimo per UX mobile/PWA/TWA?
- Chi approva la palette e quali ruoli devono validare visualmente la vista Live?

## Limiti

Analisi statica delle fonti indicate e dei documenti `analysis/02-ui-inventory.md` e `analysis/03-mobile-experience.md`. Non sono state misurate combinazioni di contrasto nel rendering né eseguite prove browser, tastiera, screen reader, zoom, dispositivi, PWA o TWA. I rapporti indicativi riportati sopra derivano dai valori hex nominali e non sostituiscono una misura sulle schermate effettive. La mappa dei consumer è parziale e non include una scansione esaustiva di tutti gli stili inline/legacy. La disponibilità effettiva dei font e il collegamento build del prototipo di design system restano da verificare. I valori raccomandati derivano dal sistema presente e vanno confermati con accessibility specialist e stakeholder.

## Fonti principali

- `docs/projects/layout-2026/analysis/02-ui-inventory.md`
- `docs/projects/layout-2026/analysis/03-mobile-experience.md`
- `docs/wiki/comparisons/Mappatura Componenti UI Condivisi (comparison).md`
- `docs/wiki/comparisons/Mappatura Frontend Pubblico e Autenticato (comparison).md`
- `docs/wiki/workflows/Cronista Telecronaca (workflow).md`
- `docs/wiki/workflows/Spettatore Partita (workflow).md`
- `src/RugbyRadioWeb/src/assets/css/rrl.css`, `src/RugbyRadioWeb/src/styles.css`, `src/RugbyRadioWeb/angular.json`
- `src/RugbyRadioDesignSystem/index.html`, `src/RugbyRadioDesignSystem/rrl.css`
- Componenti effettivi elencati nell’inventario, in `src/RugbyRadioWeb/src/app/common/`, `src/app/user/match/` e `src/app/global/g-match/`


