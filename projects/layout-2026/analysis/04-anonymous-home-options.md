# Home anonima: confronto delle alternative

## Ambito e criterio

Valutazione delle tre direzioni indicate nel brief: landing di presentazione, home centrata sui contenuti pubblici e soluzione mista. L'obiettivo qui è chiarire come ciascuna supporta scoperta, prova, accesso e registrazione, usando le fonti disponibili senza attribuire risultati di business non misurati. Questa è un'analisi; non approva modifiche di prodotto o frontend.

## Fonti consultate

**Wiki**

- `docs/wiki/frontend/web/pages/HomePage (web).md`
- `docs/wiki/frontend/web/pages/GMatchesPage (web).md`
- `docs/wiki/frontend/web/pages/GChannelsPage (web).md`
- `docs/wiki/frontend/web/pages/GMatchPage (web).md`
- `docs/wiki/frontend/web/pages/GChannelPage (web).md`
- `docs/wiki/frontend/web/components/HomeGridComponent (web).md`
- `docs/wiki/frontend/web/components/ChannelCardListComponent (web).md`
- `docs/wiki/frontend/web/services/AnalyticsService (web).md`
- `docs/wiki/articles/Public Sitemap (article).md`
- `docs/wiki/articles/Superficie SEO e Indicizzazione (article).md`
- `docs/wiki/backend/api/services/SeoUrlInventoryService (api).md`
- `docs/wiki/backend/api/jobs/GenerateSeoSitemapJob (api).md`
- `docs/wiki/frontend/web/pages/LoginPage (web).md`

**Codice verificato** (percorsi relativi a `src/RugbyRadioWeb/`)

- Route e protezione: `src/app/app.routes.ts`, `src/app/services/auth-guard.service.ts`.
- Home e schermata di ingresso: `src/app/site/home/home.component.ts`, `home.component.html`, `home-splash/home-splash.component.ts`, `home-splash/home-splash.component.html`, `home-logo/home-logo.component.html`.
- Feed home: `home-ongoing-matches/home-ongoing-matches.component.ts`, `home-next-matches/home-next-matches.component.ts`, `home-last-matches/home-last-matches.component.ts`, `home-last-channels/home-last-channels.component.ts` e i rispettivi template.
- Liste e schede pubbliche: `src/app/global/g-matches/g-matches.component.ts`, `g-channels/g-channels.component.ts`, `g-match/g-match.component.ts`, `g-channel/g-channel.component.ts`; `src/app/common/match-card-list/match-card-list.component.html`, `channel-card-list/channel-card-list.component.html`, `home-grid/home-grid.component.ts`.
- Login, registrazione e tracciamento: `src/app/user/login/login.component.html`, `login.component.ts`, `src/app/user/registration/registration.component.ts`, `src/app/services/logincallback.service.ts`, `src/app/services/analytics.service.ts`.
- SEO, annunci e shell: `src/app/services/seo-metadata.service.ts`, `src/app/common/entity-ads/entity-ads.component.ts`, `src/app/app.config.ts`, `src/index.html`, `src/app/site/home/home.component.html`, `src/app/global/g-channel/g-channel.component.html`, `src/app/common/channel-card-list/channel-card-list.component.ts`.
- Pubblicazione: `firebase.json`, `angular.json`, `src/sitemap.xml`, `src/robots.txt`.

## Fatti documentati dalla wiki

- La pagina `HomePage` riassume la route `/` come pubblica con splash/onboarding, marketing e caroselli di partite/canali; la dashboard utente è su `/user-dashboard` e richiede autenticazione.
- Le pagine `/g-matches` e `/g-channels` sono pubbliche e offrono ricerca e paginazione. Le pagine `/g-match/:matchId` e `/g-channel/:channelPublicId` sono consultabili senza login; follow e like richiedono login.
- La sitemap pubblica include home, liste di partite e canali; esistono inoltre sitemap per entità pubbliche. La policy documentata ammette in sitemap i match con almeno 10 eventi, stato `FullTime`, blog associato e canale non di test.
- La wiki descrive il wrapper Analytics basato su Firebase Analytics e segnala eventi/tracciamento per le pagine principali. Non fornisce risultati di conversione, ricavi pubblicitari o confronti quantitativi tra home.

