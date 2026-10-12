# Mappa dei percorsi utente — layout-2026

**Stato:** ricognizione documentale e statica del frontend; nessuna proposta UX è stata approvata.

## Ambito e metodo

Confronto tra le fonti di prodotto in `docs/wiki/` e route, componenti TypeScript e template in `src/RugbyRadioWeb/`. Le osservazioni sul codice attestano ciò che è implementato nei file letti; non equivalgono a una prova end-to-end nell’applicazione avviata o a ricerca con utenti.

Sono stati consultati il brief `docs/projects/layout-2026/README.md`, `docs/wiki/business/actors/{Spettatore,Cronista} (actor).md`, `docs/wiki/workflows/{Spettatore Partita,Cronista Telecronaca,Gestione Canale,Autenticazione Utente} (workflow).md`, `docs/wiki/comparisons/{Mappatura Frontend Pubblico e Autenticato,Mappatura Attori e Workflow} (comparison).md`, gli articoli `docs/wiki/articles/{Esperienza Spettatore Partita,Creazione Rapida Partita} (article).md` e le pagine wiki `docs/wiki/frontend/web/pages/{HomePage,GMatchPage,MatchPage} (web).md`.

Nel codice sono stati verificati `src/RugbyRadioWeb/src/app/app.routes.ts`, la home e il relativo template, la navigazione header, le pagine pubbliche lista e partita, la pagina editor partita, le azioni Live, la vista eventi pubblica, le formazioni e la lista canali autenticata. I riferimenti specifici sono elencati nei percorsi sottostanti.

## Attori e confini di accesso

| Ruolo/contesto | Fatti documentati dalla wiki | Comportamento verificato nel frontend |
|---|---|---|
| Visitatore anonimo | Può scoprire partite/canali e seguire una partita senza account. Le interazioni come commenti, voti e follow possono richiedere login. Fonti: `docs/wiki/business/actors/Spettatore (actor).md`; workflow `Spettatore Partita`. | Route pubbliche per `/`, `/g-matches`, `/g-channels`, `/g-match/:matchId`, `/g-radio/:matchId`, `/g-channel/:channelPublicId`, `/g-team/:teamId`, `/g-stats`, `/g-feedback`. Il menu header offre discovery e login. Sulla partita pubblica le azioni protette invitano al login o sono presentate solo per sessione autenticata. |
| Spettatore autenticato | Segue la partita, può interagire con commenti, reazioni, voti e preferenze AI-Talker secondo attore/workflow. | La pagina partita pubblica rimane la stessa; `GBaseUserComponent` espone sessione. Se non autenticato appare il CTA login nelle impostazioni; follow è mostrato agli autenticati non a tempo pieno; like è mostrato ad autenticati a partita conclusa se non già espresso. Le reazioni rapide nella radio richiedono login e invocano il callback login. |
| Cronista | Account che crea telecronaca attraverso eventi cliccati durante il match; gestisce canali, partite, eventi e contenuti. L’uso mobile rapido è un obiettivo documentato, non una prestazione verificata. Fonti: `docs/wiki/business/actors/Cronista (actor).md`; workflow `Cronista Telecronaca` e `Gestione Canale`. | La gestione è su route protette `/user-channels`, `/user-channel/:channelId`, `/user-match/:matchId`. L’editor partita ha tab Live, Events, formazioni, Stats e Share; Live presenta azioni per avvio, intervallo, eventi e aggiornamenti. La route guard controlla solo la sessione locale. |
| Utente autenticato generico | Workflow autenticazione copre registrazione, login, reset password e profilo; la wiki distingue superfici pubbliche, ibride e autenticate. | `/user-login`, `/user-registration`, `/user-reset-password` sono pubbliche. `/user-dashboard`, `/user-profile`, `/user-channels`, `/user-channel/:channelId`, `/user-match/:matchId`, `/user-danger`, `/user-favorites` richiedono `AuthGuardService`. Dashboard è la `HomeComponent` con contenuto condizionato dalla sessione. |

L’amministratore compare nella mappatura attori wiki, ma non rientra nei quattro ruoli richiesti dal brief. La route manutenzione esiste solo con `environment.maintenance`; non è stata analizzata qui come percorso di prodotto.

## Percorsi principali

### 1. Scoperta anonima → partita

**Documentato:** homepage pubblica con onboarding/marketing e caroselli partite/canali; la pagina partita è pubblica, con eventi, formazioni, statistiche e condivisione. `docs/wiki/frontend/web/pages/HomePage (web).md`, `GMatchPage (web).md`; workflow `Spettatore Partita`.

