# Audit UX/UI mobile — Rugby Radio Live

**Data audit:** 8 ottobre 2026  
**Perimetro:** app Angular `src/RugbyRadioWeb`, router attivo nell'ambiente di sviluppo (`maintenance: false`).  
**Esito:** 19 rotte pagina individuate e analizzate sul codice; 2 viste verificate visivamente a 375 px; 2 rilievi unici, entrambi a priorità bassa.

## 1. Riepilogo generale

- **Rotte pagina standard individuate:** 19.
- **Rotte analizzate sul codice:** 19.
- **Rotte verificate visivamente:** 2 (`/` e `/user-login`), entrambe a 375 px.
- **Problemi unici:** 0 alta, 0 media, 2 bassa.
- **Valutazione complessiva:** lo stato mobile appare complessivamente adeguato. Sono presenti breakpoints, form controls da almeno 44 px nel design system, card/grid responsive, rail touch e layout mobile dedicati. I due rilievi riguardano la dimensione dei controlli di paginazione e la tabella classifica nella pagina canale.

Le larghezze 320, 375, 390 e 430 px sono state considerate nell'analisi delle regole responsive. **Non** sono state eseguite emulazioni o misure visuali separate a tutte e quattro le larghezze: solo 375 px è stato osservato nel browser. Le pagine protette e quelle legate a specifici dati di partita/canale/squadra sono state analizzate sul codice, senza simulare sessioni o dati mancanti.

### Perimetro del router

Il router principale è `src/RugbyRadioWeb/src/app/app.routes.ts`. I path `''` e `**` sono redirect/fallback e non sono conteggiati come pagine. Quando `environment.maintenance` è `true` vengono inserite la pagina `/admin-maintenance` e l'alias redirect `/adm-maintenance`; nell'ambiente controllato il flag è `false`, quindi non sono inclusi nelle 19 rotte attive. Il query state TWA e i tab/drawer/modali sono stati considerati stati della pagina ospite, non rotte separate. `g-radio/:matchId` è invece una rotta distinta.

## 2. Inventario delle rotte

`Codice` indica revisione di route, template, CSS e dipendenze; `Visiva · 375` indica osservazione renderizzata nel browser a 375 px. I conteggi sono riferimenti ai rilievi condivisi: lo stesso rilievo è spiegato una sola volta nella sezione 3.

| Rotta | Componente principale | Accesso | Stato verifica | Rilievi applicabili |
|---|---|---|---|---:|
| `/` | `HomeComponent` | Pubblica; marketing anonimo o dashboard se autenticato | Visiva · 375 + codice | 0 |
| `/user-login` | `LoginComponent` | Pubblica | Visiva · 375 + codice | 0 |
| `/user-registration` | `RegistrationComponent` | Pubblica | Codice | 0 |
| `/user-reset-password` | `ResetPasswordComponent` | Pubblica; flusso OTP | Codice | 0 |
| `/user-dashboard` | `HomeComponent` | Protetta da `AuthGuardService` | Codice; stato autenticato non verificato | 0 |
| `/user-profile` | `ProfileComponent` | Protetta | Codice; sessione/dati profilo non verificati | 0 |
| `/user-channels` | `ChannelsComponent` | Protetta | Codice; dati utente e drawer non verificati | 0 |
| `/user-channel/:channelId` | `ChannelComponent` | Protetta | Codice; canale e tab non verificati | 1 |
| `/user-match/:matchId` | `MatchComponent` | Protetta | Codice; partita e stati editor non verificati | 0 |
| `/user-danger` | `DangerComponent` | Protetta | Codice; sessione non verificata | 0 |
| `/user-favorites` | `FavoritesComponent` | Protetta | Codice; preferiti utente non verificati | 0 |
| `/g-channel/:channelPublicId` | `GChannelComponent` | Pubblica | Codice; dati e tab classifica non verificati | 2 |
| `/g-match/:matchId` | `GMatchComponent` | Pubblica | Codice; partita e stati live non verificati | 0 |
| `/g-radio/:matchId` | `GMatchRadioComponent` | Pubblica; richiede una partita valida | Codice; playback non verificato | 0 |
| `/g-matches` | `GMatchesComponent` | Pubblica | Codice; risultati/paginazione non verificati | 1 |
| `/g-channels` | `GChannelsComponent` | Pubblica | Codice; risultati/paginazione non verificati | 1 |
| `/g-team/:teamId` | `GTeamComponent` | Pubblica | Codice; squadra e tab non verificati | 1 |
| `/g-stats` | `GStatsComponent` | Pubblica | Codice; dati statistiche non verificati | 0 |
| `/g-feedback` | `GFeedbackComponent` | Pubblica | Codice; form non inviato | 0 |

