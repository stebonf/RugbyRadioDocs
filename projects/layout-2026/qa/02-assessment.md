# Valutazione risposte e raccomandazioni esperte — Q&A 02

**Fonte stakeholder:** `docs/Q&A - 02.md`.
**Analisi coordinate:** `qa/02-home-and-trial-recommendation.md`, `qa/03-navigation-and-twa-recommendation.md`, `qa/04-technical-verification.md`, `qa/05-auth-and-intent-recommendation.md`.
**Scopo:** convertire risposte e deleghe aperte in una direzione esperta e praticabile. I “non lo so” del responsabile sono incarichi di proposta agli agenti, non richieste di altre risposte.

## Pertinenza delle risposte

Le risposte sono pertinenti al redesign UX/UI e in parte descrivono comportamenti desiderati. Gli agenti li hanno confrontati con codice e wiki; qui si separano intenti di prodotto, comportamento verificato e raccomandazioni.

| Tema della risposta | Esito della verifica | Sintesi e conseguenza |
|---|---|---|
| Registrazione via email crea canale test; Home lo segnala | **Intento pertinente; comportamento esistente in gran parte confermato, privacy contraddetta dal codice.** | Registrazione email e Google provisionano canale test, squadre e partita. Il form email attuale richiede anche nickname e password. Dashboard mostra già un invito condizionale ma può lasciare un pulsante inerte se fallisce il lookup. Il canale è escluso da discovery e sitemap, ma l’endpoint pubblico per ID non mostra protezione equivalente: non va chiamato “privato” come garanzia finché la privacy effettiva non è assicurata. |
| Wizard veloce, soli campi obbligatori, utenti autenticati | **Intento pertinente e flusso confermato; descrizione wiki non aggiornata.** | Il wizard è autenticato e realizza il quick-create, ma l’interfaccia attuale ha cinque passaggi numerati più introduzione, non tre. Può preselezionare il canale esistente (che per un nuovo utente può essere quello di test). Separare visualmente “prova” da “crea una partita reale” ed evitare riuso involontario del canale test. |
| Policy di autenticazione affidata a product owner | **Incarico correttamente delegato agli agenti.** | Proposta esperta: lasciare anonimi esplorazione, lettura, ascolto e condivisione; chiedere login per scritture personali e strumenti di gestione; CTA contestuale e ritorno a pagina/tab/oggetto dopo login, con tap di conferma prima della scrittura. Le policy API vanno verificate prima dell’implementazione. |
| Navigazione mobile affidata agli agenti | **Incarico correttamente delegato; proposta prodotta.** | Proposta preferita a quattro voci autenticato: Home, Partite, Crea, Profilo; Canali accessibili dalla Home/contesti, ascolto Radio dalla partita. Variante a cinque voci rinominando Radio in Canali se l’uso del catalogo lo giustifica. Non ci sono dati d’uso per preferire la variante alternativa. |
| TWA affidata agli agenti | **Incarico correttamente delegato; proposta prodotta.** | Splash distinto e breve; poi Home anonima content-first con spiegazione essenziale, esempi e accesso, oppure dashboard operativa per autenticati. Non ripetere splash agli avvii successivi; conservare eventuali link diretti. La persistenza effettiva va verificata in runtime, ma non blocca la proposta. |
| “Non mi interessa un fallback; se qualcosa non va l’intero applicativo è giù” | **Assunzione non confermata dal comportamento tecnico.** | È plausibile per un guasto hosting/asset totale; non per errori isolati di API/query. In quel caso shell e sezioni sorelle possono restare attive mentre una sezione scompare come vuota o il wizard non dà feedback. Non serve progettare un’elaborata esperienza offline: servono messaggi locali minimi, distinzione vuoto/errore e recovery per azioni che falliscono. |
| Priorità della dashboard e gerarchia prova/esplorazione affidate agli agenti | **Incarico correttamente delegato; proposta prodotta.** | Dashboard senza marketing: card del canale/partita test per nuovi account, azione primaria in base all’attività, partite e canali, poi statistiche/profilo. Home anonima: spiegazione breve, CTA principale prova cronista, secondaria esplorazione, esempi pubblici subito raggiungibili. Non imporre un profilo fisso cronista/spettatore. |
| Validazione rimandata a fine lavoro | **Preferenza temporale pertinente.** | Proposte esperte e direzione possono essere completate ora senza user test o nuova raccolta dati. La validazione con persone e dispositivi si pianifica come fase successiva, quando il pacchetto UX/prototipo sarà completo; non va usata per bloccare l’attuale ideazione. |

## Raccomandazione integrata

### Esperienza anonima e autenticata

- **Anonimo:** primo schermo breve che spiega cosa fa RRL, mostra un esempio concreto e propone due percorsi: **Prova la telecronaca** e **Esplora partite e radio**. Per la prova, spiegare prima della registrazione che RRL prepara automaticamente un ambiente demo; non costringere a scegliere “cronista/spettatore”. Il form può mantenere per ora le credenziali esistenti (email, nickname, password), interpretando “con una email” come registrazione tramite email senza configurazione manuale di canale/squadre/partita.
- **Nuovo utente autenticato:** atterrare sulla dashboard, senza marketing; mettere in primo piano la prova già predisposta e accompagnare all’avvio della partita demo, al primo evento e alla vista del risultato.
- **Utente autenticato attivo:** azione primaria contestuale (continua una partita live o crea una partita), scorciatoie a canali/partite e informazioni di profilo in secondo piano. L’ipotesi di un selettore di ruolo nel profilo non serve al primo incremento.
- **Wizard:** mantenerlo distinto dalla demo. Il suo scopo è creare una partita reale scegliendo/creando canale e squadre, inserendo i soli dati necessari, rivedendo il riepilogo e confermando. Contrassegnare chiaramente il canale test e non selezionarlo per errore come contenitore di contenuto pubblico.

