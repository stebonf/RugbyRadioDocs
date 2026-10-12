# 01 - Analisi repository RRL

## Executive summary

L'analisi conferma che lo stack RRL in uso e' composto da API ASP.NET Core, worker Hangfire, libreria comune, test .NET, frontend Angular su Firebase Hosting, directory statiche Blog e directory statica Sitemap.

La migrazione UAT a Docker/Linux e' fattibile, ma non e' ancora pronta per una containerizzazione completa per tre motivi principali:

- il backend e Hangfire dipendono ancora da SQL Server (`UseSqlServer`, `Hangfire.SqlServer`, connection string SQLEXPRESS);
- ci sono path Windows hardcoded per storage, blog, sitemap, backup e alcuni output temporanei;
- ci sono secrets reali in file di configurazione versionati o comunque presenti nel sorgente locale.

La Fase 2 dovrebbe partire da una singola applicazione a basso rischio. La candidata piu' adatta e' `src/RugbyRadio/Api`, limitandosi a build/startup/config/logging in container, senza ancora migrare database, Hangfire o storage.

## Fonti consultate

- `C:\Repositories\RRL\AGENTS.md`
- `C:\Repositories\RRL\README.md`
- `C:\Repositories\RRL\wiki\index.md`
- `C:\Repositories\RRL\wiki\architecture\Rugby Radio Live (architecture).md`
- `C:\Repositories\RRL\wiki\workflows\Pubblicazione Blog Statico (workflow).md`
- `C:\Repositories\RRL\wiki\data\schemas\AppDbContext (api).md`
- `C:\Repositories\RRL\wiki\concepts\Operativita Backend (concept).md`
- `C:\Repositories\RRL\wiki\concepts\Superficie SEO Pubblica (concept).md`
- `C:\Repositories\RRL\docs\projects\vps\README.md`
- sorgenti sotto `C:\Repositories\RRL\src`

Nota: `C:\Repositories\RRL\wiki\summary.md` e' citato dalle istruzioni repository ma non esiste nel filesystem corrente.

## Progetti e applicazioni individuati

| Percorso | Tipo | Stato per migrazione VPS |
| --- | --- | --- |
| `src/RugbyRadio/Api` | ASP.NET Core Web API .NET 8 | In scope; candidata a `rrl-api`. |
| `src/RugbyRadio/HF` | ASP.NET Core host Hangfire .NET 8 | In scope; candidata a `rrl-hangfire`. |
| `src/RugbyRadio/Lib` | Libreria comune .NET 8 | In scope come dipendenza build/runtime di API e HF; non e' un container. |
| `src/RugbyRadio/Tests` | Test xUnit .NET 8 | In scope per validazione API/HF/Lib; non e' un container. |
| `src/RugbyRadioBlog` | File HTML/statici Blog | In scope come contenuto statico persistente generato da HF. |
| `src/RugbyRadioSitemap` | File XML sitemap | In scope come contenuto statico persistente generato da HF. |
| `src/RugbyRadioWeb` | Angular 18 + Firebase Hosting | Non migrare su VPS; resta su Firebase, ma va coordinato con gli URL UAT. |
| `src/RugbyRadioWebNext` | Next.js / esperimento | Da ignorare per questa iniziativa. |
| `src/RugbyRadioDesignSystem`, `src/RugbyRadioManga`, `src/RugbyRadioSocial` | Esperimenti/altro | Da ignorare salvo dipendenze reali future. |

Differenza da appunti: non esiste `src/RugbyRadio/Web`; il frontend Angular in uso risulta `src/RugbyRadioWeb`.

## Solution e dipendenze tra progetti

La solution `src/RugbyRadio/RugbyRadio.sln` contiene solo:

- `Api` (`src/RugbyRadio/Api/Api.csproj`);
- `Lib` (`src/RugbyRadio/Lib/Lib.csproj`);
- `Tests` (`src/RugbyRadio/Tests/Tests.csproj`);
- `HF` (`src/RugbyRadio/HF/HF.csproj`).