## Comportamento verificato nel codice

### Home e scoperta

- `/` usa `HomeComponent`; `/user-dashboard` riusa il componente ma è protetta da `AuthGuardService`. Le route di login e registrazione sono `/user-login` e `/user-registration`; `/g-matches`, `/g-channels`, `/g-match/:matchId` e `/g-channel/:channelPublicId` sono route senza guard.
- Nella home il splash sostituisce il resto della pagina solo quando `isTwa && internalShowSplash`. Sul web normale, invece, il visitatore anonimo vede prima `HomeLogo`, `HomeWho` e `HomeHelp`, poi le sezioni partite in corso, prossime, recenti e canali, quindi caratteristiche, motivazioni, tutorial, FAQ e un annuncio. Per TWA, escluso lo splash iniziale, le sezioni marketing non vengono mostrate ma restano i feed e l'annuncio. Per utenti autenticati compaiono anche `HomeUser` e i feed.
- Il blocco iniziale web ha un CTA login e un CTA per esplorare le partite. Non c'è un CTA di registrazione diretto nel blocco home verificato. La schermata splash offre login e continua senza login, più selezione della lingua; il percorso di registrazione è offerto dalla pagina di login tramite azione che porta a `/user-registration`.
- Le sezioni home usano `findMatches('', 1, 10/20/30)` e `findChannels('', 1)`; le card aprono pagine pubbliche di dettaglio e i link “vedi tutti” aprono le liste pubbliche. Il client non comunica al lettore, tramite questi parametri, criteri espliciti di stato/ordinamento. Le etichette e i componenti distinguono in corso, prossime e recenti, ma va verificato con l'API quali record e ordinamento siano effettivamente restituiti: non deduco la correttezza semantica dei feed dal solo nome del componente.
- La lista partite e la lista canali permettono ricerca testuale e paginazione; le schede aprono i dettagli. Le pagine partita mostrano eventi/commento, formazioni, statistiche e condivisione. Le pagine canale mostrano radio/partite, squadre, classifiche e condivisione. Sono quindi il percorso attuale più diretto per provare l'esperienza pubblica senza account.
- Nel dettaglio partita il visitatore anonimo può leggere e seguire gli aggiornamenti pubblici; il follow/like attiva il flusso di login e ritorno all'URL richiesto tramite `LoginCallbackService`. Nel dettaglio canale l'azione follow per anonimo conduce al login. La registrazione è successiva a questo passaggio, dalla schermata login.

### SEO, analytics e annunci

- La home aggiorna a runtime title, description, canonical e immagini Open Graph/Twitter e registra `home_viewed`. Le liste pubbliche aggiornano metadata e registrano `match_list_viewed`/`channel_list_viewed`; i dettagli impostano metadata per match/canale e registrano eventi di apertura/visualizzazione. Il servizio Analytics invia gli eventi a Firebase/Google Analytics, se configurato. Il codice traccia anche inizio registrazione e completamento email in `registration.component.ts`.
- I dettagli match/canale generano dati strutturati; la pagina canale usa `SportsOrganization` e la pagina match un tipo di evento sportivo. La sitemap è una superficie separata e include home, liste e URL di entità selezionate secondo le policy wiki.
- Il titolo/description nel documento iniziale `src/index.html` corrisponde ai metadata iniziali home; la pagina Angular li aggiorna lato client. `firebase.json` riscrive gli URL non statici a `index.html`. Non ho verificato il contenuto HTML servito ai crawler/social scraper né i report Search Console aggiornati: la sola presenza di metadata dinamici non dimostra che ogni crawler legga le versioni aggiornate.
- È presente un annuncio nella home. Il dettaglio canale ha un annuncio nella scheda Radio; liste di canali/partite supportano inserimenti pubblicitari ogni N card se vengono passati client, slot e frequenza. Nel template attuale di `/g-channels` non sono visibili parametri pubblicitari passati alla lista; per il layout home-grid non risulta una logica di inserimento annuncio per singola card. Non sono deducibili impression, ricavi, policy di consenso o priorità commerciali.

## Problemi e lacune osservabili