**Verificato:** `/` e `/user-dashboard` puntano alla stessa `HomeComponent`, con dashboard protetta dalla guard. Nella home anonima browser si mostrano logo, contenuti introduttivi e help, poi partite in corso/prossime/recenti e canali recenti, contenuti promozionali/FAQ e annunci. La navigazione header conduce a cataloghi partite e canali; le liste hanno ricerca, paginazione, stato di caricamento e stato senza risultati (`g-matches.component.html`, `g-channels.component.html`). Selezionare un match conduce al dettaglio pubblico; il dettaglio carica match e blog, e avvia aggiornamento periodico per match iniziati non archiviati. I tab sono Events, lineup casa/trasferta, Stats e Share. Il feed testo può essere alternato alla radio audio; il player espone play/pausa/ripresa/stop e opzione di partire dagli eventi passati.

**Stati e azioni verificati:** loading/error via base component/error handler; scheduled vs started/halftime/full time; tab selezionata; polling; modalità testo/radio e stati audio (attesa evento/caricamento/riproduzione/pausa). Azioni: ricerca e paginazione cataloghi; apertura partita; scelta tab; configurazione commentatore; ascolto; condivisione/copia URL; follow, like e reazioni quando consentiti.

**Punti di frizione osservabili nel codice:** la pagina di match concentra molte destinazioni in tab e, nella vista Events, settings, radio/testo e feed. Le interazioni che richiedono account sono contestuali alla partita e alcune portano al login con ritorno al match. L’effettiva chiarezza e facilità d’uso non è stata misurata.

### 2. Spettatore → interazione e accesso

**Documentato:** seguire il match non richiede account; commenti, rating e follow lo richiedono. Audio TTS può non essere disponibile o fallire. Le regole precise di interazione non sono tutte note. Fonti: `docs/wiki/business/actors/Spettatore (actor).md`, workflow `Spettatore Partita`, `Riproduzione Audio Telecronaca`.

**Verificato:** il template pubblico mostra invito al login nelle impostazioni per anonimi; azione login invoca `LoginCallbackService.goToLogin('/g-match/' + matchId)`. Follow chiede permesso notifiche e mostra warning se negato; l’utente autenticato può richiedere toggle follow. Il like viene presentato a tempo pieno se l’utente non ha ancora messo like. Le quick reaction audio verificano login prima di inviare la reazione. Nella lineup, il pulsante rating è presente anche per anonimi nel template comune, ma il codice letto nella pagina pubblica non mostra un gate esplicito prima della chiamata; le regole effettive server-side e il feedback di rifiuto richiedono verifica ulteriore.

**Domande aperte:** quali interazioni anonime sono ammesse? Quali sono i limiti di commenti/rating/reazioni? Qual è il comportamento atteso se audio o permesso notifiche non sono disponibili? Il ritorno post-login conserva tab e contesto preciso o solo route partita?

### 3. Cronista → creazione/configurazione → live → conclusione

**Documentato:** il cronista apre o crea partita, produce la cronaca con pochi click, gestisce eventi e formazioni. Il wiki descrive anche un wizard di creazione rapida, con scelta canale, squadre, data e riepilogo; l’articolo precisa che la creazione composta tocca API e modello dati. Fonti: workflow `Cronista Telecronaca`, `Gestione Canale`; `docs/wiki/articles/Creazione Rapida Partita (article).md`.

**Verificato:** dashboard autenticata espone quick match, canali, preferiti e profilo. Il wizard `MatchCreateComponent` ha cinque step: canale (esistente o nuovo), squadra casa, squadra ospite (esistente o nuova), data, riepilogo; quindi invia creazione e notifica refresh. La lista canali autenticata consente di aprire canali e creare un canale da drawer con nome, titolo e sottotitolo header. In `/user-match/:matchId`, tab Live compare all’inizio e scompare a full time; Events, lineup, Stats e Share restano. In Scheduled il cronista può aprire il drawer di avvio e fornire meteo, temperatura, genere, durata del primo tempo e commento. Durante il live appaiono pulsanti evento raggruppati in azioni primarie/avanzate e falli; a halftime è disponibile l’azione secondo tempo; il timer aggiorna le statistiche. Nei tab formazioni può modificare giocatori prima del full time; la modalità editor fa caricare i giocatori e mostra l’editor. La pagina Events permette gestione commentatore e feed eventi. A full time Live scompare e il tab selezionato viene riportato a Events.

**Stati e azioni verificati:** loading/errore; scheduled, live, halftime, full time; modalità possesso/posizione; tab; selezione e invio eventi; inizio/secondo tempo; modifica line-up; consultazione stats; condivisione; aggiornamento automatico. Le operazioni di dominio e validazioni backend non sono state ispezionate.

