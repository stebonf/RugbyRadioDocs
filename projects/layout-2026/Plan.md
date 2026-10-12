# RRL — revisione UX/UI 2026: piano di lavoro

## Obiettivo

Definire una direzione UX/UI coerente per Rugby Radio Live e implementarla in modo incrementale sul frontend, dopo aver verificato l’esperienza esistente e approvato le decisioni di prodotto e design.

Il README di progetto è il brief di riferimento. Il responsabile ha approvato la realizzazione e revisione di un mockup isolato in `src/RugbyRadioLayout2026`. Questa approvazione non autorizza modifiche ai progetti runtime esistenti o alle API di produzione: tali interventi seguiranno la validazione del mockup.

## Direzione aggiornata dopo Q&A 03

- Costruire in `src/RugbyRadioLayout2026` un prototipo HTML/Angular autonomo, con design system CSS riutilizzabile e principali schermate RRL.
- Simulare le API usando gli stessi metodi, path, query, payload e forme di risposta delle API esistenti, verificati su OpenAPI/controller e client Angular. Registrare separatamente ogni differenza proposta; non inventare endpoint o presentare la simulazione come backend reale.
- Usare solo fixture locali; evitare chiamate a servizi reali, analytics, feedback di produzione e scritture di dominio.
- Completare e far validare il mockup prima di portare le decisioni in `RugbyRadioWeb` o intervenire sulle API. La verifica/fix della privacy della demo e l’allineamento della policy auth restano dipendenze tecniche esplicite.
- Applicare le indicazioni Q&A 03: mantenere signup attuale, verificare i permessi prima di procedere, errore generico locale alle sezioni, navigazione mobile a quattro voci approvata, valutazioni utenti/device/SEO/analytics/pubblicità rinviate al pacchetto UX completo.

La proposta architetturale e i limiti sono in `qa/09-mockup-architecture.md`; piano CSS/design system in `qa/07-prototype-design-system-plan.md`; mappa schermate in `qa/08-prototype-screen-map.md`.

## Principi di lavoro

- Verificare la documentazione wiki rispetto a route, template e stili effettivi prima di trarre conclusioni.
- Distinguere in ogni elaborato fatti documentati, comportamenti verificati, problemi osservati, proposte e decisioni confermate.
- Citare i percorsi wiki e i file di codice usati come evidenza.
- Registrare divergenze e lacune; non colmarle con ipotesi presentate come requisiti.
- Trattare desktop, mobile web e installazione PWA/TWA come contesti d’uso da valutare esplicitamente.
- Non modificare comportamenti di dominio durante il lavoro visuale senza una decisione esplicita.
- Non modificare il frontend finché la direzione e la proposta di implementazione non sono state approvate.

## Profili di agente

Gli agenti sono indicati per competenza, non per nome o modello specifico. Le analisi iniziali possono procedere in parallelo con incarichi distinti. Ogni agente deve restituire evidenze, questioni aperte e raccomandazioni nel proprio ambito.

- **Analista funzionale / UX researcher**: ricostruisce ruoli, percorsi, pagine, stati, azioni e frizioni usando wiki e codice.
- **Frontend engineer Angular**: verifica route, template, componenti, stili e fattibilità tecnica; identifica componenti riutilizzabili e dipendenze.
- **UX designer mobile**: esamina i flussi su smartphone, in particolare l’uso del cronista durante una partita, e i contesti PWA/TWA.
- **Product designer / product analyst**: valuta le alternative per la home anonima e i percorsi di scoperta, prova e conversione senza assumere una soluzione a priori.
- **UI designer / design systems specialist**: rileva l’identità esistente e propone principi, token, componenti, varianti responsive e regole d’uso.
- **Accessibility specialist**: valuta tastiera, focus, contrasti, testi, target touch e stati di feedback; propone criteri verificabili.
- **Coordinatore UX/prodotto**: integra le analisi, evidenzia decisioni e dipendenze, ordina gli interventi e prepara la proposta da sottoporre ad approvazione.

Una persona o un agente può coprire più profili, purché gli elaborati mantengano separati ambiti ed evidenze.

