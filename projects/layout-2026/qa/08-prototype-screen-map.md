# Mappa schermate e stati per il prototipo layout-2026

**Stato:** mappa per la realizzazione del prototipo, derivata dalle direzioni approvate in Q&A 03. Le schermate sono specifica UX, non nuove route applicative né contratto API. La cartella `src/RugbyRadioLayout2026` è presente ma vuota al momento della stesura: questo documento non presuppone framework o file già creati.

## Direzioni approvate da riflettere nel prototipo

- Home diversa per stato di sessione: l’anonimo capisce il servizio e vede esempi; l’autenticato trova una dashboard operativa senza marketing.
- La Home anonima dà priorità alla prova cronista e offre l’esplorazione pubblica come percorso secondario, senza scelta obbligatoria di profilo.
- Registrazione corrente con email, nickname e password; provisioning della demo descritto come automatico. Non ridisegnare come email-only/passwordless.
- Demo intesa come privata: il responsabile ha chiesto verifica e correzione prima di prometterla. Il prototipo può mostrare la destinazione demo, ma il rilascio della label “privata” dipende dalla verifica/chiusura API di accesso anonimo per ID.
- Wizard autenticato per creare una partita, un canale e squadre, con soli dati necessari; deve restare distinto dalla partita demo già predisposta.
- Navigazione mobile preferita: **Home · Partite · Crea · Profilo**. Radio si apre dal match; canali dalla Home e dai contesti. Team, statistiche e feedback restano raggiungibili ma non sono tab primarie.
- TWA: splash breve distinto dalla landing web; dopo splash contenuto pubblico per anonimi e dashboard operativa per autenticati. Non ripetere splash ai ritorni e rispettare deep link.
- Errore di lettura parziale: messaggio generico “Al momento non è possibile recuperare le informazioni”, separato dallo stato regolarmente vuoto. Non simulare un errore di tutta l’app quando fallisce un solo mock.
- La validazione con persone/dispositivi è rinviata a prototipo completo.

Fonti di approvazione: `docs/projects/layout-2026/qa/Q&A - 03.md`, `docs/projects/layout-2026/qa/02-assessment.md` e registro `docs/projects/layout-2026/Decisions.md`. Le scelte indicate come esperte in `qa/02-home-and-trial-recommendation.md`, `qa/03-navigation-and-twa-recommendation.md` e `qa/05-auth-and-intent-recommendation.md` sono state approvate in Q&A 03; le dipendenze API qui sotto restano vincoli tecnici.

## Mappa dei percorsi principali

```text
Anonimo web mobile/desktop
  Home anonima → Prova la telecronaca → Registrazione → Onboarding demo
    → Dashboard nuova → Apri partita demo → Avvia → Registra evento
    → risultato testuale / ascolto
  Home anonima → Esplora → Partite / Canali → Match / Radio / Team / Stats
    → login contestuale solo per azione personale protetta

Autenticato nuovo
  Home / TWA splash al primo avvio → Dashboard nuova
    → demo pronta → match editor → avvio → primo evento → risultato
    → Crea partita reale (wizard)

Autenticato attivo
  Home dashboard → continua partita attiva oppure Crea
    → wizard 5 passaggi → editor → Live / Events / Formazioni / Stats / Share
  Home → Partite / Canali → pagine pubbliche
  Profilo → preferiti / profilo / canali e impostazioni account

TWA al riavvio
  sessione anonima → Home TWA anonima senza splash
  sessione attiva → Dashboard senza splash
  URL profonda presente → destinazione richiesta, con ritorno navigabile
```

## Schermate e stati

La colonna “route riferimento” indica solo route che esistono in `src/RugbyRadioWeb/src/app/app.routes.ts`. “Schermata prototipo” è un frame/variante visuale e non autorizza a introdurre una route nuova nell’app reale.

