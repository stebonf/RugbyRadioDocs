# Priorità e piano incrementale — layout-2026

**Stato:** roadmap aggiornata dopo Q&A 03. È autorizzato il prototipo isolato in `src/RugbyRadioLayout2026`; il gate di validazione precede qualunque modifica ai progetti runtime e alle API di produzione.

**Aggiornamento 24 settembre 2026:** la prima versione del prototipo è implementata e compilata. Il lavoro attivo è revisione/validazione esperta e raccolta feedback; il rollout resta subordinato al gate di validazione.

## Nuova fase approvata: design system e mockup prima del redesign

L’incarico aggiornato è costruire un’applicazione demo autonoma in `src/RugbyRadioLayout2026`, con HTML/Angular, componenti e CSS riutilizzabili, pagine principali e API simulate compatibili con i contratti esistenti. Architettura: `qa/09-mockup-architecture.md`; matrice API: `qa/06-prototype-technical-review.md`; mappa schermate: `qa/08-prototype-screen-map.md`; piano design system: `qa/07-prototype-design-system-plan.md`.

### Ordine di lavoro aggiornato

1. **Baseline API e differenze** — verificare contratti FE/backend e modellare esplicitamente privacy demo, auth, errori, wizard e discrepanza statistiche. Implementare i mock endpoint con le stesse method/path/query/body/response. Non inventare o nascondere modifiche necessarie.
2. **Bootstrap autonomo** — creare l’app avviabile nella cartella target; mock worker/adapter e fixture locali, senza collegamento a origin API reale.
3. **Fondazioni CSS e componenti** — token, typography, layout, primitive e stati riusabili, responsive/accessibili; distinguere pattern esistenti da proposte.
4. **Schermate e flussi** — costruire pagina design system e schermate principali anonime/autenticate, esplorazione, onboarding demo, wizard, partita/radio/editor e TWA secondo la mappa.
5. **Revisione esperta e validazione** — revisione UX/UI, tecnica e accessibilità; poi stakeholder valida mockup completo. Test con utenti/device e valutazioni SEO/analytics/ads restano dopo il completamento del pacchetto UX.
6. **Rollout reale successivo** — solo dopo validazione, pianificare incremento frontend/backend; chiudere prima privacy demo e policy di accesso, e approvare ogni differenza API.

La privacy demo è un requisito di prodotto ma il backend attuale non dimostra il blocco dell’accesso anonimo via ID. Il mock può mostrare il target privacy in uno scenario chiaramente etichettato; non presentarlo come comportamento già attivo. Q&A 03 conferma signup attuale, errore generico locale, navigazione mobile a quattro voci (Home · Partite · Crea · Profilo), prova delle raccomandazioni TWA e rinvio delle verifiche utenti/device/SEO/analytics/pubblicità.

## Ambito e fonti

Questo piano coordina i risultati di:

- `analysis/01-user-flows.md` — percorsi, stati e discrepanze wiki/codice.
- `analysis/02-ui-inventory.md` — componenti, stili, stati e dipendenze frontend.
- `analysis/03-mobile-experience.md` — cronista, spettatore e PWA/TWA.
- `analysis/04-anonymous-home-options.md` — confronto delle alternative per la home.
- `analysis/05-information-architecture.md` — proposta di navigazione non approvata.
- `analysis/06-design-system-proposal.md` — token e componenti proposti, non approvati.
- `analysis/07-accessibility-review.md` — rilievi statici e verifiche necessarie.
- `qa/Q&A - 01.md` e `qa/01-assessment.md` — risposte del responsabile prodotto e valutazione di pertinenza.
- `docs/Q&A - 02.md` e `qa/02-assessment.md` — ulteriori indicazioni e proposte degli agenti per i punti delegati.
- `qa/02-home-and-trial-recommendation.md`, `qa/03-navigation-and-twa-recommendation.md`, `qa/04-technical-verification.md`, `qa/05-auth-and-intent-recommendation.md` — raccomandazioni esperte e riscontro tecnico.
- `Decisions.md` — direzioni di prodotto confermate e limiti ancora aperti.
- `../README.md` e `../Plan.md` — brief, vincoli e processo.

