# 02 - Docker locale prima applicazione

## Scopo

Rendere avviabile in Docker, in locale, il primo componente runtime della migrazione VPS: `src/RugbyRadio/Api`.

La scelta confermata e' di limitare questo step alla sola API, lasciando fuori:

- frontend Angular `src/RugbyRadioWeb`;
- sitemap/static SEO `src/RugbyRadioSitemap`;
- Hangfire `src/RugbyRadio/HF`;
- database reale SQL Server Express;
- blog statico;
- storage definitivo;
- DNS e CI/CD.

Questo consente di validare prima il runtime containerizzato della API senza mescolare problemi applicativi, database, job schedulati e pubblicazione.

## Modifiche effettuate

### Configurazione Firebase

File modificato:

- `C:\Repositories\RRL\src\RugbyRadio\Api\Program.cs`

La API non usa piu' un path Firebase fisso a `FirebaseKey.json`.

Il path delle credenziali Firebase viene letto da configurazione:

```csharp
var firebaseCredentialsPath = builder.Configuration["Firebase:CredentialsPath"] ?? "FirebaseKey.json";
```

In locale tradizionale resta compatibile con `FirebaseKey.json`; in container il file viene montato come secret/bind mount su `/run/secrets/firebase-key.json`.

### Configurazione container

File aggiunto:

- `C:\Repositories\RRL\src\RugbyRadio\Api\appsettings.Container.json`

Contiene solo configurazioni non sensibili per l'ambiente `Container`.

Le configurazioni sensibili sono escluse dal file e devono arrivare da variabili d'ambiente o secret mount.

### Compose locale della API

File aggiunto:

- `C:\Repositories\RRL\src\RugbyRadio\compose.api.yml`
- `C:\Repositories\RRL\src\RugbyRadio\.env.api.example`

Definisce il servizio `rrl-api` con:

- build context su `src/RugbyRadio`;
- Dockerfile `Api/Dockerfile`;
- porta host `5100` verso porta container `8080`;
- ambiente `ASPNETCORE_ENVIRONMENT=Container`;
- connection string e segreti risolti da variabili d'ambiente locali;
- Firebase key montata in sola lettura.

Il file e' pensato come harness locale per lo step 2, non come compose definitivo di produzione.

Il file `.env.api.example` documenta le variabili richieste da `compose.api.yml`. Il file reale locale deve chiamarsi `.env.api`, non deve essere committato e deve essere passato esplicitamente a Compose.

## Come funziona `compose.api.yml`

Il file `compose.api.yml` descrive a Docker Compose come costruire e avviare la API senza dover scrivere ogni volta a mano un comando `docker build` e un lungo comando `docker run`.

Il comando tipico sara':

```powershell
docker compose --env-file .env.api -f compose.api.yml up --build
```

Compose legge il file YAML, risolve le variabili, costruisce l'immagine se serve, crea il container e lo avvia con porte, environment e volumi configurati.

### Servizio

```yaml
services:
  rrl-api:
```

`services` e' l'elenco dei container che Compose deve gestire.

In questo step c'e' un solo servizio: `rrl-api`.

In futuro lo stesso compose, o un compose di produzione separato, potra' contenere altri servizi come database, reverse proxy, Hangfire, blog statico o sitemap.

### Build

```yaml
build:
  context: .
  dockerfile: Api/Dockerfile
image: rrl-api:latest
```

`context: .` significa che il build context e' la cartella corrente da cui viene eseguito Compose, cioe' `C:\Repositories\RRL\src\RugbyRadio`.

Il Dockerfile usato e' `Api/Dockerfile`.

Durante la build Docker puo' copiare solo file presenti nel build context. Per questo il Dockerfile puo' fare:

```dockerfile
COPY Api/Api.csproj Api/
COPY Lib/Lib.csproj Lib/
```

perche' sia `Api` sia `Lib` sono dentro `src/RugbyRadio`.

`image: rrl-api:latest` assegna un nome e un tag esplicito all'immagine generata. Dopo la build, l'immagine locale si chiama `rrl-api:latest` e puo' essere riusata da Docker senza ricostruirla ogni volta, salvo modifiche o richiesta esplicita di rebuild.

### Porte

```yaml
ports:
  - "5100:8080"
```

La sintassi e':

```text
porta_host:porta_container
```