## Fasi e incarichi

### 0. Verifica dei materiali e delimitazione

**Responsabile:** coordinatore UX/prodotto, con supporto dell’analista funzionale.

**Attività:**

- Verificare che siano disponibili `docs/projects/layout-2026/`, le voci pertinenti in `docs/wiki/` e il frontend in `src/RugbyRadioWeb/`.
- Individuare le pagine wiki pertinenti a prodotto, spettatore, cronista, pagine pubbliche e componenti frontend.
- Se un percorso o una fonte manca, registrare il limite e proseguire solo con quanto verificabile.

**Output:** elenco delle fonti consultate e delle fonti mancanti. Questa fase non deduce la struttura del progetto dal nome dei percorsi.

### 1. Mappa dei percorsi e confronto wiki-codice

**Responsabile:** analista funzionale / UX researcher.

**Supporto:** frontend engineer Angular.

**Attività:**

- Mappare visitatore anonimo, spettatore, cronista e utente autenticato.
- Per ciascun ruolo descrivere pagine, stati, azioni e transizioni principali.
- Confrontare le descrizioni wiki con route e implementazione effettiva.
- Annotare punti di frizione, divergenze e domande aperte, citando le fonti.

**Output:** `01-user-flows.md`, con una sezione distinta per evidenze, problemi e proposte.

### 2. Inventario dell’interfaccia attuale

**Responsabile:** frontend engineer Angular.

**Supporto:** UI designer / design systems specialist e accessibility specialist.

**Attività:**

- Inventariare navigazione, layout, componenti ricorrenti, tipografia, colori, spaziature, icone, form, card e feedback.
- Rilevare stati di caricamento, errore, vuoto e contenuti mancanti.
- Collegare gli elementi alle pagine e ai file sorgente pertinenti.
- Distinguere componenti effettivamente riutilizzati da somiglianze solo visive.

**Output:** `02-ui-inventory.md`, con inventario e opportunità di riuso supportate da riferimenti al codice.

### 3. Analisi dell’esperienza mobile e del cronista

**Responsabile:** UX designer mobile.

**Supporto:** analista funzionale e frontend engineer Angular.

**Attività:**

- Analizzare le azioni del cronista durante una partita, dando priorità a chiarezza e rapidità dei tap.
- Esaminare la fruizione dello spettatore da smartphone.
- Valutare dimensioni ridotte, orientamento, densità informativa, navigazione e comportamento installato PWA/TWA.
- Separare problemi osservati da ipotesi che richiedono verifica con utenti o stakeholder.

**Output:** `03-mobile-experience.md`, con flussi critici, problemi, proposte e aspetti da validare.

### 4. Valutazione della home anonima

**Responsabile:** product designer / product analyst.

**Supporto:** analista funzionale e UX designer mobile.

**Attività:**

- Confrontare: landing di presentazione, home con contenuti pubblici, soluzione mista.
- Per ogni alternativa chiarire scoperta di partite e canali, prova del prodotto, accesso e registrazione.
- Considerare comprensibilità delle pagine pubbliche e impatti su SEO, analytics e spazi pubblicitari dove presenti.
- Dichiarare le assunzioni e le informazioni mancanti; raccomandare una direzione motivata.

**Output:** `04-anonymous-home-options.md`, con confronto delle alternative e decisioni richieste.

### 5. Proposta di architettura dell’informazione e navigazione

**Responsabile:** UX designer, con coordinamento del product analyst.

**Supporto:** frontend engineer Angular e UX designer mobile.

**Attività:**

- Proporre struttura delle informazioni e navigazione per desktop e smartphone.
- Rendere esplicite le differenze tra ruoli e contesti quando migliorano l’uso.
- Collegare la proposta ai percorsi e ai problemi documentati nelle fasi precedenti.
- Evidenziare dipendenze da API o modello dati come questioni da valutare separatamente.

**Output:** `05-information-architecture.md`, con mappe o schemi di navigazione e motivazioni.

### 6. Proposta di design system