1. **Scoperta con doppio intento, ma CTA di registrazione indiretta.** L'utente può passare da presentazione a contenuti pubblici senza account, ma la home porta al login e il login porta alla registrazione. La frizione effettiva non è misurata.
2. **La home è già mista sul web, ma la gerarchia è marketing-first.** Le sezioni pubbliche sono presenti sotto più blocchi di presentazione. Il codice non offre una variante decisa dal tipo di visitatore o dalla provenienza, né un ordine specifico per visitatori interessati a una partita live.
3. **Onboarding differente per superficie.** Lo splash è condizionato a TWA e alla preferenza locale sullo splash. La wiki lo descrive più genericamente come parte della home pubblica. Questa è una differenza fra descrizione sintetica e condizione implementata da verificare come scelta voluta.
4. **Rischio di promessa non allineata ai contenuti.** Non è verificato se la prima sezione mostrata contenga sempre partite in corso o se sia vuota. La query del feed in corso usa la ricerca pubblica generica; non passa un filtro `status` in `HomeOngoingMatchesComponent`.
5. **Prova del prodotto non equivale alla registrazione.** Match e canali pubblici permettono una prova concreta, mentre azioni sociali richiedono account. Il brief non stabilisce quali azioni anonime siano sufficienti né quale conversione si voglia ottimizzare.
6. **SEO e analytics non misurano da soli l'impatto della direzione.** Esistono metadata, sitemap e tracciamento eventi, ma non sono stati forniti dati di indicizzazione, traffico, funnel o rendimento pubblicitario attribuibili al layout attuale.
7. **Vincolo di contenuti e freschezza.** La soluzione pubblica dipende da dati di partite/canali disponibili e corretti; non è documentata una regola di fallback editoriale quando feed e risultati sono vuoti o non pertinenti.

## Confronto delle alternative

| Alternativa | Scoperta di partite e canali | Prova del prodotto | Accesso e registrazione | SEO, analytics e annunci |
|---|---|---|---|---|
| **Landing di presentazione** | Presenta il valore del servizio e indirizza verso sezioni dedicate. Senza contenuti o link ben visibili, allunga il percorso per trovare una partita o un canale. | Spiega l'esperienza, ma per provarla serve uscire dalla landing e aprire le pagine pubbliche. | Può rendere chiari login e registrazione; la registrazione diretta sarebbe un nuovo CTA/proposta. Conservare l'opzione “esplora senza account” evita di chiudere il percorso anonimo. | La home è già canonica e indicizzata nella sitemap. Pagine pubbliche separate continuano a essere l'entry point di contenuto. Una landing semplifica la lettura del messaggio ma non risolve la resa dinamica dei metadata. Analytics può misurare CTA, ma gli eventi per funnel andrebbero definiti. Spazio pubblicitario home esistente andrebbe posizionato senza interferire con il messaggio. |
| **Home di contenuti pubblici** | Porta partite/canali in primo piano; card e liste pubbliche consentono di esplorare subito e filtrare nelle pagine elenco. | Offre la prova più rapida tramite partite, commenti, canali, formazioni e statistiche pubblici. | Login/registrazione diventano azioni contestuali (es. follow) oltre ai link globali; va preservata una CTA per chi vuole contribuire come cronista. L'attuale onboarding TWA resta un caso da decidere. | Coerente con route pubbliche, sitemap e metadata per pagine entità; richiede che il contenuto sia chiaro e fruibile anche quando non ci sono eventi correnti. Analytics può osservare apertura e uso liste, ma non prova un miglioramento senza baseline. Può ospitare annunci già previsti, con rischio di competizione visiva e maggiore dipendenza dalla densità delle liste. |
| **Soluzione mista (raccomandazione)** | Primo blocco breve con promessa e due percorsi espliciti: esplora contenuti pubblici e accedi/inizia a raccontare; feed pubblici immediatamente successivi, con priorità a partite live solo se la disponibilità è verificata. | Combina spiegazione essenziale e accesso in pagina a contenuti reali; le sezioni marketing più estese possono essere subordinate o collegate a pagine informative dedicate. | Mantiene login e registrazione facilmente raggiungibili, aggiunge un percorso chiaro alla registrazione e conserva l'accesso anonimo. L'azione che richiede account deve spiegare il motivo e tornare all'elemento richiesto dopo il login. | Riutilizza le pagine pubbliche canoniche e la superficie SEO già presente. Analytics dovrebbe distinguere ingresso/CTA, scoperta lista, apertura entità e avvio/completamento registrazione; gli eventi vanno concordati e non implicano obiettivi quantitativi. Conserva gli spazi ads esistenti dopo i contenuti principali e verifica resa mobile e impatto sulla gerarchia. |