Quindi:

- `8080` e' la porta su cui la API ascolta dentro il container;
- `5100` e' la porta esposta sul computer host.

Quando dal browser o da PowerShell si chiama:

```text
http://localhost:5100
```

Docker inoltra la richiesta alla porta `8080` del container.

Questa distinzione e' importante: il processo ASP.NET Core non sa di essere esposto su `5100`; lui ascolta su `8080` dentro il suo piccolo ambiente isolato.

### Variabili d'ambiente del container

```yaml
environment:
  ASPNETCORE_ENVIRONMENT: Container
  ASPNETCORE_URLS: http://+:8080
```

Queste righe creano variabili d'ambiente dentro il container.

ASP.NET Core le legge automaticamente tramite il sistema di configurazione.

`ASPNETCORE_ENVIRONMENT=Container` dice all'applicazione di caricare anche:

```text
appsettings.Container.json
```

oltre alla configurazione base.

`ASPNETCORE_URLS=http://+:8080` dice a Kestrel di ascoltare sulla porta `8080` su tutte le interfacce del container.

### Mapping tra environment e configurazione ASP.NET Core

In ASP.NET Core, le variabili d'ambiente con doppio underscore `__` vengono interpretate come sezioni annidate di configurazione.

Esempio:

```yaml
ConnectionStrings__App: ...
```

diventa equivalente a:

```json
{
  "ConnectionStrings": {
    "App": "..."
  }
}
```

Quindi il codice puo' continuare a leggere:

```csharp
builder.Configuration.GetConnectionString("App")
```

anche se il valore non arriva da `appsettings.json`, ma da una variabile d'ambiente del container.

Lo stesso vale per:

```yaml
Firebase__CredentialsPath: /run/secrets/firebase-key.json
Security__SecretKey: ...
Smtp__Password: ...
Sentry__Dsn: ...
```

che diventano rispettivamente:

- `Firebase:CredentialsPath`;
- `Security:SecretKey`;
- `Smtp:Password`;
- `Sentry:Dsn`.

### Variabili sostituite da Docker Compose

Alcuni valori nel compose usano questa forma:

```yaml
ConnectionStrings__App: ${RRL_API_CONNECTION_STRING:?Set RRL_API_CONNECTION_STRING in your local environment}
```

Questa sostituzione avviene prima che il container parta.

Docker Compose cerca una variabile chiamata `RRL_API_CONNECTION_STRING`:

- prima nelle variabili d'ambiente della shell;
- oppure nel file indicato con `--env-file`, in questo caso `.env.api`.

Se la variabile esiste, Compose la inserisce nel container come valore di `ConnectionStrings__App`.

Se la variabile non esiste, la parte `:?Set RRL_API_CONNECTION_STRING in your local environment` fa fallire Compose con un messaggio esplicito. Questo e' voluto: alcune configurazioni sono obbligatorie e non vogliamo avviare la API con valori mancanti o ambigui.

Esempio locale:

```powershell
$env:RRL_API_CONNECTION_STRING = "..."
$env:RRL_API_SECURITY_SECRET_KEY = "..."
$env:RRL_API_FIREBASE_KEY_PATH = "C:\Repositories\RRL\src\RugbyRadio\Api\FirebaseKey.json"
docker compose -f compose.api.yml up --build
```

In alternativa, ed e' la convenzione consigliata per questo progetto, si puo' creare un file `.env.api` locale non committato partendo dal template `.env.api.example`:

```dotenv
RRL_API_CONNECTION_STRING=...
RRL_API_SECURITY_SECRET_KEY=...
RRL_API_FIREBASE_KEY_PATH=C:\Repositories\RRL\src\RugbyRadio\Api\FirebaseKey.json
```

e avviare Compose con:

```powershell
docker compose --env-file .env.api -f compose.api.yml up --build
```

La scelta del nome non e' casuale:

```text
compose.api.yml
.env.api.example
.env.api
```

In questo modo il file env della API resta distinto dai futuri file env di Hangfire o dello stack completo.

Il file `.gitignore` e' stato aggiornato apposta per evitare di versionare questi file.

### Valori obbligatori e valori con default

Nel compose ci sono due forme principali.

Forma obbligatoria:

```yaml
${NOME_VARIABILE:?messaggio di errore}
```

