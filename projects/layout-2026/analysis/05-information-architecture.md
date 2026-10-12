# Architettura informativa e navigazione — layout-2026

**Stato:** proposta da validare con product owner/stakeholder. Non costituisce una decisione approvata né autorizza modifiche al frontend.

## Obiettivo e basi

Organizzare le superfici intorno ai due compiti pubblici — trovare e seguire una partita/canale — e al compito operativo autenticato — gestire un canale e registrare gli eventi di una partita. La proposta mantiene i percorsi pubblici accessibili senza account e rende esplicito il passaggio verso le funzioni che richiedono autenticazione.

Evidenze principali: `projects/layout-2026/analysis/01-user-flows.md` descrive route, accessi, flussi e frizioni; `03-mobile-experience.md` documenta la densità della tab Live e la combinazione feed/radio in Events; `04-anonymous-home-options.md` raccomanda come ipotesi una home mista con presentazione breve e contenuti pubblici anticipati. Tutti e tre sono analisi statiche: la gerarchia proposta qui resta da testare.

## Modello mentale proposto

1. **Scopri**: partite, canali, squadre e statistiche pubbliche.
2. **Segui**: una partita pubblica, scegliendo cronaca testuale, radio, formazioni e statistiche.
3. **Racconta**: accedi, scegli/gestisci un canale, crea una partita e usa la superficie Live.
4. **Il mio account**: profilo, preferiti, canali e dashboard.

Questi sono gruppi di navigazione, non nuove capacità di prodotto. Le pagine corrispondono alle route verificate in `src/RugbyRadioWeb/src/app/app.routes.ts`; eventuali pagine nuove sono indicate esplicitamente come da valutare.

## Mappa proposta

```text
Home
├── Scopri
│   ├── Partite (/g-matches)
│   │   └── Partita (/g-match/:matchId)
│   │       ├── Eventi e cronaca / radio
│   │       ├── Formazione casa / ospiti
│   │       ├── Statistiche
│   │       └── Condividi
│   ├── Canali (/g-channels)
│   │   └── Canale (/g-channel/:channelPublicId)
│   ├── Squadra (/g-team/:teamId)
│   └── Statistiche pubbliche (/g-stats)
├── Racconta (CTA verso login o registrazione; destinazione da approvare)
│   └── Area account (/user-dashboard)
│       ├── Partita rapida (wizard esistente)
│       ├── I miei canali (/user-channels)
│       │   └── Canale gestito (/user-channel/:channelId)
│       ├── Preferiti (/user-favorites)
│       └── Profilo (/user-profile)
└── Supporto e informazioni (voci esterne già presenti nel menu; priorità da rivedere)
```

`/g-radio/:matchId` è una pagina pubblica autonoma già esistente; tenerla come destinazione diretta/condivisibile per l’ascolto, ma collegarla chiaramente al dettaglio partita. `/g-feedback` resta una destinazione di supporto. Le voci esterne Blog, News, Tutorial, Why, AI Talkers e Architecture sono nel menu corrente, ma la loro gerarchia rispetto ai compiti primari va validata. La route `user-danger` resta in area account, con etichetta esplicita che ne chiarisca l’effetto prima dell’accesso.

## Navigazione per contesto

### Desktop

Proposta di intestazione con brand/home, accesso primario a **Partite** e **Canali**, e azione account persistente. Statistiche, squadre, supporto e contenuti editoriali possono stare in un menu secondario “Altro” o nel footer, senza competere con discovery e accesso. La sessione autenticata sostituisce login con un menu account che apre dashboard, canali, preferiti e profilo.

La home usa l’impostazione mista già raccomandata in `04-anonymous-home-options.md`: descrizione breve e due azioni riconoscibili (esplora contenuti; accedi/inizia a raccontare), poi partite e canali pubblici. Promuovere il blocco “in corso” solo se API e ordinamento garantiscono che contenga partite effettivamente live; predisporre e progettare uno stato vuoto/fallback senza inventare contenuti. La proposta evita che l’utente debba scorrere tutta la presentazione per raggiungere i cataloghi, problema ipotizzato in `01-user-flows.md` e `04-anonymous-home-options.md`.

