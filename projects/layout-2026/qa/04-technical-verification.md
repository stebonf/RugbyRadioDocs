# Verifica tecnica — registrazione, canale test e resilienza delle sezioni

**Fonte della richiesta:** `docs/Q&A - 02.md`.
**Esito:** la creazione automatica e il quick wizard sono confermati nel percorso normale, con condizioni e limiti importanti. La frase “se qualcosa non va l'intero applicativo è giù” non descrive i guasti parziali; una indisponibilità completa del backend può interrompere molte funzioni dati lasciando comunque caricabile la SPA, se hosting e asset statici sono disponibili.

## 1. Registrazione e canale di test

### Evidenze verificate

- La route email `POST /v1/auth/users` è pubblica (`[ApiController]`, nessun `[Authorize]` sul metodo) in `Api/Controllers/AuthV1Controller.cs` (metodo `Register`, circa righe 35–66). Crea l'utente tramite `IUserService.RegisterNewUserAsync`, ottiene il token e poi chiama `WizardFastAddChannelAsync(..., true)` con `Training Channel`, `Blue Sharks` e `Red Lions`.
- Quindi un account creato via email riceve automaticamente il canale test, le due squadre e una partita preimpostata **se la richiesta API completa correttamente**. Anche il percorso Google in `GoogleLogin` crea il canale test con lo stesso wizard.
- “Registrarsi con una email” descrive la modalità di autenticazione, ma il form attuale richiede anche nickname e password: `src/RugbyRadioWeb/src/app/user/registration/registration.component.ts` (form e `onRegister`) e `registration.component.html` (campi required). L'email da sola non basta.
- `RugbyRadioLiveService.WizardFastAddChannelAsync` (`Lib/Services/RugbyRadioLiveService.cs`, righe circa 50–90) controlla l'esistenza di un canale test attivo e ritorna un match vuoto se ne trova già uno; altrimenti crea/recupera canale, lo marca `IsTestChannel = true`, crea/recupera squadre, partita e formazioni. Il flag è sul canale (`Lib/Repositories/ChannelBox/Channel.cs`).
- Il job `HF/Jobs/CreateTrainingChannelJob.cs` percorre gli utenti senza test channel e tenta la stessa creazione. Può servire a colmare account già esistenti senza canale; il suo trigger/frequenza non è accertabile qui (il file dichiara job Hangfire, nessun cron è nel sorgente consultato).
- La home autenticata mostra la sezione con titolo, descrizione e pulsante “prova telecronaca” (`src/RugbyRadioWeb/src/app/site/home/home-user/home-user.component.html`, righe 34–40) solo se `profile.channels === 1`, `profile.followChannels === 0` e il suggerimento locale è visibile. La pagina richiede inoltre caricamento del profilo. Il fetch della partita di training è una chiamata distinta (`home-user.component.ts`, metodo `loadUserInfo`); il suo errore viene solo scritto in console. Se fallisce, il pulsante resta nel template ma `navigateToTrainingMatch()` non naviga quando `trainingMatch` è nullo. Dunque la promessa della label+pulsante è valida nel caso iniziale ordinario, non garantita in ogni stato o errore.

### Correzione necessaria sul significato di “privato/non pubblico”

Il flag test esclude i canali dalla ricerca pubblica e dai candidati sitemap: `Lib/Repositories/ChannelBox/ChannelRepository.cs`, `FindByFilterAsync` (circa righe 100–130) e `FindSeoCandidatesAsync` (circa righe 137–150). Ciò limita la **scoperta** tramite catalogo e SEO.

