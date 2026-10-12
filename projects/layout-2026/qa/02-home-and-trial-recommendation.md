# Home, registrazione e prova cronista — raccomandazione

## Scopo

Tradurre le risposte del responsabile in `docs/Q&A - 02.md` in una direzione concreta per la home anonima, la dashboard autenticata e il percorso di prova del cronista. Le risposte sono trattate come input prodotto; il comportamento corrente è riportato separatamente dal codice. Non è necessario attendere altre risposte per proporre una soluzione.

## Input dal Q&A

Il responsabile indica che:

- una nuova registrazione deve predisporre automaticamente un canale di test non pubblico;
- la home deve mostrare un'etichetta e un pulsante che rendano evidente la possibilità di fare prove;
- per creare una partita senza conoscere l'ordine dei passaggi, il wizard deve permettere agli utenti autenticati di creare in pochi passaggi un canale, due squadre e una partita, richiedendo i soli campi obbligatori e lasciando le rifiniture successive;
- restano da proporre la policy delle interazioni autenticate, la gerarchia fra scoperta e prova cronista e il comportamento delle superfici pubbliche. Non sono state specificate metriche.

Le risposte di `docs/projects/layout-2026/qa/Q&A - 01.md` completano il quadro: home differenziata per stato di accesso, anonimi informati e invitati a provare, autenticati orientati all'operatività senza marketing; per gli anonimi, esempi di partite reali; per il TWA uno splash diverso perché l'utente ha già visto la presentazione sullo store. La preferenza di profilo “cronista/spettatore” era espressa come possibilità, non come decisione. La valutazione è in `docs/projects/layout-2026/qa/01-assessment.md`.

## Fatti verificati nel codice

**Registrazione e creazione del canale demo**

- Il form frontend in `src/RugbyRadioWeb/src/app/user/registration/registration.component.ts` richiede nickname, email valida e password (6–20 caratteri); `user.service.ts` invia email, password, nickname e lingua a `POST /v1/auth/users`.
- In `src/RugbyRadio/Api/Controllers/AuthV1Controller.cs`, `Register` crea utente e token, poi invoca `WizardFastAddChannelAsync(..., true)` prima di restituire il token. Crea “Training Channel”, “Blue Sharks”, “Red Lions” e una partita per la data corrente. Il ramo Google crea allo stesso modo canale e partita.
- `src/RugbyRadio/Lib/Services/RugbyRadioLiveService.cs` imposta `IsTestChannel = true`, crea le squadre e la partita e inizializza le formazioni. Il metodo evita di creare un secondo canale test già presente.
- L'endpoint `GET /v1/channels/matches/training` è protetto da `[Authorize]` in `src/RugbyRadio/Api/Controllers/MatchesV1Controller.cs` e carica le partite test dell'utente corrente.
- La pagina di registrazione, al successo, va a `/user-dashboard` (`registration.component.ts`). Non mostra una conferma dedicata che il canale test è pronto.

**Dashboard e prova cronista**

- `src/RugbyRadioWeb/src/app/site/home/home-user/home-user.component.html` mostra già una sezione “inizia la tua esperienza” e un pulsante “Apri partita di esempio”, ma solo se `profile.channels === 1`, `followChannels === 0` e il flag locale `hide_tips_get_started` non è attivo.
- `home-user.component.ts` chiede il match di training solo quando il suggerimento è visibile. Il click apre `/user-match/:id` e imposta `rrl_training_active` e `rrl_training_match_id` nel localStorage. Il testo italiano in `assets/i18n/it.json` spiega che radio e partite sono visibili solo all'utente.
- Nella partita demo ancora programmata, `match-events.component.html` mostra il comando per avviare la telecronaca. Dopo l'avvio appaiono le azioni principali di cronaca. Il componente registra eventi di analytics specifici per la prova.

**Wizard per la creazione rapida**

- `src/RugbyRadioWeb/src/app/common/match-create/match-create.component.html/.ts` implementa un drawer a cinque passaggi: canale, squadra in casa, squadra ospite, data e riepilogo. Per canale e squadre offre la scelta tra record esistenti e nuovi; al completamento chiama `MatchService.addQuickMatch` (`src/app/services/match.service.ts`) e apre la partita creata.
- Il wizard è montato in `AppComponent` ed è apribile dalla voce “Crea” della bottom navigation; è anche incorporato in `HomeUserComponent`. La bottom navigation è mostrata solo agli utenti autenticati (`entity-bottom-nav.component.html`). Il wizard non chiede descrizione, colori, rosa giocatori o altri dettagli di configurazione; questi possono essere aggiunti successivamente.
- La wiki `docs/wiki/frontend/web/components/MatchCreateComponent (web).md` parla di tre step e non riporta la scelta di elementi nuovi né la data. Il codice corrente ne implementa cinque: prevale il comportamento verificato nel codice e la wiki va aggiornata a parte.

