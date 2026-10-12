# Raccomandazione: navigazione mobile e avvio TWA

**Stato:** raccomandazione esperta per la direzione UX; non equivale a una decisione di prodotto approvata né a una specifica pronta per implementazione.

## Sintesi della raccomandazione

Semplificare la navigazione mobile autenticata da cinque voci a quattro: **Home · Partite · Crea · Profilo**. Rimuovere **Radio** dalla barra persistente e rendere l’attuale destinazione di quella voce esplicita come **Canali**, raggiungibile dalla Home e dalle pagine collegate. Il lettore radio resta un’azione contestuale e una destinazione pubblica condivisibile; non è una sezione globale perché oggi il frontend espone `/g-radio/:matchId`, cioè una radio legata a una partita, senza un catalogo radio generale.

La barra attuale è mostrata solo quando l’utente è autenticato (`entity-bottom-nav.component.html`); le sue voci sono Home, Radio (link a `/g-channels`), Crea (apre il wizard), Partite (`/g-matches`) e Profilo (`/user-profile`). La proposta mantiene i tre compiti più distinti e frequenti, elimina la duplicazione tra home e canali in navigazione persistente e chiarisce che la radio si ascolta nel contesto di una partita. È una scelta di IA da verificare prima di applicarla: “Radio” è una parola riconoscibile e il prodotto la considera una superficie importante.

Le pagine pubbliche **radio, squadra, statistiche e feedback** restano nel perimetro e raggiungibili senza login. La loro gerarchia consigliata è: radio dal dettaglio match/canale e da link diretto; squadra dal match/canale; statistiche da partite e dal menu “Altro”; feedback dal menu supporto/footer e dalle schermate pertinenti. Nessuna di queste quattro destinazioni va inserita come tab persistente aggiuntiva.

In TWA, lo splash compare solo al primo avvio in cui la preferenza locale lo richiede. Dopo lo splash, anonimo e autenticato arrivano a esperienze diverse: **anonimo → Home pubblica orientata ai contenuti con spiegazione breve, esempi e accesso; autenticato → dashboard operativa senza marketing**, con canale di test e pulsante per iniziare una prova in evidenza. Agli avvii successivi lo splash non deve ripetersi; l’utente torna alla Home anonima o alla dashboard in base alla sessione corrente.

## Cosa è già confermato e cosa raccomando

### Direzioni confermate dal responsabile prodotto

- Anonimo: deve capire cos’è RRL, vedere esempi e sapere come accedere. Autenticato: esperienza operativa, senza contenuti marketing. (Q&A 01, risposte 1 e 3; `projects/layout-2026/Decisions.md`.)
- Dare risalto alla prova cronista con wizard rapido e canale di test privato per utente. Q&A 02 chiarisce che il canale test viene creato alla registrazione via email e non è pubblico; in Home deve comparire un’etichetta e un pulsante per avvisare l’utente.
- Il wizard, per utenti loggati, crea in pochi passaggi canale, due squadre e partita, chiedendo inizialmente i campi obbligatori; ulteriori dettagli possono essere aggiunti dopo. (Q&A 02.)
- Lo splash TWA deve differire dall’introduzione marketing del web, perché l’installazione dallo store ha già presentato il prodotto. Questo non significa che la home anonima TWA debba essere una schermata vuota o che non debba spiegare i contenuti.
- Radio pubblica, squadre, statistiche e feedback sono superfici importanti per dimostrare il prodotto e portare traffico. Il responsabile non ha assegnato loro una posizione precisa nella barra.
- Semplicità e pochi passaggi sono il principio guida. L’elenco futuro della navigazione mobile e le policy di autenticazione restano aperti.

### Raccomandazioni in questo documento

