# Raccomandazione — policy di autenticazione e conservazione dell’intento

**Stato:** proposta di product analysis da sottoporre a decisione; non cambia la policy attuale e non autorizza modifiche al codice.

## Decisione raccomandata

Mantenere anonima la scoperta e la fruizione dei contenuti pubblici. Richiedere un account solo quando l’utente vuole compiere un’azione persistente collegata alla propria identità, oppure accedere agli strumenti del cronista. Al confine di accesso spiegare in una frase perché serve il login, offrire login e registrazione nello stesso passaggio e riportare la persona al contenuto e all’azione che aveva scelto.

Non chiedere all’utente di selezionare un profilo “cronista/spettatore” prima di usare il prodotto: la Q&A 01 lo lascia come possibilità, ma la registrazione può rimanere semplice e i percorsi si distinguono dal gesto scelto. Dopo la registrazione, valorizzare il canale di test privato che la Q&A 02 dice essere creato automaticamente.

## Policy proposta per azione

| Azione | Anonimo | Login richiesto | Comportamento raccomandato dopo login |
|---|---|---|---|
| Aprire home, liste, canali, squadre, match, statistiche e pagine radio pubbliche | Sì | No | Resta nel contenuto aperto. |
| Leggere cronaca, commenti già pubblicati, formazioni, statistiche e blog | Sì | No | N/A. Evita un account prima che la persona abbia provato RRL. |
| Ascoltare la radio/TTS e scegliere voce/lingua disponibili | Sì, se il contenuto audio è disponibile | No | Restare sulla stessa partita e modalità; le preferenze locali possono restare locali. |
| Condividere o copiare link pubblico | Sì | No | N/A. |
| Aggiungere un commento | No | Sì | Tornare allo stesso match, alla tab Eventi e all’evento cui si riferiva il commento; mostrare il campo pronto, ma non inviare automaticamente testo senza conferma. |
| Aggiungere una reazione emoji a un evento | No | Sì | Tornare allo stesso match/evento e riaprire o evidenziare l’azione di reazione; richiedere un nuovo tap per inviarla. |
| Votare un giocatore | No | Sì | Tornare alla stessa partita e formazione/giocatore; richiedere conferma con un tap. |
| Mettere like alla partita conclusa | No | Sì | Tornare alla partita e mostrare il controllo like; l’utente conferma il like. |
| Seguire partita o canale e ricevere notifiche | No | Sì | Tornare alla pagina entità e riaprire il controllo follow. Chiedere il permesso notifiche nel contesto del gesto, spiegando la finalità prima della richiesta del browser. |
| Creare/gestire canali, partite, squadre, formazioni o inserire eventi | No | Sì | Accedere alla dashboard o al match editor richiesto, nel rispetto dell’ownership. |
| Avviare il wizard quick match | No | Sì | Dopo login tornare alla dashboard e aprire il wizard solo se l’utente aveva premuto esplicitamente “Crea partita”; mantenere intatti i dati raccolti se possibile. |
| Provare il flusso cronista | Non scrivere su entità pubbliche senza login | Registrazione per il canale privato di test | Dopo registrazione mostrare chiaramente il canale di test automatico e un pulsante per aprirlo/iniziare la prova. Non obbligare a creare un canale o una partita pubblica. |

La policy è intenzionalmente semplice: lettura e ascolto pubblici restano aperti; le scritture personali e gli strumenti di gestione chiedono account. Non introduce soglie, piani o permessi nuovi.

## CTA e percorso di accesso

### Nel punto in cui serve l’account

- Usare un messaggio contestuale breve: “Accedi per commentare”, “Accedi per votare questo giocatore”, “Accedi per seguire questa partita e ricevere aggiornamenti”.
- Mostrare **Accedi** e **Crea account** nello stesso pannello; il secondo non deve essere nascosto dietro un ulteriore passaggio non correlato.
- Conservare l’azione scelta come intento. Dopo l’autenticazione riportare alla pagina, tab e oggetto interessati; richiedere un ultimo tap per completare un’azione che scrive o può generare notifiche.
- Se l’utente annulla o torna indietro, ripristinare la pagina pubblica senza perdita del contenuto letto.
- Mantenere una CTA globale “Accedi” nel menu. Nella presentazione anonima mantenere “Esplora senza account” e una CTA cronista che spieghi la prova privata.

### Dal blocco cronista alla registrazione

La Q&A 02 specifica: registrazione via email, creazione automatica di un canale privato di test, etichetta e pulsante per avvisare la persona; il wizard è destinato agli utenti loggati e crea in pochi passaggi canale, due squadre e partita. Raccomando due percorsi distinti e chiari:

1. **Prova il cronista** → registrazione/login → dashboard autenticata con avviso sul canale di test privato e pulsante “Apri canale di test”. Il pulsante deve aprire il canale/match di prova già esistente e non il quick wizard.
2. **Crea una partita** → se anonimo, login/registrazione → dashboard → apertura diretta del wizard → raccolta dei soli campi obbligatori → riepilogo e conferma. Non creare le entità pubbliche prima della conferma.

La registrazione non dovrebbe essere proposta come prerequisito per vedere esempi pubblici. La prova del cronista è il motivo concreto per creare un account; il lettore può continuare a seguire partite senza sceglierlo.

## Conservazione del contesto: requisiti raccomandati

Conservare almeno:

- URL e identificativo match/canale;
- tab selezionata e, per interazioni su eventi/formazioni, identificativo dell’evento o giocatore;
- azione richiesta, in forma riconoscibile e circoscritta;
- eventuale bozza inserita dall’utente solo se si può conservarla in modo temporaneo e ripristinarla senza inviarla.

Dopo login o registrazione, ripristinare la pagina e rendere visibile l’azione originaria. Non eseguire automaticamente commento, reazione, rating, like o follow: la conferma dell’utente dopo il ritorno evita scritture involontarie e consente di rivalutare l’azione. La persona può quindi completare con un solo tap; la destinazione e l’oggetto sono già mantenuti.

Per una protezione di route diretta, tornare all’URL richiesto dopo l’autenticazione. La policy per l’utente che arriva direttamente a una route gestionale senza sessione dovrebbe spiegare che serve accedere e conservare la route richiesta; il permesso effettivo viene comunque ricontrollato dal backend.

## Stato attuale distinto dalla proposta

| Area | Comportamento corrente verificato | Differenza/rischio rispetto alla raccomandazione |
|---|---|---|
| Pagine pubbliche | `app.routes.ts` lascia pubblici cataloghi, match, canali, radio, team e statistiche; l’utente può leggere senza login. | Allineato al principio di discovery e fruizione anonime. |
| Callback login | `LoginCallbackService.goToLogin()` salva una stringa URL in `localStorage`; dopo login `goToCallback()` naviga a quell’URL. | Il callback visto è un URL pagina, non un’intenzione strutturata; tab, evento e azione non sono conservati dal servizio. |
| Accesso diretto a route protetta | `AuthGuardService.canActivate()` restituisce il booleano della sessione; nel servizio non è visibile redirect o salvataggio della route tentata. | Non assicura la ripresa del percorso diretto; messaggio/gestione effettiva da verificare nel router. |
| Login completato | `LoginComponent.onLoginSuccessfull()` chiama il callback con default `/user-dashboard`; `ngOnInit()` ha anche una subscription che naviga alla dashboard quando la sessione diventa autenticata. | La priorità fra queste due navigazioni va verificata nel runtime; non affidarsi al default dashboard per l’intento. |
| Registrazione completata | `RegistrationComponent` usa il callback con default `/user-dashboard`; la Q&A 02 dichiara creazione automatica del canale privato di test. | Il percorso dashboard/test è coerente come landing di registrazione generica, ma la UI, l’etichetta e il pulsante del canale di test vanno verificati nel codice completo e non presunti dalla sola Q&A. |
| Commenti | Il form commento viene mostrato solo con utente autenticato; l’invio usa `addComment`. | Allineato nell’accesso, ma la bozza non è salvata automaticamente per il login. |
| Reazioni | Nella radio, `addQuickReaction()` controlla login e, da anonimo, emette evento login; nelle reazioni del feed testo il form/picker è visibile e l’azione invia via servizio. | Gate coerente solo per la radio; il picker del feed testo non mostra un gate equivalente nel template analizzato. Non assumere che backend rifiuti/consenta senza verificarlo. |
| Rating | Il controllo lineup è visualizzato e invoca `onRatePlayer`; l’handler del match editor verifica un limite locale, ma il template comune non condiziona il pulsante alla sessione. | Il comportamento anonimo è ambiguo e non va replicato come policy. Raccomandazione: login richiesto e CTA contestuale su pubblico. |
| Follow e like | Sulla partita il template mostra follow agli utenti autenticati e like autenticato a full time; follow chiede permesso notifiche e può ricaricare la pagina. Le pagine canale gestiscono login con URL corrente secondo il flusso verificato in `g-channel.component.ts`. | Follow/like richiedono login; preferire ripristino del contesto e aggiornamento UI senza reload, subordinato a verifica tecnica. |
| Login e registrazione | Le route sono pubbliche; login email/Google e registrazione email sono implementati. La schermata login collega la registrazione. | Il punto di accesso per il signup può essere reso contestuale, come indicato dalla Q&A 01/02. |

## Limiti API e dominio

La raccomandazione presume che commenti, reazioni, rating, like e follow siano azioni personali persistenti e dunque richiedano identità. La wiki riporta endpoint per queste azioni in `docs/wiki/backend/api/apis/MatchesV1Controller (api).md`, ma non fornisce una matrice completa delle policy né i vincoli esatti per commenti e rating (`docs/wiki/workflows/Spettatore Partita (workflow).md`). La presenza di un endpoint non prova da sola che l’autenticazione sia richiesta o che il backend la applichi correttamente.