**Responsabile:** UI designer / design systems specialist.

**Supporto:** frontend engineer Angular e accessibility specialist.

**Attività:**

- Rilevare l’identità visiva corrente da wiki e codice prima di proporre cambiamenti.
- Definire principi, token per colori, tipografia, spaziature, raggi e stati.
- Proporre componenti, varianti responsive e regole d’uso applicabili al frontend esistente.
- Specificare requisiti di accessibilità e modalità di feedback per stati di caricamento, errore e assenza di dati.

**Output:** `06-design-system-proposal.md`, con token proposti, componenti e regole d’uso. Le scelte non approvate vanno etichettate come proposte.

### 6a. Revisione accessibilità

**Responsabile:** accessibility specialist.

**Supporto:** frontend engineer Angular e UX designer mobile.

**Attività:**

- Verificare tastiera, focus, contrasti, testi, target touch e feedback negli elementi accessibili dal codice o dalla documentazione.
- Distinguere l’ispezione statica da ciò che richiede verifica manuale in browser o con tecnologie assistive.
- Proporre criteri controllabili per gli interventi e il design system.

**Output:** `07-accessibility-review.md`. Non dichiarare conformità senza prove adeguate.

### 7. Sintesi, priorità e piano incrementale

**Responsabile:** coordinatore UX/prodotto.

**Supporto:** referenti delle fasi precedenti e frontend engineer Angular.

**Attività:**

- Integrare le analisi evitando di appiattire divergenze o incertezze.
- Ordinare gli interventi per valore d’uso, dipendenze, rischio e sequenza tecnica.
- Per ogni intervento indicare pagine, file o aree coinvolte, dipendenze e criteri osservabili di accettazione.
- Separare le modifiche frontend dalle eventuali dipendenze API, dati, logica di dominio o infrastruttura.

**Output:** `07-priorities-and-rollout.md`, con roadmap incrementale e criteri verificabili.

### 8. Proposta decisionale e approvazione della direzione

**Responsabile:** coordinatore UX/prodotto.

**Revisione:** product owner/stakeholder e referente tecnico.

**Attività:**

- Presentare evidenze, alternative, raccomandazioni e domande che richiedono una decisione.
- Includere la direzione per la home anonima, l’architettura informativa, il design system e le priorità.
- Rendere la proposta verificabile indicando pagine coinvolte e criteri di accettazione.

**Gate:** non iniziare il redesign del frontend finché la direzione e la proposta non sono state approvate.

**Output:** decisioni registrate in `Decisions.md` e proposta approvata o elenco delle questioni ancora aperte.

### 9. Implementazione incrementale

**Responsabile:** frontend engineer Angular.

**Supporto:** UI designer, accessibility specialist e QA secondo necessità.

**Prerequisito:** approvazione della fase 8.

**Attività:**

- Implementare gli interventi nell’ordine concordato, per flussi o pagine e con criteri di accettazione espliciti.
- Mantenere coerenti i componenti condivisi e le varianti responsive col design system approvato.
- Segnalare e isolare le dipendenze che richiedono modifiche fuori dal frontend.
- Non cambiare implicitamente logica di partite, canali o Talker.

**Output:** modifiche frontend tracciabili rispetto alle decisioni e ai criteri approvati. Ogni incremento documenta pagine e componenti coinvolti.

### 8a. Mockup validato prima del rollout reale (fase attiva)

Questa fase, introdotta dopo Q&A 03 e successiva richiesta del responsabile, precede la fase 9 di implementazione effettiva. La sua realizzazione nel progetto isolato è autorizzata; il rollout in `RugbyRadioWeb` e le modifiche API non lo sono ancora.

**Responsabili:** frontend engineer Angular, UI designer/design systems specialist e UX/information architect; revisione accessibility specialist; coordinatore integra.

**Attività/output:** architettura in `qa/09-mockup-architecture.md`; verifica API in `qa/06-prototype-technical-review.md`; mappa schermate in `qa/08-prototype-screen-map.md`; piano CSS/componenti in `qa/07-prototype-design-system-plan.md`; app e mock API isolati in `src/RugbyRadioLayout2026`.