Le verifiche sono prevalentemente statiche. Non sono stati eseguiti test con utenti, prove browser/device, verifiche runtime PWA/TWA o audit completo del frontend. Le priorità sotto sono raccomandazioni da validare, non risultati di ricerca quantitativa.

## Sintesi della direzione raccomandata

1. Mantenere accessibili senza account la scoperta e la fruizione pubblica delle partite e dei canali.
2. Per la home anonima, combinare spiegazione breve di RRL, esempi e percorsi di prova/accesso con contenuti pubblici raggiungibili; mettere in evidenza il wizard e il canale cronista di test solo dopo aver verificato disponibilità e permessi. Per gli utenti autenticati, puntare a una dashboard operativa senza contenuti marketing. Questa direzione è registrata in `Decisions.md`; gerarchia e composizione visuale attendono l’approvazione della proposta.
3. Conservare il contesto informativo della partita e rendere leggibili i passaggi tra cronaca, ascolto, formazioni e statistiche.
4. Trattare l’editor Live del cronista come flusso operativo prioritario per smartphone; convalidare gerarchia, rapidità, feedback e recupero errori prima di modificare le azioni di dominio.
5. Formalizzare prima i pattern condivisi e gli stati di caricamento, vuoto ed errore; riusare componenti dove il codice conferma una struttura e un comportamento comuni.
6. Considerare PWA e TWA come ambienti da verificare dopo il completamento della proposta, come richiesto dal responsabile. La configurazione nel repository non dimostra il comportamento in produzione.

## Priorità proposte

