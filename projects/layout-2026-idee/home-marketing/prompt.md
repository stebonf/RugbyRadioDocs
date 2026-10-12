# RRL — Redesign Home pubblica

## Contesto

Stiamo iniziando il redesign progressivo dell'interfaccia di Rugby Radio Live.

Questa attività riguarda esclusivamente la **Home pubblica**, ma NON deve essere
trattata come una landing page isolata.

Questa è la prima pagina di un percorso che proseguirà successivamente con:

1. Home per utente autenticato;
2. esperienza TWA;
3. altre pagine di Rugby Radio Live.

Le decisioni prese adesso devono quindi costituire le prime fondamenta visuali
riutilizzabili dell'applicazione, senza però progettare anticipatamente pagine
che non sono ancora state analizzate.


# Source of truth

Utilizzare queste fonti con responsabilità differenti.

## Codice Angular esistente

È la source of truth per:

- funzionalità;
- dati disponibili;
- chiamate API;
- componenti;
- servizi;
- routing;
- azioni;
- contenuti dinamici;
- comportamento attuale;
- differenze tra pubblico e autenticato;
- asset già utilizzati;
- integrazioni esistenti.

## Wiki RRL

È la source of truth funzionale e concettuale per Rugby Radio Live.

Non inventare funzionalità non presenti nel codice o nella wiki.

## Mockup allegato

È la **source of truth per la direzione visuale della nuova Home**.

Il mockup definisce:

- composizione;
- gerarchia;
- ritmo;
- densità;
- uso degli spazi;
- rapporto testo/immagini;
- stile generale;
- principio visuale dell'Hero.

Il mockup NON è source of truth per:

- dati;
- testi dinamici;
- immagini dinamiche;
- funzionalità;
- routing;
- API;
- Talkers;
- contenuti reali.

Quando mockup e applicazione reale differiscono:

**dati, funzionalità e comportamento devono derivare dal codice/wiki.**

Il mockup NON autorizza a inventare ciò che manca.


# Modalità di implementazione

Lavorare DIRETTAMENTE sull'attuale applicazione Angular.

NON:

- creare un mockup HTML intermedio;
- creare una nuova applicazione;
- creare una pagina parallela scollegata dall'applicazione;
- sostituire dati reali con dati statici;
- ricostruire funzionalità già esistenti.

L'obiettivo finale sarà modificare l'attuale Home Angular.


# Obiettivo UX principale

La Home deve permettere a una persona che non conosce Rugby Radio Live di
comprenderne molto rapidamente il principio fondamentale:

> You tap. We tell the story.

Il cronista racconta ciò che accade sul campo attraverso semplici azioni/tap.

Rugby Radio Live trasforma queste azioni nel racconto della partita per chi
la sta seguendo.

Questo concetto deve essere soprattutto **VISIBILE**, non soltanto spiegato
attraverso testo.


# Direzione visuale

Seguire molto fedelmente la direzione del mockup allegato.

NON è richiesta una replica pixel-perfect.

Sono invece intenzionali e devono essere preservati:

- grande quantità di spazio bianco;
- pagina ariosa;
- gerarchia tipografica evidente;
- colore RRL come elemento identificativo;
- card semplici e leggere;
- bordi e ombre discreti;
- poche informazioni contemporaneamente;
- sezioni facilmente distinguibili;
- composizioni differenti tra le sezioni;
- immagini utilizzate con uno scopo;
- sensazione moderna, semplice e accessibile;
- forte leggibilità;
- mobile-first.

Un aspetto particolarmente importante del mockup è il suo **ritmo**.

NON uniformare tutte le sezioni nello stesso layout.


# Hero

L'Hero è l'elemento più importante del redesign.

Il riferimento allegato mostra il concetto corretto:

- messaggio RRL;
- CTA;
- telefono/interfaccia del cronista;
- azioni rugby selezionabili tramite tap.

Il telefono con gli eventi NON è un semplice elemento decorativo.

Serve a spiegare immediatamente il funzionamento fondamentale di RRL.

L'utente deve percepire:

    GUARDO LA PARTITA
          ↓
    TAP SU UN EVENTO
          ↓
    RRL LO RACCONTA

Prima di implementarlo verificare quali elementi dell'interfaccia reale
esistente possono essere riutilizzati o rappresentati.

NON sostituire questo concetto con:

- logo RRL molto grande;
- fotografia generica di rugby;
- dashboard generica;
- semplice screenshot senza contesto;
- elemento grafico puramente decorativo.

NON inventare nuove funzionalità per costruire l'Hero.


# "For whom"

Mantenere il concetto già presente nella Home.

Seguire la composizione del riferimento:

- introduzione centrale;
- pochi elementi importanti;
- card grandi;
- immagini rilevanti;
- descrizioni brevi;
- molto spazio.

NON trasformare questa sezione in una generica feature grid.


# "You tap. We tell the story."

Questa deve essere una delle sezioni caratterizzanti della pagina.

Deve spiegare VISIVAMENTE il funzionamento di RRL.

Il principio è:

1. il cronista seleziona ciò che accade;
2. RRL produce il racconto;
3. chi segue riceve il racconto.

Utilizzare esclusivamente funzionalità realmente presenti in RRL secondo
codice e wiki.

La sezione deve poter essere capita almeno in buona parte anche senza leggere
tutto il testo.

NON deve sembrare documentazione tecnica.


# AI Talkers

Gli AI Talkers fanno parte dell'identità di Rugby Radio Live.

Tuttavia NON aggiungere una nuova sezione Talkers immediatamente sotto l'Hero.

La direzione approvata è quella del mockup Versione 1 originale.

Non utilizzare le successive esplorazioni visuali che rendevano i Talkers
protagonisti della parte superiore della pagina.


# Immagini dei Talkers

Le immagini ufficiali dei Talkers esistono già.

NON:

- generare nuovi Talkers;
- ridisegnarli;
- reinterpretarli;
- ricavarli graficamente dal mockup.

Se un'immagine corretta non viene immediatamente individuata nel progetto,
utilizzare temporaneamente un **placeholder chiaramente identificabile**.

Il placeholder verrà successivamente sostituito con l'asset ufficiale.


# Cover di partite e radio

IMPORTANTE:

le immagini di copertina di:

- partite;
- radio;

arrivano dinamicamente dalle API RRL.

NON sono asset statici della Home.

Individuare nel codice Angular attuale:

- API/dati utilizzati;
- proprietà contenente la cover;
- componenti che la visualizzano;
- eventuale gestione fallback/errori già presente.

Continuare a utilizzare i dati reali provenienti dalle API.

NON:

- creare cover statiche;
- salvare nel progetto le cover presenti nel mockup;
- sostituire le URL provenienti dalle API;
- introdurre fotografie generiche al loro posto;
- cambiare il meccanismo di caricamento senza necessità.

Il nuovo layout deve funzionare con qualsiasi cover reale restituita dalle API.

Gestire correttamente:

- aspect ratio;
- object-fit;
- responsive;
- dimensioni;
- eventuale fallback secondo quanto già previsto dall'applicazione.


# Contenuti dinamici

La Home attuale contiene contenuti dinamici relativi, tra gli altri, a:

- partite Live;
- prossime partite;
- partite concluse;
- radio.

Questi contenuti NON devono essere sostituiti con contenuti fittizi.

Devono essere ridisegnati utilizzando i dati reali già disponibili.

La Home però NON deve sembrare un archivio completo.

Preferire:

- pochi contenuti rappresentativi;
- gerarchia;
- spazio;
- accesso agli elenchi completi attraverso le azioni già esistenti.

Non visualizzare decine di card soltanto perché i dati sono disponibili.


# Ritmo della pagina

REQUISITO IMPORTANTE.

NON utilizzare lo stesso schema per tutte le sezioni.

In particolare evitare una successione continua:

    titolo + descrizione + CTA | immagine
    titolo + descrizione + CTA | immagine
    titolo + descrizione + CTA | immagine

Il mockup approvato funziona anche perché le sezioni hanno composizioni
differenti.

Per esempio:

- Hero → forte composizione visuale;
- For whom → card;
- funzionamento → processo visuale;
- Live → contenuto protagonista;
- Upcoming → contenuti più compatti;
- Last matches → composizione editoriale;
- Radio → composizione adatta alle cover radio;
- contenuti informativi → maggiore respiro narrativo.

Questa varietà deve comunque sembrare parte dello stesso prodotto.


# Densità

Ridurre significativamente la densità percepita rispetto alla Home attuale.

NON limitarsi a:

> stessi contenuti + card più belle.

Utilizzare:

- gerarchia;
- selezione;
- spazio bianco;
- dimensioni differenti;
- accesso alle liste complete.

Un contenuto importante può occupare molto più spazio rispetto a contenuti
secondari.


# Immagini

Riutilizzare dove possibile gli asset realmente disponibili nel progetto.

Le immagini devono aiutare a raccontare Rugby Radio Live.

NON utilizzare automaticamente fotografie sportive generiche per rendere la
pagina apparentemente più moderna.

Il redesign deve conservare una propria identità RRL.


# Responsive — requisito fondamentale

La Home deve essere progettata **MOBILE FIRST**.