**Privacy e accesso pubblico: verifica critica**

- Il canale di test è escluso dalla ricerca pubblica in `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelRepository.cs` e dai candidati sitemap in `HF/Services/SeoUrlInventoryService.cs`. Le ricerche pubbliche match escludono le partite di canali test in `Lib/Repositories/MatchBox/MatchRepository.cs`.
- Tuttavia, `GET /v1/matches/{matchId}` in `Api/Controllers/MatchesV1Controller.cs` è `[AllowAnonymous]` e chiama `GetMatchAsync`; `Lib/Repositories/MatchBox/MatchService.cs` carica la partita per ID senza un controllo visibile su `IsTestChannel` o sul proprietario prima di restituire i dati. Perciò codice esaminato prova l'esclusione da liste e sitemap, ma **non prova che un match test non sia leggibile a chi possiede l'URL/ID**. L'etichetta “privato / visibile solo a te” non deve essere trattata come garanzia tecnica finché non viene chiuso questo controllo.
- Il DTO frontend `channelDto` in `src/RugbyRadioWeb/src/app/dto/channelDto.ts` non espone `IsTestChannel`. Il quick create carica i canali utente e, se la lista non è vuota, inizializza la scelta su “canale esistente” (`match-create.component.ts`). Un account appena creato può quindi avere il Training Channel preselezionato come contenitore per una nuova partita, senza che il wizard distingua visivamente l'uso test da quello reale.

## Raccomandazione di esperienza

### 1. Home anonima: presentare RRL e offrire due ingressi chiari

Conservare una home mista, breve e orientata all'azione:

1. **Hero**: una frase concreta su cosa fa RRL, senza introdurre una scelta di ruolo obbligatoria.
2. **CTA primaria — “Crea un account e prova a raccontare”**: porta alla registrazione email, spiega nella stessa area che dopo la creazione account è disponibile una prova privata. La registrazione deve essere qualificata come email e password finché il form resta quello attuale.
3. **CTA secondaria — “Esplora partite e radio”**: porta ai contenuti pubblici o direttamente alle liste pubbliche. Un esempio di partita visibile subito dopo il hero rende tangibile il prodotto senza account.
4. **Sezione di prova**: tre passaggi visivi, “crea account → apri la partita demo privata → registra un'azione e ascolta/leggi il commento”, con un esempio breve di risultato. Segnalare che la prova non pubblica contenuti.
5. **Contenuti pubblici e spiegazioni**: mostrare partite/canali reali, con link a liste e dettagli; tenere i blocchi marketing più estesi, tutorial e FAQ sotto queste azioni principali.

Ordine da mobile: CTA e promessa di prova nel primo viewport; esempio reale immediatamente raggiungibile con una sola breve scrollata; nessun interstitial obbligatorio prima dell'esplorazione. Lo splash installato TWA può restare snello e distinto come già orientato dal Q&A 01.

### 2. Dopo la registrazione: confermare la prova pronta

Il successo della registrazione deve portare direttamente alla dashboard autenticata con una card prominente, prima delle statistiche o di qualsiasi invito a creare una radio pubblica:

**Badge:** `Canale di prova · Privato`

**Testo:** “Abbiamo preparato una partita di esempio. Prova a raccontare un'azione: puoi creare la tua radio pubblica più tardi.”

**Pulsante:** `Apri la partita di prova`

La card deve apparire in base al fatto che il Training Channel/partita esiste, non al conteggio `channels === 1`: un conteggio è un proxy e smette di funzionare appena l'utente aggiunge o segue una radio. Mantenerla disponibile fino al primo evento di prova completato o a una scelta esplicita di chiuderla; non nasconderla solo perché l'utente ha un canale seguito. Dopo la prova, sostituire l'invito con una singola azione successiva, `Crea la tua radio`, e lasciare il collegamento al canale demo nel contesto Radio/Partite di prova.