- Barra autenticata con quattro destinazioni: **Home, Partite, Crea, Profilo**. La Home diventa anche il luogo da cui esplorare i canali, con link chiaro “Tutti i canali”; la voce persistente “Radio” scompare.
- Per anonimi nessuna barra con azioni protette. Usare intestazione/menu e collegamenti chiari verso Home, Partite, Canali, Accedi e Registrati. Non introdurre una nuova barra persistente anonima senza evidenza che serva.
- Radio come azione di ascolto contestuale al match e come URL diretta per condivisioni/risultati esterni; pagina squadra contestuale; statistiche e feedback secondari ma visibili.
- Home TWA anonima content-first dopo splash; Home TWA autenticata in modalità dashboard operativa. Lo splash si sopprime ai ritorni, salvo una futura azione esplicita di riapertura introduttiva.
- Nessuna preferenza “cronista/spettatore” obbligatoria in profilo per determinare home o navigazione: il responsabile l’ha descritta come possibilità, non come decisione. Il task Crea resta visibile agli autenticati e l’interfaccia può mettere in evidenza attività compatibili con i dati/permessi reali.

## Navigazione mobile raccomandata

### Barra persistente autenticata

| Voce | Destinazione proposta | Motivazione |
|---|---|---|
| **Home** | `/user-dashboard` dopo login; per autenticati può usare `/` se il router mostra la dashboard in base alla sessione | Punto d’ingresso operativo. Mostra canale di test e prova guidata, attività e accessi frequenti. Il codice attuale assegna Home a `/`, mentre anche `/user-dashboard` monta `HomeComponent`; va resa coerente la destinazione dopo login. |
| **Partite** | `/g-matches` | Accesso rapido alla scoperta e alla fruizione pubblica. La pagina è pubblica e resta utile anche agli account autenticati. |
| **Crea** | Wizard `MatchCreateComponent` esistente | È la scorciatoia principale al flusso composto che evita di creare separatamente canale, squadre e partita. Non cambiarne il dominio come parte del restyle. |
| **Profilo** | `/user-profile` (con accessi ad account e preferiti) | Raggruppa configurazione personale, preferiti, canali gestiti e logout; non appesantisce la barra con singole destinazioni amministrative. |

**Dove trovare i canali:** Home autenticata e anonima mostrano o devono collegare le superfici di canali; CTA **Tutti i canali** porta a `/g-channels`. La pagina resta a un tap dalla Home. Nelle partite, il canale collegato apre il dettaglio pubblico `/g-channel/:channelPublicId`. In questo modo la rimozione della voce “Radio” non nasconde il catalogo.

**Cosa succede a Radio:** rinominare l’attuale voce in **Canali** sarebbe un miglioramento lessicale minimo, ma lascerebbe cinque tab e non semplificherebbe la struttura. La raccomandazione preferita la toglie dalla barra, mette Canali in Home e colloca **Ascolta** nell’esperienza della partita. Un link diretto `/g-radio/:matchId` continua a funzionare come destinazione condivisa e include già un ritorno esplicito al match.

**Pagine partita:** la barra attuale viene nascosta per `/g-match/:matchId` e `/user-match/:matchId` (`app.component.ts`). Conservare questa eccezione durante la telecronaca: il cronista deve avere spazio e contesto stabile per la tab Live; lo spettatore usa le tab interne Events, lineup, Stats e Share. Un link di ritorno alla Home/Partite deve restare disponibile nel guscio.

### Superfici pubbliche e livelli di gerarchia

| Pagina | Livello consigliato | Percorso mobile |
|---|---|---|
| **Radio pubblica** `/g-radio/:matchId` | Azione di fruizione primaria dentro la partita; destinazione diretta per URL condiviso. Nessuna tab “Radio” globale senza un catalogo generale. | Partite → dettaglio partita → **Ascolta**; oppure link condiviso → radio → “Torna alla partita”. |
| **Squadra** `/g-team/:teamId` | Dettaglio collegato, non voce globale. È una prova concreta del contenuto e utile all’indicizzazione, ma non è un compito di navigazione ricorrente dimostrato. | Match o canale → nome squadra → pagina squadra; dalla pagina squadra proseguire alle partite/canali mostrati dal componente solo se già forniti. |
| **Statistiche pubbliche** `/g-stats` | Destinazione secondaria nel menu **Altro** e link contestuale dalle statistiche match. Utile come prova del prodotto, con priorità inferiore a trovare/ascoltare una partita. | Match → tab Stats; oppure Menu → Statistiche. |
| **Feedback** `/g-feedback` | Supporto, fuori dalla barra e dal percorso di fruizione principale. Link nel menu secondario/footer e vicino al supporto quando appropriato. | Profilo/Menu → Aiuto e feedback → Feedback. Non richiedere login senza requisito verificato. |
| **Canali pubblici** `/g-channels` | Destinazione di esplorazione dalla Home e dal dettaglio match; accesso persistente rimosso nella proposta mobile. | Home → Tutti i canali; match → canale collegato. |