Non risulta però privato nel senso di accesso anonimo negato. `ChannelService.CreateChannelAsync` assegna un `PublicId` di otto caratteri (`Lib/Repositories/ChannelBox/ChannelService.cs`, circa righe 50–95). L'endpoint `GET /v1/channels/public/{publicId}` è `[AllowAnonymous]` (`Api/Controllers/ChannelsV1Controller.cs`, metodo `GetByPublicId`, circa righe 160–176) e `GetPublicChannelAsync` recupera il record per ID senza filtrare `IsTestChannel == true` (`ChannelService.cs`, metodo intorno alla riga 133). Il DTO pubblico viene assemblato con squadre e partite collegate. Un ID noto o condiviso può quindi rendere il canale test accessibile via URL, anche se non compare nella ricerca. Non chiamarlo “privato” senza un controllo di accesso effettivo; formulazione più aderente al codice: **escluso dalla discovery pubblica, ma accessibile dall'endpoint pubblico conoscendone l'ID**. La policy desiderata resta una decisione di prodotto/sicurezza e richiede verifica delle altre route pubbliche collegate.

### Nota di coerenza/robustezza della registrazione

Nel metodo email il record utente viene creato prima della generazione token e della creazione del canale. Non è visibile in questo flusso una transazione unica che comprenda registrazione e wizard. Se il wizard fallisce, il client riceve un errore invece del token (il FE mostra alert di errore), anche se l'utente potrebbe essere già stato scritto. Il job training può successivamente creare il canale per gli utenti senza training, ma dal codice consultato non si può promettere quando avverrà. La registrazione potrebbe quindi apparire fallita mentre l'account esiste; retry di signup può essere respinto come duplicato. È un caso di recovery da esplicitare per l'analisi UX e verificare con il dominio.

## 2. Quick wizard e gate di accesso

La direzione funzionale del Q&A è confermata: è un flusso di creazione rapida che permette di scegliere un canale e squadre esistenti oppure inserirne di nuove e crea partita/formazioni nell'orchestratore.

- L'accesso utente è disponibile da bottom navigation solo autenticata (`src/RugbyRadioWeb/src/app/common/entity-bottom-nav/entity-bottom-nav.component.html`, blocco `isUserLoggedIn$`) e dalla dashboard autenticata (`site/home/home-user/home-user.component.html`). `AppComponent` carica i dati di scelta solo per sessione autenticata (`src/RugbyRadioWeb/src/app/app.component.ts`, `bindQuickMatch`/`loadQuickMatchData`).
- La protezione decisiva è server-side: `Api/Controllers/MatchesV1Controller.cs`, metodo `AddMatchQuick` (`POST`, MTC-17, circa righe 345–361) ha `[Authorize]` e usa lo user ID corrente.
- L'implementazione corrente è un drawer con **cinque step numerati** più schermata introduttiva: canale, squadra casa, squadra ospite, data e riepilogo/conferma (`src/RugbyRadioWeb/src/app/common/match-create/match-create.component.html`; logica di validazione step in `.ts`, circa righe 170–280). La descrizione in `docs/wiki/articles/Creazione Rapida Partita (article).md` e nella pagina componente wiki parla di tre step aggregati; per documentare l'UI attuale aggiornare l'analisi usando il template effettivo, non la vecchia numerazione.
- La richiesta FE invia `dateDay`, `channel`, `homeTeam`, `awayTeam` a `MatchService.addQuickMatch`; l'API delega a `WizardFastAddChannelAsync`, che crea le formazioni. La sintesi wiki `docs/wiki/articles/Creazione Rapida Partita (article).md` conferma la relazione end-to-end, ma l'effettiva atomicità database non è dimostrata dalla sequenza di operazioni letta.
- Sul fallimento del POST il wizard ripristina `quickMatchOnSaving` e lascia il drawer aperto, ma l'errore è solo `console.error` (`match-create.component.ts`, catchError circa righe 148–155): non è visibile feedback inline/toast né una spiegazione del retry. Una modifica UX può mostrare errore e preservare i campi; prima di offrire retry automatico o promettere creazione atomica occorre confermare idempotenza/rollback, perché il backend esegue più scritture/SaveChanges.

## 3. “Se qualcosa non va l'intero applicativo è giù”

La frase è vera solo come descrizione di un guasto del livello che serve la SPA (hosting, asset necessari o infrastruttura comune) che impedisce di caricare l'app. Non è una descrizione corretta del comportamento implementato quando una API o una singola query fallisce.

### Indisponibilità backend ampia