Nella pagina partita mantenere un contesto persistente riconoscibile (squadre, stato e punteggio, secondo i dati effettivamente disponibili) e le sezioni Events, Lineup, Stats, Share già implementate. Rendere “Cronaca” e “Ascolta” distinguibili all’interno della superficie eventi: la mappa indica che oggi feed, configurazione commentatore e radio si concentrano lì. Non si propone una nuova modalità radio o dati aggiuntivi; è una riorganizzazione/gerarchia della UI da verificare.

Per il cronista, `/user-dashboard` funge da punto d’ingresso operativo: azione “Crea partita”/wizard esistente e accesso ai canali gestiti in primo piano, profilo e preferiti come aree di supporto. Dentro `/user-match/:matchId`, le fasi e le azioni di partita devono restare il livello primario durante il live; Events, formazioni, Stats e Share restano consultabili. La scheda Live è sensibile allo stato e scompare a full time nel comportamento rilevato: preservare il contesto di conclusione e portare l’utente alla cronaca/risultato senza suggerire che Live sia ancora attiva. Verificare questa regola con il dominio prima di cambiare la navigazione.

### Smartphone e PWA/TWA

Proposta: ridurre le destinazioni persistenti a **Home**, **Partite**, **Canali** e **Account**; usare l’area account per il percorso “Racconta” e le destinazioni di gestione. Se si mantiene la bottom navigation esistente, le etichette devono chiarire le destinazioni e la selezione corrente; il menu a pannello va riservato a supporto, statistiche e contenuti secondari. La bottom nav è condizionale nel guscio (`src/RugbyRadioWeb/src/app/app.component.html`); le analisi disponibili non enumerano tutte le sue voci, pertanto lo schema è una proposta e non descrizione dello stato presente.

Per il visitatore mobile, la home breve deve offrire accesso immediato alle liste e ai contenuti; card/risultati devono mantenere un percorso semplice verso il dettaglio pubblico. Sulla pagina partita preservare il contesto mentre si passa tra cronaca, ascolto, formazioni e statistiche. La radio e il feed possono rimanere nello stesso gruppo informativo, ma mostrare un controllo evidente “Leggi / Ascolta” (la wiki e l’analisi documentano già la commutazione) e lo stato audio. Testare l’uso con una mano, la conservazione della posizione di lettura e l’accesso a tab/azioni su viewport stretta, come richiesto da `03-mobile-experience.md`.

Per il cronista, proposta di percorso diretto e breve: **Account/Racconta → partita o canale → Live**. Durante il live, non introdurre una gerarchia mobile diversa che nasconda gli eventi essenziali; raggruppare le destinazioni non operative in accessi secondari e mantenere la superficie Live in primo piano finché lo stato lo consente. Il template attuale usa gruppi di azioni e griglie a due colonne sotto breakpoint; la priorità di validazione è densità, reachability, conferma dell’invio e recupero da errore. La proposta non definisce quali azioni accorpare, rinominare o rendere persistenti: servono osservazione sul campo e vincoli di dominio.

PWA/TWA: mantenere lo stesso modello mentale e la stessa struttura delle destinazioni della web mobile. Non assumere che splash, onboarding o home anonima debbano differire: `01-user-flows.md` segnala che il ramo TWA post-splash è diverso dalla web, e `03-mobile-experience.md` richiede una decisione e una prova dedicata. La configurazione portrait del manifest non basta a escludere o risolvere landscape.

## Percorsi per ruolo

| Ruolo/contesto | Percorso principale proposto | Accessi secondari |
|---|---|---|
| Visitatore anonimo | Home → Partite/Canali → dettaglio pubblico → Leggi o Ascolta | Squadra, statistiche, supporto; login contestuale alle azioni protette |
| Spettatore | Link diretto o catalogo → partita → cronaca/radio → lineup/stats/share | Canale collegato; login quando richiesto da un’interazione |
| Cronista | Login → dashboard → crea/gestisci canale o partita → Live → eventi → intervallo/secondo tempo → conclusione | Events, lineup, Stats, Share; profilo e preferiti |
| Utente autenticato generico | Home/dashboard → account e contenuti pubblici | Profilo, preferiti, canali; può seguire partite come spettatore o svolgere compiti da cronista secondo permessi effettivi |