Significa: se `NOME_VARIABILE` non e' valorizzata, Compose deve fermarsi.

La usiamo per:

- connection string applicativa;
- secret key JWT;
- path locale della Firebase key.

Forma con default:

```yaml
${NOME_VARIABILE:-valore_default}
```

Significa: se `NOME_VARIABILE` non e' valorizzata, usa `valore_default`.

Esempi:

```yaml
Security__ExpirationMinutes: ${RRL_API_SECURITY_EXPIRATION_MINUTES:-525600}
Smtp__Port: ${RRL_API_SMTP_PORT:-465}
Sentry__SendDefaultPii: ${RRL_API_SENTRY_SEND_DEFAULT_PII:-false}
```

La usiamo quando un valore ragionevole puo' esistere anche in assenza di configurazione esplicita.

Forma opzionale vuota:

```yaml
${NOME_VARIABILE:-}
```

Significa: se `NOME_VARIABILE` non e' valorizzata, passa stringa vuota.

La usiamo per integrazioni che possono restare disabilitate in locale, ad esempio Sentry, SMTP o Google Client ID.

### Firebase key come volume

```yaml
volumes:
  - type: bind
    source: ${RRL_API_FIREBASE_KEY_PATH:?Set RRL_API_FIREBASE_KEY_PATH to your local Firebase key JSON}
    target: /run/secrets/firebase-key.json
    read_only: true
```

Questo non copia la Firebase key dentro l'immagine Docker.

Fa invece un bind mount:

- `source` e' il file reale sul computer host;
- `target` e' il path con cui quel file appare dentro il container;
- `read_only: true` impedisce al container di modificarlo.

Dentro il container la API vede quindi:

```text
/run/secrets/firebase-key.json
```

e `Program.cs` lo legge tramite:

```csharp
builder.Configuration["Firebase:CredentialsPath"]
```

Questo approccio e' importante perche':

- l'immagine Docker resta riusabile e priva di segreti;
- il file Firebase resta fuori dal repository;
- in produzione si potra' sostituire il bind mount locale con un secret o con un meccanismo equivalente del server.

### Ordine di precedenza pratico della configurazione

Per questa API, in ambiente container, il flusso pratico e':

1. Docker costruisce l'immagine usando `Api/Dockerfile`.
2. `.dockerignore` impedisce di includere configurazioni e chiavi reali nel build context.
3. Compose risolve le variabili `${...}` usando shell o `.env.api`.
4. Compose crea il container e imposta le variabili sotto `environment`.
5. Compose monta la Firebase key nel path `/run/secrets/firebase-key.json`.
6. ASP.NET Core parte con `ASPNETCORE_ENVIRONMENT=Container`.
7. ASP.NET Core carica `appsettings.Container.json`.
8. ASP.NET Core applica le variabili d'ambiente, che hanno precedenza sulla configurazione da file.
9. Il codice legge i valori finali da `builder.Configuration`.

In breve: i valori non sensibili stanno nel file `appsettings.Container.json`; i valori sensibili o variabili per ambiente arrivano da environment/secret al momento dell'avvio del container.

### Esclusione segreti dal build context

File modificato:

- `C:\Repositories\RRL\src\RugbyRadio\.dockerignore`

Sono ora esclusi dal build context:

- `appsettings.json`;
- `appsettings.Production.json`;
- file key/Google/Firebase gia' coperti dalle regole esistenti.

Resta invece ammesso:

- `appsettings.Container.json`.

### Template env della API e ignore dei file `.env`

File aggiunto:

- `C:\Repositories\RRL\src\RugbyRadio\.env.api.example`

Questo file contiene l'elenco delle variabili usate da `compose.api.yml`, con placeholder sicuri.

Non e' il file da usare direttamente per eseguire il container. Per l'uso locale va copiato in:

```text
.env.api
```

Il file `.env.api` contiene valori reali locali e non deve essere committato.

La separazione serve perche' API e Hangfire saranno container diversi, con compose diversi e potenzialmente variabili diverse. La convenzione prevista e':

```text
compose.api.yml        -> .env.api.example        -> .env.api
compose.hf.yml         -> .env.hf.example         -> .env.hf
compose.stack.yml      -> .env.stack.example      -> .env.stack
```

File modificato:

- `C:\Repositories\RRL\src\RugbyRadio\.gitignore`

Aggiunte regole per evitare commit accidentali di configurazioni runtime locali:

```gitignore
.env
.env.*
!.env.*.example
!.env.example
```

## Verifiche eseguite

### Build .NET

Comando eseguito da `C:\Repositories\RRL\src\RugbyRadio`:

```powershell
dotnet build RugbyRadio.sln
```

Esito:

- build riuscita;
- 0 errori;
- 53 warning esistenti.

Warning rilevanti da affrontare in seguito:

- vulnerabilita' moderate segnalate su `MailKit 4.12.0`;
- vulnerabilita' moderate segnalate su `OpenTelemetry.Exporter.OpenTelemetryProtocol 1.11.2`;
- diversi warning nullable gia' presenti nel codice.

Questi warning non bloccano lo step 2, ma vanno trattati in uno step di hardening/manutenzione dipendenze.

### Build immagine Docker

Comando eseguito da `C:\Repositories\RRL\src\RugbyRadio`:

```powershell
docker build -f Api/Dockerfile -t rrl-api:latest .
```

Esito:

- build Docker riuscita;
- immagine locale generata come `rrl-api:latest`;
- dopo l'aggiornamento di `.dockerignore`, il build context risulta ridotto e non include gli `appsettings` reali.

### Avvio container

Container temporaneo avviato con:

```powershell
docker run -d --name rrl-api-test -p 5180:8080 ...
```

Esito:

- container in stato `Up`;
- Kestrel in ascolto su `http://[::]:8080`;
- ambiente applicativo rilevato come `Container`;
- content root `/app`.

La chiamata HTTP a `http://localhost:5180/` restituisce `HTTP 404`.

Questo e' accettato come prova di reachability per lo step 2: la root non espone una route applicativa, ma il processo ASP.NET Core risponde correttamente.

### Ispezione configurazione nell'immagine

Comando eseguito:

```powershell
docker run --rm --entrypoint sh rrl-api:latest -c "find /app -maxdepth 1 -name 'appsettings*.json' -print | sort"
```

Esito:

```text
/app/appsettings.Container.json
```

Quindi l'immagine non contiene `appsettings.json` ne' `appsettings.Production.json`.

## Problemi incontrati e risolti

### Docker Desktop non inizialmente disponibile

Durante la prima verifica Docker, il daemon non era raggiungibile. Docker Desktop e' stato avviato e la build e' poi riuscita.

### Sentry DSN nullo in ambiente Container

Il primo avvio del container e' fallito per configurazione Sentry mancante.

Risoluzione:

- aggiunta configurazione `Sentry:Dsn` vuota in `appsettings.Container.json`;
- impostata esplicitamente anche la possibilita' di override via ambiente.

Con DSN vuoto, Sentry resta disabilitato in locale senza causare crash all'avvio.

## Limiti intenzionali dello step

Questo step non verifica ancora:

- connessione reale a SQL Server;
- configurazione completa SQL Server Express;
- login/autenticazione completa;
- endpoint che interrogano il database;
- Hangfire;
- generazione blog;
- generazione sitemap;
- reverse proxy HTTPS;
- deploy remoto su VPS.

La connection string usata nella verifica e' volutamente un placeholder locale, sufficiente per validare startup e configurazione del container.

## Stato finale

Step 2 completato.

La API puo' essere:

- compilata con `dotnet build`;
- costruita come immagine Docker;
- avviata in container con ambiente `Container`;
- raggiunta da host sulla porta pubblicata;
- distribuita senza includere i file di configurazione reali nell'immagine.

## Condizioni per passare allo step 3

Per procedere allo step 3 serve decidere quale sara' il prossimo asse tecnico:

- preparare SQL Server Express locale in Docker e collegarlo alla API;
- oppure preparare la base VPS/Docker Compose di produzione dopo il database locale;
- oppure introdurre un endpoint health esplicito per distinguere startup applicativa, database readiness e dipendenze esterne.

Decisione aggiornata: non si procede con PostgreSQL. Dato il risultato dello step 2 e gli impatti emersi nello step 1, la raccomandazione e' passare a SQL Server Express locale in Docker, idealmente aggiungendo anche un health endpoint minimo per distinguere processo avviato, database raggiungibile e dipendenze esterne.