| ID / schermata prototipo | Route di riferimento | Stato e contenuto da simulare | Varianti |
|---|---|---|---|
| **P01 Home anonima** | `/` | Hero breve: cos’è RRL; CTA primaria “Prova la telecronaca”; secondaria “Esplora partite e radio”; anteprima concreta partita/canale. Se non ci sono match live, omettere solo il blocco live e mostrare storico partite/canali. Stati feed: caricamento, risultati, vuoto valido, errore con messaggio generico approvato. | Desktop: hero con contenuti a fianco/sotto; mobile: CTA e primo esempio in alto. Web mobile mostra contesto introduttivo; TWA mantiene solo spiegazione essenziale e contenuti. |
| **P02 Login** | `/user-login` | Form email/password, accesso Google se nel flusso corrente; link registrazione/reset; eventuale motivo del login se proveniente da follow/reazione/altro intento. Stato invalid, submitting, errore login. | Desktop card centrale; mobile form a colonna. Rientro a route/tab/oggetto quando il callback supporta l’intento. |
| **P03 Registrazione** | `/user-registration` | Form corrente email, nickname, password; consenso/validazioni esistenti; testo “Crea un account per iniziare la prova” e spiegazione breve del provisioning demo. Stati editing, validation, submitting, error, success. Non rappresentare email-only. | Success va a onboarding/dashboard; errore del provisioning parziale non deve invitare a un retry cieco. |
| **P04 Onboarding prova demo** | Schermata/variante post-signup; route esistente di destinazione `/user-dashboard` (nessuna nuova route) | Conferma che è stata preparata una partita demo; 3 azioni: apri, avvia, registra un evento; CTA “Apri partita di prova”. Non introdurre dati dimostrativi/eventi precompilati. La label “Privata/solo per te” resta condizionata alla correzione API; in prototipo aggiungere nota interna di blocco privacy. | Overlay/card nella dashboard, non onboarding obbligatorio ripetibile. Versione TWA può omettere il testo di presentazione già visto nello store. |
| **P05 Dashboard nuova** | `/user-dashboard` (auth guard) | Card demo in testa: partita pronta, indicazione non pubblica solo se la policy è verificata, pulsante apri; successivamente attività recenti e Crea partita. Stati lookup demo: loading, disponibile, assente/errore con messaggio generico e azione utile/contattare supporto secondo flow concordato. Non lasciare CTA inerte. | Desktop: card ampia con passi e stato; mobile: CTA demo sopra scorciatoie. TWA autenticato atterra qui dopo splash e ai riavvii. |
| **P06 Dashboard attiva** | `/user-dashboard` | Senza contenuti marketing. Gerarchia per stato dati: partita live gestita → “Continua”; altrimenti “Crea partita”; poi prossime/recenti, canali posseduti/seguiti, preferiti e dati profilo/statistiche. Nessun selettore cronista/spettatore obbligatorio. Stati loading, dati, vuoto valido ed errore per ciascuna sezione. | Desktop più colonne; mobile lista verticale. Non simulare attività senza fixture dichiarate. |
| **P07 Lista partite** | `/g-matches` | Ricerca, risultati/paginazione, card match con info restituite dal modello; selezione apre match pubblico. Stati loading, risultati, nessun risultato, errore locale con testo approvato. | Responsive lista/card. Filtri e sorting soltanto se già supportati dal client/API o annotati come dependency. |
| **P08 Lista canali** | `/g-channels` | Catalogo canali e ricerca/paginazione correnti; CTA dalla Home “Tutti i canali”. Stati loading, risultati, nessun risultato, errore. Non mostrare la demo test nel catalogo pubblico. | Desktop griglia/lista; mobile card. L’autorizzazione demo non va dedotta dal fatto che è esclusa dalla ricerca. |
| **P09 Dettaglio canale** | `/g-channel/:channelPublicId` | Titolo/intestazione, radio/partite/squadre/share e link a match/team quando presenti. Stato anonimo e autenticato; follow protetto segue proposta di login contestuale. Loading, dati, errore. | Da canali o deep link; mobile mantiene ritorno al catalogo. |
| **P10 Dettaglio squadra** | `/g-team/:teamId` | Dettaglio pubblico della squadra e partite collegate soltanto secondo i dati del template/API corrente; ritorni a match/canale. Loading, dati, vuoto legittimo, errore. | Collegamento dal nome squadra su match/canale; mai tab primaria. |
| **P11 Statistiche pubbliche** | `/g-stats` | Metriche aggregate e breakdown eventi esistenti; evitare metriche inventate. Stati loading, dati, errore e no events. | Menu secondario “Altro” e link contestuali da match/team se il componente già lo consente. |
| **P12 Feedback** | `/g-feedback` | Form feedback, campi e validazioni del template reale; stato anonimo/autenticato solo se il codice lo distingue. Stato editing/submitting/success/error. | Menu supporto/footer. La presentazione visuale non implica autenticazione senza prova. |
| **P13 Match pubblico: cronaca** | `/g-match/:matchId` | Contesto match (squadre, stato, punteggio disponibili), tab Events/Lineup/Stats/Share; feed e selettore Leggi/Ascolta. Stato programmata/live/intervallo/fine, loading, errore. Rende lettura anonima. | Desktop tab orizzontali; mobile tab/controls accessibili senza perdere contesto. Per eventi che richiedono login, usare CTA contestuale; policy esatta secondo P05-auth below. |
| **P14 Match pubblico: ascolto radio** | `/g-radio/:matchId` | Player esistente: stato, play/pause/resume/stop, “dal principio”, dati match e link torna al match. Stati idle/loadingAudio/playing/paused/stopped/error; non confondere errore audio con login. | Pagina profonda/condivisibile, raggiunta da “Ascolta” nel match e da link diretto. PWA/TWA compatibile in layout, runtime audio non simulare come garanzia. |
| **P15 Wizard Crea — introduzione** | Drawer/modal globale, nessuna route dedicata; accesso da nav Crea autenticata | Spiega che crea una partita reale; distinta dalla prova già predisposta. Indica i dati obbligatori e cosa sarà configurabile più tardi. | Desktop drawer/dialog; mobile bottom sheet/fullscreen per tastiera e spazio. |
| **P16 Wizard Crea — dati** | Nessuna route dedicata | Passi correnti: 1 canale (scegli/crea), 2 squadra casa (scegli/crea), 3 squadra ospite (scegli/crea), 4 giorno, 5 riepilogo/conferma. Stepper, validazioni e progress; distingue il canale test e impedisce riuso accidentale senza scelta deliberata. | Desktop drawer; mobile un passo per schermata. Errori locali e preservazione campi; niente retry automatico del POST. Il flag test manca nel DTO: mock badge solo come fixture e bloccare mapping reale finché API reviewer non chiarisce. |
| **P17 Wizard Crea — esito** | Avvio editor su `/user-match/:matchId` dopo creazione; nessuna route esito nuova | Conferma creazione, prossima azione “Apri partita e avvia quando pronta”; errore POST inline generico, campi preservati, retry manuale dopo aver chiarito idempotenza/duplicati. | Mobile dialog/confirmation compatta; desktop drawer. |
| **P18 Editor cronista: preparazione** | `/user-match/:matchId` | Match scheduled: contesto, tab Live/Events/Lineup/Stats/Share; azione avvio e drawer con campi correnti. Indicare progress demo all’utente nuovo e cosa fare per iniziare. Stati dati e errore. | Desktop layout editor; mobile azioni primarie visibili e disposte per tap, drawer gestisce tastiera/safe area. |
| **P19 Editor cronista: Live** | `/user-match/:matchId` | Match live/halftime: stato/fase, tempo, azioni evento esistenti (primarie/avanzate/falli), feedback di invio, accesso correzione solo se dominio lo consente, intervallo/secondo tempo. Stati invio/loading/success/error senza azione duplicata automatica. | Mobile portrait: layout denso ma controlli primari raggiungibili, scroll e stati chiaramente distinti. Desktop: pannello live e contenuto in colonne. Prima di simulare reachability reale serve test device (rinviato a fase di validazione). |
| **P20 Editor cronista: post-live** | `/user-match/:matchId` | Full time: Live non disponibile come tab attiva secondo stato attuale; mostra Events/risultato e accessi a formazione/stats/share. CTA torna dashboard o crea altra partita. | Desktop/mobile; non presentare controlli live dopo conclusione. |
| **P21 Profilo e area account** | `/user-profile`; link a `/user-favorites`, `/user-channels`, `/user-channel/:channelId`, `/user-danger` | Account, preferiti e gestione canali come sottopercorsi; logout e area pericolosa distinta/conferma. Stati loading/data/error e protetto. | Accesso dalla quarta voce Profilo e menu; dettagli di gestione non fanno parte dei quattro tab principali. |
| **P22 Splash TWA** | Condizione shell/home, nessuna route | Splash breve distinta dalla home marketing web. Stato primo avvio/preferenza; azione continua. Al ritorno soppressa. Non bloccare i deep link interni dopo la chiusura. | TWA anonima e autenticata usa stessa splash sintetica; il contenuto post-splash cambia per sessione. |
| **P23 TWA anonima post-splash** | `/` o deep link richiesto | Home compatta content-first, esempi e CTA accedi/registrati, links partite/canali. Avvio successivo uguale senza splash. | Portrait come target dichiarato dal manifest; prototipo può mostrare desktop/mobile web separatamente senza asserire comportamento runtime TWA. |
| **P24 TWA autenticata post-splash** | `/user-dashboard` | Dashboard nuova o attiva secondo stato demo/attività. Nessun marketing; shortcut prova e Crea. Riavvio autenticato rientra qui senza splash, salvo URL profonda richiesta. | Ritratto TWA; barra mobile Home/Partite/Crea/Profilo. |

