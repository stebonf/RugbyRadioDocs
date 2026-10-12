# Piano per il prototipo del design system RRL

**Stato:** piano per un prototipo HTML/Angular di consultazione; non è implementazione né approvazione definitiva dei token. La riduzione della navigazione mobile a quattro voci è stata approvata nel Q&A 03: **Home · Partite · Crea · Profilo**. La direzione visuale resta quella proposta in `analysis/06-design-system-proposal.md` e va mantenuta riconoscibile rispetto al frontend corrente.

## Obiettivo e forma consigliata

Realizzare una pagina catalogo interattiva nel progetto Angular `src/RugbyRadioWeb`, con una route dimostrativa accessibile nell’ambiente di sviluppo. Riutilizzare `rrl.css` e i componenti standalone effettivi quando la loro API e il loro comportamento servono alla dimostrazione; comporre nuove viste solo per i pattern non coperti. Evitare di copiare il prototipo statico in `src/RugbyRadioDesignSystem` come se fosse già una libreria integrata: è un artefatto HTML/CSS autonomo e non è compreso nell’elenco stili Angular di `angular.json`.

La pagina dovrebbe permettere di esplorare fondazioni e componenti, passare tra stati e varianti, e vedere una composizione mobile/desktop. Deve dichiarare “prototipo” vicino al titolo, distinguere esempi simulati da API reali e non inviare dati a backend/analytics di produzione.

## Evidenze e vincoli tecnici

- La sorgente visuale globale Angular è `RugbyRadioWeb/src/assets/css/rrl.css`; definisce palette `--rrl-*`, spazi, raggi, ombre, typo base, bottoni, form, card, tab, skeleton, sheet, navbar e breakpoint.
- `angular.json` carica `rrl.css` seguito da `styles.css`; il file `src/styles.css` è vuoto nello snapshot esaminato. Stili locali nei componenti sono invece attivi e possono cambiare l’aspetto.
- `RugbyRadioDesignSystem/index.html`, `example.html` e `rrl.css` sono dimostrazioni separate. Il loro contenuto può ispirare la struttura del catalogo, ma l’app non li importa dalla build Angular.
- La maggior parte dei componenti riusabili sono standalone in `RugbyRadioWeb/src/app/common/`. Riutilizzarli nel catalogo richiede import Angular diretti, non solo classi uguali.
- Per feedback esiste già `UserService.sendFeedback(rating, message)` su `POST /user/feedback`. Un prototipo non deve invocare questo endpoint: può includere un adapter locale dimostrativo, indipendente da sessione/API reali.
- Altri esiti già approvati che guidano gli esempi: errore locale per il blocco che non carica, con copy generico “Al momento non è possibile recuperare le informazioni”; home senza sezione live quando non ci sono match live, mostrando storico; niente promessa di canale test “privato” senza controllo API.

## Cosa riusare, ricostruire e aggiungere