Il guscio Angular non attende il successo delle query business prima di renderizzare header, outlet e footer; `src/RugbyRadioWeb/src/app/app.component.ts` avvia richieste in metodi successivi al bootstrap e le intercetta. Se Angular e gli asset vengono serviti, contenuti statici/marketing possono restare visibili, mentre autenticazione, dashboard e superfici alimentate da API non funzionano o sono parziali. La registrazione fallisce con alert; un tentativo wizard fallisce ma non spiega l'errore visivamente. Quindi si può avere una **degradazione ampia della parte dinamica**, non necessariamente “l'app intera giù”.

### Guasto parziale di singolo servizio/query

Le chiamate sono effettuate e gestite localmente, spesso in sottoscrizioni separate:

- Home anonima: `HomeOngoingMatchesComponent`, `HomeNextMatchesComponent`, `HomeLastMatchesComponent` e `HomeLastChannelsComponent` fanno query indipendenti e in `catchError` concludono il loading senza mostrare errore. `HomeGridComponent` (`src/RugbyRadioWeb/src/app/common/home-grid/home-grid.component.html`) rende la sezione solo con loading o risultati; una query fallita può quindi sparire come se la sezione non avesse contenuti, mentre sezioni fratelli e parte marketing restano.
- Home autenticata: profilo, canali e squadre hanno catchError indipendenti, ognuno completa il contatore loading; gli errori sono solo in console (`home-user.component.ts`). La query `getTrainingMatch()` è separata e il suo errore non impedisce le altre. È possibile che dashboard e wizard si aprano con dati incompleti.
- Cataloghi pubblici: `GMatchesComponent` e `GChannelsComponent` catturano l'errore, fermano loading e passano da `errorHandling` del `GBaseUserComponent`, che mostra un toast e registra l'errore. Non bloccano necessariamente shell o altre route; il toast resta generico e non equivale a stato contestuale persistente.
- Wizard: errore di creazione lascia pannello aperto e spinner spento, ma senza feedback visibile; può sembrare che il click non abbia funzionato.

Perciò il codice presenta proprio il caso che il Q&A dice di non voler trattare: dati mancanti/errori locali possono essere scambiati con sezioni vuote o restare senza spiegazione. Il fatto che un outage infrastrutturale totale renda tutto indisponibile non giustifica sopprimere il recovery locale per fault isolati.

## 4. Gestione UX proporzionata ai comportamenti osservati

1. **Non mostrare una pagina globale “servizio giù” per qualsiasi errore locale.** Mantieni le parti funzionanti e presenta lo stato di errore nel blocco che ha fallito. Riserva un avviso globale a un outage effettivamente globale/rilevato con evidenza (ad esempio health/boot failure); il client attuale non ha health check globale.
2. **Distinguere i dati vuoti da query fallite.** Per home e dashboard, ogni feed/query dovrebbe mantenere stato separato `loading / success-empty / success-data / error`. Un feed fallito non deve sparire silenziosamente né essere etichettato come lista vuota; le sezioni sibling riuscite restano utilizzabili.
3. **Retry locale per letture recuperabili.** Aggiungi retry contestuale alle richieste GET e ricarica solo il blocco interessato. Non presupporre retry per tutte le operazioni di scrittura.
4. **Feedback persistente per azioni che bloccano il compito.** Per registrazione e wizard, spiega che cosa non è riuscito; conserva i dati inseriti. Nel wizard, abilita retry manuale dopo che server ha chiarito rollback/idempotenza o dopo una verifica che eviti duplicati.
5. **CTA training coerente col dato.** Carica uno stato per il lookup partita test; se fallisce o restituisce no match, disabilita/ritira il pulsante oppure offre una destinazione funzionante (es. wizard) con copy corretto. Non lasciare CTA apparentemente attiva che non esegue azione.
6. **Decidere il requisito di privacy del canale test.** Se dev'essere davvero privato, includere la route diretta pubblica tra i criteri API e verificare anche match, team, assets e sitemap. Filtrare solo il catalogo non equivale a proteggere l'accesso.

