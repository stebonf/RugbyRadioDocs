# Esperienza mobile — analisi UX

**Stato:** analisi statica di flussi, template, TypeScript, CSS, manifest e documentazione; nessuna proposta UX è stata approvata. Nessuna modifica al codice applicativo.

## Sintesi

Il frontend prevede adattamenti responsive per l’editor live, i controlli radio e il guscio dell’app; la PWA usa modalità standalone e dichiara orientamento portrait. Sono evidenze di implementazione, non una prova dell’esperienza su smartphone o dentro una TWA.

La priorità di verifica è il flusso del cronista durante il live: il template presenta gruppi di azioni primarie, avanzate e falli, oltre alle impostazioni AI e a drawer per le fasi di partita. A larghezze ridotte i pulsanti principali diventano una griglia a due colonne. Questo può rendere la selezione più densa e richiede una prova con cronista, dispositivo e condizioni d’uso reali prima di trarre conclusioni su velocità, errori o raggiungibilità.

Per lo spettatore, la pagina pubblica riunisce in Events la cronaca testuale, la radio e relativi controlli; lineup, statistiche e condivisione sono tab separate. Esistono regole mobile esplicite per la radio, ma restano da verificare la gerarchia, la leggibilità e l’uso prolungato su schermi piccoli.

## 1. Cronista: gestione live sullo smartphone

### Flusso verificato

La mappa flussi descrive l’apertura di una partita autenticata in `/user-match/:matchId`, l’avvio da Scheduled, l’inserimento di eventi durante il live, l’intervallo e il secondo tempo; a full time la scheda Live scompare e si torna a Events. Il workflow wiki individua autorizzazione/ownership e creazione eventi come punti di fallimento.

Nel codice letto:

- `src/RugbyRadioWeb/src/app/user/match/match.component.html` monta le tab Live, Events, lineup, Stats e Share; la visibilità dipende dallo stato match.
- `src/RugbyRadioWeb/src/app/user/match/match-live/match-live.component.html` mostra un avviso e un’azione di avvio prima del match; durante il live rende gruppi separati per azioni primarie, avanzate e falli. Sono presenti anche il controllo della sezione AI e l’opzione emoji.
- Lo stesso template usa sheet/drawer per inizio e secondo tempo, con selettori meteo, temperatura e genere, slider durata e commento; la vista del secondo tempo include un campo commento.
- `src/RugbyRadioWeb/src/app/user/match/match-live/match-live.component.css` riduce le griglie a due colonne sotto 768px e 520px. Sotto 520px icona e testo si dispongono in colonna, l’icona scende a 36px e il testo a 0,76rem. Sotto 640px i pulsanti del footer drawer occupano tutta la larghezza e la griglia meteo a sei opzioni passa a tre colonne.

### Implicazioni da validare (non difetti accertati)

- **Densità e ricerca dell’azione:** il cronista deve distinguere più gruppi e scorrere il contenuto, mentre usa la tab Live per registrare gli eventi. Valutare tempo per evento, errori di selezione, necessità di scorrere e possibilità di recuperare un’azione, con simulazione di una partita.
- **Uso con una mano:** la griglia a due colonne non attesta la raggiungibilità dei pulsanti nelle diverse dimensioni. Osservare impugnature reali, mano dominante, dispositivo in custodia e uso in movimento/sole; non dedurre touch target effettivi dalla sola struttura CSS.
- **Feedback e rischio di selezione errata:** il click apre il modal evento; il codice dell’interazione e la risposta visiva dopo l’invio vanno valutati insieme al template del modal. Misurare se il cronista capisce che l’evento è stato registrato e come correggerlo senza perdere il flusso.
- **Fase pre-partita:** verificare se il drawer e la tastiera virtuale lasciano sempre visibili i campi e i comandi finali su display con altezza ridotta. La sola media query non prova gestione resize/scroll con tastiera aperta.
- **Cambio stato e orientamento:** confermare che avvio, intervallo, secondo tempo e full time restino riconoscibili in portrait e landscape, e che i controlli essenziali non finiscano fuori dalla prima area utile. Il manifest dichiara portrait per la PWA, ma questo non prova il blocco effettivo o il comportamento dei browser/TWA.

### Prova consigliata

Sessione osservata con almeno un cronista esperto e uno meno esperto, su smartphone piccolo e medio, in una simulazione che includa avvio, eventi frequenti, fallo, intervallo, correzione e conclusione. Registrare tempo e tocchi per attività, errori, scroll, cambi di presa e richieste di aiuto. Ripetere con tastiera aperta nel drawer. Prima della sessione definire i criteri di successo con il coordinatore; non cambiare logica di partita come parte di una proposta visuale.

## 2. Spettatore: seguire partita e radio

### Flusso verificato