Il pulsante deve aprire il match esistente dell'utente, aggiungendo un piccolo orientamento iniziale alla tab che permette di avviare la partita. Il match demo è datato al giorno della creazione account, ma parte in stato programmato: il primo passo per la cronaca è avviarlo, quindi l'invito deve essere esplicito (“avvia la partita demo”); dopo l'avvio, evidenziare una sola azione semplice per registrare il primo evento.

### 3. Journey minimo del cronista

```text
Home anonima
  → Crea account (email + password nel contratto UI corrente)
  → Dashboard: conferma “Canale di prova privato pronto”
  → Apri partita demo
  → Avvia la partita
  → Aggiungi un evento semplice
  → Leggi/ascolta il risultato della telecronaca
  → Crea una radio reale oppure torna a esplorare
```

Se la registrazione è già avvenuta, tutte le entrate “Prova a raccontare” devono saltare alla dashboard e aprire o mettere in evidenza direttamente la card demo. Se la chiamata alla partita demo non trova contenuto, non lasciare un CTA morto: mostrare un messaggio operativo e la possibilità di ricaricare/contattare supporto, rispettando la regola Q&A di considerare l'applicazione indisponibile quando il servizio centrale fallisce.

### 4. Wizard rapido: un percorso operativo distinto dalla demo

Mantenere “Crea” come azione persistente della navigazione autenticata e usare il wizard esistente per chi vuole predisporre una partita reale o un'altra partita. La schermata introduttiva deve chiarire che il wizard crea una partita e consente di creare le entità mancanti, senza chiedere le configurazioni facoltative. Le fasi raccomandate, compatibili con i campi correnti, sono:

1. scegli o crea una radio;
2. scegli o crea la squadra di casa;
3. scegli o crea la squadra ospite;
4. imposta il giorno;
5. controlla il riepilogo e crea la partita.

Rinominare visivamente “Training Channel” in `Canale di prova · Privato` nelle liste di creazione, oppure rimuoverlo dalla selezione standard e offrire “Usa canale di prova” come scelta deliberata. Per account che possiedono solo il canale test, pre-selezionare la creazione di una nuova radio quando l'intento del wizard è creare la propria partita, con una scelta esplicita per riusare la radio test. L'interfaccia deve distinguere i record creati in questo flusso da un risultato pubblico: il wizard attuale crea un match programmato, non avvia la cronaca.

Il completamento del wizard deve atterrare sulla partita nuova e indicare il passo successivo, `Avvia partita`, anziché terminare con un generico successo. La demo resta un'opzione separata e senza rischio di rendere pubblica una prova.

### 5. Gerarchia della dashboard autenticata

Priorità suggerita, dall'alto:

1. orientamento e stato (saluto compatto, radio attiva/numero partite o invito demo per nuovo utente);
2. azione primaria di contesto: `Continua la prova` per account nuovi, `Crea partita` per chi ha già una radio, oppure `Apri partita live` quando ne sta gestendo una;
3. prossime partite/partite recenti e radio possedute, in base all'attività;
4. radio seguite e partite da seguire per il profilo spettatore;
5. statistiche e gestione profilo come informazioni secondarie.

Non introdurre adesso un'impostazione persistente “cronista/spettatore”: il responsabile l'ha menzionata come possibilità e non come decisione. Si può adattare l'ordine usando stato reale (es. account appena creato, radio possedute, follow, partita in corso), senza etichettare l'utente con un ruolo immutabile. La home autenticata non deve riproporre blocchi marketing della home anonima.

## Contenuto minimo per rendere la demo comprensibile

Perché un account nuovo capisca cosa deve fare e riceva un risultato evidente, il canale test dovrebbe contenere:

- nome distinto e badge privato, non confondibile con una radio pubblica;
- una partita demo già associata a due squadre con nomi comprensibili;
- data valida e stato iniziale che consenta di avviare la prova;
- formazioni o almeno i controlli minimi già predisposti, senza obbligare a compilare rose;
- istruzione breve sui primi tre gesti: avvia, registra un evento, leggi/ascolta il commento;
- almeno una dimostrazione del risultato atteso dopo l'evento: commento testuale e disponibilità audio dove prevista dal modello prodotto;
- CTA successiva separata: `Crea la tua radio` quando l'utente ha capito il ciclo.

Il codice attuale crea canale, due squadre, partita e formazioni inizializzate, ma non popola un evento dimostrativo: lo user deve avviare la partita e aggiungere un evento per vedere il risultato. La proposta è mantenere la prova attiva e aggiungere una micro-istruzione con feedback sul primo evento, non simulare attività o introdurre dati falsi non richiesti.