I numeri nella colonna finale contano le esposizioni dei due rilievi condivisi sulle rotte; non rappresentano altrettanti difetti distinti.

## 3. Problemi dei componenti condivisi

| ID | Componente | Problema ed evidenza | Rotte coinvolte | Priorità | Intervento minimo suggerito |
|---|---|---|---|---|---|
| M-01 | `EntityPaginationComponent` | A `max-width: 640px`, controlli precedente/successivo e controllo pagina passano da 44×44 a 40×40 px. Il codice mostra quindi target inferiori al riferimento touch di 44 px. | `/g-matches`, `/g-channels`, `/g-channel/:channelPublicId` (tab Matches), `/g-team/:teamId` (tab Matches), `/user-channel/:channelId` (tab Matches) | Bassa | Mantenere 44×44 px anche nel breakpoint mobile. Verificare che la fila resti entro la larghezza della card a 320 px. | 
| M-02 | `ChannelTablesComponent` | La tabella ha `min-width: 760px` dentro un wrapper `overflow-x: auto`, quindi richiede scorrimento orizzontale su tutti i viewport richiesti. Il template contiene anche card per riga, ma `.g-channel__table-cards` è `display: none` e non risulta una regola mobile che le attivi. | `/g-channel/:channelPublicId` (tab Tables) | Bassa | Valutare l'attivazione della rappresentazione a card già presente nel template per mobile, mantenendo la tabella desktop. | 

### Componenti condivisi esaminati senza rilievi confermati

- **Shell/header e bottom navigation:** header comune, menu, lingua e nav mobile; nessun difetto concreto rilevato nel codice esaminato. Non ho eseguito la navigazione completa tra tutte le voci.
- **Form controls e pulsanti:** `EntityFieldComponent`, `EntityButtonComponent` e stili globali prevedono campi e pulsanti standard da 44 px; login e submit/accessibilità sono cablati nel template. Le schermate form non sono state tutte verificate con tastiera virtuale.
- **Home grid/carousel:** il CSS usa rail touch orizzontali e snap; i controlli mobile dei caroselli sono 44×44 px. Nessun overflow pagina è stato confermato dal codice.
- **Card, tabs, alert e drawer:** responsività e stati sono implementati localmente. Per le viste protette/dinamiche non è stata verificata la resa con dati reali.
- **Tabelle e statistiche:** il componente tabelle del canale è il solo caso con larghezza minima fissa individuato che necessita scorrimento orizzontale esplicito. Le statistiche usano layout fluidi, ma le stringhe/dati estremi richiedono una verifica visuale.

## 4. Analisi per rotta

Le voci seguenti riportano gli elementi da preservare e l'esito. Quando non sono indicati difetti, significa che non è emerso un problema concreto dall'analisi del codice; non equivale a una verifica visuale.

### `/` — `HomeComponent`

- **Stato:** adeguata nella vista osservata a 375 px; codice responsive esaminato.
- **Da preservare:** hero e sezioni marketing, sequenza dei contenuti, card, caroselli touch e adattamento mobile; la home autenticata riusa lo stesso componente con contenuto condizionale.
- **Problemi:** nessuno confermato.
- **Evidenza/viewports:** screenshot a 375 px; CSS mobile e rail esaminati per 320/375/390/430 px. Nessun test visuale indipendente a 320/390/430.
- **Intervento/controindicazioni:** nessuno suggerito. Non sono stati verificati caricamento lento, card con testi estremi o menu aperto.

### `/user-login` — `LoginComponent`