Evidenze:

- `src/RugbyRadio/RugbyRadio.sln:3` include `Api`.
- `src/RugbyRadio/RugbyRadio.sln:5` include `Lib`.
- `src/RugbyRadio/RugbyRadio.sln:7` include `Tests`.
- `src/RugbyRadio/RugbyRadio.sln:9` include `HF`.
- `src/RugbyRadio/Api/Api.csproj:38` referenzia `..\Lib\Lib.csproj`.
- `src/RugbyRadio/HF/HF.csproj:23` referenzia `..\Lib\Lib.csproj`.
- `src/RugbyRadio/Tests/Tests.csproj:22-24` referenzia `Api`, `HF` e `Lib`.

Matrice dipendenze:

| Componente | Dipende da | Note |
| --- | --- | --- |
| API | `Lib`, SQL Server App DB, Firebase Admin, SMTP, Sentry | Espone controller REST e usa `AppDbContext`. |
| HF | `Lib`, SQL Server App DB, SQL Server HF DB, Hangfire, filesystem Blog/Sitemap/Storage | Host always-on per job e dashboard. |
| Lib | EF Core SQL Server, servizi esterni, filesystem storage/audio | Contiene DbContext, repository, servizi dominio e configurazioni. |
| Tests | API, HF, Lib | Copre repository, servizi e job. |
| RugbyRadioBlog | HF | Output statico generato da job HF. |
| RugbyRadioSitemap | HF | Output statico generato da job HF. |
| RugbyRadioWeb | API, Storage, Blog, Sitemap | Resta Firebase; contiene URL degli hostname attuali. |

## SQL Server ed EF Core

Uso attuale:

- API registra `AppDbContext` con SQL Server in `src/RugbyRadio/Api/Program.cs:29-31`.
- HF registra `AppDbContext` con SQL Server in `src/RugbyRadio/HF/Program.cs:33-35`.
- `Lib` dipende da `Microsoft.EntityFrameworkCore.SqlServer` in `src/RugbyRadio/Lib/Lib.csproj:21`.
- HF dipende da `Hangfire.SqlServer` in `src/RugbyRadio/HF/HF.csproj:16`.
- HF usa Hangfire storage SQL Server in `src/RugbyRadio/HF/Program.cs:70-75`.
- Le connection string App/HF puntano a SQLEXPRESS in `src/RugbyRadio/Api/appsettings.json:7-10` e `src/RugbyRadio/HF/appsettings.json:2-6`.

`AppDbContext`:

- definisce i DbSet principali in `src/RugbyRadio/Lib/Repositories/AppDbContext.cs:31-49`;
- configura conversioni enum in `src/RugbyRadio/Lib/Repositories/AppDbContext.cs:62-72`;
- configura conversioni custom compresse per audit in `src/RugbyRadio/Lib/Repositories/AppDbContext.cs:74-84`.

Migrations:

- non sono state trovate cartelle `Migrations` sotto `Api`, `HF` o `Lib`.
- Questo era un punto critico per l'ipotesi iniziale PostgreSQL: il README richiedeva schema controllato tramite EF Core migrations, ma nel codice analizzato non risulta una base migration esistente.

SQL Server-specific rilevante:

- `src/RugbyRadio/HF/Jobs/MaintenanceJob.cs:37-38` esegue `EXEC sp_Maintenance` e `EXEC sp_Backup`.
- `src/RugbyRadio/Lib/Repositories/UnitOfWork.cs:71-80` espone `ExecuteSqlRawAsync`.
- Alcuni test costruiscono DbContext con `UseSqlServer`, ad esempio `src/RugbyRadio/Tests/Repositories/RepositoryConstructionTests.cs:82` e `src/RugbyRadio/Tests/Repositories/AppDbContextModelTests.cs:72`.

## Hangfire

HF e' un host ASP.NET Core separato:

- `src/RugbyRadio/HF/Program.cs:68-77` configura Hangfire con SQL Server storage e RecurringJobAdmin.
- `src/RugbyRadio/HF/Program.cs:83` registra `AddHangfireServer()`, quindi il worker puo' rimanere always-on come processo/container dedicato.
- `src/RugbyRadio/HF/Program.cs:97` espone la dashboard Hangfire.
- `src/RugbyRadio/HF/Core/SentryHangfireJobFilter.cs` intercetta errori job verso Sentry.

Job individuati:

- `CreateMatchEventJob`
- `CreateMatchEventAdminJob`
- `TranslateMatchEventFemaleJob`
- `CreateTrainingChannelJob`
- `CreateMatchBlogJob`
- `CreateMatchBlogHtmlJob`
- `GenerateSeoSitemapJob`
- `CreateMatchImageJob`
- `CreateMatchImageInstagramJob`
- `CreateChannelImageJob`
- `CreateChannelImageInstagramJob`
- `RepairMatchImageJob`
- `MaintenanceJob`
- `HfFixJob`
- `UsbBackupJob`
- `FakeLastYearAgentJob`
- `FakeLeagueAgentJob`
- `FakeFantasyAgentJob`
- `FacebookJob`

Nota importante: molti job hanno `[AutomaticRetry(Attempts = 0)]`, ad esempio `CreateMatchBlogHtmlJob` in `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs:46`, `GenerateSeoSitemapJob` in `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs:74` e `MaintenanceJob` in `src/RugbyRadio/HF/Jobs/MaintenanceJob.cs:26`. Questo non blocca Docker, ma va considerato nei test di resilienza.

## Generazione Blog

La generazione Blog e' svolta da `CreateMatchBlogHtmlJob`:

- legge post non staticizzati per lingua in `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs:82-85`;
- legge template da `Templates/post-template.html` in `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs:91-94`;
- scrive output in sottocartelle lingua sotto `BlogSettings:OutputPath` in `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs:96-99`;
- scrive pagine dettaglio in `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs:233-241`;
- marca il blog come statico in DB in `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs:243-245`;
- genera indici paginati in `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs:257-317`;
- genera landing root in `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs:326-343`;
- genera sitemap lingua e sitemap index in `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs:532-564`.

Configurazione attuale:

- `BlogSettings:OutputPath` e' un path Windows in `src/RugbyRadio/HF/appsettings.json:9-11`.
- `BlogSettings:BlogDomain` punta all'hostname blog attuale in `src/RugbyRadio/HF/appsettings.json:10-11`.
- `src/RugbyRadioBlog` contiene gia' output statici HTML e sitemap.

Implicazione Docker:

- `BlogSettings:OutputPath` deve diventare configurabile via environment variable e puntare a un mounted volume persistente condiviso con il servizio che serve il Blog.
- Le URL hardcoded verso storage attuale vanno inventariate prima di passare a hostname UAT.

## Sitemap / SEO

La generazione sitemap e' svolta da `GenerateSeoSitemapJob`:

- definisce sitemap root, static, matches, channels e teams in `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs:18-22`;
- calcola i file statici candidati in `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs:24-49`;
- scrive sitemap in `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs:84-115`;
- usa `SeoSitemap:OutputPath` e `SeoSitemap:StaticFilesPath` in `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs:118-152`;
- scrive XML in modo atomico in `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs:167-204`.

Configurazione attuale:

- `SeoSitemap:OutputPath` e `SeoSitemap:StaticFilesPath` sono path Windows in `src/RugbyRadio/HF/appsettings.json:14-17`.
- `src/RugbyRadioSitemap` contiene file XML statici generati.
- Il frontend Firebase contiene un `sitemap.xml` che punta agli hostname attuali in `src/RugbyRadioWeb/src/sitemap.xml:4-13`.

Implicazione Docker:

- `src/RugbyRadioSitemap` corrisponde al contenuto del servizio `rrl-seo`/sitemap, ma il nome `rrl-seo` va confermato.
- Il container che serve sitemap deve leggere un volume persistente aggiornato da HF, oppure va confermata un'alternativa.

## Storage

Non e' stato individuato un progetto server `RugbyRadioStorage`. Lo storage attuale appare come filesystem statico sotto path Windows, manipolato da API/HF e pubblicato dall'hosting corrente.

Evidenze principali:

- `src/RugbyRadio/Lib/Types/UrlType.cs:8-14` definisce path Windows per immagini match/canali e varianti Instagram.
- `src/RugbyRadio/Lib/Services/VoiceService.cs:41` usa un path Windows per audio MP3.
- `src/RugbyRadio/Lib/Services/VoiceService.cs:123` compone path sotto `D:\Web\RugbyRadioStorage`.
- `src/RugbyRadio/Api/Controllers/VoicesV1Controller.cs:75` rimuove il prefisso Windows dal path audio restituito.
- HF legge/scrive immagini tramite `UrlType` in vari job e servizi, ad esempio `src/RugbyRadio/HF/Services/MatchImageAssigner.cs:28-43` e `src/RugbyRadio/HF/Services/ChannelImageAssigner.cs:16-29`.
- Il frontend usa `storage-sh.rugbyradiolive.com` per media e audio in `src/RugbyRadioWeb/src/app/environments/environment.ts:6-7` e `src/RugbyRadioWeb/src/app/environments/environment.prod.ts:6-7`.

Implicazione Docker:

- Serve decidere come implementare `rrl-storage`: probabilmente container static-file/reverse-proxy su volume persistente, non una app .NET dedicata.
- Prima di implementare, tutti i path `UrlType` e `VoiceService` devono diventare configurabili.

## Accessi al filesystem

Accessi rilevanti per Docker/Linux:

- Storage immagini: `src/RugbyRadio/Lib/Types/UrlType.cs:8-14`.
- Audio TTS: `src/RugbyRadio/Lib/Services/VoiceService.cs:41`, `src/RugbyRadio/Lib/Services/VoiceService.cs:123`, `src/RugbyRadio/Lib/Services/VoiceService.cs:239-245`.
- Blog output: `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs:97-99`, `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs:233-241`, `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs:341-343`.
- Sitemap output: `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs:86-87`, `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs:171-177`.
- Backup SQL: `src/RugbyRadio/HF/Jobs/MaintenanceJob.cs:48-68`.
- Backup USB configurabile: `src/RugbyRadio/HF/appsettings.json:19-37`.
- Log fallback audit: `src/RugbyRadio/Lib/Core/Middlewares/AuditMiddleware.cs:235-237`.
- File AI talker: `src/RugbyRadio/Api/appsettings.json:9`, `src/RugbyRadio/HF/appsettings.json:5`, e letture in `SystemMessageService`/`AiOllamaService`.

Questi accessi devono essere convertiti a path Linux/container e volumi persistenti o configurazioni esterne.

## Configurazioni Windows/IIS

Dipendenze o tracce Windows/IIS:

- Path `D:\Web\...` per Blog, Sitemap e Storage.
- Path `D:\Sql\Backup` per backup.
- Path `C:\Repositories\...` in `src/RugbyRadio/HF/Jobs/Social/FacebookJob.cs:74` e commenti vicini.
- API ha profilo IIS Express in `src/RugbyRadio/Api/Properties/launchSettings.json:3-10` e `src/RugbyRadio/Api/Properties/launchSettings.json:22-29`.
- API ha profilo Kestrel su `http://localhost:5100` in `src/RugbyRadio/Api/Properties/launchSettings.json:12-20`.
- HF non ha `launchSettings.json` rilevato.

Non sono stati trovati riferimenti diretti a Windows Service o `UseWindowsService`.

## Secrets e configurazione

Sono presenti valori sensibili o operativi in configurazioni locali/versionate. Per sicurezza, questo report non riporta i valori.

