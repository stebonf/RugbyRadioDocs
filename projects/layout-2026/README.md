# RRL — revisione UX/UI 2026

## Scopo

Migliorare la grafica e l'usabilità del frontend di Rugby Radio Live (RRL), rendendo coerenti interfaccia, navigazione e componenti. Il progetto riguarda l'esperienza di chi scopre RRL, di chi segue una partita e di chi la racconta. Considerare desktop, mobile web, PWA e Android TWA; progettare esplicitamente le interazioni da smartphone, in particolare quelle del cronista durante una partita.

Questo README è il brief iniziale. Non costituisce una specifica funzionale definitiva né autorizza a implementare subito un redesign. Le scelte aperte vanno analizzate e documentate prima di modificare il frontend. Le analisi di agenti diversi verranno richieste in una fase successiva.

## Dove lavorare

I percorsi sono relativi alla radice del repository:

- `docs/projects/layout-2026/`: documentazione e decisioni di questo progetto; qui si trova il presente README.
- `docs/wiki/`: conoscenza documentata su prodotto, flussi, pagine e componenti RRL.
- `src/RugbyRadioWeb/`: frontend Angular da esaminare per verificare il comportamento effettivo e, solo dopo l'approvazione della soluzione, implementare le modifiche.

Se uno di questi percorsi non è disponibile, segnalarlo: non dedurre struttura o comportamento del progetto dal solo nome della cartella.

## Come usare la wiki

1. Partire dalle pagine di prodotto, dai workflow del cronista e dello spettatore e dalle pagine/componenti frontend coinvolti. Consultare le voci pertinenti, senza trattare l'intera wiki come un requisito indistinto.
2. Per ogni comportamento rilevante, confrontare la descrizione della wiki con codice, route, template e stili presenti in `src/RugbyRadioWeb/`.
3. Distinguere sempre **fatto documentato**, **comportamento verificato nel codice**, **problema osservato** e **proposta**. Citare nei documenti di analisi il percorso della voce wiki e i file di codice pertinenti.
4. Se wiki e codice divergono, registrare la divergenza e verificare il comportamento corrente prima di decidere. Non riscrivere la wiki per farla coincidere con un'ipotesi.
5. Non inventare funzionalità, metriche, vincoli tecnici o obiettivi di business non presenti nelle fonti. Esplicitare le lacune e le domande che richiedono una decisione.

Punto di partenza documentato: la home pubblica mostra onboarding, marketing e caroselli di partite/canali; la dashboard dell'utente autenticato mostra profilo, statistiche e partite in corso. La pagina del cronista è organizzata in aree Live, Events, formazioni, statistiche e condivisione. Questi elementi descrivono lo stato documentato, non prescrivono la soluzione futura.

## Risultati attesi dall'analisi

- Mappa delle esperienze e dei percorsi principali: visitatore anonimo, spettatore, cronista, utente autenticato; individuare pagine, stati, azioni e punti di frizione.
- Inventario dell'interfaccia esistente: navigazione, layout, componenti ricorrenti, tipografia, colori, spaziature, icone, form, card, feedback, loading, errori e stati vuoti. Verificare cosa può essere riutilizzato.
- Proposta di architettura dell'informazione e navigazione per desktop e smartphone, inclusa la fruizione PWA/TWA.
- Valutazione della home anonima: landing di presentazione, home con contenuti pubblici o soluzione mista. Per ogni alternativa chiarire come si scoprono partite e canali, come si prova il prodotto e come si accede o ci si registra. Motivare la scelta senza assumere in partenza che la home debba essere priva di dati.
- Proposta di design system applicabile al frontend esistente: principi, token (almeno colori, tipografia, spaziature, raggi e stati), componenti, varianti responsive e regole d'uso. Rilevare l'identità visiva corrente dal codice e dalla wiki prima di modificarla.
- Priorità di intervento e piano incrementale: cosa cambia, quali file/pagine coinvolge, dipendenze, rischi e criteri verificabili per valutare il risultato.

## Criteri di progettazione

- Rendere evidenti le azioni principali per ciascun ruolo. Nell'interfaccia del cronista privilegiare chiarezza e rapidità dei tap; per lo spettatore dare risalto alle informazioni necessarie per seguire la partita.
- Progettare desktop e mobile in modo intenzionale: contenuti, densità, navigazione e controlli possono differire quando serve. Verificare anche schermi piccoli, orientamento e comportamento nell'esperienza installata PWA/TWA.
- Mantenere accessibili testi, contrasti, focus, controlli da tastiera e aree di tocco; prevedere stati di caricamento, errore e assenza di dati.
- Preservare la comprensibilità delle pagine pubbliche e valutare l'impatto su SEO, analytics e spazi pubblicitari dove esistono; non sacrificare i percorsi d'uso per ospitarli.
- Evitare componenti disegnati pagina per pagina senza regole comuni. Il design system deve guidare anche le future implementazioni.

## Confini iniziali

L'analisi può proporre modifiche ai flussi e alle informazioni mostrate quando migliorano l'usabilità. L'implementazione iniziale riguarda il frontend; cambiamenti a API, modello dati, logica di partite/canali/Talker o infrastruttura vanno segnalati come dipendenze e valutati separatamente. Non cambiare i comportamenti di dominio in modo implicito durante un intervento grafico.

## Metodo di lavoro per Codex

1. Ricostruire lo stato attuale da wiki e frontend, annotando prove e discrepanze.
2. Esporre problemi, alternative e raccomandazioni per le decisioni aperte, soprattutto la home anonima.
3. Definire prima la direzione UX e il design system; poi proporre una sequenza di interventi sulle pagine.
4. Produrre documenti di analisi in `docs/projects/layout-2026/` con nomi chiari. Separare osservazioni, decisioni confermate e proposte ancora da approvare.
5. Prima di modificare il codice, presentare una proposta verificabile con pagine coinvolte, criteri di accettazione e impatti. Implementare solo dopo la scelta della direzione del progetto.

Le analisi complementari sono state affidate ai profili descritti in `agents/`; risultati, raccomandazioni e stato corrente sono raccolti in `Plan.md`, `STATUS.md`, `analysis/`, `qa/` e `delivery/`. Questo README resta il brief e i suoi confini sono ancora validi: le raccomandazioni degli agenti non sono decisioni approvate e non autorizzano da sole il redesign.