- **Stato:** adeguata nella vista osservata a 375 px; codice responsive esaminato.
- **Da preservare:** card, dimensione e gerarchia del titolo, campi con etichette accessibili e autocomplete, pulsanti Google/Entra, flusso login e link legali. Le aree mobile di recupero password, registrazione e policy hanno già target da almeno 44 px nel CSS presente.
- **Problemi:** nessuno confermato nell'implementazione corrente.
- **Evidenza/viewports:** screenshot a 375 px e codice fino a 480 px; gli altri viewport non sono stati emulati.
- **Intervento/controindicazioni:** nessuno suggerito. Tastiera virtuale e iframe Google non sono stati provati su device.

### `/user-registration` — `RegistrationComponent`

- **Stato:** analisi codice; pagina pubblica non aperta nel browser.
- **Da preservare:** form reattivo, componenti campo/pulsante condivisi, validazione e flusso registrazione.
- **Problemi:** nessuno confermato.
- **Evidenza/viewports:** componenti globali con campi e pulsanti da 44 px; nessuna verifica visuale sui 4 viewport.
- **Intervento/controindicazioni:** nessuno suggerito; da controllare manualmente il wrapping di errori e policy con le traduzioni più lunghe.

### `/user-reset-password` — `ResetPasswordComponent`

- **Stato:** analisi codice; il flusso OTP non è stato eseguito.
- **Da preservare:** sequenza OTP e validazione esistenti.
- **Problemi:** nessuno confermato.
- **Evidenza/viewports:** template/CSS e breakpoint mobile esaminati; nessun test visuale o di tastiera.
- **Intervento/controindicazioni:** nessuno suggerito; verificare manualmente focus, inserimento OTP da tastiera mobile e scroll con keyboard aperta.

### `/user-dashboard` — `HomeComponent`

- **Stato:** solo codice; route protetta e sessione autenticata non disponibile per questa verifica.
- **Da preservare:** riuso della home e layout per profilo/statistiche/partite secondo stato account.
- **Problemi:** nessuno confermato.
- **Evidenza/viewports:** route guard e rendering condizionale esaminati; nessuna verifica visuale autenticata.
- **Intervento/controindicazioni:** nessuno suggerito; verificare con dati account e partite in corso reali.

### `/user-profile` — `ProfileComponent`

- **Stato:** solo codice; sessione e profilo reale non disponibili.
- **Da preservare:** hero profilo, form informativo, selettore avatar e componenti statistiche.
- **Problemi:** nessuno confermato; possibile overflow con valori/etichette statistiche lunghe da controllare manualmente, non dimostrato.
- **Evidenza/viewports:** breakpoint fino a 380 px e 560/600/720/900 px presenti nel CSS; nessuna resa visuale.
- **Intervento/controindicazioni:** nessuno nel backlog; verificare le etichette statistiche e gli avatar a 320 px con dati reali.

### `/user-channels` — `ChannelsComponent`

- **Stato:** solo codice; dipende da canali dell'utente e stato drawer.
- **Da preservare:** card responsive, stato vuoto, sheet di creazione e campi condivisi.
- **Problemi:** nessuno confermato.
- **Evidenza/viewports:** CSS mobile a 640/600 px; lo sheet usa body scrollabile e safe area nel footer. Nessuna apertura visuale del drawer.
- **Intervento/controindicazioni:** nessuno suggerito; verificare footer e tastiera virtuale nel drawer a 320 px.

### `/user-channel/:channelId` — `ChannelComponent`

- **Stato:** solo codice; route protetta, canale e tab non disponibili.
- **Da preservare:** hero responsive e navigazione a tab per info/layout/editor/teams/matches.
- **Problemi:** M-01 nella tab Matches.
- **Evidenza/viewports:** paginazione a 40×40 px sotto 640 px; non verificata visivamente. Composizione contenuto variabile per tab.
- **Intervento/controindicazioni:** applicare M-01; verificare tutti i tab e la scrollabilità delle tabelle team a 320/375 px.

### `/user-match/:matchId` — `MatchComponent`