Evidenze:

- connection string con utente/password in `src/RugbyRadio/Api/appsettings.json:7-10`;
- connection string App/HF con utente/password in `src/RugbyRadio/HF/appsettings.json:2-6`;
- chiave JWT in `src/RugbyRadio/Api/appsettings.json:13-18` e `src/RugbyRadio/HF/appsettings.json:39-44`;
- credenziali SMTP in `src/RugbyRadio/Api/appsettings.json:26-31` e `src/RugbyRadio/HF/appsettings.json:46-51`;
- Meta/Facebook secret in `src/RugbyRadio/HF/appsettings.json:53-59`;
- Sentry DSN e `SendDefaultPii` in `src/RugbyRadio/Api/appsettings.json:40-43` e `src/RugbyRadio/HF/appsettings.json:68-71`;
- frontend environment contiene URL e chiavi client Firebase in `src/RugbyRadioWeb/src/app/environments/environment.ts:4-18` e `environment.prod.ts:4-18`.

Implicazione:

- Prima di creare immagini o GHCR, serve `.env.example`, `.gitignore`, rotazione dei secrets reali se sono stati committati, e configurazione runtime tramite environment/secrets esterni.

## Problemi potenziali per Docker/Linux

| Problema | Evidenza | Impatto |
| --- | --- | --- |
| Path Windows hardcoded per Storage | `src/RugbyRadio/Lib/Types/UrlType.cs:8-14` | Container Linux non trova directory e separatori attesi. |
| Path Windows hardcoded per audio | `src/RugbyRadio/Lib/Services/VoiceService.cs:41`, `:123` | TTS/audio non persistono o non vengono serviti. |
| Blog/Sitemap output su `D:\Web` | `src/RugbyRadio/HF/appsettings.json:9-17` | Serve volume Linux condiviso e configurazione esterna. |
| Backup SQL Server su `D:\Sql\Backup` | `src/RugbyRadio/HF/Jobs/MaintenanceJob.cs:48` | Da rendere portabile su Linux/container anche mantenendo SQL Server Express. |
| Firebase key caricata da file locale fisso | `src/RugbyRadio/Api/Program.cs:123-127` | Il container deve ricevere file/secret o configurazione alternativa. |
| Dashboard HF esposta dal processo HF | `src/RugbyRadio/HF/Program.cs:97` | Serve reverse proxy/auth policy prima di esposizione pubblica. |
| `UseHttpsRedirection` in container | `src/RugbyRadio/Api/Program.cs:129`, `src/RugbyRadio/HF/Program.cs:95` | Da verificare dietro reverse proxy TLS termination. |
| CORS `AllowAnyOrigin` | `src/RugbyRadio/Api/Program.cs:64-72` | Non blocca Docker, ma va rivisto per UAT/prod hardening. |
| File statici HF | `src/RugbyRadio/HF/Program.cs:96` | Chiarire se servono solo dashboard assets o anche contenuti pubblici. |

## Impatti dell'ipotesi PostgreSQL/Npgsql

Decisione successiva: questi impatti hanno portato a scartare la migrazione PostgreSQL per UAT e a mantenere SQL Server Express.

