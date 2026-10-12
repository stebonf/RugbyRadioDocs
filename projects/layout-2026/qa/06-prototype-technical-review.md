# Revisione tecnica prototipo layout-2026 e contratti API

> **Aggiornamento 24 settembre 2026:** la valutazione sotto descrive lo stato osservato prima del bootstrap. Il prototipo è ora implementato in `src/RugbyRadioLayout2026` come app Angular autonoma con interceptor mock e fixture locali. `npm run build` riesce. L’analisi delle differenze di contratto, auth e privacy riportata sotto resta il riferimento per la validazione e l’eventuale rollout.

**Stato:** verifica read-only, 24 settembre 2026. Nessun codice o contratto API modificato.

## Esito e fattibilità

`src/RugbyRadioLayout2026/` è presente ma non mostra file, `package.json`, `angular.json`, `tsconfig`, entry point o client API; la directory è quindi uno scaffold non eseguibile nell’ambiente esaminato. Un prototipo isolato è comunque fattibile come applicazione Angular di presentazione con mock; manca però la decisione/scelta dello stack e del punto di avvio. Se deve provare l’integrazione con l’app attuale, la strada meno divergente è riusare i servizi Angular/DTO e intercettarne le richieste HTTP. Se il prototipo ha una struttura di app autonoma, definire prima il minimo progetto e mantenere un adapter HTTP con gli stessi path e DTO.

Il backend locale è stato consultato oltre alla wiki. I contratti sotto sono quelli osservabili nei controller e servizi FE attuali. L’API risiede su base URL FE `environment.apiUrl` (`https://api-s1-sh.rugbyradiolive.com/v1`), quindi i path riportati sono relativi a `/v1`; l’interceptor aggiunge `X-USER-LANGUAGE`, `X-COMMENTARY-LANGUAGE` e, se la sessione esiste, `Authorization: Bearer …`.

## Contratti principali per il prototipo

Le DTO JSON sono serializzate in camelCase dalla configurazione ASP.NET corrente; le interfacce Angular usano la stessa convenzione. Salvo la risposta di errore, i controller restituiscono il DTO come body diretto (non dentro `data`/`result`).