| Priorità | Intervento | Motivo ed evidenza | Dipendenze / rischio |
|---|---|---|---|
| P0 — privacy demo | Garantire che canale, partita e risorse collegate della demo siano effettivamente visibili solo all’utente proprietario prima di presentarle come private. Definire/controllare autorizzazione server-side sugli endpoint per ID noti. | `qa/04-technical-verification.md` ha trovato esclusione da discovery/sitemap ma un endpoint anonimo di partita per ID senza filtro visibile. La promessa stakeholder “privato” non coincide ancora con l’evidenza di codice. | Backend/API e revisione permessi. Bloccante per CTA e copy che promettono privacy; non blocca la proposta grafica. |
| P1 — direzione d’esperienza | Applicare le direzioni date: home anonima breve con esempi e prova, dashboard autenticata operativa, wizard distinto dalla demo, splash TWA differenziata e storico quando non ci sono partite live. Usare le raccomandazioni degli agenti per CTA, policy d’accesso, navigazione a quattro voci e TWA content-first come proposta predefinita. | `docs/Q&A - 02.md`, `qa/02-assessment.md` e i quattro elaborati esperti chiariscono i punti delegati. Il wizard è a cinque step nell’UI corrente; la registrazione non è email-only e la privacy della demo va corretta. | Revisione della proposta e dipendenze backend/privacy e policy per azioni di scrittura. User test e verifica device sono rinviati fino al completamento del pacchetto UX, come indicato dal responsabile. |
| P1 — policy login/ritorno | Adottare come proposta: lettura, ascolto e condivisione pubblica senza account; login per scritture personali e strumenti cronista; dopo login tornare al contesto e chiedere un tap esplicito per completare l’azione. | `qa/05-auth-and-intent-recommendation.md` usa i flussi verificati e il principio stakeholder “semplicità e pochi click”. Il callback attuale conserva una URL semplice e i gate UI non sono uniformi. | Verifica della matrice autorizzazioni API; non basarsi esclusivamente sul frontend. |
| P1 — base condivisa | Approvare il design system minimo: ruoli dei token esistenti, semantica di button/field/tab, focus, stati feedback e regole responsive. Mappare gli override CSS prima di migrare. | `02-ui-inventory.md` rileva componenti realmente condivisi ma usi non uniformi e coesistenza di CSS globale, pagina e componente. `06-design-system-proposal.md` raccomanda una migrazione compatibile. | Mappa consumer, contrasto renderizzato, componenti Angular Material/NgSelect e fogli legacy da censire prima di modifiche globali. Cambiare token senza mappa può alterare pagine fuori dal campione. |
| P1 — cronista mobile | Progettare e validare una prima iterazione della superficie Live: priorità visiva delle azioni, target, stato di invio/esito/errore e accesso ai comandi di fase, senza ridefinire gli eventi di dominio. | Brief iniziale e `03-mobile-experience.md` pongono enfasi esplicita sull’uso del cronista durante la partita; l’editor mostra gruppi di azioni e drawer su viewport stretti. | Validazione osservata con cronisti; permessi e transizioni confermati dal dominio; focus, dialoghi e nomi delle scelte accessibili dalla review. Rischio alto di rallentare o alterare la cronaca se si riordina senza prova. |
| P2 — spettatore e radio | Chiarire e validare la gerarchia tra feed testuale e radio, gli stati audio (caricamento, riproduzione, pausa, non disponibile/errore) e il mantenimento del punto di lettura. | La pagina pubblica concentra feed, configurazione commentatore e radio in Events; il workflow audio elenca failure point e lascia da verificare background/lock-screen. | API/media e stati reali, sessioni con spettatori, comportamento browser/PWA/TWA. Non promettere continuità audio in background senza prova. |
| P2 — home e discovery | Evolvere la home secondo direzione approvata; semplificare gerarchia tra presentazione, contenuti e azioni; collegare home, cataloghi e dettaglio pubblico. | La home web già combina marketing, match, canali e annunci. L’analisi home raccomanda soluzione mista ma segnala che i parametri client non provano quali match il feed contenga. | Verificare status/ordinamento/freschezza via API, empty/error fallback, annunci, metadata/SEO, analytics e localizzazioni. Evitare etichetta “in corso” non sostenuta dai dati. |
| P3 — copertura e rifinitura | Applicare pattern coerenti alle altre pagine pubbliche e autenticate incluse nel perimetro approvato; verificare stati, tastiera, zoom, screen reader, pagine secondarie e TWA. | La ricognizione non ha coperto ogni route o consumer; accessibilità individua verifiche statiche e runtime da completare. | Perimetro definitivo, browser/AT/device di supporto e capacità di verifica. Evitare di presentare audit parziale come conformità dell’intero prodotto. |

## Sequenza di delivery proposta

### Incremento 0 — decisioni e criteri di validazione

**Responsabili:** coordinatore UX/prodotto e product owner; consultare frontend e responsabili dominio.

**Output prima del codice:** proposta coerente con gli indirizzi in `Decisions.md`; scope del primo incremento; privacy demo e policy di scrittura confermate lato API; CTA e destinazioni per la prova; contenuti TWA e gerarchia mobile raccomandati. User test/device e verifiche SEO/analytics/ads sono rinviati finché il pacchetto UX/prototipo non è completo, come indicato in Q&A 02; non bloccano le raccomandazioni esperte.

**Criteri di uscita:**

- La direzione per anonimi (comprensione, esempi, prova e accesso) e autenticati (dashboard operativa senza marketing) è recepita; le CTA raccomandate distinguono prova demo ed esplorazione pubblica.
- Il canale e la partita demo sono effettivamente protetti da accesso anonimo prima di promettere “privato”; il wizard non confonde demo e contenuto pubblico.
- Le policy di login e ritorno al contesto sono documentate e allineate con i gate API; le scritture richiedono conferma esplicita.
- In assenza di partite live si omette la sezione e si usa lo storico; un guasto isolato non viene scambiato per lista vuota. Il piano non aggiunge modalità offline globale.
- La TWA dopo lo splash ha una proposta per utente anonimo e autenticato; runtime/installazione si verificano nella fase successiva.
- User/device test, SEO, analytics e annunci si pianificano dopo il completamento del pacchetto UX/prototipo, come richiesto dal responsabile.