Il menu secondario può raccogliere **Canali**, **Statistiche**, **Feedback** e le destinazioni editoriali già presenti (Blog, News, Tutorial, Why, AI Talkers, Architecture, contatto). L’etichetta e l’ordine delle voci richiedono il contenuto corrente e traduzioni; non creare una pagina “Altro” se il pannello menu esistente basta.

## Esperienza Home e TWA

### Prima apertura TWA con utente anonimo

1. Mostrare lo splash di benvenuto distinto dalla landing web, coerente con la conferma che l’utente arriva dall’installazione Play Store. Tenerlo breve e con un’unica uscita verso l’app; non ripetere una lunga spiegazione promozionale già fruita nello store.
2. Dopo lo splash, aprire la **Home anonima di RRL**: una frase concreta che spieghi il servizio, esempi pubblici reali di partite e canali e accessi chiari a **Partite**, **Canali**, **Accedi** e **Registrati**.
3. Evitare i blocchi marketing estesi web (Why, tutorial e FAQ) sopra i contenuti. Restano raggiungibili dal menu/supporto per chi vuole approfondire.
4. Se non ci sono partite live, omettere il blocco live e mostrare lo storico pubblico di partite e canali, come indicato dal responsabile. Un errore complessivo dell’app va mostrato come errore, non interpretato come lista vuota: la risposta Q&A 02 dice che un disservizio implica indisponibilità generale.

Questa gerarchia rispetta entrambi gli obiettivi: l’utente TWA non riceve una seconda landing da store, ma capisce comunque cosa può fare e vede il prodotto in uso. Il codice attuale esclude i blocchi anonimi di marketing quando `isTwa` è vero e mostra feed partite/canali dopo lo splash; la raccomandazione aggiunge la spiegazione essenziale e CTA chiare, non un catalogo nuovo.

### Prima apertura TWA con utente autenticato

1. Dopo lo splash, atterrare sulla **dashboard**, senza introduzione marketing.
2. In testa, mantenere saluto e attività. Se il canale di test creato alla registrazione esiste ed è riconosciuto per quell’account, mostrare un’etichetta **Canale di prova · non pubblico** e un pulsante **Apri la prova**.
3. Mostrare un’azione primaria **Crea una partita** che apre il wizard esistente. Il canale di prova è una proposta di destinazione del pulsante “Apri la prova”; va collegata alla route e ai permessi verificati, senza dedurre che il wizard debba usare automaticamente quel canale.
4. Tenere partite, canali, preferiti e profilo come scorciatoie subordinate alla prova e alla creazione.

Q&A 02 conferma la generazione del canale di test e il label/pulsante in Home come comportamento voluto. Prima di implementare il CTA va comunque verificato quale route `user-channel/:channelId` lo apra e se l’API/servizio espone l’identificatore e lo stato di test. Non si assume che tale stato sia rappresentato dal profilo FE attuale.

### Avvii successivi

- **Anonimo:** non mostrare di nuovo lo splash; riaprire la stessa Home TWA content-first con esempi e accesso/registrazione. Se una URL profonda era la destinazione iniziale, preservarla come comportamento di navigazione/back secondo il router e il sistema operativo; non sostituirla con una landing ad ogni avvio.
- **Autenticato:** non mostrare lo splash; aprire la dashboard operativa, con prova canale test e wizard evidenti. Se la sessione non è valida, passare all’esperienza anonima e non lasciare un dashboard apparentemente autenticato.
- **Dopo login o registrazione nella sessione corrente:** completare l’autenticazione e mostrare la dashboard operativa. Per un’azione partita da una pagina pubblica, preservare la destinazione se l’utente ha esplicitamente richiesto quell’azione e la policy di login la supporta; le regole per rating, follow, reazioni e ritorno restano da definire dal product owner/API. Non trasformare questo principio in un redirect automatico per ogni login.