**Punti di frizione/limiti:** il live presenta più gruppi di pulsanti evento, oltre a impostazioni AI e azioni legate alle fasi di gioco. Questo rende la densità un punto da valutare con l’analisi mobile e osservazioni sul campo; non è prova che il flusso sia lento. Il brief chiede pochi tocchi e uso smartphone, ma il codice da solo non verifica dimensioni percepite, raggiungibilità o velocità in partita.

### 4. Utente autenticato → dashboard e account

**Documentato:** home loggata mostra profilo, statistiche personali e partite in corso (`HomePage (web).md`); il profilo e gestione account sono autenticati (`Mappatura Frontend Pubblico e Autenticato`).

**Verificato:** dashboard personalizza saluto/immagine, mostra quick actions per fast match/canali/preferiti/profilo, statistiche e suggerimento per avviare un training match in una condizione specifica. Il menu header autenticato offre profilo, canali, preferiti, area account/danger e logout. Guard: se non loggato restituisce `false`; in `AuthGuardService` non è visibile un redirect o un callback. Login/registrazione/reset password sono route pubbliche.

**Domande aperte:** quale messaggio/redirect vede l’utente quando visita direttamente una route protetta da anonimo? Come sono gestiti account con permessi diversi su canali e match? La dashboard presenta le partite in corso attraverso un’area, ma i relativi stati vuoti/errori non sono stati approfonditi.

## Matrice sintetica pagine / stati / azioni

| Superficie | Accesso | Stati principali verificati | Azioni principali |
|---|---|---|---|
| Home `/` | Pubblico, con variante autenticata | sessione, TWA/mobile, splash | discovery, link a partite/canali, accesso, azioni dashboard |
| Cataloghi `g-matches`, `g-channels` | Pubblico | loading, risultati, no results, paginazione | ricerca, clear, apertura card, pagina successiva |
| Match `g-match/:matchId` | Pubblico, interazioni ibride | scheduled/live/halftime/full time, tab, polling, audio/text, errore | leggere eventi, lineup, stats, share, audio, follow/login/like/reazioni |
| Canali `user-channels`, `user-channel/:id` | Autenticato | loading, lista vuota/piena, drawer creazione | creare/aprire/gestire canale |
| Match editor `user-match/:id` | Autenticato | scheduled/live/halftime/full time, tab, modalità possesso, loading/errore | avvio, inserimento eventi, intervallo/secondo tempo, edit lineup, stats, share |
| Account | Pagine auth pubbliche; profilo e preferiti autenticati | sessione/login e validazioni non approfondite in questa ricognizione | login, registrazione, reset, profilo, preferiti, logout |

## Divergenze wiki/codice

1. **Home anonima browser:** la wiki descrive onboarding, marketing e caroselli. La home Angular in browser include questi contenuti, ma mostra anche contenuti pubblici di match/canali e annunci. Non è soltanto una landing.
2. **Home TWA:** la wiki definisce la route adatta a TWA/mobile e descrive splash/dashboard/landing. Nel template la splash viene mostrata solo se `isTwa && internalShowSplash`; una volta nascosta, TWA riceve liste di partite/canali ma il ramo contenuti marketing anonimi è escluso con `!isTwa`. Da verificare la regola di prodotto per primo avvio TWA.
3. **Polling pubblico:** la pagina wiki dice polling attivo durante partite in corso. Il codice verifica `isStarted` e match non archiviato prima di chiamare `startTimer`; il timer viene creato ogni 60 secondi. Match halftime/full time interrompono ulteriori refresh nel callback timer, ma il timer resta registrato fino al destroy.
4. **Polling editor:** la wiki parla di timer di auto-refresh. Il codice `MatchComponent.startTimer()` esegue `minuteChange()` ogni minuto; quel metodo invia `updateStats` con lo stato locale anziché rileggere la partita. Quindi la descrizione “auto-refresh” non corrisponde a una lettura evidente in questo metodo.
5. **Regole di autenticazione:** la wiki sintetizza che follow/like/interazioni richiedono login. Nel template pubblico il follow è condizionato a utente autenticato, mentre il like è esposto solo autenticato a full time; quick reaction richiede login al click. Il rating lineup presenta un controllo attivabile anche in vista pubblica e il gate non è visibile nel template; policy effettiva da verificare.
6. **Rotte e copertura wiki:** il README comparativo wiki dichiara che non ricostruisce l’intero routing. Il file `app.routes.ts` espone inoltre pagine pubbliche radio, team, statistiche, feedback, e route account/danger/favorites non incluse nel flusso dettagliato qui. La route manutenzione è condizionale a environment.