Non realizzare semplicemente una buona versione desktop che viene poi
compressa su smartphone.

Per ogni sezione verificare esplicitamente:

- gerarchia mobile;
- leggibilità;
- dimensione font;
- spacing;
- touch target;
- disposizione;
- immagini;
- card;
- eventuali scroll orizzontali;
- quantità di contenuto;
- altezza complessiva;
- CTA.

In particolare l'Hero deve mantenere chiarissimo su mobile il concetto:

    TAP → EVENTO → RACCONTO

Il telefono/interfaccia non deve diventare un elemento minuscolo o
incomprensibile nella versione mobile.

La versione mobile ha la stessa importanza di quella desktop.


# TWA

Rugby Radio Live viene utilizzato anche tramite TWA.

NON è richiesto in questo step ridisegnare specificamente l'esperienza TWA.

Le decisioni attuali devono però facilitarne il redesign successivo.

Evitare quindi:

- dipendenze da larghezze desktop;
- dimensioni fisse non necessarie;
- interazioni disponibili esclusivamente tramite hover;
- componenti difficili da utilizzare tramite touch;
- CSS specifico della Home quando potrebbe essere condiviso.


# Questo redesign continuerà

La Home pubblica è soltanto lo STEP 1.

Successivamente lavoreremo su:

    STEP 2
    Home utente autenticato

    STEP 3
    esperienza TWA

    STEP 4+
    altre pagine RRL

Per questo motivo NON costruire la Home come un'isola grafica.

Le regole visuali generali emerse da questo redesign devono poter essere
riutilizzate.


# Stili globali

Analizzare gli stili globali esistenti prima di modificarli.

Quando una scelta rappresenta una regola generale del nuovo linguaggio
visuale RRL, implementarla in maniera riutilizzabile.

Valutare in particolare:

- palette;
- typography;
- heading;
- spacing;
- container;
- larghezze;
- button;
- link;
- card;
- border radius;
- shadow;
- badge;
- immagini/cover;
- breakpoint;
- stati interattivi;
- pattern responsive.

NON significa creare adesso un Design System completo.

NON fare over-engineering.

Estrarre soltanto ciò che nasce realmente dalla Home e che ha un chiaro valore
di riutilizzo nelle pagine successive.


# Componenti condivisi

Applicare lo stesso principio ai componenti Angular.

Prima di creare nuovi componenti:

1. individuare quelli esistenti;
2. verificare se possono essere riutilizzati;
3. verificare se possono essere evoluti;
4. creare qualcosa di nuovo soltanto quando necessario.

Valutare in particolare eventuali pattern condivisibili come:

- match card;
- radio card;
- section header;
- CTA;
- badge Live;
- cover/image container;
- stati loading/empty;
- elementi di navigazione.

NON frammentare però la Home in decine di micro-componenti soltanto per
ottenere teorica riutilizzabilità.


# Funzionalità esistente

Il redesign è principalmente visuale.

Preservare:

- chiamate API;
- routing;
- azioni;
- navigazione;
- tracking;
- SEO;
- eventuale AdSense;
- comportamento funzionale;
- loading;
- error handling;
- autenticazione;
- eventuali condizioni di visualizzazione.

Prima di rimuovere o modificare qualcosa perché non compare nel mockup,
verificare perché esiste nell'implementazione attuale.

Il mockup NON rappresenta necessariamente ogni requisito tecnico della Home.


# Cosa NON fare

NON:

- inventare feature;
- inventare dati;
- inventare API;
- inventare Talkers;
- creare cover statiche;
- creare una nuova applicazione;
- creare un mockup intermedio;
- cambiare routing senza necessità;
- rimuovere funzionalità senza analizzarle;
- introdurre nuove librerie UI senza necessità concreta;
- trasformare RRL in una landing SaaS generica;
- creare un Design System completo anticipatamente;
- fare over-engineering;
- rendere tutte le sezioni strutturalmente identiche;
- riempire ogni sezione di CTA;
- utilizzare fotografie generiche come soluzione visuale automatica;
- reinterpretare autonomamente il mockup;
- aggiungere sezioni soltanto perché sembrano utili;
- implementare oggi le future pagine.


# MODALITÀ DI LAVORO

## Fase 1 — Analisi

NON modificare ancora codice.

Analizzare:

- Home Angular attuale;
- struttura dei componenti;
- servizi;
- API utilizzate;
- modelli/dati;
- routing;
- CSS/styling;
- stili globali;
- variabili/token CSS;
- breakpoint;
- responsive attuale;
- asset;
- componenti condivisi;
- comportamento pubblico/autenticato;
- differenze Web/TWA eventualmente già presenti;
- SEO;
- tracking;
- AdSense;
- loading/error states;
- wiki rilevante;
- mockup allegato.