Lo splash esistente dipende da `isTwa && internalShowSplash` nella home e viene nascosto tramite stato/preferenza locale (`home.component.ts` da controllare nel dettaglio implementativo). La decisione di non ripeterlo è una raccomandazione coerente con “primo avvio/ritorni” e con l’esistenza della preferenza; va verificato il comportamento effettivo dello storage prima di modificare il codice.

## Sequenze di percorso per ruolo

### Visitatore anonimo su web mobile

`Home (breve descrizione + esempi) → Partite → partita pubblica → Leggi / Ascolta → lineup e statistiche → (se sceglie un’azione che richiede account) Login/Registrati → ritorno al contesto solo quando supportato dalla policy.`

Può anche esplorare canali da Home, aprire un dettaglio canale e seguire la radio/partita collegata. Radio, squadra e statistiche restano consultabili senza login secondo le route pubbliche attuali.

### Visitatore anonimo TWA

`Splash breve al primo avvio → Home content-first → Partite o Canali → match/canale → Ascolta oppure Leggi.`

`Avvio successivo → stessa Home content-first senza splash.` Accesso e registrazione restano disponibili, con spiegazione corta di ciò che RRL offre.

### Spettatore autenticato

`Home dashboard → Partite o Tutti i canali → dettaglio partita → cronaca/radio → lineup/Stats/Share.`

Il login non deve degradare la parte pubblica: un account può continuare a seguire contenuti. L’esposizione di commenti, rating, follow e reazioni segue la policy di prodotto/API ancora da fissare.

### Aspirante cronista / nuovo account

`Home anonima → Prova a raccontare → Registrati via email → dashboard → label “Canale di prova · non pubblico” + Apri la prova → wizard Crea una partita quando vuole creare la propria sequenza completa.`

La destinazione **Prova a raccontare** è una raccomandazione, coerente con l’obiettivo product-owner di far provare la telecronaca. Q&A 02 conferma che la registrazione crea il canale privato; l’etichetta e il pulsante in Home sono richiesti. La precisa destinazione di “Apri la prova” e la relazione fra wizard e canale test vanno mantenute distinte finché non sono mappate sul comportamento effettivo.

### Cronista già autenticato

`Avvio TWA → dashboard operativa → apri canale di test oppure Crea → wizard (canale / squadre / partita) → editor partita → Live → eventi / intervallo / secondo tempo → conclusione.`

Durante il live, la bottom nav sparisce nel dettaglio match e la scheda Live resta la destinazione operativa principale; questa eccezione è già prevista dal codice. Il cronista non dovrebbe dover navigare alle pagine pubbliche per tornare agli strumenti di registrazione.

## Variante considerata (tradeoff significativo)

**Mantenere cinque voci, ma rinominare Radio in Canali**: Home · Canali · Crea · Partite · Profilo. Questa è la variante se analytics o ricerca qualitativa mostrano che il catalogo canali è una destinazione primaria usata frequentemente e la Home non lo espone con un link/card chiaro. Mantiene la discoverability massima del catalogo, però non riduce il numero di tab e quindi soddisfa meno l’obiettivo esplicito di semplificare.

Non consiglio una voce **Radio** globale: l’implementazione collega la barra a `/g-channels`, mentre la route di playback disponibile è `/g-radio/:matchId`; la voce confonde catalogo canali e ascolto. In assenza di una pagina elenco radio o dati d’uso che dimostrino un bisogno frequente, l’ascolto contestuale è più comprensibile. Se la barra a quattro voci non ha spazio per il catalogo Canali, preferire la variante con etichetta chiara piuttosto che nascondere l’accesso ai contenuti.

## Evidenze di codice e wiki