### Navigazione e pagine pubbliche

Adottare come proposta di base la barra autenticata **Home · Partite · Crea · Profilo**. Mettere **Canali** nella Home, nel contesto delle partite e in un link sempre evidente; mantenere l’ascolto Radio legato al match e raggiungibile da link diretto. Pagine squadra, statistiche e feedback restano nel perimetro e facilmente raggiungibili, ma non occupano una tab primaria senza dati che dimostrino un uso ricorrente. Conservare una variante a cinque voci **Home · Canali · Crea · Partite · Profilo** solo se necessaria a non nascondere il catalogo.

### Accesso e conservazione dell’intento

Lasciare anonime tutte le azioni di lettura/ascolto/condivisione pubblica. Richiedere login alle azioni persistenti legate alla persona (commento, reazione, voto/like, follow/notifiche) e alle funzioni del cronista. Al login presentare accesso e registrazione nello stesso contesto, spiegare il motivo e ripristinare URL, tab ed elemento; poi chiedere un tap esplicito per completare scritture o notifiche. Verificare la matrice con API e autorizzazioni, senza affidarsi ai soli gate frontend.

### TWA

Usare uno splash iniziale breve, diverso dalla presentazione web. Dopo lo splash mostrare contenuti pubblici ed esempi per l’anonimo, dashboard operativa e prova per l’autenticato. Non ripetere lo splash al ritorno e conservare eventuali deep link. È una proposta completa per iniziare il design; verificare poi storage, sessione e comportamento reale dell’app installata.

### Errori proporzionati

Non introdurre una complessa modalità offline o una pagina globale per qualunque guasto. Quando l’hosting/asset non sono disponibili, la UI non può intervenire. Quando fallisce una singola query, mantenere attive le altre aree e mostrare nel blocco interessato un messaggio essenziale, distinguendo errore da “nessun risultato”; offrire retry per letture recuperabili. Per registrazione/wizard, mostrare l’errore vicino all’azione e conservare i dati inseriti. Non ripetere automaticamente operazioni di scrittura finché rollback/idempotenza non sono confermati.

## Punti aperti con soluzione raccomandata

Questi sono i soli elementi ancora da decidere/verificare; per ciascuno gli agenti hanno già indicato una soluzione, quindi non è necessario rimettere a te la domanda aperta in questa fase.

1. **Privacy della demo — bloccante prima della promessa “privata”.** Il prodotto la intende privata, ma i controlli letti escludono discovery/sitemap senza dimostrare l’autorizzazione su endpoint pubblici per ID. Raccomandazione: applicare ownership/autorizzazione server-side a match, canale, squadre e risorse collegate; solo dopo chiamarla “privata” nell’interfaccia. In alternativa, finché il backend non è corretto, chiamarla “demo non elencata” e non promettere visibilità solo personale. È dipendenza backend/sicurezza, separata dal redesign frontend.
2. **Cosa significa “registrarsi con una email”.** Il form presente richiede email, nickname e password. Raccomandazione a basso impatto: mantenere il modello attuale e rimuovere il setup manuale grazie al provisioning automatico; email-only/passwordless richiederebbe una diversa specifica e cambi API/autenticazione. Questa interpretazione è da verificare nel gate di prodotto, ma non blocca le proposte UX.
3. **Canale demo nel wizard.** Il DTO non espone il flag test e il wizard può preselezionare il canale esistente. Raccomandazione: distinguere il canale demo dai canali pubblici, preselezionare la creazione di un nuovo canale nel percorso “Crea partita” oppure chiedere una selezione intenzionale; adeguare DTO/API se serve un’etichetta affidabile.
4. **Callback autenticazione e policy backend.** La raccomandazione è stata formulata; il callback attuale salva solo una URL e i template non mostrano gate uniformi per tutte le interazioni. Verificare/implementare matrice API e ritorno a tab/oggetto prima di cambiare i CTA.
5. **Errore di registrazione con provisioning parziale.** Il record utente può essere scritto prima che canale demo/token completino; un errore può apparire come registrazione fallita mentre l’account esiste. Definire col backend esito/recupero senza generare account duplicati; nel frattempo la UI deve spiegare l’errore e non incoraggiare retry cieco.

Altri punti — variante a quattro/cinque voci, gerarchia tra CTA, dettagli TWA e contenuti dashboard — hanno una proposta esperta preferita e possono passare alla revisione della direzione senza raccogliere ulteriori risposte. La validazione con persone e dispositivi è rinviata come richiesto.

## Tracciamento

- Direzioni del responsabile in Q&A 01 e Q&A 02: `Decisions.md`.
- Valutazione iniziale risposte Q&A 01: `qa/01-assessment.md`.
- Raccomandazioni esperte e verifica tecnica: i quattro documenti collegati all’inizio di questo file.
- Roadmap aggiornata: `delivery/07-priorities-and-rollout.md`.

## Limiti

Le raccomandazioni sono sintesi di analisi statica del checkout e delle risposte stakeholder, non decisioni formalmente approvate. I flussi TWA, query/API live e provisioning effettivo non sono stati eseguiti in ambiente runtime. La questione accesso alla demo è un rilievo basato sui metodi esaminati, non una scansione completa di ogni endpoint, asset o policy di produzione; serve una verifica backend/sicurezza prima del rilascio della promessa di privacy. Nessun codice applicativo è stato modificato.