### Componenti comuni da simulare

- **App shell:** topbar/brand, menu secondario, indicatore sessione, lingua, navigazione responsive; barra mobile autenticata a quattro voci; comportamento header/back sui dettagli.
- **Page header:** titolo, sottotitolo, immagine/media, azioni contestuali.
- **CTA e pulsanti:** primario/secondario/terziario, disabled, loading, focus/pressed; conferme separate da azioni immediate.
- **Card entità:** partita, canale, squadra; badge stato e privacy solo se il modello lo certifica; apertura dettagli e azioni.
- **Tabs e contesto match:** stato partita stabile sopra le viste Events/Lineup/Stats/Share; stato selezionato e ritorno.
- **Player radio:** stati audio distinti e modalità text/listen; errore audio; no autoplay non richiesto.
- **Form:** input/validazione/help/error, password show/hide, stepper wizard, select record esistente/crea nuovo, calendario/data.
- **Feedback di sistema:** skeleton/loading; empty state valido; errore locale con messaggio approvato “Al momento non è possibile recuperare le informazioni”; retry solo per letture; success toast/banner; error di scrittura vicino all’azione con campi preservati.
- **Overlay:** drawer/dsheet/modal, backdrop, close/back, safe-area e viewport tastiera; demo onboarding integrato, non wizard separato.
- **Navigazione secondaria:** links Canali, Team, Stats, Feedback, Help, preferiti e gestione account.
- **Responsive:** desktop, smartphone web, TWA portrait; definire almeno varianti viewport stretto e altezza corta per wizard/live. Non asserire collaudo accessibilità o device in assenza di test.