| Schermata/azione | Client FE | Metodo e path effettivo | Query/body | Auth e successo |
|---|---|---|---|---|
| Login | `UserService.login` | `POST /auth/user/login` | `{ email, password }` (`userLoginDto`) | Pubblico; `userTokenDto { id, nickname, token, language }` |
| Registrazione email | `UserService.register` | `POST /auth/users` | `{ email, password, nickname, language }` (`userRegisterDto`) | Pubblico; `userTokenDto`. L’API crea l’utente e poi prova a creare training channel + squadre + match prima di rispondere. Un errore nel secondo passaggio può far fallire la risposta dopo la scrittura utente. |
| Home anonima e catalogo partite | `MatchService.findMatches` | `GET /matches/public/search` | `textToSearch`, `page`, `pageSize=20`, `status` opzionale (int) | Pubblico; `PageDto<MatchMinDto>`: `currentPage`, `pageSize`, `totalPages`, `totalItems`, `items[]`. Home chiama la ricerca generica senza `status`; l’etichetta “ongoing/next/last” non corrisponde di per sé a un filtro API verificato. |
| Home anonima e catalogo canali | `ChannelService.findChannels` | `GET /channels/public/search` | `textToSearch`, `page`, `pageSize=20` | Pubblico; `PageDto<ChannelPublicDto>`. Il repository esclude `IsTestChannel` dalla ricerca. |
| Dettaglio canale pubblico | `ChannelService.getPublicChannel` | `GET /channels/public/{publicId}` | path `publicId` | `[AllowAnonymous]`; `ChannelPublicDto` con proprietario, nome, colori, statistiche/follow, squadre e classifiche. **Nessun filtro test-channel nel lookup per ID**; vedi privacy-demo. |
| Dettaglio partita/spettatore | `MatchService.getMatch` | `GET /matches/{matchId}` | path `matchId` | `[AllowAnonymous]`; `MatchDto` completo (score/stato, squadre, formazioni, eventi, commenti, statistiche, dati utente come `userLike`, `userFollow`, `isEditor`). Il token è opzionale e personalizza alcuni campi. |
| Post blog partita, quando presente | `BlogService.getMatchBlog` | `GET /blog/matches/{matchId}` | path `matchId` | Pubblico; `BlogDto`. Verificare se per assenza il backend risponde con DTO vuoto/null o errore prima di fissare fixture; il contratto frontend non basta a decidere. |
| Home autenticata/profilo | `UserService.getProfile` | `GET /user` | nessuno | `[Authorize]`; `UserProfileDto { email, nickname, avatarUrl, language, timezone, isVerified, channels, followChannels }`. |
| Home/dashboard canali | `ChannelService.getChannels` | `GET /channels` | nessuno | `[Authorize]`; `ChannelDto[]` (`id`, `name`, `publicId`, colori/header, numero matches). Include canale test dell’utente. |
| Home/dashboard squadre | `TeamService.getUserTeams` | `GET /teams` | nessuno | `[Authorize]`; `TeamMinDto[]` (`id`, `channelId`, `name`, `logoUrl`). |
| CTA training della dashboard | `MatchService.getTrainingMatch` | `GET /channels/matches/training` | nessuno | `[Authorize]`; `MatchChannelDto`. La UI usa il risultato separatamente dalle query profilo/canali/squadre. |
| Quick wizard | `MatchService.addQuickMatch` | `POST /matches` (MTC-17) | `{ dateDay, channel: { id?, name? }, homeTeam: { id?, name? }, awayTeam: { id?, name? } }` (`MatchQuickAddDto`) | `[Authorize]`; `MatchMinDto`. Ogni elemento è create-or-reference. Le scritture aggregate passano da `WizardFastAddChannelAsync`; non assumere rollback atomico in un mock. |
| Editor live: impostazioni/start | `MatchService.updateStats` | `PUT /matches/{matchId}/stats` | `MatchStatsUpdateDto`: `teamId?`, `lineupPlayerId?`, `status?`, `minute`, possesso casa/ospiti, `zone1..zone4`, `extraParams?`, `comment?`, `halfMinutes?` | `[Authorize]`; `MatchDto` aggiornato. |
| Editor live: evento | `MatchService.addEvent` | `POST /matches/{matchId}/events` | `MatchEventAddDto`: `teamId?`, player IDs?, `type`, `subType?`, `territory?`, `extraParams?`, `comment?`, `useAiEmoji?` | `[Authorize]`; `MatchDto` aggiornato. `DELETE /matches/{matchId}/events/{eventId}` ha la stessa auth/risposta. |
| Reazione spettatore | `MatchService.addReaction` | `POST /matches/{matchId}/reactions` | `{ eventId, reactionType }` | Il metodo del controller non ha `[Authorize]` né `[AllowAnonymous]`; non imporre auth nel mock senza una decisione/policy esplicita. Successo `MatchDto`. |
| Commento spettatore | `MatchService.addComment` | `POST /matches/{matchId}/comments` | `{ eventId, message }` | `[Authorize]`; successo `MatchDto`. |
| Like/follow partita | `MatchService.likeMatch` / `manageFollow` | `PUT /matches/{matchId}/like`; `PUT /matches/{matchId}/follow` | body `{}` | `[Authorize]`; like ritorna `MatchDto`, follow `boolean`. |
| Statistiche pubbliche (se incluse) | `StatsService.getStats` | `GET /stats/` | nessuno | Pubblico; `StatsDto`. |

Altri route/methodi rilevanti si trovano nei servizi Angular: `MatchService` comprende anche `MTC-10/18` liste per canale/squadra, `MTC-12` rating, `MTC-14` partite ongoing autenticate; `ChannelService` ha gestione canale/favorites; `TeamService` dettaglio squadra; `UserService` feedback e profilo. Aggiungerli solo se le schermate selezionate li invocano.

## Errori e stati HTTP

- I controller dichiarano `400` e `401` con `ResponseDto`; la classe è `{ code, message, errors }` (`Lib/Dto/ResponseDto.cs`). Il filtro `RugbyRadioExceptionFilter` restituisce per validation `400`, `code: "1000"`, `message: "Validation Failed"` e mappa `errors` localizzati; per eccezioni generiche restituisce `400`, `code: "EX"`, message e potenzialmente dettagli InnerException/StackTrace. Non riprodurre nel mock i dettagli stack/produzione: possono esporre informazioni interne. Il challenge ASP.NET `401` non è garantito come body JSON anche se `ProducesResponseType` dichiara ResponseDto; verificare il comportamento reale prima di affidarsi a `e.error.errors` per ogni 401.
- Gli endpoint lista con nessun risultato hanno successo HTTP e DTO paginato con `items: []` e contatori coerenti: ciò rappresenta **empty**, non errore.
- Errore di una singola query è un errore per quella richiesta e non implica offline generale. Il FE home intercetta diverse query separatamente e termina il caricamento; `HomeGrid` nasconde il blocco se non ci sono item, così al momento un errore può somigliare a empty. Le pagine lista pubbliche invece chiamano un handler che mostra toast generico.
- Il mock deve offrire almeno tre scenari distinti: `200 + items: []` (empty), `400/401` con i contratti descritti (errore funzionale/autorizzazione), e guasto servizio simulato su una sola route, senza forzare `navigator.onLine = false`. Un outage backend generale si può simulare restituendo indisponibilità a tutte le route `/v1/*` lasciando SPA/assets caricabili; l’app completamente offline per asset è un guasto del livello hosting e non si ottiene testando una query.