| Trattamento | Elementi | Base/evidenza | Indicazione per il prototipo |
|---|---|---|---|
| **Riuso diretto Angular/CSS** | `EntityButton`, `EntityField`, `EntityAlert`, `EntityToast`, `EntityTabs`, `EntitySearch`, `EntityPagination`, `EntitySkeleton`, `EntityInfo`, `EntityPageHeader` | Componenti standalone in `app/common/`; le API supportano output/input e varianti reali | Mostrare il componente vero con controlli per gli input realmente esposti. Non simulare una variante inesistente spacciandola per già supportata. Per toast, usare `ToastService` solo nella route demo e non con messaggi business. |
| **Riuso diretto di componenti di dominio** | `MatchCardSmall`, `MatchCardList`, `ChannelCard`, `ChannelCardList`, `MatchHeader`, `EntityBottomNav`, componenti di match/eventi/radio | Uso condiviso documentato in `analysis/02-ui-inventory.md`; dipendono da DTO e talvolta da servizi | Preferire fixture locali e adapter/mock. Isolare le dimostrazioni di dominio, dichiarando che dati/avatar/audio sono esemplificativi. Le azioni Match Live vanno mostrate come pattern UI solo, senza mutazioni dominio. |
| **Ricostruzione visuale su CSS esistente** | Chip/badge, stato live, superficie/card base, statistiche, selettore squadra, blocchi di pagina, menu globale e footer | Classi globali (`rrl-card`, `rrl-badge`, `rrl-grid`, `rrl-section`) e template con composizione custom | Comporre markup del catalogo usando classi globali/token e layout Angular locale; non dichiarare esistenza di un componente condiviso dove c’è solo markup/CSS simile. |
| **Ricostruzione visuale controllata** | Stati delle card o radio che richiedono DTO/servizi complessi; stati loading/error/empty in sezioni | Alcuni consumer/list component gestiscono già loading/empty, ma `error` non è una variante comune | Presentare fixture statiche e un controllo di scenario; mantenere rendering isolato e non riutilizzare una chiamata API reale. |
| **Pattern nuovi nel prototipo (da proporre)** | Indice/categorie del catalogo, campione responsive, switch di stati, registro del feedback locale | Non sono pattern di prodotto esistenti; servono alla consultazione del sistema | Realizzare solo nell’area demo. Non estendere API di componenti prodotto senza passaggio successivo di design/tecnico. |
| **Pattern nuovo raccomandato, da valutare** | `EntitySectionError`/sezione dati con retry locale | Q&A 03 conferma messaggio d’errore generico in sezione; `02-ui-inventory` segnala che liste condivise non hanno input errore dedicato | Nel prototipo ricostruire un esempio accessibile senza introdurre prematuramente un componente di prodotto. Se i consumer convergono, formalizzare l’API in un task tecnico dedicato. |
| **Non portare come componente UI** | Funzioni business di login, creazione match, follow/like/reaction, playback effettivo, analytics e ads | Effetti esterni e autorizzazioni/servizi specifici | Sostituire con controlli inert o adapter stub chiaramente nominati. Nessuna CTA deve modificare dati o aprire flussi reali non previsti. |

### Primitive Angular già disponibili: controlli da rispettare

- `EntityButton`: `variant` è `pill | panel | close`, `color` `primary | secondary | ghost`; gestisce nome accessibile, disabled e aria-expanded. Nel prototipo non introdurre destructive/loading come se fossero API esistenti: mostrarli soltanto come esempio ricostruito o proposta marcata.
- `EntityTabs`: riceve `tabs`, `selectedTab`, `sectionId`, `ariaLabel` e supporta tab disabilitate; conservare l’interazione reale e controllare che le label mobile non scompaiano senza nome accessibile.
- `EntitySkeleton`: layout `header | card | list | text` e conteggi configurabili.
- `EntityAlert`: toni `info | warning | success | danger | neutral`, filled/outline e layout; la dismiss persiste in localStorage quando ha ID. Nel catalogo usare ID prefissato demo e includere ripristino/nota sulla persistenza.
- `EntityToast`: riceve dal `ToastService` gli stati `success | info | warning | error`; nel template attuale ogni toast ha `role="alert"` dentro contenitore polite: documentare la tensione con il criterio accessibility e non presentare il comportamento attuale come convalidato.
- `EntityField`: proietta il controllo form e renderizza label, help ed errore. Usare label esplicite; i demo-only inputs non devono fingere invii validi.

## Contenuto minimo del catalogo

1. **Fondazioni:** swatches per sfondo/superfici/testo/primario/accento/live/semantici; scala tipografica effettivamente dichiarata; spazi 4–40 px; raggi/ombre; container e breakpoint. Ogni valore deve rimandare al token e indicare “attuale” o “proposta”. Contrasti ancora da misurare sul rendering.
2. **Controlli:** button nelle varianti effettive, field/help/error/disabled, search, tab, pagination e link/focus.
3. **Feedback:** alert per ogni tono, toast per quattro tipi, skeleton, empty, error locale con messaggio approvato e retry simulato, stato successo.
4. **Contenuti:** card match in programma/live/terminata e card canale usando fixtures e componenti esistenti se l’API dei dati può essere fornita senza dipendenze live; in alternativa visuale composta con la dicitura “render illustrativo”.
5. **Navigazione:** shell anonima con header/menu e accessi pubblici; shell autenticata dimostrativa con bottom navigation a quattro voci; stato attivo, focus, safe-area e layout desktop. Le pagine partita mantengono l’eccezione senza bottom nav secondo l’analisi/raccomandazione.
6. **Esempi di flusso:** mini dashboard con canale di prova marcato “esempio”; errore di un feed con sibling disponibile; wizard come superficie descrittiva inerte; campione evento live con feedback registrato/errore/correzione simulati.