Individuare inoltre esplicitamente:

- da dove arrivano le cover delle partite;
- da dove arrivano le cover delle radio;
- come vengono attualmente renderizzate;
- dove sono gli asset dei Talkers;
- quali componenti match/radio sono già condivisi;
- quali pattern visuali sono già globali.


## Fase 2 — Mapping mockup → applicazione reale

Produrre una tabella:

| Area visuale | Implementazione attuale | Dati/API | Riutilizzo | Modifica proposta |
|---|---|---|---|---|

Mappare almeno:

- Header;
- Hero;
- CTA;
- For whom;
- Live;
- Upcoming;
- Last matches;
- Radio;
- You tap. We tell the story;
- contenuti informativi;
- Footer;
- eventuali altre aree realmente presenti nella Home.

Per ogni elemento spiegare da dove deriveranno:

- dati;
- immagini;
- comportamento;
- componenti.

Se qualcosa mostrato dal mockup NON corrisponde a una funzionalità o asset
esistente, segnalarlo.

NON inventare automaticamente una soluzione.


## Fase 3 — Piano di implementazione

Produrre il piano delle modifiche indicando:

- file coinvolti;
- componenti mantenuti;
- componenti modificati;
- eventuali nuovi componenti;
- servizi coinvolti;
- modifiche CSS;
- modifiche globali;
- asset;
- strategia responsive;
- comportamento mobile;
- eventuali rischi/regressioni.


## Fase 4 — Fondamenta UI riutilizzabili

Produrre inoltre:

| Elemento | Situazione attuale | Modifica proposta | Scope |
|---|---|---|---|
| Colors | ... | ... | Global |
| Typography | ... | ... | Global |
| Spacing | ... | ... | Global |
| Container | ... | ... | Global |
| Buttons | ... | ... | Shared |
| Cards | ... | ... | Shared/Home |
| Match card | ... | ... | Shared |
| Radio card | ... | ... | Shared |
| Live badge | ... | ... | Shared |
| Responsive | ... | ... | Global |
| ... | ... | ... | ... |

Utilizzare come Scope:

- Global;
- Shared;
- Home.

Motivare le scelte.

NON rendere globale qualcosa soltanto perché potrebbe teoricamente essere
riutilizzato in futuro.


## Fase 5 — Verifica responsive proposta

Prima dell'implementazione descrivere sinteticamente come cambieranno almeno:

- Hero;
- For whom;
- Live;
- match;
- radio;
- processo "You tap";
- navigazione;

tra:

- mobile;
- tablet;
- desktop.

Non servono tre design differenti.

Serve dimostrare che la composizione responsive è stata pensata prima di
scrivere il CSS.


# STOP OBBLIGATORIO

Dopo Fase 1-5:

**FERMARSI.**

NON modificare alcun sorgente.

NON iniziare l'implementazione.

NON creare nuovi componenti.

NON modificare CSS.

Presentare esclusivamente:

1. analisi;
2. mapping;
3. piano;
4. fondamenta UI;
5. strategia responsive;
6. eventuali dubbi/blocchi reali trovati nel codice.

Attendere la mia approvazione.


# Dopo l'approvazione

Solo dopo approvazione verrà richiesta l'implementazione.

L'implementazione dovrà essere eseguita direttamente sui sorgenti Angular
esistenti, in passi piccoli e verificabili.

Non effettuare durante l'implementazione un nuovo redesign autonomo.


# Criteri di successo

Il risultato finale dovrà soddisfare contemporaneamente queste domande:

1. Una persona che arriva sulla Home capisce rapidamente cosa fa RRL?
2. Il concetto "You tap. We tell the story." è evidente visivamente?
3. Il telefono/tap nell'Hero comunica concretamente il funzionamento?
4. La pagina mantiene il ritmo e la leggerezza del mockup?
5. Le sezioni sono abbastanza diverse da non risultare ripetitive?
6. I dati continuano ad arrivare dalle API reali?
7. Le cover di match e radio continuano ad arrivare dalle API?
8. Gli asset esistenti vengono rispettati?
9. La Home funziona realmente bene su smartphone?
10. Touch e responsive sono adeguati alla futura TWA?
11. SEO, tracking, AdSense e comportamento esistente sono preservati?
12. Le regole visuali realmente generali sono riutilizzabili?
13. Possiamo passare alla Home autenticata e alle altre pagine senza rifare
    da zero le fondamenta visuali?

Se una soluzione rende la Home più bella ma compromette uno di questi punti,
non è una soluzione corretta.