- **Stato:** solo codice; route protetta e stato partita/editor non disponibili.
- **Da preservare:** hero punteggio, tab live/eventi/formazioni/statistiche/condivisione, sheet/modal e flussi esistenti.
- **Problemi:** nessuno confermato; molte varianti dipendono da stato partita e dati reali.
- **Evidenza/viewports:** breakpoint 767/640/520 px nei pannelli; lineup usa colonne ridotte su mobile. Nessuna interazione o modal verificata.
- **Intervento/controindicazioni:** nessuno suggerito; verifica manuale prioritaria per event editor, lineup drawer e tastiera su 320 px.

### `/user-danger` — `DangerComponent`

- **Stato:** solo codice; autenticazione e schermata distruttiva non aperte.
- **Da preservare:** eventuali controlli e conferme di sicurezza esistenti.
- **Problemi:** nessuno confermato.
- **Evidenza/viewports:** sorgenti esaminati; nessuna verifica visuale o di azioni.
- **Intervento/controindicazioni:** nessuno suggerito; eseguire verifica manuale senza confermare/eliminare dati.

### `/user-favorites` — `FavoritesComponent`

- **Stato:** solo codice; dati preferiti/account non disponibili.
- **Da preservare:** layout a schede e stati vuoto/caricamento.
- **Problemi:** nessuno confermato.
- **Evidenza/viewports:** breakpoint 800/600 px e min-width contenuti esaminati; nessuna resa con nomi lunghi.
- **Intervento/controindicazioni:** nessuno suggerito; verificare card con dati reali a 320 px.

### `/g-channel/:channelPublicId` — `GChannelComponent`

- **Stato:** solo codice; contenuto pubblico e tab Tables non verificati visualmente.
- **Da preservare:** hero, tab radio/squadre/partite/classifica/condivisione, griglia statistiche mobile.
- **Problemi:** M-01 nella tab Matches; M-02 nella tab Tables.
- **Evidenza/viewports:** tabella `min-width: 760px`, wrapper `overflow-x: auto`; fallback a card presente ma nascosto. Rilievi dimostrabili dal CSS/template, non da screenshot.
- **Intervento/controindicazioni:** applicare M-01 e valutare M-02. Attivare le card richiede scelta di comportamento responsive ma riusa markup esistente; testare lunghe denominazioni e traduzioni.

### `/g-match/:matchId` — `GMatchComponent`

- **Stato:** solo codice; dati/stato partita non disponibili.
- **Da preservare:** scoreboard, tab overview/eventi/radio/formazioni/statistiche/share e rail eventi.
- **Problemi:** nessuno confermato.
- **Evidenza/viewports:** CSS breakpoint a 767 px e componenti condivisi esaminati; tab e contenuti dinamici non renderizzati.
- **Intervento/controindicazioni:** nessuno suggerito; verificare nomi squadra lunghi, stato live e contenuto evento HTML su 320 px.

### `/g-radio/:matchId` — `GMatchRadioComponent`

- **Stato:** solo codice; partita e riproduzione audio non disponibili.
- **Da preservare:** controlli playback, stato radio e ritorno alla partita.
- **Problemi:** nessuno confermato.
- **Evidenza/viewports:** layout e breakpoint da 768 px esaminati; nessuna prova di playback o viewport visuale.
- **Intervento/controindicazioni:** nessuno suggerito; verificare controlli, wrapping dei nomi squadra e stati loading/paused su device.

### `/g-matches` — `GMatchesComponent`

- **Stato:** solo codice; risultati e paginazione reali non verificati.
- **Da preservare:** ricerca, card compatte mobile, stati di caricamento/vuoto e paginazione.
- **Problemi:** M-01.
- **Evidenza/viewports:** controlli paginazione 40×40 px sotto 640 px; nessuno screenshot della pagina.
- **Intervento/controindicazioni:** applicare M-01; il target maggiore può aumentare lievemente l'ingombro della barra, verificare a 320 px.

### `/g-channels` — `GChannelsComponent`

- **Stato:** solo codice; risultati reali non verificati.
- **Da preservare:** ricerca, card canale, informazioni risultato e paginazione mobile.
- **Problemi:** M-01.
- **Evidenza/viewports:** controlli paginazione 40×40 px sotto 640 px; nessuna verifica visuale.
- **Intervento/controindicazioni:** applicare M-01 e verificare riepilogo/paginazione a 320 px.