| Problema | Evidenza | Impatto |
| --- | --- | --- |
| Provider EF SQL Server esplicito | `Api/Program.cs:31`, `HF/Program.cs:35`, `Lib.csproj:21` | Una conversione provider richiederebbe modifiche trasversali. |
| Hangfire usa SQL Server storage | `HF/Program.cs:74`, `HF.csproj:16` | Cambiare database impatterebbe anche lo storage dei job. |
| Stored procedure SQL Server | `MaintenanceJob.cs:37-38` | `sp_Maintenance` e `sp_Backup` andrebbero riscritte o rimosse. |
| Nessuna migration EF trovata | assenza cartelle `Migrations` | Una baseline PostgreSQL richiederebbe lavoro aggiuntivo non necessario per UAT. |
| Test legati a SQL Server | `RepositoryConstructionTests.cs:82`, `AppDbContextModelTests.cs:72` | I test dovrebbero essere adattati o duplicati. |
| Query LINQ con `.Date` su `DateTime` | es. `ChannelService.cs:256`, `:267` | La semantica andrebbe rivalidata su provider diverso. |
| Uso misto `DateTime.Now`/`UtcNow` | molte occorrenze in API/HF/Lib | Su Linux resta da controllare, ma senza sommare differenze PostgreSQL. |
| Case sensitivity/collation | non configurata in `AppDbContext` | Mantenere SQL Server riduce il rischio di differenze sui confronti stringa. |
| Conversioni custom audit | `AppDbContext.cs:74-84` | Restano da verificare in container, non richiedono conversione provider. |

## Differenze tra codice reale e README VPS

| Tema | README target | Codice reale |
| --- | --- | --- |
| Database | Inizialmente PostgreSQL da valutare per UAT; decisione aggiornata: SQL Server Express | SQL Server esplicito in API, HF e Hangfire storage. |
| EF migrations | Non usate come prerequisito per PostgreSQL | Nessuna cartella migrations individuata. |
| Storage | Servizio/container indipendente | Nessun progetto server dedicato; path statici Windows. |
| Blog | HF scrive volume condiviso letto da Blog | HF scrive `D:\Web\RugbyRadioBlog`; directory statiche presenti in `src/RugbyRadioBlog`. |
| SEO | `rrl-seo` concettuale | Directory `src/RugbyRadioSitemap` con XML generati; naming da confermare. |
| Frontend | Firebase Hosting, fuori VPS | Confermato da `RugbyRadioWeb` con target Firebase prod/uat. |
| Secrets | Non in Git | Configurazioni locali contengono secrets; da bonificare/ruotare. |
| Cloudflare Tunnel | Non obbligatorio su VPS | Wiki descrive hosting attuale con Cloudflare Tunnel. |
| Redis/Metabase | Non installare | Redis non trovato; Metabase citato solo nell'hosting attuale/wiki, non nello stack RRL analizzato. |
| Ollama locale/LLM locali | Non previsti | Dipendenze e servizi OllamaSharp presenti; va verificato se attivi in UAT o solo funzioni esistenti/cloud. |

## Remediation / preparazione per fasi successive

| ID | Priorita | Categoria | Task | Acceptance criteria | Effort |
| --- | --- | --- | --- | --- | --- |
| VPS-001 | P1 | Secrets | Spostare secrets reali fuori da `appsettings*.json`, creare `.env.example`, ruotare secrets se committati. | Nessun secret reale in Git; app parte con env vars/local secrets. | M |
| VPS-002 | P1 | Filesystem | Rendere configurabili i path Storage/Blog/Sitemap/Audio/Backup. | Nessun path `D:\...` necessario per runtime Docker; path Linux documentati. | M |
| VPS-003 | P1 | SQL Server Express | Preparare SQL Server Express locale/VPS con volume persistente e connection string containerizzata. | SQL Server parte in Docker, non e' pubblico e la API lo raggiunge via rete backend. | M |
| VPS-004 | P1 | Hangfire | Mantenere storage Hangfire SQL Server e proteggere dashboard. | HF parte come processo always-on con storage SQL Server e dashboard non esposta liberamente. | M |
| VPS-005 | P2 | Storage | Definire implementazione `rrl-storage` come static server su volume o alternativa approvata. | Storage servito da DNS UAT, dati su volume persistente, niente filesystem effimero. | M |
| VPS-006 | P2 | Blog/SEO | Definire volumi condivisi HF -> Blog e HF -> Sitemap. | Job HF scrivono in volume persistente; servizi statici leggono dagli stessi volumi. | M |
| VPS-007 | P2 | Frontend config | Preparare configurazioni UAT Firebase per nuovi hostname. | `apiUrl`, `storageUrl`, `audioUrl`, blog/sitemap references allineati agli hostname UAT approvati. | S/M |