- **Navigazione corrente:** `src/RugbyRadioWeb/src/app/common/entity-bottom-nav/entity-bottom-nav.component.html` mostra il menu solo quando autenticato; Radio punta a `/g-channels`, Crea apre `MatchCreateComponent`, Partite punta a `/g-matches`, Profilo a `/user-profile`.
- **Visibilità della barra:** `src/RugbyRadioWeb/src/app/app.component.html` la rende condizionata da `showBottomNav`; `app.component.ts` la nasconde in `/g-match/:matchId` e `/user-match/:matchId`.
- **Home e TWA:** `src/RugbyRadioWeb/src/app/site/home/home.component.html` mostra splash, HomeUser per autenticati, blocchi di presentazione solo per anonimi web (`!isTwa`) e feed match/canali per tutti. Q&A 01 chiede home differente per sessione; Q&A 02 specifica test channel e CTA.
- **Rotte:** `src/RugbyRadioWeb/src/app/app.routes.ts` espone `/g-match/:matchId`, `/g-radio/:matchId`, `/g-channel/:channelPublicId`, `/g-team/:teamId`, `/g-matches`, `/g-channels`, `/g-stats`, `/g-feedback`, e le route protette di account/gestione. Non esiste nel routing esaminato una route per catalogo radio indipendente dalla partita.
- **Home autenticata:** `src/RugbyRadioWeb/src/app/site/home/home-user/home-user.component.html` ha scorciatoie wizard, canali, preferiti e profilo; il wizard è montato globalmente come `app-match-create` in `app.component.html`.
- **Dettaglio radio:** `src/RugbyRadioWeb/src/app/global/g-match-radio/g-match-radio.component.html` mostra partita, punteggio/stato, play/pausa/stop, opzione dall’inizio e link per tornare alla partita.
- **Esperienza attesa:** `docs/wiki/frontend/web/pages/HomePage (web).md`, `GMatchPage (web).md`; `docs/wiki/business/actors/{Cronista,Spettatore} (actor).md`; `docs/wiki/workflows/{Cronista Telecronaca,Spettatore Partita,Riproduzione Audio Telecronaca} (workflow).md`.
- **Analisi di progetto:** `projects/layout-2026/analysis/01-user-flows.md`, `03-mobile-experience.md`, `04-anonymous-home-options.md`, `05-information-architecture.md`, `projects/layout-2026/qa/01-assessment.md`, `projects/layout-2026/Decisions.md`.

## Dipendenze e limiti

1. **Canale di test:** verificare entity e route di apertura, indicatore privato, ownership e permessi in codice/API. Q&A 02 ne conferma la creazione a registrazione, ma non documenta identificatore, modello, o route esatta per la UI.
2. **Landing/login:** verificare registrazione email, CTA esistenti e redirect. La route `/user-registration` è pubblica, ma la navigazione attuale da Home non dimostra da sola il flusso completo richiesto.
3. **Home TWA e persistenza splash:** `isTwa`, `internalShowSplash` e preferenza persistita vanno riletti nel TypeScript e provati in TWA/PWA; il template statico non dimostra primo avvio e successivi.
4. **Home senza live:** l’omissione quando non ci sono match live è confermata; la disponibilità dello storico è dichiarata dal responsabile ma va verificata nel servizio dati. Q&A 02 dice che un errore significa applicazione giù: disegnare feedback d’errore di caricamento a livello applicativo, non scambiare errore per feed vuoto.
5. **Login contestuale:** policy di interazione e ritorno rimangono aperte, quindi il documento raccomanda percorsi ma non dichiara quali azioni siano gated.
6. **Traffico e priorità:** il responsabile dichiara valore e traffico delle pagine pubbliche, ma non sono stati forniti dati quantitativi. L’ordine proposto è qualitativo e dovrà essere riconsiderato se i dati mostrano che Canali merita una tab persistente.

La verifica disponibile è documentale/statica. Non sono stati provati la TWA installata, il comportamento della sessione al riavvio, l’accesso del canale test, le autorizzazioni server-side o la frequenza d’uso delle cinque voci. La presente raccomandazione non modifica codice e non chiude la policy di autenticazione.