## Privacy-demo: contratto attuale contro obiettivo

Il finding già registrato in `qa/04-technical-verification.md` si applica direttamente al prototipo. Il training channel ha `PublicId`, il repository lo esclude dalle ricerche pubbliche, ma `/channels/public/{publicId}` lo recupera senza filtrare `IsTestChannel`. Inoltre `/matches/{matchId}` è anonimo e `MatchRepository.GetByIdIncludeAsync` recupera il match per ID senza filtro test-channel esplicito: un test-match noto può quindi essere visibile dal dettaglio pubblico. Le sitemap escludono test channel, ma questo non è controllo d’accesso. Il mock deve tenere separati due intenti:

1. **Modalità compatibilità con l’API attuale:** cataloghi non mostrano test channel; ID sintetico noto può aprire il dettaglio perché è ciò che il backend esaminato consente.
2. **Modalità privacy-demo/target UX:** fixture del canale di training visibile solo alla sessione proprietaria; richiesta anonima diretta a canale/match test restituisce 404/403. Dichiarare nel prototipo che questo è comportamento proposto da implementare/approvare, non comportamento API già esistente. Nessun ID o dato personale di produzione va incorporato nella fixture.

Il DTO pubblico non porta un flag `isTestChannel`; la privacy deve derivare da policy server-side sui dati, non dalla sola presenza di un boolean nascosto nel client. Per realizzare il target anche nell’app reale servono modifiche API separate e verifica di tutti i percorsi diretti pubblici (match, canale, squadre, blog/media correlati). Questa review non cambia tali API.

## Strategia di mock compatibile

**Raccomandazione:** mock HTTP a livello rete (per esempio MSW) con handler che matchano origin/base `/v1`, metodo e path, poi leggono query/body e applicano auth. L’istanza dovrebbe restituire le stesse DTO nominali del backend e usare fixture tipizzate contro le interfacce FE / DTO C#. Per il prototipo autonomo, isolare i fixture e gli handler in `mocks/`; avviare il worker prima del bootstrap solo in modalità mock. In alternativa, se si mantiene Angular e si vuole evitare un worker aggiuntivo, un `HttpInterceptor` dedicato può essere sufficiente purché intercetti solo le richieste API configurate e lasci le altre HTTP esterne proseguire.

Regole pratiche per gli handler:

- Trattare `Authorization` come token demo per la sessione e proteggere le route che il controller marca `[Authorize]`; restituire 401 quando manca/è invalido. Non fidarsi solo delle route guard o delle condizioni UI.
- Parse query con `URLSearchParams`, restituire paginazione coerente e rispettare i parametri effettivamente inviati. Il codice FE concatena query string senza encoding esplicito; mantenere fixture di search testuale con caratteri speciali per scoprire divergence, non correggere implicitamente il contratto nel mock.
- Mantenere le proprietà esatte camelCase e i tipi JSON (es. status `lookupDto { id, description }` in risposte, ma `status` int nella ricerca e in `MatchStatsUpdateDto`). Non inviare `{ data: ... }` wrapper o proprietà UI-only ai contratti.
- Conservare stato in memoria per le demo mutabili (login, preferenze minime, creazione wizard, eventi) e definire un reset scenario esplicito. Le scritture `POST/PUT/DELETE` possono aggiornare le fixture e poi rispondere col `MatchDto` aggiornato così i consumer reali vedono la stessa forma.
- Se il mock non implementa una route chiamata, fallire esplicitamente e visibilmente (404 fixture/diagnostica dev); non restituire `[]` come fallback universale, perché maschera una route mancante come un catalogo legittimamente vuoto.
- Mettere latenza simulata solo come opzione scenario e fault toggle per singola API. Nessun fallback globale che trasformi errori in risposte empty; UI dovrebbe mantenere data state separato per query.