**Gate:** validare il mockup completo e registrare le decisioni; poi pianificare gli interventi reali, inclusi privacy demo e policy API. Si applicano i criteri in `qa/09-mockup-architecture.md`.

## Dipendenze e gate

```text
Verifica fonti
    ├── Percorsi e confronto wiki-codice
    ├── Inventario UI
    ├── Analisi mobile/cronista
    └── Alternative home anonima
              ↓
Architettura informativa + design system
              ↓
Sintesi e priorità
              ↓
Proposta verificabile → approvazione
              ↓
Mockup isolato in RugbyRadioLayout2026
              ↓
Validazione stakeholder
              ↓
Implementazione incrementale nei progetti reali
```

Le analisi iniziali possono svolgersi in parallelo. Architettura informativa e design system devono usare i risultati della ricognizione; la sintesi dipende dalle analisi; l’implementazione dipende dall’approvazione.

## Struttura documentale proposta

```text
layout-2026/
├── README.md                         # Brief iniziale e vincoli di progetto
├── Plan.md                           # Sequenza di lavoro, responsabilità e gate
├── STATUS.md                         # Avanzamento degli incarichi e deliverable
├── Decisions.md                      # Registro delle decisioni confermate
├── agents/                           # Brief operativi dei profili assegnabili
├── analysis/
│   ├── 01-user-flows.md
│   ├── 02-ui-inventory.md
│   ├── 03-mobile-experience.md
│   ├── 04-anonymous-home-options.md
│   ├── 05-information-architecture.md
│   ├── 06-design-system-proposal.md
│   └── 07-accessibility-review.md
├── qa/                               # Risposte e raccomandazioni per le decisioni aperte
│   ├── Q&A - 01.md
│   ├── 01-assessment.md
│   ├── 02-assessment.md
│   ├── 03-assessment.md
│   ├── 02-home-and-trial-recommendation.md
│   ├── 03-navigation-and-twa-recommendation.md
│   ├── 04-technical-verification.md
│   └── 05-auth-and-intent-recommendation.md
└── delivery/
    ├── 07-priorities-and-rollout.md
    └── qa/
        ├── 06-prototype-technical-review.md
        ├── 07-prototype-design-system-plan.md
        ├── 08-prototype-screen-map.md
        └── 09-mockup-architecture.md
```

Il secondo input stakeholder si trova in `docs/Q&A - 02.md` fuori dalla cartella progetto; mantenerlo come fonte e non duplicarlo.

Creare le cartelle e i documenti di analisi quando viene assegnato il relativo incarico, evitando file vuoti o conclusioni anticipate. `Decisions.md` può partire subito come registro essenziale delle decisioni, delle relative date e delle motivazioni.

## Formato raccomandato per gli elaborati

Ogni analisi dovrebbe includere:

1. **Ambito e fonti**: voci wiki e percorsi di codice consultati.
2. **Fatti documentati**: cosa affermano le fonti di prodotto.
3. **Comportamento verificato**: cosa fanno route, template e stili osservati.
4. **Problemi e divergenze**: evidenze, impatto e incertezza.
5. **Proposte**: motivazione, alternative e compromessi.
6. **Decisioni richieste**: domande che spettano a stakeholder o product owner.
7. **Dipendenze**: API, dati, logica di dominio, SEO, analytics o infrastruttura.

## Criteri per considerare completa l’analisi

- Tutti i ruoli e i percorsi principali sono coperti o le lacune sono esplicitate.
- Le osservazioni rilevanti hanno riferimenti verificabili a wiki e codice.
- La proposta per la home anonima confronta tutte e tre le alternative indicate nel brief.
- La navigazione e il design system considerano desktop, smartphone e PWA/TWA.
- Accessibilità, stati di feedback e pagine pubbliche sono trattati con criteri controllabili.
- Le priorità riportano dipendenze e criteri di valutazione.
- Decisioni confermate e proposte ancora da approvare sono distinguibili.
- Nessuna modifica al frontend precede il gate di approvazione.