Un account autenticato non equivale automaticamente a un cronista autorizzato su ogni canale o match: permessi e ownership vanno verificati nei servizi/API, non dedotti dalla guard frontend.

## Collegamento tra evidenze e proposta

| Evidenza documentata | Risposta proposta | Verifica richiesta |
|---|---|---|
| Home web mescola marketing, partite/canali, FAQ e annunci; il feed “in corso” non porta un filtro di stato evidente nel client (`04-anonymous-home-options.md`) | Presentazione sintetica; cataloghi e feed pubblici subito raggiungibili. Evidenziare live solo con criterio dati verificato | API/query, ordinamento, freschezza, stato vuoto; dati home Analytics/SEO se la priorità di conversione è determinante |
| Menu header contiene account, discovery, feature e supporto in un unico pannello (`01-user-flows.md`; `src/RugbyRadioWeb/src/app/site/header/header.component.html`) | Separare navigazione primaria da destinazioni secondarie; adattare voce account alla sessione | Test di comprensione con visitatori e utenti autenticati |
| Events combina feed, opzioni commentatore, radio e controlli (`01-user-flows.md`, `03-mobile-experience.md`) | Nominare il compito della sezione e distinguere chiaramente cronaca testuale e ascolto | Prova mobile con stati audio disponibili/non disponibili e scroll/aggiornamento |
| Live ha gruppi d’azione densi e drawer in fase di partita; CSS usa griglia a due colonne su viewport ridotte (`03-mobile-experience.md`) | Mantenere Live come contesto prioritario; posticipare navigazione non operativa e non aumentare complessità durante l’inserimento evento | Sessione osservata con cronisti, errori/tap/scroll e feedback; verifica con tastiera e viewport corto |
| Home TWA differisce dalla web dopo splash (`01-user-flows.md`, `03-mobile-experience.md`) | Modello IA coerente tra superfici; trattare onboarding come presentazione iniziale, non come navigazione separata | Decisione prodotto e test su PWA e TWA reali |
| Interazioni protette e ritorno al match sono parzialmente contestuali; regole rating non chiare (`01-user-flows.md`) | Chiedere accesso nel contesto dell’azione e restituire al contesto iniziale, se supportato | Confermare route/intent di ritorno, permessi, policy di login e azioni permesse lato API |

## Decisioni aperte dopo le risposte del responsabile prodotto

Le risposte sono in `qa/Q&A - 01.md`; la valutazione puntuale è in `qa/01-assessment.md`. Sono state registrate le direzioni per home anonima e autenticata, prova della telecronaca, splash TWA distinto, perimetro delle superfici pubbliche e omissione del blocco live vuoto. Non sono tutte decisioni di layout approvate.

1. **Home anonima e autenticata — direzione chiarita; composizione da approvare.** L’anonimo deve capire RRL, vedere esempi e sapere come accedere/provare; l’autenticato deve atterrare su un’esperienza operativa senza marketing. Resta da fissare la gerarchia concreta tra spettatore e prova cronista.
2. **Prova/CTA cronista — parzialmente chiarita.** Dare evidenza al wizard e al canale privato di test; verificare percorso, disponibilità e permessi, quindi decidere CTA e destinazione esatte.
3. **Dashboard — direzione chiarita.** Per gli autenticati serve un accesso immediato alle attività; restano da definire priorità e stati. L’eventuale scelta cronista/spettatore nel profilo è un’ipotesi, non una decisione.
4. **Navigazione mobile — aperta.** Il set attuale indicato è Home, Radio, Crea, Partite e Profilo; l’obiettivo è semplificare. Verificare nel codice e decidere quali destinazioni sono persistenti o secondarie.
5. **Autenticazione e ritorno — aperta.** “Semplicità e pochi click” è un principio guida, ma non risolve policy per rating, follow, like, commenti e reazioni né il ritorno al contesto dopo il login.
6. **TWA — parzialmente chiarita.** Lo splash deve differire dalla presentazione web perché l’installazione dallo store già introduce il prodotto. Resta da definire cosa vede un anonimo dopo lo splash e cosa accade al ritorno/autenticazione.
7. **Pagine pubbliche — perimetro chiarito, gerarchia aperta.** Radio, squadra, statistiche e feedback sono esempi importanti e superfici di traffico; stabilire quali meritano navigazione primaria e quali accesso contestuale/secondario.
8. **Home senza live — regola di contenuto chiarita, errore aperto.** Omettere la sezione live e mostrare lo storico; verificare che lo storico sia disponibile e progettare lo stato di errore dati distinguendolo dal feed vuoto.
9. **Validazione — aperta.** Definire device/browser e prove qualitative per home, navigazione, cronista e spettatore; i dati Analytics/SEO e l’erogazione ads richiedono evidenze separate.