**Tradeoff:** MSW esercita i path e le request reali, quindi rende più semplice passare dal prototipo al client attuale e rilevare differenze FE/API; richiede una dipendenza e worker setup (oggi assenti dallo scaffold). Un interceptor Angular è più leggero e usa `HttpClient`, ma lega il mock al framework e può deviare se il prototipo sostituisce i servizi reali. Repository/service finti in memoria sono rapidi per una demo statica, ma non verificano method/path/query/auth/shape: adatti a un mockup senza claim di compatibilità API.

## Divergenze e decisioni tecniche da risolvere

1. **Home “ongoing/next/last”:** FE chiama in più sezioni `findMatches('', page, pageSize)` senza `status`, quindi tutte le richieste vanno allo stesso endpoint generico. Se il prototipo mostra feed categorici garantiti, servono filtri/status o endpoint/ordinamento definiti; il mock non deve far sembrare esistente il filtro che non è inviato.
2. **Dashboard/training:** la home fa richieste separate per profile, channels, teams e training-match; il mock deve gestire fault isolati separatamente. Il blocco CTA dipende anche dai contatori profilo e preferenza di hide locale.
3. **DTO statistiche Live:** `MatchLiveComponent` invia oggetto `matchStatsUpdateDto` completo, ma `MatchService.updateStats` è tipizzato con `matchStatsDto` che contiene solo le zone (`src/RugbyRadioWeb/src/app/services/match.service.ts` contro `dto/matchTeamStatsDto.ts` e `Lib/Dto/MatchStatsDto.cs`). Il body effettivamente costruito nel componente include status/minute/possesso/zone/metadati e corrisponde al DTO C# più ampio; aggiornare solo il tipo FE in un futuro lavoro è preferibile a restringere il mock.
4. **Privacy test:** catalogo escluso, fetch diretto anonimo non escluso; scegliere se il prototipo dimostra parità attuale o target privacy e segnare il target come dipendenza backend.
5. **Wizard error/atomicità:** più scritture backend e nessun rollback confermato. Le fixture non devono fare finta che qualunque retry sia idempotente. UX/API devono decidere error handling e deduplica.
6. **Bootstrap prototipo — chiuso:** al momento di questa verifica non esisteva un punto di partenza eseguibile. È stato poi creato lo scaffold Angular autonomo descritto nell’aggiornamento iniziale; build e mock sono disponibili. Resta da validare l’esperienza visuale e confermare i flussi col responsabile.

## Fonti verificate

- Prototipo: `src/RugbyRadioLayout2026/` (directory vuota nel checkout letto al momento della verifica iniziale; in seguito implementata).
- Frontend: `src/RugbyRadioWeb/src/app/services/base.service.ts`, `match.service.ts`, `channel.service.ts`, `team.service.ts`, `user.service.ts`, `stats.service.ts`, `blog.service.ts`, `interceptors/auth.interceptor.ts`; DTO in `src/RugbyRadioWeb/src/app/dto/{commonDto,matchDto,matchEventDto,matchTeamStatsDto,channelDto,teamDto,userDto,blogDto,statsDto}.ts`.
- Pagine/consumer: `src/RugbyRadioWeb/src/app/site/home/home-{component,home-user,home-ongoing-matches,home-next-matches,home-last-matches,home-last-channels}.ts/html`; `global/g-matches`, `global/g-channels`, `global/g-match`, `user/match`, `common/match-create`.
- API: `src/RugbyRadio/Api/Controllers/{AuthV1Controller,MatchesV1Controller,ChannelsV1Controller,TeamsV1Controller,UserV1Controller,StatsV1Controller,BlogV1Controller,MatchEventsV1Controllers}.cs`; DTO/filtri in `src/RugbyRadio/Lib/Dto/`, `Lib/Core/Filters/RugbyRadioExceptionFilter.cs`, `Lib/Repositories/{ChannelBox,MatchBox}/`.
- Wiki: `docs/wiki/articles/Creazione Rapida Partita (article).md`; voci API/DTO frontend e backend corrispondenti; analisi precedente `docs/projects/layout-2026/qa/04-technical-verification.md`.

## Limiti

È stata fatta analisi statica di servizi, DTO, controller e repository pertinenti; non sono state chiamate API, verificate risposte live, eseguita l’app o controllata la configurazione di hosting/reverse proxy. I `ProducesResponseType` descrivono le risposte dichiarate, non sempre il body effettivo del middleware per ogni 401. L’assenza di transazione unica è valutata sui metodi letti, non su eventuali transazioni avviate in middleware/database. La verifica non copre ogni route secondaria del prodotto.