### `/g-team/:teamId` — `GTeamComponent`

- **Stato:** solo codice; dati e tab della squadra non verificati.
- **Da preservare:** hero, schede statistiche, tab giocatori/partite/condivisione.
- **Problemi:** M-01 nella tab Matches.
- **Evidenza/viewports:** paginazione condivisa 40×40 px sotto 640 px; layout card responsive esaminato.
- **Intervento/controindicazioni:** applicare M-01; verificare nomi giocatore/squadra molto lunghi su 320 px.

### `/g-stats` — `GStatsComponent`

- **Stato:** solo codice; statistiche API non verificate.
- **Da preservare:** griglie di metriche e contenuti evento con breakpoint mobile.
- **Problemi:** nessuno confermato; etichette evento in maiuscolo da 0,72 rem possono risultare dense, ma non ho dati o rendering sufficienti per classificarle come problema.
- **Evidenza/viewports:** regole a 560 px per griglia a due colonne; nessuna verifica visuale con traduzioni/dati reali.
- **Intervento/controindicazioni:** nessuno suggerito; controllare wrapping delle etichette evento a 320 px.

### `/g-feedback` — `GFeedbackComponent`

- **Stato:** solo codice; il form non è stato inviato.
- **Da preservare:** rating a stelle accessibile, textarea con contatore, errori associati e stato successo.
- **Problemi:** nessuno confermato.
- **Evidenza/viewports:** campi globali min-height 44 px e layout form mobile esaminati; nessuna prova della tastiera o dello stato errore.
- **Intervento/controindicazioni:** nessuno suggerito; verificare focus e scroll con textarea attiva a 320 px.

## 5. Backlog consolidato

| ID | Priorità | Rotta/componente | Problema | Intervento suggerito | Impatto codice | Stato iniziale |
|---|---|---|---|---|---|---|
| M-01 | Bassa | `EntityPaginationComponent` — 5 rotte | Target di paginazione 40×40 px a larghezza ≤640 px. | Mantenere 44×44 px nel breakpoint mobile e verificare la barra a 320 px. | Basso; CSS condiviso, effetti su liste pubbliche e tab Matches. | Da valutare |
| M-02 | Bassa | `ChannelTablesComponent` — `/g-channel/:channelPublicId` | Classifica con tabella 760 px e scorrimento orizzontale; card mobile già nel template ma nascoste. | Valutare l'uso del markup card esistente su mobile, lasciando invariata la tabella desktop. | Basso/medio; regole responsive condivise solo dalla classifica canale. | Da valutare |

## 6. Pagine già adeguate

“Adeguata” qui significa che non è emerso un problema concreto dall'analisi svolta; non implica copertura visuale completa.

- **Verifica visuale a 375 px e codice:** `/` (stato pubblico osservato), `/user-login`.
- **Analisi codice senza rilievi confermati:** `/user-registration`, `/user-reset-password`, `/user-dashboard` (stato autenticato non osservato), `/user-profile`, `/user-channels`, `/user-match/:matchId`, `/user-danger`, `/user-favorites`, `/g-match/:matchId`, `/g-radio/:matchId`, `/g-stats`, `/g-feedback`.
- **Con rilievi limitati ai componenti condivisi:** `/user-channel/:channelId`, `/g-channel/:channelPublicId`, `/g-matches`, `/g-channels`, `/g-team/:teamId`.

## Limiti e verifiche ancora necessarie

- Nessun test automatizzato o emulazione responsive è stato eseguito durante questo audit.
- Solo `/` e `/user-login` sono stati osservati nel browser e solo a 375 px. Gli altri viewport (320/390/430 px) sono stati valutati leggendo le regole CSS e le dimensioni dichiarate; non sono misure di rendering.
- Le pagine protette richiedono autenticazione; non sono state sbloccate né popolate con dati artificiali.
- Partite, canali, squadre, tabelle, paginazioni, stati di errore/loading, wizard, drawer e modal dipendono da dati o azioni non provati in questa verifica.
- Non è stato simulato l'uso della tastiera virtuale su un dispositivo reale.