La roadmap resta soggetta al gate di approvazione descritto in `delivery/07-priorities-and-rollout.md`.
## Dipendenze e confini

### Frontend potenzialmente coinvolto

- Route e guard: `src/RugbyRadioWeb/src/app/app.routes.ts`, `src/RugbyRadioWeb/src/app/services/auth-guard.service.ts`.
- Shell e navigazione: `src/RugbyRadioWeb/src/app/app.component.html`, `src/RugbyRadioWeb/src/app/site/header/header.component.html`, componenti header e entity bottom nav.
- Home/dashboard: `src/RugbyRadioWeb/src/app/site/home/home.component.html`, `home-user/home-user.component.html` e componenti home pubblica.
- Discovery: `src/RugbyRadioWeb/src/app/global/g-matches/`, `g-channels/`, `g-match/`, `g-match-radio/`, `g-channel/`, `g-team/`, `g-stats/`.
- Cronista/account: `src/RugbyRadioWeb/src/app/user/match/`, `user/channels/`, `user/channel/`, `user/favorites/`, `user/profile/`, `common/match-create/`.
- Shared tab/header: `src/RugbyRadioWeb/src/app/common/` e relativi componenti.

I percorsi sono aree candidate basate sulle route e analisi già lette; la mappatura dei singoli file da modificare richiede la direzione approvata e l’inventario UI completo.

### Dati, API e dominio da chiarire

- Feed home: criteri effettivi per match in corso/prossimi/recenti, ordinamento, freschezza, paginazione e comportamento senza risultati; non deducibili dal nome dei componenti.
- Canali e partite gestiti: permessi/ownership e operazioni ammesse su ogni risorsa; il `AuthGuardService` controlla la sessione locale, non prova l’autorizzazione di dominio.
- Interazioni: policy server-side per rating, commenti, follow, like e reazioni; destinazione di ritorno dopo login.
- Stato partita: transizioni e tab ammissibili nei diversi stati, inclusi conclusione e ripresa.
- SEO e annunci: verifica della resa di route pubbliche e slot attivi prima di fissarne peso e posizione nella gerarchia.
- PWA/TWA: route di avvio, preferenza splash, back, stato sessione e disponibilità runtime; l’analisi attuale non ha ispezionato pacchetto Android o API in esecuzione.

Non proporre nuovi endpoint, filtri o proprietà dei dati come già esistenti. Se i requisiti di ordinamento/filtro o ripristino dell’intento richiedono capacità assenti, registrarle come dipendenze e valutarle separatamente dal redesign frontend.

## Prossimi passi raccomandati

1. Convalidare le otto decisioni aperte con product owner e responsabili dominio.
2. Ispezionare il menu e bottom navigation completi e provare i percorsi principali su desktop, smartphone e TWA/PWA disponibili.
3. Confermare con API/prodotto semantica e fallback dei feed home e matrice dei permessi.
4. Trasformare la direzione approvata in mappa di pagine/stati e criteri di accettazione, poi aggiornare la proposta UX prima di intervenire sul frontend.

## Limiti

Documento basato su analisi statiche e percorsi elencati, non su applicazione avviata, dati runtime, backend, interviste o test di usabilità. I comportamenti citati sono limitati ai file verificati in `01-user-flows.md`, `03-mobile-experience.md` e `04-anonymous-home-options.md` e alle route/template consultati qui. Non è stata verificata tutta la bottom navigation, il rendering effettivo degli annunci, l’output SEO per crawler, la TWA distribuita, né la policy API. Le raccomandazioni sono ipotesi di struttura da validare e nessuna decisione di prodotto è stata assunta.