### Incremento 1 — fondamenta visuali e navigazione

**Responsabili:** frontend engineer Angular e UI designer; revisione accessibilità.

**Ambito candidato:** shell, header/menu, bottom navigation, token comuni e pattern condivisi di focus, button, field, tab, alert/toast e loading/empty/error, limitati al perimetro approvato.

**Criteri di accettazione:**

- Le destinazioni principali per visitatore, spettatore, cronista e autenticato sono coerenti con la mappa approvata su desktop e mobile.
- La pagina corrente e gli stati interattivi sono riconoscibili; i controlli funzionano da tastiera e hanno nome/stato accessibile.
- Focus, contrasto, hit area e reflow sono verificati sulle schermate incluse, non dedotti dai soli token CSS.
- Loading, empty ed error sono distinti dove il flusso può fallire e un retry è disponibile quando il recupero è possibile.
- Nessuna route pubblica, guard o azione di dominio cambia senza requisito e review espliciti.

### Incremento 2 — flusso Live del cronista

**Responsabile:** frontend engineer Angular, con UX designer mobile, accessibility specialist e supporto dominio.

**Ambito candidato:** una partita di prova dalla tab Live: preparazione/avvio, inserimento degli eventi selezionati per la prova, intervallo, secondo tempo, feedback ed error recovery. Non estendere la modifica alle API se non come intervento separato approvato.

**Criteri di accettazione:**

- Un cronista può eseguire i compiti concordati senza ambiguità su stato, evento selezionato, invio riuscito o errore.
- La prova su smartphone registra difficoltà, scroll, errori di selezione, feedback mancante e recupero; i risultati sono documentati e confrontati con criteri concordati prima della prova.
- Azioni frequenti sono raggiungibili e distinguibili nelle viewport di riferimento, con touch e tastiera dove applicabile.
- Dialoghi/drawer sono utilizzabili con tastiera, focus gestito e contenuti non coperti dalla tastiera mobile.
- Transizioni e autorizzazioni di dominio restano invariate, salvo decisione separata.

### Incremento 3 — partita pubblica e radio

**Responsabile:** frontend engineer Angular con UI/UX designer e revisione accessibilità.

**Ambito candidato:** passaggio tra cronaca testuale, ascolto e altre sezioni; feedback dei controlli media e stati audio; contenuto aggiornato senza perdita involontaria del punto di lettura.

**Criteri di accettazione:**

- Il visitatore distingue lo stato dell’audio e sa avviare, mettere in pausa o riprendere quando il media è disponibile.
- Errori e contenuti audio non disponibili presentano un feedback persistente e comprensibile, senza confonderli con feed vuoto.
- Un aggiornamento della partita non sposta inaspettatamente la lettura nel caso verificato.
- Tab, nomi, focus e layout sono verificati a larghezza mobile e desktop.
- Funzioni background/lock screen sono dichiarate disponibili solo se provate nell’ambiente target.

### Incremento 4 — home anonima e discovery

**Responsabile:** frontend engineer Angular con product designer, SEO/analytics e referente advertising dove pertinente.

**Ambito candidato:** gerarchia del primo schermo, link/cataloghi, card/feed e fallback; aggiornamenti ai metadata o tracking solo se inclusi nella direzione approvata.

**Criteri di accettazione:**

- Un visitatore anonimo può raggiungere partite e canali pubblici, capire come provarli e trovare accesso/registrazione secondo decisione.
- Le sezioni con etichetta live/prossimo/recenti riflettono la semantica dei dati verificata; dati assenti o errore hanno uno stato definito.
- Le pagine pubbliche mantengono metadata, link e contenuto comprensibili; annunci e CTA non occludono le azioni principali nelle viewport provate.
- Gli eventi analytics sono limitati a quelli approvati e non sono presentati come misura di successo senza baseline e obiettivo concordato.

