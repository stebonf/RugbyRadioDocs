# Guide

## Convenzione di naming Docker

I componenti condivisi usano il prefisso `shared-`. Ogni progetto deve usare un prefisso proprio e riconoscibile per container, servizi e volumi, evitando collisioni con `shared-*` e con i prefissi degli altri progetti. Per RRL il prefisso applicativo è `rrl-`.

## 0. Prerequisiti

- Docker Desktop avviato
- PowerShell
- repository disponibili in `C:\Repositories\RRL`
- file Firebase key disponibile
- password SQL Server scelta
- eventuale backup `.bak` disponibile

## 1. Leggere il piano

```powershell
cd C:\Repositories\RRL\docs
notepad .\projects\vps\README.md
```

```powershell
Get-ChildItem .\projects\vps\plan
Get-ChildItem .\projects\vps\decisions
Get-ChildItem .\projects\vps\results
```

## 2. Verificare struttura repository

```powershell
cd C:\Repositories\RRL
Get-ChildItem .\src
```

Controllare che esistano:

```text
src\RugbyRadio\Api
src\RugbyRadio\HF
src\RugbyRadio\Lib
src\RugbyRadio\Tests
src\RugbyRadioWeb
src\RugbyRadioBlog
src\RugbyRadioSitemap
```

## 3. Aprire workspace applicativo

```powershell
cd C:\Repositories\RRL\src\RugbyRadio
```

## 4. Verificare file Docker/env

```powershell
Get-Item .\compose.api.yml
Get-Item .\compose.sqlserver.yml
Get-Item .\compose.sftp.yml
Get-Item .\compose.reverse-proxy.yml
Get-Item .\compose.hangfire.yml
Get-Item .\compose.storage.yml
Get-Item .\compose.blog.yml
Get-Item .\compose.seo.yml
Get-Item .\.env.api.example
Get-Item .\.env.sqlserver.example
Get-Item .\.env.sftp.example
Get-Item .\.env.reverse-proxy.example
Get-Item .\.env.hangfire.example
Get-Item .\.env.storage.example
Get-Item .\.env.blog.example
Get-Item .\.env.seo.example
Get-Item .\Api\Dockerfile
Get-Item .\HF\Dockerfile
Get-Item .\Api\appsettings.Container.json
Get-Item .\sqlserver\backup-database.sql
Get-Item .\sqlserver\restore-database.sql
```

## 5. Build .NET

```powershell
dotnet build .\RugbyRadio.sln
```

## 6. Build immagine API

```powershell
docker build -f .\Api\Dockerfile -t rrl-api:latest .
```

## 7. Preparare env SQL Server

```powershell
Copy-Item .\.env.sqlserver.example .\.env.sqlserver
notepad .\.env.sqlserver
```

Impostare:

```dotenv
SHARED_SQLSERVER_SA_PASSWORD=...
SHARED_SQLSERVER_HOST_PORT=14333
```

## 8. Avviare SQL Server Express

```powershell
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml up -d
```

## 9. Verificare SQL Server

```powershell
docker ps --filter name=sqlserver-express
docker logs sqlserver-express --tail 50
Test-NetConnection -ComputerName 127.0.0.1 -Port 14333
```

## 10. Creare database vuoto

Usare la stessa password impostata in `.env.sqlserver`:

```powershell
$saPassword = "..."
docker exec -e SQLCMDPASSWORD="$saPassword" sqlserver-express /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -C -Q "IF DB_ID(N'RugbyRadioLive') IS NULL CREATE DATABASE [RugbyRadioLive]; SELECT name FROM sys.databases WHERE name = N'RugbyRadioLive';"
```

Se ricevi:

```text
Login failed for user 'sa'.
```

Il volume SQL Server potrebbe essere gia' stato inizializzato con una password diversa.

Controllare di essere nella cartella corretta:

```powershell
Get-Location
```

Deve essere:

```text
C:\Repositories\RRL\src\RugbyRadio
```

Controllare quale volume usa il container:

```powershell
docker inspect sqlserver-express --format "{{range .Mounts}}{{.Name}} {{.Destination}}{{println}}{{end}}"
```

Controllare il file env senza copiarlo in chat:

```powershell
Get-Content .\.env.sqlserver
```

Se hai cambiato `SHARED_SQLSERVER_SA_PASSWORD` dopo il primo avvio, SQL Server non aggiorna automaticamente la password `sa`.