## Conseguenze per il piano layout-2026

- Integrare nel piano discovery/onboarding il fatto che il test channel è creato automaticamente e che la CTA dashboard è condizionale; non progettare la prova cronista come un flusso che richiede subito creazione manuale di un canale.
- Registrare come decisione necessaria il significato atteso di “privato” per canale test. L'evidenza attuale mostra esclusione da ricerca/sitemap, ma accesso anonimo per ID noto: la policy è distinta dalla sola UI.
- Per la home anonima, sostituire l'assunzione “tutto giù” con stati per query; il piano di delivery dovrebbe mantenere marketing e feed indipendenti in caso di fault parziale e proporre fallback locale solo dove il flusso richiede recupero.
- Per la home autenticata, trattare i fallimenti di profilo/canali/squadre/lookup training come stati distinti. Rischio particolare: il quick wizard può offrire solo la creazione nuova se i dati di esistenti non si caricano.
- Per il wizard, dichiarare il numero e contenuto step in base ai template attuali (5 numerati), correggendo la discrepanza col riepilogo wiki prima di definire criteri di riduzione.
- Registrazione e quick-create coinvolgono backend e persistenza composta. Un eventuale obiettivo di “successo atomico” o di retry sicuro esce dal solo redesign frontend e va valutato col referente dominio/API, mantenendo per ora un recovery UI per errori già osservabili.

## Fonti puntuali consultate

**Codice frontend**
- `src/RugbyRadioWeb/src/app/user/registration/registration.component.ts` e `.html`
- `src/RugbyRadioWeb/src/app/site/home/home-user/home-user.component.ts` e `.html`
- `src/RugbyRadioWeb/src/app/common/match-create/match-create.component.ts` e `.html`
- `src/RugbyRadioWeb/src/app/common/entity-bottom-nav/entity-bottom-nav.component.html`
- `src/RugbyRadioWeb/src/app/app.component.ts` e `.html`
- `src/RugbyRadioWeb/src/app/common/home-grid/home-grid.component.html` e `.ts`
- `src/RugbyRadioWeb/src/app/site/home/home-ongoing-matches/`, `home-next-matches/`, `home-last-matches/`, `home-last-channels/`
- `src/RugbyRadioWeb/src/app/global/g-matches/g-matches.component.ts`, `g-channels/g-channels.component.ts`, `g-base-user/g-base-user.component.ts`

**Codice API/backend**
- `src/RugbyRadio/Api/Controllers/AuthV1Controller.cs`
- `src/RugbyRadio/Api/Controllers/MatchesV1Controller.cs`
- `src/RugbyRadio/Api/Controllers/ChannelsV1Controller.cs`
- `src/RugbyRadio/Lib/Services/RugbyRadioLiveService.cs`
- `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelService.cs`, `ChannelRepository.cs`, `Channel.cs`
- `src/RugbyRadio/HF/Jobs/CreateTrainingChannelJob.cs`

**Wiki**
- `docs/wiki/articles/Creazione Rapida Partita (article).md` (riassume wizard a tre step, da aggiornare in base all’UI corrente)
- `docs/wiki/frontend/web/pages/RegistrationPage (web).md`
- `docs/wiki/frontend/web/components/MatchCreateComponent (web).md`
- `docs/wiki/backend/api/jobs/CreateTrainingChannelJob (api).md`
- `docs/wiki/backend/api/apis/AuthV1Controller (api).md`
- `docs/wiki/backend/api/services/RugbyRadioLiveService (api).md`

## Limiti

Ho potuto leggere il codice sorgente API/backend locale oltre alla wiki, ma non ho eseguito l'app, chiamato endpoint live o verificato dati di produzione. Non ho verificato policy firewall/reverse proxy, configurazione del database/transazioni, pianificazione effettiva Hangfire o tutti gli endpoint pubblici indiretti di match/media. L'affermazione “privato” è quindi valutata sulle route e query consultate: per accesso tramite ID è sufficiente evidenziare un endpoint pubblico che non applica il flag, ma la superficie completa richiede revisione API separata.