## Piano proposto per Fase 2

### Candidato consigliato

Containerizzare inizialmente `src/RugbyRadio/Api`.

Motivazione:

- e' il servizio backend pubblico principale;
- e' piu' semplice di HF perche' non deve mantenere job always-on;
- consente di validare build .NET 8, startup Kestrel, configurazione via environment variables, logging e reverse-proxy-readiness;
- permette di affrontare subito i problemi reali di secrets, Firebase key, connection string e `UseHttpsRedirection`;
- evita di affrontare contemporaneamente Blog/Sitemap/Storage/Hangfire.

### Scope Fase 2

In scope:

- Dockerfile API Linux-compatible;
- `.dockerignore` se necessario;
- configurazione runtime da environment variables;
- gestione del file/secret Firebase in modo non hardcoded nell'immagine;
- startup container e log;
- eventuale endpoint health minimo solo se gia' coerente con pattern esistente o approvato.

Out of scope:

- database reale e porting dati;
- containerizzazione HF;
- containerizzazione Blog/Sitemap/Storage;
- GHCR/GitHub Actions;
- reverse proxy pubblico;
- DNS;
- modifica frontend Firebase;
- modifica PROD.

### Verifiche minime Fase 2

- `docker build` dell'API.
- `docker run` o compose minimo.
- variabili ambiente lette correttamente.
- container avviato con Kestrel.
- log leggibili su stdout/stderr o configurazione coerente.
- nessun secret incorporato nell'immagine.
- documentazione di tutto cio' che impedisce startup completa senza SQL Server reale.

## Open questions

- Quale repository/branch applicativo e' la fonte ufficiale da modificare per Docker? La root `C:\Repositories\RRL` non risulta usabile come repository Git da questo contesto, mentre `docs` lo e'.
- `src/RugbyRadioWeb` e' confermato come frontend Angular in uso, sostituendo l'appunto `src/RugbyRadio/Web`?
- `rrl-seo` deve servire esattamente i file di `src/RugbyRadioSitemap` o va rinominato concettualmente in `rrl-sitemap`?
- Esiste un progetto o configurazione IIS separata per servire `RugbyRadioStorage`, Blog e Sitemap non presente nel repository?
- Le stored procedure `sp_Maintenance` e `sp_Backup` sono ancora necessarie in UAT Docker/SQL Server Express o vanno escluse/riprogettate?
- Le funzionalita' OllamaSharp sono operative in UAT o vanno trattate come legacy/future AI cloud?
- Quale sara' il formato desiderato per esporre la Firebase key nel container API: file montato, secret Docker, variabile base64 o altra opzione?

## Validation performed

Comandi/controlli eseguiti:

- inventario file con `rg --files`;
- lettura `AGENTS.md`, README root, README VPS e wiki rilevante;
- lettura `.sln`, `.csproj`, `Program.cs`, `appsettings.json`, launch settings e file job principali;
- ricerca mirata di SQL Server, Hangfire, path Windows, filesystem, Blog/Sitemap/Storage e configurazioni frontend.

Non sono stati eseguiti build o test perche' il punto 1 richiede analisi senza modifiche e il sandbox corrente consente scrittura solo sotto `C:\Repositories\RRL\docs`; build/test .NET scriverebbero `bin/obj` sotto `C:\Repositories\RRL\src`.

## Stop point

Fermarsi qui.

Prima di passare alla Fase 2 serve approvazione esplicita su:

- usare `src/RugbyRadio/Api` come prima applicazione da containerizzare;
- trattare `src/RugbyRadioWeb` come frontend Angular in uso e fuori scope VPS;
- trattare `src/RugbyRadioSitemap` come servizio statico `rrl-seo`/sitemap da confermare;
- non implementare ancora database completo, HF, Blog, Storage, DNS o CI.