La variabile `MSSQL_SA_PASSWORD` viene usata per inizializzare SQL Server solo quando il volume dati e' vuoto.

Per ambiente locale vuoto, reset completo:

```powershell
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml down -v
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml up -d
```

Attenzione: `down -v` cancella i database locali nel volume.

Se `down -v` non basta e sei sicuro di non avere dati da tenere:

```powershell
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml down
docker volume rm sqlserver-express-data
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml up -d
```

Se invece il volume contiene dati da tenere e conosci la vecchia password:

```powershell
$oldPassword = "..."
$newPassword = "..."
docker exec -e SQLCMDPASSWORD="$oldPassword" sqlserver-express /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -C -Q "ALTER LOGIN [sa] WITH PASSWORD = N'$newPassword';"
```

Poi aggiornare `.env.sqlserver` con la nuova password.

## 11. Creare cartella backup nel container

```powershell
docker exec sqlserver-express mkdir -p /var/opt/mssql/backup
```

## 12. Restore database da `.bak`

Saltare questo step se non hai ancora un backup.

```powershell
docker cp C:\path\to\RugbyRadioLive.bak sqlserver-express:/var/opt/mssql/backup/RugbyRadioLive.bak
```

```powershell
docker exec -e SQLCMDPASSWORD="..." sqlserver-express /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -C -Q "RESTORE VERIFYONLY FROM DISK = N'/var/opt/mssql/backup/RugbyRadioLive.bak';"
```

```powershell
docker cp .\sqlserver\restore-database.sql sqlserver-express:/tmp/restore-database.sql
docker exec -e SQLCMDPASSWORD="..." sqlserver-express /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -C -i /tmp/restore-database.sql
```

```powershell
docker exec sqlserver-express rm -f /var/opt/mssql/backup/RugbyRadioLive.bak
```

## 13. Preparare env API

```powershell
Copy-Item .\.env.api.example .\.env.api
notepad .\.env.api
```

Impostare:

```dotenv
RRL_API_CONNECTION_STRING=Server=sql-server-express,1433;Database=RugbyRadioLive;User ID=sa;Password=...;TrustServerCertificate=True;Encrypt=False;
RRL_API_FIREBASE_KEY_PATH=C:\path\to\FirebaseKey.json
RRL_API_SECURITY_SECRET_KEY=...
```

## 14. Avviare API

```powershell
docker compose --env-file .env.api -f compose.api.yml up -d --build
```

Il Compose avvia contemporaneamente:

```text
rrl-api-s1 -> http://localhost:5101
rrl-api-s2 -> http://localhost:5102
```

## 15. Verificare API

```powershell
Invoke-WebRequest -Uri http://localhost:5101/ -UseBasicParsing -SkipHttpErrorCheck
Invoke-WebRequest -Uri http://localhost:5102/ -UseBasicParsing -SkipHttpErrorCheck
docker compose --env-file .env.api -f compose.api.yml logs --tail 100
```

## 16. Stop API

```powershell
docker compose --env-file .env.api -f compose.api.yml down
```

## 17. Stop SQL Server

```powershell
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml down
```

## 18. Reset SQL Server completo

Usare solo se vuoi cancellare i dati locali.

```powershell
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml down -v
```

## 19. Step successivo: stack locale completo

Da fare dopo conferma:

```text
API
SQL Server Express
Hangfire
Blog statico
Sitemap/static SEO
Storage
eventuale reverse proxy locale
```

## 20. Step successivo: CI immagini

Da fare dopo conferma:

```text
build immagini
tag immagini
push GHCR
pull da VPS
```

## 21. Step successivo: VPS UAT

Da fare dopo conferma:

```text
VPS Ubuntu
Docker Engine
compose runtime
env reali fuori Git
restore database
avvio stack
```

## 22. Step successivo: DNS e reverse proxy

Da fare dopo conferma:

```text
hostname UAT
Cloudflare
HTTPS
reverse proxy
solo porte pubbliche approvate
```

## 23. Step successivo: monitoraggio

Da fare dopo conferma:

```text
docker stats
logs
restart
reboot
spazio disco
job Hangfire
```

## 24. Step successivo: disaster recovery

Da fare dopo conferma:

```text
nuova VPS
restore database
restore storage/contenuti
docker compose up
verifica UAT
tempo totale ricostruzione
```

## 25. Avvio automatizzato locale

Per eseguire in sequenza l'avvio di SQL Server, la verifica della password, la creazione o il restore del database e l'avvio dell'API, usare:

```powershell
cd C:\Repositories\RRL\docs
.\projects\vps\scripts\Initialize-LocalRrl.ps1
```

Prima modificare i parametri iniziali, inclusi password e secret locali, in:

```text
projects\vps\scripts\Initialize-LocalRrl.ps1
```

Gli URL locali e i futuri DNS sono raccolti nella sezione `URL PUBBLICI / DNS` dello script:

```powershell
$ApiS1PublicUrl
$ApiS2PublicUrl
$HangfirePublicUrl
$StoragePublicUrl
$BlogPublicUrl
$SeoPublicUrl
$ReverseProxyPublicUrl
```

Lo script trasferisce questi valori nei file `.env` durante l'esecuzione. I template `.env.*.example` non contengono quindi i valori specifici dell'ambiente corrente.

Lo script genera automaticamente `src\RugbyRadio\.env.sqlserver`, `src\RugbyRadio\.env.api` e `src\RugbyRadio\.env.hangfire` a partire dai rispettivi template, usando una sola password SQL Server per SQL Server, API e Hangfire. I file `.env` di lavoro vengono sovrascritti a ogni esecuzione; i valori configurati nello script devono quindi essere la fonte di verita' durante questa fase locale.
La rete Docker condivisa `shared-net` viene creata automaticamente dallo script se non esiste.

I file Compose dichiarano due nomi di progetto Docker Desktop:

```text
shared -> SQL Server Express e SFTP
rrl    -> API, Hangfire, Storage, Blog e SEO
```

Il raggruppamento è ottenuto tramite il campo Compose `name:`. I container mantengono comunque i nomi espliciti definiti nei rispettivi file.

Per eseguire il reset completo, il restore dei due database e l'avvio di API S1, API S2 e Hangfire usare:

```powershell
.\projects\vps\scripts\Initialize-LocalRrl.ps1
```

La verifica del backup non richiede `WITH CHECKSUM`, perché i backup sorgente possono non contenere informazioni checksum.

Prima di avviare API e Hangfire, lo script chiede username GitHub e token con permesso `read:packages`, esegue il login a `ghcr.io` e scarica le immagini private con tag `feat-vps`. Il token viene usato solo via standard input e non viene scritto nei file del progetto.

Lo script non accetta flag: ogni esecuzione rimuove i container API/Hangfire, cancella il volume SQL Server, ripristina `$BackupFile` e `$HangfireBackupFile`, quindi ricrea e avvia tutto lo stack. API e Hangfire vengono avviati con `compose.ghcr.yml`, che sostituisce il build locale con le immagini GHCR.

Attenzione: l'esecuzione e' sempre distruttiva per i dati locali presenti nel volume `sqlserver-express-data`.

## 27. Storage/CDN locale

Lo storage condiviso usa il container `rrl-storage`, il volume persistente `rrl-storage-data` e la rete `shared-net`.

Il contenuto iniziale viene copiato ricorsivamente dalla cartella configurata nella variabile `$StorageBackupPath` dello script:

```text
C:\Repositories\RRL\backup\RugbyRadioStorage
```

Il container pubblica i file statici su `http://localhost:5300`.

API S1, API S2 e Hangfire montano lo stesso volume in `/data/storage` con permessi di scrittura. Il percorso applicativo viene configurato tramite `RRL_STORAGE_ROOT_PATH=/data/storage`; in questo modo i job Hangfire e le API scrivono nello stesso contenuto che `rrl-storage` espone come CDN.

Lo script ricrea anche il volume dello storage a ogni esecuzione. Per questo il backup sorgente deve essere presente e completo, comprese le sottodirectory.

## 30. SFTP condiviso

Il container `rrl-sftp-storage` fornisce accesso SFTP in lettura/scrittura al volume `rrl-storage-data`, condiviso con `rrl-storage`, API e Hangfire. Il servizio non è legato al progetto RRL e appartiene al gruppo Docker Desktop `shared` insieme a SQL Server.

In locale il servizio ascolta su:

```text
127.0.0.1:2222
```

Parametri generati dallo script nel file `.env.sftp`:

```dotenv
SHARED_SFTP_HOST_PORT=2222
SHARED_SFTP_USER=storage
SHARED_SFTP_PASSWORD=...
```

La cartella visibile all'utente SFTP è `/storage`, che corrisponde al volume completo `rrl-storage-data`. Un client può collegarsi, ad esempio, con:

```text
Protocollo: SFTP
Host: 127.0.0.1
Porta: 2222
Utente: storage
```

La password viene valorizzata dallo script nella sezione parametri e trasferita nel file env locale. Prima di usare il servizio fuori dal PC locale è necessario sostituire la password di sviluppo, limitare gli IP autorizzati e preferire autenticazione tramite chiave SSH.

## 28. Blog statico locale

Il blog viene servito dal container `rrl-blog` tramite Nginx. Il volume `rrl-blog-content` è montato da Nginx per la pubblicazione e da Hangfire in `/data/blog` per la generazione dei file.

Il contenuto iniziale viene copiato ricorsivamente da:

```text
C:\Repositories\RRL\src\RugbyRadioBlog
```

Durante la copia lo script crea uno staging temporaneo e sostituisce nei file testuali il dominio completo `https://storage-sh.rugbyradiolive.com` con il valore di `$StoragePublicUrl`. La sorgente nel repository non viene modificata; file binari come immagini e font vengono copiati senza trasformazioni.

La pagina predefinita è `index.html`, quindi il sito è raggiungibile su:

```text
http://localhost:5400
```

Lo script ricrea il volume e copia la sorgente prima di avviare Hangfire. Le successive modifiche generate dai job Hangfire vengono servite automaticamente da `rrl-blog` perché i due container condividono lo stesso volume.

Il dominio usato da Hangfire nei link alle immagini del Blog è configurato separatamente:

```dotenv
RRL_HF_STORAGE_PUBLIC_URL=http://localhost:5300
```

In UAT o produzione il valore viene sostituito dallo stesso parametro dello script con il dominio pubblico del CDN. Questa variabile modifica solo gli URL generati nell'HTML; il percorso filesystem resta `RRL_STORAGE_ROOT_PATH=/data/storage`.

## 29. SEO/sitemap statico locale

Il container `rrl-seo` pubblica i file XML presenti in `src\RugbyRadioSitemap` tramite Nginx sulla porta locale:

```text
http://localhost:5500/sitemap.xml
```

Il volume `rrl-seo-content` è montato da Nginx in `/usr/share/nginx/html` e da Hangfire in `/data/seo`. Lo script ricrea il volume a ogni esecuzione e copia i file SEO iniziali prima dell'avvio di API e Hangfire.

Il job Hangfire usa `SeoSitemap__OutputPath=/data/seo`, quindi i file generati o aggiornati diventano immediatamente disponibili tramite `rrl-seo`. Le URL contenute nei sitemap restano quelle canoniche del sito; non vengono sostituite con l'URL locale del container.

Il valore `$SeoPublicUrl` è raccolto nella sezione `URL PUBBLICI / DNS` dello script insieme agli altri endpoint. In locale vale `http://localhost:5500`; in UAT o produzione potrà essere sostituito dal DNS pubblico del servizio SEO.

## 31. Reverse proxy locale

Il reverse proxy è un componente condiviso chiamato `reverse-proxy`, inserito nel progetto Compose `shared` insieme a SQL Server e SFTP. Pubblica una sola porta locale:

```text
http://localhost:8080
```

Il routing usa i domini `.localhost`:

```text
http://api.localhost:8080       -> rrl-api-s1
http://storage.localhost:8080   -> rrl-storage
http://blog.localhost:8080      -> rrl-blog
http://seo.localhost:8080       -> rrl-seo
http://hf.localhost:8080        -> rrl-hangfire
```

La destinazione API attiva è configurata in `SHARED_REVERSE_PROXY_API_UPSTREAM` nel file `.env.reverse-proxy`. Impostando `rrl-api-s2` e ricreando il solo reverse proxy si può provare lo switch tra le due istanze.

Le porte dirette dei container restano disponibili per debug locale; in UAT o produzione il reverse proxy sarà il punto di esposizione pubblico e le porte interne non dovranno essere pubblicate.

## 26. Hangfire locale

Il container Hangfire viene avviato dallo script e pubblica la dashboard solo localmente:

```text
rrl-hangfire -> http://localhost:5200
```

Aprire `http://localhost:5200/hangfire`. In locale la dashboard usa `RRL_HF_DASHBOARD_ALLOW_LOCAL=true`; la porta resta pubblicata solo su `127.0.0.1`.

Output generati:

```text
rrl-blog-content -> /data/blog
rrl-seo-content  -> /data/seo
```

I volumi saranno riutilizzati dai futuri container `rrl-blog` e `rrl-seo`.