## Dati mock e mapping API

Usare un adapter mock per lo stesso contratto consumato dai componenti, non introdurre URL mock nell’interfaccia o simulare endpoint futuri. Le voci endpoint seguenti sono route trovate negli attributi del controller; il mapping preciso di params/DTO deve seguire il service FE/wiki e, dove indicato, il reviewer API. Tutti gli endpoint sono versionati `/v1/...` secondo attributi controller.

| Flusso prototipo | Dati mock necessari | Endpoint sorgente noto | Stato mapping / reviewer API |
|---|---|---|---|
| Login/registrazione | token/sessione, user profile; esito provisioning test | `POST /v1/auth/user/login` (ATH-03), `POST /v1/auth/users` (ATH-01) | Confermare payload, risposta errori e caso provisioning parziale. UI corrente richiede email/nickname/password. |
| Demo account nuovo | partita e channel test dell’utente corrente | `GET /v1/channels/matches/training` (MTC-19) | Richiede auth. Confermare DTO e lookup/assenza/errori. Privacy pubblica per ID è blocker dichiarato in Q&A 03. |
| Dashboard | profilo, canali, partite, match test | `GET /v1/user` (USR-02), `GET /v1/channels` (CHL-01), `GET /v1/channels/matches/training` (MTC-19), ricerche match | Esistono route candidate. Reviewer confermi mapping per card dashboard e ordinamento/status query. Non inventare endpoint dashboard aggregato. |
| Home anonima / partite | ongoing e storico/lista pubblica | `GET /v1/matches/ongoing` (MTC-14), `GET /v1/matches/public/search` (MTC-11) | Ongoing route nota; filtri e ordinamento dello storico/next vanno confermati in FE service/API. Empty live → sezione omessa; GET error → messaggio locale. |
| Home anonima / canali | elenco/search canali pubblici | `GET /v1/channels/public/search` (CHL-11) | Confermare query, paginazione, ordinamento e DTO. Non includere canale test. |
| Lista dettagli partita | match + eventuale blog | `GET /v1/matches/public/search` (MTC-11), `GET /v1/matches/{matchId}` (MTC-02), `GET /v1/blog/matches/{matchId}` (BLOG-02) | Rivedere accesso anonimo MTC-02 e filtraggio demo per ID prima di usare dati demo nel mock pubblico. Blog dipendenza se incluso nella schermata. |
| Radio playback | match, stato player, voci/audio evento | Dati match: `GET /v1/matches/{matchId}` (MTC-02). Voci: `GET /v1/voices` (VOICE-01), `GET /v1/voices/events` (VOICE-02). | Route per recupero/streaming file audio non identificate dagli attributi qui censiti. API reviewer deve fornire il mapping dell’audio TTS e dei media evento. Il prototipo può mostrare stati player simulati, etichettati come mock. |
| Dettaglio canale | canale pubblico, match associati, team | `GET /v1/channels/public/{publicId}` (CHL-10); lista match `GET /v1/channels/{channelId}/matches` (MTC-01) | Confermare publicId vs channelId e accesso anonimo; API pubblico channel carica relazioni? Reviewer chiarisca per non assumere chiamate non necessarie. |
| Team | dettaglio squadra, eventuali match | `GET /v1/teams/{teamId}` (TMS-06), `GET /v1/teams/{teamId}/matches/search` (MTC-18) | Confermare campi e filtri; non mockare statistiche team non offerte. |
| Stats | aggregati pubblici / breakdown eventi | `GET /v1/stats` (STS-01) | Confermare schema, eventuali query params e ambito statistico. |
| Feedback | form fields / esito invio | `POST /v1/user/feedback` (USR-07) | Reviewer confermi se anonimo è ammesso, payload e validazione. Nessun endpoint inventato. |
| Wizard create | channels/teams selezionabili e risultato match | `GET /v1/channels` (CHL-01); teams `GET /v1/channels/{channelId}/teams` (TMS-01) o `GET /v1/teams` (TMS-05); `POST /v1/matches` (MTC-17) quick create | Confermare contratto per canale/team nuovi e campi obbligatori; il DTO canale non espone `IsTestChannel`, rendendo il badge/filtraggio una dipendenza API. Non inserire mock endpoint alternativi. Scrittura composta: no retry automatico finché idempotenza/rollback sconosciuti. |
| Editor cronista | match stato, eventi, roster/lineup, stats | `GET /v1/matches/{matchId}` (MTC-02); `PUT /v1/matches/{matchId}/status` (MTC-08); `PUT /v1/matches/{matchId}/stats` (MTC-04); lineup `POST/PUT/DELETE /v1/channels/{channelId}/matches/{matchId}/lineups/{lineupId}` (LNP-04/05/06) | L’API reviewer deve mappare “aggiungi evento” e caricamento feed completo: i route match/reactions/comments esistenti non dimostrano da soli il contratto degli eventi. Verificare ownership/autorizzazione su tutte le scritture. |
| Interazioni match | like/follow/rating/comment/reaction | MTC-05 reaction, MTC-06 comment POST, MTC-12 rating, MTC-13 like, MTC-15 follow, MTC-16 notification | Policy esatta per anonimo/auth e limiti resta da confermare dal reviewer API; non attivare azioni simulate come se fossero consentite. Login callback conserva intento come raccomandazione approvata, contract FE/backend da mappare. |
| Profilo/preferiti/canali gestiti | user, own channels, favorites | `GET /v1/user` (USR-02); `GET /v1/channels` (CHL-01); `GET /v1/channels/favorites` (CHL-07) | Confermare ownership e route mutative prima di simulare edit. |