### Incremento 5 — copertura delle superfici rimanenti

**Responsabile:** frontend engineer Angular; revisione coordinata di UX, accessibilità e QA.

Estendere i pattern alle route comprese nel perimetro approvato (ad esempio canali, squadre, statistiche, profilo, preferiti, feedback) dopo una verifica puntuale dei rispettivi template e consumer.

**Criteri di accettazione:** criteri del design system applicati ai pattern coinvolti; stati e navigazione documentati; prove keyboard/responsive/accessibilità per la copertura scelta; differenze legacy o eccezioni motivate e registrate.

## Rischi trasversali e mitigazioni

| Rischio | Evidenza | Mitigazione richiesta |
|---|---|---|
| Home promette contenuti non corrispondenti allo stato reale | Il client usa query senza filtri di stato evidenti e il comportamento API non è stato verificato | Confermare dati/ordinamento e definire fallback prima di fissare etichette o ordine feed |
| Cambio visuale altera il dominio cronaca | Azioni Live invocano logiche di match/evento e stato | Stabilire mapping azione→comportamento e verificare che l’incremento non cambi eventi/transizioni/permessi |
| Regole di autenticazione incoerenti | Rating e altre interazioni hanno gate non del tutto leggibili dal frontend | Confermare policy server-side e comportamento d’accesso/ritorno prima di uniformare CTA |
| Token globali propagano regressioni | CSS globale, override e stili locali coesistono | Fare mappa consumer e migrazione per pattern, mantenendo alias e verificando pagine interessate |
| Accessibilità presunta dai token | Rapporti calcolati su colori nominali, hit area e focus non misurati su tutti i render | Misurare combinazioni e controlli nelle schermate effettive con tastiera e tecnologie assistive |
| PWA/TWA configurata ma non verificata | Manifest, service worker e flag client attestano solo configurazione nel repository | Provare installazione, route diretta, splash, back, stato sessione e audio su ambienti distribuiti |
| SEO/annunci interferiscono con discovery | Metadata/ads sono presenti nelle superfici pubbliche, ma output crawler e layout attivi non verificati | Revisione specifica SEO/advertising prima del rilascio dei relativi incrementi |

## Gate di approvazione

Prima del primo intervento sul frontend, product owner/stakeholder e referente tecnico devono approvare almeno:

1. proposta di home/dashboard, CTA per prova/esplorazione e gerarchia della navigazione (raccomandazione: Home/Partite/Crea/Profilo);
2. protezione effettiva della demo e sua distinzione dal wizard per creare contenuti pubblici;
3. policy di login e conservazione dell’intento con verifica backend;
4. token/componenti del design system e perimetro del flusso Live;
5. proposta TWA dopo splash e stati essenziali per errori API/query locali;
6. piano di validazione utenti/device e verifiche SEO/analytics/advertising dopo il completamento del pacchetto UX.

Le proposte dettagliate e le dipendenze sono nei documenti di analisi e in `qa/02-assessment.md`. Le raccomandazioni degli agenti non sono ancora approvate come direzione di implementazione; `Decisions.md` contiene solo gli indirizzi espliciti del responsabile. Il gate resta **non superato**. Non serve che il responsabile risponda personalmente ai punti delegati agli agenti, ma occorre rivedere/approvare la proposta esperta e risolvere la privacy della demo prima di usare il claim “privata”. L’implementazione resta sospesa fino a tale passaggio.

## Limiti

La roadmap non dispone di stime, dati analytics dettagliati, osservazioni utenti, output SEO runtime, matrice device supportata o verifica API completa. Perciò non assegna durata o beneficio quantitativo e non assume che le priorità rappresentino una decisione di business. Confermare ambito e ordine con product owner e responsabili tecnici prima di pianificare rilasci.