## Frizioni osservate e piste da validare

- L’accesso ai contenuti è distribuito tra la home, cataloghi separati e menu laterale; verificare se un visitatore comprende dove trovare rapidamente una partita live.
- La home ha contenuti promozionali, cataloghi e annunci nella stessa sequenza. Verificare ordine, peso e opportunità di raggiungere subito una partita.
- Nelle partite, Events è la tab iniziale e ospita sia lettura testuale sia esperienza radio e controlli di configurazione; osservare se la commutazione è comprensibile su smartphone.
- Il cronista opera con molte azioni specifiche e controlli di stato nella tab Live. Testare sul dispositivo reale con una simulazione di partita e una mano sola; il codice non dimostra la raggiungibilità dei tap.
- Lo stato di autenticazione cambia quali controlli sono visibili o eseguibili. Validare inviti al login e ritorno all’azione, soprattutto per rating e reazioni.
- Drawer e form sono presenti nei flussi di creazione; verificare contenimento su schermi piccoli, tastiera mobile e persistenza dei dati tra step.

Queste sono aree di indagine, non requisiti o proposte approvate.

## Decisioni / domande aperte

1. La home anonima deve servire prima scoperta del contenuto, presentazione del prodotto o entrambi? Il README richiede confrontare alternative e lascia la scelta aperta.
2. Quale esperienza deve mostrare la home TWA dopo la splash iniziale?
3. Qual è la matrice corretta di accesso per commenti, rating, reazioni, like e follow? Quali azioni devono riportare all’intento dopo autenticazione?
4. La pagina pubblica deve continuare a ricaricare contenuti per un match live ogni 60 secondi, e quali stati interrompono il polling?
5. Cosa deve succedere quando l’utente anonimo entra su route protetta? La guard attuale nega l’attivazione senza redirect esplicito visibile in quel servizio.
6. Il flusso cronista è ottimizzato per uso in campo da smartphone? Servono test osservati per confermare tempi, errori di tap e reachability.
7. Le pagine radio standalone, canale pubblico, squadra, statistiche e feedback sono nel perimetro del redesign? Sono route pubbliche disponibili, ma non tutte erano coperte dalle fonti/analisi richiesta.
8. Quanto incidono SEO, analytics e annunci sui percorsi prioritari? Il codice home imposta metadata e tracking; il catalogo inserisce annunci ogni sette elementi. La scelta UX richiede dati di prodotto e approvazione.

## Limiti della ricognizione

- L’analisi è statica e limitata alle fonti e ai file citati; non sono state eseguite l’applicazione né prove responsive, PWA/TWA, tastiera, screen reader o device reali.
- Non sono stati consultati backend/API, quindi autorizzazioni finali, validazioni, persistenza e limiti di interazione restano da confermare.
- Non sono stati analizzati tutti i componenti e tutte le route account/pubbliche, né svolte interviste o test con spettatori e cronisti.
- I contenuti/wiki possono non riflettere la produzione corrente; la verifica copre il checkout presente.
- Nessuna modifica a frontend o wiki è stata effettuata.

### File di codice verificati

- Routing e accesso: `src/RugbyRadioWeb/src/app/app.routes.ts`; `src/RugbyRadioWeb/src/app/services/auth-guard.service.ts`.
- Home e menu: `src/RugbyRadioWeb/src/app/site/home/home.component.ts`; `src/RugbyRadioWeb/src/app/site/home/home.component.html`; `src/RugbyRadioWeb/src/app/site/header/header.component.html`; `src/RugbyRadioWeb/src/app/site/home/home-user/home-user.component.html`.
- Cataloghi: `src/RugbyRadioWeb/src/app/global/g-matches/g-matches.component.html`; `src/RugbyRadioWeb/src/app/global/g-channels/g-channels.component.html`.
- Spettatore: `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.ts`; `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.html`; `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.ts`; `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.html`; `src/RugbyRadioWeb/src/app/common/match-lineup/match-lineup.component.html`.
- Cronista: `src/RugbyRadioWeb/src/app/user/match/match.component.ts`; `src/RugbyRadioWeb/src/app/user/match/match.component.html`; `src/RugbyRadioWeb/src/app/user/match/match-live/match-live.component.html`; `src/RugbyRadioWeb/src/app/user/match/match-events/match-events.component.html`; `src/RugbyRadioWeb/src/app/user/channels/channels.component.html`; `src/RugbyRadioWeb/src/app/common/match-create/match-create.component.html`.

La fonte wiki e il codice si trovano nei repository accessibili. Non sono stati individuati percorsi richiesti mancanti; la parte backend/API è fuori dall’ambito di questa assegnazione e non è stata esaminata.