## Dipendenze che bloccano una consegna affidabile

1. **Privacy effettiva della prova — bloccante.** Prima di promuovere “privato / visibile solo a te”, il backend deve impedire che gli endpoint anonimi leggano i match/canali di test tramite ID noto, oppure deve essere dimostrato con test d'accesso che la risposta escluda tali record. Le liste e sitemap escludono i test, ma `GET /matches/{id}` risulta anonimo e non mostra il filtro. Questa è una dipendenza API/permessi, non una rifinitura grafica.
2. **Significato di “registrazione semplicemente con una email” — blocca solo se letterale.** Il form/API oggi richiede email, password e nickname. La raccomandazione è interpretarlo come “crea un account con email, senza configurare manualmente canale/squadre/partita” e mantenere il contratto auth attuale. Se il requisito è una registrazione a un solo campo email o passwordless, la schermata e il contratto backend di autenticazione/identità devono cambiare prima del relativo CTA.
3. **Riconoscimento del canale test nel wizard — bloccante solo per l'esperienza senza ambiguità proposta.** `channelDto` non espone il flag test e il wizard può preselezionare il canale esistente. Prima di distinguere il test nella scelta canale, esporre `isTestChannel` nel DTO oppure identificare il canale test tramite il match restituito dall'endpoint autenticato. Non blocca un wizard generico, ma blocca una selezione sicura e chiaramente etichettata.

La verifica della resa SEO/analytics, dei dispositivi e dei copy tradotti migliora la qualità ma non impedisce di implementare questa gerarchia. Il sistema ha già route, API e componenti per la prova e il quick create; le verifiche residue vanno portate nel normale piano di consegna.

## Sintesi decisionale

- **Anonimo:** breve promessa di prodotto, CTA primaria verso registrazione/prova cronista, CTA secondaria verso contenuti pubblici concreti. Niente richiesta di scegliere un profilo.
- **Autenticato nuovo:** dashboard operativa con badge e pulsante per la partita privata; accompagnamento fino al primo evento riuscito.
- **Autenticato attivo:** “Crea”/wizard per creare radio, squadre e partita in cinque passaggi o continuare l'attività; contenuti marketing rimossi.
- **Privacy:** non pubblicizzare la prova come privata finché l'accesso anonimo al match noto per ID non è escluso in backend.
- **Registrazione:** riusare il flusso email attuale (email, password, nickname) interpretando “semplice” come nessuna configurazione manuale di entità; introdurre email-only solo con un'esplicita modifica di contratto e identità.

## Fonti puntuali

- Responsabile prodotto: `docs/Q&A - 02.md`; contesto complementare: `docs/projects/layout-2026/qa/Q&A - 01.md` e `01-assessment.md`.
- Wiki: `docs/wiki/frontend/web/components/MatchCreateComponent (web).md`, `docs/wiki/frontend/web/pages/HomePage (web).md`, `docs/wiki/backend/api/apis/AuthV1Controller (api).md`, `docs/wiki/backend/api/jobs/CreateTrainingChannelJob (api).md`.
- Frontend: `src/RugbyRadioWeb/src/app/user/registration/registration.component.ts`; `src/app/site/home/home-user/home-user.component.ts/.html`; `src/app/common/match-create/match-create.component.ts/.html`; `src/app/app.component.ts/.html`; `src/app/common/entity-bottom-nav/entity-bottom-nav.component.html`; `src/app/dto/channelDto.ts`; `src/app/user/match/match-events/match-events.component.html`; `src/app/user/match/match-live/match-live.component.html`; `src/assets/i18n/it.json`.
- API/servizi: `src/RugbyRadio/Api/Controllers/AuthV1Controller.cs`; `src/RugbyRadio/Api/Controllers/MatchesV1Controller.cs`; `src/RugbyRadio/Lib/Services/RugbyRadioLiveService.cs`; `src/RugbyRadio/Lib/Repositories/MatchBox/MatchService.cs`; `src/RugbyRadio/Lib/Repositories/MatchBox/MatchRepository.cs`; `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelRepository.cs`; `src/RugbyRadio/HF/Services/SeoUrlInventoryService.cs`.

Le risposte del Q&A definiscono la direzione UX; le raccomandazioni e i blocchi sopra sono la valutazione di prodotto/tecnica derivata dalle fonti, non ulteriori decisioni attribuite al responsabile.