## Navigazione approvata da rappresentare

Per la variante autenticata mobile mostrare esattamente quattro item, in quest’ordine: **Home · Partite · Crea · Profilo**. `Crea` può avere trattamento visivo prioritario, ma non deve rendere irraggiungibili le altre voci; tutte hanno label e icona, stato corrente esposto accessibilmente e target touch adeguato. Su desktop continuare a mostrare il pattern del guscio/header/menu previsto, non forzare la bottom bar.

Per anonimi, niente barra persistente con azioni protette: mostrare accesso a **Home, Partite, Canali, Accedi, Registrati** tramite header/menu e collegamento “Tutti i canali” nella home. Radio è contestuale al match e non compare come quinta voce. Nella pagina match usare tab interne e link “Ascolta”; su route radio mostrare ritorno al match. Il mock nav non deve simulare il routing reale se le destinazioni demo non sono implementate: usa ancore alla sezione di esempio o un indicatore “solo anteprima”.

## Stati e comportamento del feedback API locale

L’API vera `POST /user/feedback` è fuori dal prototipo. Definire un’interfaccia locale piccola (per esempio `DemoFeedbackApi`) che accetti rating/testo e restituisca un esito asincrono simulato con latenza configurabile e tre risposte selezionabili: successo, errore recuperabile, validazione locale. Non usare `UserService` né inviare rete. I dati restano in memoria e si azzerano al reload; visualizzare copy “Invio dimostrativo: nessun feedback salvato”.

Il campione deve coprire:

- submit in idle → submitting (pulsante disabilitato, indicazione testuale) → success (conferma persistente o stato completato);
- errore simulato → alert inline nel form, valori conservati, retry manuale;
- rating mancante/testo oltre limite → errore associato e focus/lettura corretti;
- non affidarsi a toast effimero come unico esito, né confondere errore API con assenza di risultati;
- nessun retry automatico per invio o azione di scrittura.

Le liste di esempio devono esporre scenario loading, contenuto, vuoto e errore locale. Se il blocco Match fallisce, gli altri blocchi restano visibili. Copy errore allineato alla decisione Q&A 03: “Al momento non è possibile recuperare le informazioni”, più controllo retry locale.

## Regole CSS e responsive proposte

- Importare l’attuale `rrl.css` dalla build Angular; non copiare i token in un secondo foglio indipendente. Il CSS della demo aggiunge solo struttura del catalogo e classi `demo-*` per isolamento.
- Conservare variabili `--rrl-*`, scale e font stack presenti. La palette è la base corrente; non allargare la palette né cambiare i valori in questo prototipo. Etichettare contrasti non verificati e stati semantici come da review `analysis/07-accessibility-review.md`.
- Riutilizzare breakpoint esistenti (640/768 px come riferimenti) senza introdurre un nuovo sistema globale. Nel prototipo i layout si impilano sotto 768px, i campioni a griglia vanno a una/due colonne secondo larghezza, e la bottom nav rispetta safe-area. Verificare anche viewport stretto, landscape basso e zoom nel QA successivo.
- Non ridurre testo operativo sotto le misure esistenti per mera densità. Nel campione editor live usare etichette visibili, tap target obiettivo 44×44 CSS px per controlli frequenti e gestione di focus/ring.
- Le media query devono essere locali a `.demo-*`; evitare selettori globali che modificano pagine di prodotto. Rispettare `prefers-reduced-motion` per transizioni, shimmer e animazioni.
- Focus visibile non dipendente solo dal tenue fill; colori con stato affiancati da icona/testo. Non dichiarare conformità: la review accessibilità indica che i rapporti nominali di alcuni colori sono prossimi o sotto le soglie per testo e serve validazione sulle coppie effettive.