**Nota mock:** le schermate possono simulare stati realistici con fixture locali (esempio `demoAvailable`, `demoLookupError`, `noLiveMatches`, `matchesLoadError`) purché non vengano presentati come campi DTO o query string dell’API. Separare almeno `success-empty` da `error`; non far sparire una sezione per il solo errore mock. Stato di “privato” deve essere accompagnato internamente dall’annotazione “non distribuire copy privacy finché il reviewer API non chiude Q&A 03”.

## Matrice di varianti desktop/mobile/TWA

| Area | Desktop | Smartphone web/PWA | TWA |
|---|---|---|---|
| Home anonima | Proposta e due CTA accanto/prima dei feed; link chiari a tutte le liste | Hero corto, prova cronista prominente, un esempio pubblico subito raggiungibile; accessi catalogo facili | Splash breve solo quando previsto; dopo, versione content-first, testo promozionale minimo, nessuno splash ai successivi avvii |
| Dashboard | Widget attività e card demo/azione primaria, griglia | Una colonna; trial/create precedono statistiche | Come mobile; profilo anonimo/auth decide contenuto post-splash |
| Public lists/details | Tabella/griglia, panel contestuali | Card, filtri non affollati, back persistente | Stessi percorsi pubblici, deep link preservati |
| Wizard | Drawer laterale con riepilogo disponibile | Sheet/fullscreen, step uno alla volta, tastiera non copre CTA | Stesso wizard mobile; dipendenze sessione/API come web |
| Cronista editor | Controlli e contesto in layout ampio | Live prioritaria, target e stati chiari, niente tab globale sopra i controlli | Layout portrait target; audio/sessione restano da verificare sul dispositivo |
| Error/empty | Stato localizzato nella sezione | Stesso messaggio comprensibile e retry per letture recuperabili | Stesso stato; non assumere outage globale |