La mappa dei flussi descrive discovery da home/catalogo o link diretto, apertura della pagina match pubblica, lettura eventi, lineup/statistiche e passaggio alla radio. Alcune interazioni (follow, like, reazioni, preferenze) dipendono da login o stato match; la disponibilità audio può fallire secondo il workflow.

Nel codice letto:

- `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.html` mostra MatchHeader e le tab Events, lineup casa/ospiti, Stats e Share tramite componenti condivisi.
- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.html` ospita contenuto eventi, impostazioni/commentatore e pannello radio con stato, play/pausa/ripresa, selettore e reazioni rapide.
- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.css` sotto 768px riorganizza la radio: testata a griglia, stato su tutta la riga, controlli e opzioni in colonna; il pulsante Talker flottante è dimensionato 56×56px.
- `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.ts` e `g-match-events.component.ts` gestiscono stati e azioni; il dettaglio dei casi audio e il loro feedback va testato nell’applicazione funzionante.

### Implicazioni da validare (non difetti accertati)

- **Orientamento tra testo e audio:** poiché Events contiene feed e radio, verificare se il pubblico distingue subito cronaca scritta e ascolto, trova play/pausa e capisce lo stato in caricamento, in riproduzione o in pausa.
- **Controlli durante ascolto:** provare con una mano, schermo bloccato e cambio app; non è possibile stabilire dal template se la riproduzione continui o quali controlli OS siano disponibili. Verificare anche cosa succede se l’audio di un evento non è disponibile.
- **Lettura feed:** valutare testo, minuto, nomi squadra e cambiamenti durante aggiornamenti su schermi piccoli; accertare che gli aggiornamenti non spostino il punto di lettura.
- **Interazioni protette:** verificare che CTA/login, feedback di rating/reazioni e ritorno alla partita siano comprensibili e non facciano perdere tab o contesto. La mappa segnala regole di rating non del tutto chiare nel frontend.
- **Navigazione tab:** provare passaggio fra Events, formazioni e stats con scroll, refresh e viewport stretta; il codice mostra tab comuni ma non prova che selezione e posizione restino intuitive.
- **Annunci e contenuti:** il catalogo può includere slot pubblicitari; valutare la discovery mobile con contenuti e dati reali, non solo con stati di sviluppo.

## 3. Schermi piccoli, orientamento e guscio applicativo

### Evidenze statiche

- `src/RugbyRadioWeb/src/assets/css/rrl.css` usa breakpoint 640px e 768px, contenitori a larghezza piena sotto 768px, nasconde overflow orizzontale e adatta padding e card. Imposta padding body superiore/inferiore con `env(safe-area-inset-*)` e unità `100dvh`.
- `src/RugbyRadioWeb/src/app/app.component.html` include header e router outlet; la bottom navigation appare quando `showBottomNav` è true. Footer non viene montato su mobile o TWA.
- `src/RugbyRadioWeb/src/app/services/platform.service.ts` determina mobile dallo user agent e TWA da display-mode standalone o stringa user agent. Quindi le varianti mobile/TWA del guscio si basano su rilevamento statico, non su dimensioni del viewport o capacità tattili.
- `src/RugbyRadioWeb/src/manifest.json` configura `display: standalone`, `start_url: ./` e `orientation: portrait`.
- `src/RugbyRadioWeb/src/app/app.component.html` sopprime la navigazione durante la splash TWA; il template home ha una variante splash e contenuti diversi per TWA. La mappa flussi segnala che dopo la splash il contenuto TWA anonimo differisce dalla landing web: la scelta di prodotto è aperta.

### Raccomandazioni di valutazione

Provare almeno viewport stretti, dispositivo con notch, portrait/landscape, landscape con altezza ridotta, zoom testo e tastiera aperta. Verificare header fisso, safe area, bottom nav, scrolling, drawer, tab e controlli audio assieme, così da trovare sovrapposizioni o contenuti irraggiungibili. Ripetere in browser mobile, PWA installata e Android TWA se la distribuzione TWA è disponibile. Annotare browser/OS/versione e condizione di rete.

La presenza delle regole safe-area non dimostra che tutti i pannelli rispettino gli inset; il manifest portrait è un’intenzione/configurazione dichiarata e non dimostra comportamento uniforme su tutte le piattaforme. Le route e i componenti consultati non bastano a concludere compatibilità tablet o a definire un layout landscape.

## 4. PWA e TWA: evidenza e prove richieste

### Evidenza verificata nel repository

Il workflow wiki `Riproduzione Audio Telecronaca` elenca tra i failure point il blocco di `Audio.play()` prima di una gesture, audio/evento/file assenti, lingua o stile TTS non supportati e storage locale indisponibile. Indica inoltre che audio in background, lock screen e Media Session API non sono ancora validati su browser mobile, PWA e TWA.