## Sequenza di realizzazione consigliata

| Incremento | Contenuto | Dipendenze/criterio di completamento |
|---|---|---|
| 1. Scheletro demo | Route/entrypoint solo dev, titolo e indice categorie; CSS isolato | Non deve entrare nelle route pubbliche di produzione senza decisione tecnica |
| 2. Fondazioni | Palette/token/typo/spacing/radius/ombre/container | Ogni swatch indica token e stato: esistente, proposta, non validato |
| 3. Componenti atomici | Button, field, alert, toast, tabs, search, pagination | Si vedono API/varianti reali e almeno focus, disabled, error |
| 4. Stati e feedback | Loading/empty/error/retry/success con adapter mock locale | Nessun network request; stati di contenuto distinti e dati conservati dopo errore |
| 5. Composizioni di dominio | Card match/canale, feed, radio context, dashboard e sample editor live | Fixtures; niente side effect business; componenti riusati effettivamente indicati |
| 6. Shell responsive | Menu anonimo, bottom nav autenticata 4 voci, route match senza nav persistente | Ordine voci esatto, menu e tab contestuali distinti, safe-area |
| 7. Revisione | Mappa del riuso, limiti e “demo-only” visibili; verifica layout/keyboard/zoom | Accessibility review eseguita prima di promuovere elementi a libreria di prodotto |

## Criteri per promuovere un pattern dal prototipo al prodotto

- Si può identificare almeno un uso ripetuto con markup/comportamento uguale, non solo classi visuali simili.
- L’API del componente copre le varianti osservate senza accoppiarsi ai servizi o al dominio di una singola pagina.
- Loading, empty, error e success hanno una semantica chiara; errori con task bloccato non dipendono dal toast.
- La variante funziona a mobile/desktop e da tastiera, con nome/stato corretto per screen reader.
- Colori e focus sono misurati sulle superfici effettive; non si eredita implicitamente l’etichetta di “accessibile” dai token esistenti.
- Il componente è mappato ai consumer reali e la migrazione non cambia route, API, autorizzazioni o logica live.

## Rischi e limiti

L’inventario copre componenti selezionati; il prototipo statico attuale non è una libreria Angular né dimostra componenti standardizzati. La review accessibilità segnala rapporti nominali inferiori a 4,5:1 per alcuni colori usati con testo bianco: serve rivedere gli abbinamenti prima di riusarli come testo normale. I componenti di dominio dipendono da DTO, traduzioni e servizi; le fixture possono non rappresentare tutti gli stati di produzione. Il mock feedback valida la resa degli esiti ma non auth, contratto API, persistenza, analytics o successo di rete. Breakpoint, safe-area, TWA, zoom, tastiera virtuale e uso reale del cronista richiedono controlli successivi. Il piano non apporta modifiche al codice e non certifica conformità.

## Fonti

- `docs/projects/layout-2026/qa/Q&A - 03.md` — approvazione raccomandazioni navigazione/TWA ed errore locale semplice.
- `docs/projects/layout-2026/qa/03-navigation-and-twa-recommendation.md` — struttura nav anonima/autenticata e casi per match/radio.
- `docs/projects/layout-2026/qa/04-technical-verification.md` — errori parziali e mancanza feedback visibile nel wizard.
- `docs/projects/layout-2026/qa/05-auth-and-intent-recommendation.md` — distinzione API/auth e non auto-esecuzione delle azioni.
- `docs/projects/layout-2026/analysis/02-ui-inventory.md`, `03-mobile-experience.md`, `06-design-system-proposal.md`, `07-accessibility-review.md`.
- `src/RugbyRadioWeb/src/assets/css/rrl.css`, `src/RugbyRadioWeb/angular.json`, `src/RugbyRadioWeb/src/app/common/`.
- `src/RugbyRadioWeb/src/app/services/user.service.ts` (`sendFeedback`) e `src/RugbyRadioWeb/src/app/global/g-feedback/`.
- `src/RugbyRadioDesignSystem/index.html`, `example.html`, `rrl.css` (prototipo statico non integrato nella build Angular).