## Dipendenze per API reviewer (da allegare al prototipo)

1. Privacy/accesso anonimo al match e canale test per ID conosciuto; estendere verifica a squadre, eventi e media. Q&A 03 ha chiesto espressamente di verificarlo e correggerlo. La copy “privato” è bloccata finché non chiuso.
2. Provisioning registration: risposta quando utente esiste ma creazione canale demo fallisce; nessun retry cieco né account duplicato.
3. Flag/identificazione canale test in DTO e selezione wizard; il FE attuale non può affidarsi con sicurezza al nome “Training Channel”.
4. Contratto dei feed Home: storico, prossimo, ongoing, query/errori, ordinamento e paginazione.
5. Mapping endpoint e DTO dell’audio TTS (URL/file streaming), eventi match e radio queue.
6. Matrice per autorizzazione di commenti, reazioni, rating, like, follow e notifiche; confermare il ritorno al contesto dopo login.
7. Feedback: accesso anonimo e payload.
8. Operazioni quick-create: campi minimi, errori, atomicità/idempotenza per evitare duplicati al retry.
9. Dati aggregati stats e contenuti/relazioni disponibili nella route canale/team.

Questi sono dubbi di mapping/contratto destinati al reviewer API; non richiedono un altro questionario stakeholder e non sono nuove route proposte.

## Fuori scopo e limiti

- Nessun codice o mock endpoint creato; nessuna route nuova inferita.
- Nessuna promessa tecnica sulla privacy demo, accesso in TWA, riproduzione audio background o persistenza splash senza verifica runtime/backend.
- Il numero cinque dei passaggi wizard riproduce il frontend verificato, mentre il Q&A esprime l’intento di renderlo rapido e limitato ai campi necessari; il prototipo può organizzare i cinque passaggi in una sequenza visuale compatta senza alterare il payload.
- La mappa usa route/controller correnti come riferimenti. Il reviewer API deve confermare esatte response DTO, parametri e stati d’errore. In particolare, alcuni metodi hanno attributi noti ma non è stato ricostruito ogni mapping FE→API.
- La directory `src/RugbyRadioLayout2026` risultava vuota. Stack, router interno e approccio ai mock vanno letti dai file di progetto quando lo scaffold sarà presente; questa specifica non crea struttura di codice.