Prima di implementare i gate frontend occorre allineare la policy con backend/API per ciascun endpoint, inclusi autorizzazione, limiti/duplicati, proprietà dei contenuti e comportamento per token mancante. Il frontend non deve essere l’unico controllo. Il canale di test automatico, la sua visibilità privata, route e permessi devono essere verificati nel backend e nel codice di provisioning account; la Q&A 02 afferma il comportamento desiderato, mentre questa analisi non ha verificato l’implementazione backend. La pagina pubblica audio può dipendere da disponibilità TTS, non dall’identità; errori tecnici non devono essere presentati come richiesta di login.

## Cosa rinviare

- Non introdurre profili espliciti cronista/spettatore o un questionario di onboarding: la scelta è ancora ipotesi e non serve per la policy essenziale.
- Non consentire commenti, rating, reaction, like o follow anonimi prima della verifica delle regole API. Questo eviterebbe account solo se l’API li supportasse, ma non è dichiarato e implicherebbe decisioni di dominio/moderazione.
- Non aggiungere provider, passaggi OTP per nuove azioni o permessi oltre a quelli già previsti dal flusso di autenticazione senza requisito esplicito.
- Non precompilare o inviare silenziosamente azioni dopo login; non conservare bozza/commento in storage persistente senza definire durata e privacy.
- Non cambiare wizard, creazione automatica del canale test, ownership o ciclo partita come parte di un intervento UX senza conferma di API/domain.
- Non fissare analytics target o metriche di conversione finché responsabile prodotto non li definisce; la Q&A 02 rinvia la validazione a dopo il completamento.

## Evidenze e fonti

### Decisioni/indirizzi stakeholder

- `docs/Q&A - 02.md` — affidamento della policy di autenticazione agli agenti; signup email, canale test privato automatico, wizard per utenti loggati e semplificazione del numero di passaggi.
- `docs/projects/layout-2026/qa/Q&A - 01.md` — anonimo deve capire il servizio e provare esempi; utente autenticato deve avere esperienza operativa; prova cronista e canale di test da valorizzare; semplicità e pochi click.

### Analisi del progetto

- `docs/projects/layout-2026/analysis/01-user-flows.md` — flussi/stati osservati e ambiguità corrente per login, callback, rating e interazioni.
- `docs/projects/layout-2026/analysis/03-mobile-experience.md` — semplicità e feedback su smartphone sono da validare; il flusso cronista è ad alta frequenza e le azioni protette possono interrompere feed/radio.
- `docs/projects/layout-2026/analysis/04-anonymous-home-options.md` — raccomandazione di home mista, prova del prodotto senza account e CTA contestuali.

### Wiki e codice

- Wiki: `docs/wiki/business/actors/Spettatore (actor).md`; `docs/wiki/business/actors/Cronista (actor).md`; `docs/wiki/workflows/Spettatore Partita (workflow).md`; `docs/wiki/workflows/Autenticazione Utente (workflow).md`; `docs/wiki/comparisons/Mappatura Frontend Pubblico e Autenticato (comparison).md`; `docs/wiki/backend/api/apis/MatchesV1Controller (api).md`; `docs/wiki/articles/Creazione Rapida Partita (article).md`; `docs/wiki/articles/Account e Profilo Utente (article).md`.
- Frontend: `src/RugbyRadioWeb/src/app/app.routes.ts`; `src/RugbyRadioWeb/src/app/services/auth-guard.service.ts`; `src/RugbyRadioWeb/src/app/services/logincallback.service.ts`; `src/RugbyRadioWeb/src/app/services/user.service.ts`; `src/RugbyRadioWeb/src/app/user/login/login.component.ts`; `src/RugbyRadioWeb/src/app/user/registration/registration.component.ts`; `src/RugbyRadioWeb/src/app/common/match-events/match-events.component.html`; `src/RugbyRadioWeb/src/app/common/match-events/match-events.component.ts`; `src/RugbyRadioWeb/src/app/common/match-lineup/match-lineup.component.html`; `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.ts`; `src/RugbyRadioWeb/src/app/global/g-match/g-match-events/g-match-events.component.html`; `src/RugbyRadioWeb/src/app/global/g-channel/g-channel.component.ts`.

## Esito atteso

Policy di prodotto proposta: **browse/read/listen/share senza account; scritture sociali personali e strumenti cronista con account; login contestuale con ritorno a pagina/tab/oggetto e nuovo tap di conferma; registrazione che porta al canale privato di test quando è iniziata da “Prova il cronista”.** La matrice backend resta una dipendenza di implementazione, non un questionario per il responsabile.