- Il manifest dichiara app installabile standalone e portrait, con icone e start URL.
- `PlatformService` classifica il browser standalone come TWA e rileva dispositivi da user agent; `app.component.html` usa tali flag per footer, splash e shell.
- L’inventario UI segnala service worker Angular configurato in `ngsw-config.json`/app config e riferimenti Android Digital Asset Links in `angular.json`. Questi attestano configurazione nel repository, non installazione corretta, associazione Play, aggiornamento cache o funzionamento offline.
- La splash e la home per TWA sono rami condizionali del frontend; i flussi documentati riportano una differenza tra home browser anonima e TWA, ancora da decidere.

### Da verificare manualmente

1. Installazione PWA, icona, start URL, avvio standalone, ritorno a sessione esistente, aggiornamento e comportamento offline/connessione instabile.
2. Installazione e avvio Android TWA sul pacchetto distribuito, dominio associato, splash, safe area, stato login, route diretta a match e navigazione back.
3. Permessi notifiche, se richiesti dal follow, e messaggi quando negati; il flusso wiki riporta la consegna push come possibile failure point.
4. Audio TTS durante lock/sospensione, cambio app e ripresa, inclusi file non disponibili e stato di errore.
5. Comportamento quando display ruota, cambia altezza o compare tastiera; il manifest non sostituisce la verifica device.
6. Confronto della home TWA anonima dopo splash rispetto alla web, con decisione esplicita del responsabile prodotto.

## 5. Priorità di verifica

| Priorità | Prova | Perché |
|---|---|---|
| P0 | Cronista live su piccolo e medio smartphone | È un flusso operativo ad azioni frequenti; CSS conferma griglia compatta ma non ergonomia, rapidità e feedback |
| P0 | Spettatore: lettura feed, avvio/pausa audio, errore audio su smartphone | Events combina feed e radio; il workflow menziona fallimenti audio |
| P1 | Drawer e tastiera, tab, header e bottom nav con viewport corto/safe area | Layout distribuito tra componenti e shell; verifica di possibili occlusioni |
| P1 | PWA installata e Android TWA: avvio, home anonima, route match, back, audio | Configurazione presente, comportamento runtime non accertato |
| P2 | Landscape e tablet per cronista e spettatore | Manifest orientato al portrait; non c’è evidenza sufficiente sul supporto landscape |

Queste priorità organizzano la validazione, non sono decisioni di redesign.

## Fonti consultate

### Documentazione progetto e wiki

- `docs/projects/layout-2026/analysis/01-user-flows.md` — mappa attori, stati, flussi, frizioni e domande aperte.
- `docs/projects/layout-2026/analysis/02-ui-inventory.md` — inventario componenti, responsive, shell e configurazione PWA/TWA.
- `docs/wiki/workflows/Cronista Telecronaca (workflow).md` — obiettivo “pochi click”, attori, dipendenze e failure point.
- `docs/wiki/workflows/Spettatore Partita (workflow).md` — eventi, commenti, reazioni, voti e failure point audio/account.
- `docs/wiki/business/actors/Cronista (actor).md`, `docs/wiki/business/actors/Spettatore (actor).md`.
- `docs/wiki/workflows/Riproduzione Audio Telecronaca (workflow).md` (sottoflusso citato dal workflow spettatore; utilizzato come contesto del comportamento audio da verificare).

### Frontend

- `src/RugbyRadioWeb/src/app/user/match/match.component.html`
- `src/RugbyRadioWeb/src/app/user/match/match-live/match-live.component.html`, `match-live.component.css`, `match-live.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.html`, `g-match.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.html`, `g-match-events.component.css`, `g-match-events.component.ts`
- `src/RugbyRadioWeb/src/app/app.component.html`
- `src/RugbyRadioWeb/src/app/services/platform.service.ts`
- `src/RugbyRadioWeb/src/assets/css/rrl.css`, `src/RugbyRadioWeb/src/styles.css`
- `src/RugbyRadioWeb/src/manifest.json`, `src/RugbyRadioWeb/ngsw-config.json`, `src/RugbyRadioWeb/angular.json`, `src/RugbyRadioWeb/src/app/app.config.ts`

## Limiti

Analisi limitata ai file e flussi citati e al checkout corrente. Non sono state avviate l’app, usati device/emulatori, misurati target touch/contrasto/performance, osservati cronisti o spettatori, provati screen reader, audio con schermo bloccato, installazione PWA/TWA o rete offline. Non è stata verificata la configurazione del pacchetto Android distribuito, la disponibilità degli endpoint né il comportamento backend di eventi, permessi e notifiche. Le frizioni sono ipotesi di ricerca basate sulla struttura implementata; le proposte indicano prove UX, non requisiti approvati. Nessun codice applicativo è stato modificato.