## Proposta motivata

**Raccomandazione: evolvere la home web in una soluzione mista con contenuti pubblici anticipati e presentazione breve.** Il sito dispone già di pagine pubbliche utilizzabili senza account e le route, i metadata e le sitemap sostengono la scoperta diretta di partite/canali. Una landing pura duplicherebbe una parte dell'attuale marketing e aggiungerebbe un passaggio prima della prova. Una home solo feed indebolirebbe la spiegazione del servizio per chi arriva senza conoscere RRL e potrebbe apparire vuota o poco rilevante quando i contenuti correnti mancano.

La prima schermata dovrebbe chiarire in poche righe cosa fa RRL e presentare due azioni comprensibili: **esplora partite e canali** e **accedi/crea un account per raccontare o seguire**. Subito dopo, mostrare contenuti pubblici con un trattamento prioritario delle partite live solo se la query e i dati garantiscono che si tratti davvero di incontri in corso; mantenere feed e link alle liste complete. La parte esplicativa più lunga può restare più in basso. Su mobile le card e le CTA devono mantenere leggibilità e accesso ai contenuti senza costringere a scorrere tutta la presentazione.

Questa raccomandazione è una direzione da sottoporre a product owner/stakeholder, non una decisione approvata. Non si può scegliere la gerarchia definitiva senza chiarire il peso relativo di spettatori anonimi e cronisti, né senza verificare dati e resa SEO effettiva.

## Decisioni e verifiche ancora richieste dopo Q&A 01

Le risposte del responsabile prodotto in `qa/Q&A - 01.md` e la valutazione in `qa/01-assessment.md` chiariscono la direzione: home anonima per capire RRL e vedere esempi/provare, esperienza autenticata operativa senza marketing. È confermato valorizzare la prova del cronista e, senza partite live, omettere il blocco e usare lo storico. Le scelte visuali e i dettagli di navigazione sono ancora da approvare.

1. Quali CTA precise portano al wizard, al canale privato di test, al login e alla registrazione? Quali destinazioni e permessi sono effettivamente disponibili?
2. La possibile preferenza “cronista/spettatore” nel profilo è solo un’ipotesi: serve una decisione su necessità e impatto, senza assumerla nel primo rilascio.
3. Come devono essere ordinati i feed e verificato che una partita sia live? Confermare API, freschezza, storico disponibile e stati vuoto/errore separati.
4. Cosa vede l’utente anonimo TWA dopo lo splash distinto dalla presentazione web? Come cambia per sessione già autenticata o avvio successivo?
5. Quali dati Search Console/Analytics e quali requisiti SEO servono per valutare pagine pubbliche e home? Definire baseline prima di attribuire esiti a modifiche.
6. Quali slot pubblicitari sono attivi e quali vincoli di layout/consenso valgono? Il codice non prova l’effettiva erogazione.

La preferenza per una landing mista rimane una raccomandazione compatibile con le risposte, non una scelta di layout approvata.
## Limiti

- Nessuna verifica runtime delle API, dei record attualmente restituiti, delle pagine pubbliche in produzione, degli annunci erogati o dell'output reso dai crawler.
- Nessun dato analytics/Search Console, obiettivo commerciale, intervista utente o requisito di stakeholder fornito per quantificare conversione, retention, ricavi o preferenze.
- La documentazione wiki è una sintesi e può precedere il codice corrente. La condizione specifica dello splash e i dati SEO runtime sono stati quindi riportati dal codice, non dedotti dalla wiki.
- L'analisi resta limitata alla home anonima e alle superfici necessarie a confrontare le tre alternative; non definisce architettura informativa completa né design system.

