# Guide VPS — Preparazione RRL

Guida operativa per preparare una VPS Contabo appena acquistata per RRL.

La VPS ospita lo stack RRL di produzione. Questa guida documenta la preparazione iniziale e le successive procedure di gestione e ripristino.

## 1. Dati VPS

- Provider: Contabo
- Piano: Cloud VPS 6 (2026)
- IPv4: `77.237.246.2`
- OS: Ubuntu Server 24.04 LTS
- Utente operativo: `stefano`
- Directory applicative: `/srv/containers`
- Progetto RRL: `/srv/containers/rugbyradiolive`
- Componenti condivisi: `/srv/containers/shared`

Non usare directory specifiche di laboratorio come `rrl-lab`.

### Convenzione di naming Docker

I componenti condivisi della VPS usano il prefisso `shared-`, ad esempio `shared-reverse-proxy`, `shared-sqlserver-express` e `shared-portainer`.

Ogni progetto futuro deve avere un prefisso distintivo per container, servizi e, quando opportuno, volumi Docker. RRL usa `rrl-`; un nuovo progetto dovrà usare il proprio prefisso, ad esempio `foo-api`, `foo-worker` e `foo-data`, senza riutilizzare nomi `shared-*` o `rrl-*`.

### Convenzione di naming Docker

I componenti condivisi della VPS usano il prefisso `shared-`, ad esempio `shared-reverse-proxy`, `shared-sqlserver-express` e `shared-portainer`.

Ogni progetto futuro deve avere un prefisso distintivo per container, servizi e, quando opportuno, volumi Docker. RRL usa `rrl-`; un nuovo progetto dovrà usare il proprio prefisso, ad esempio `foo-api`, `foo-worker` e `foo-data`, senza riutilizzare nomi `shared-*` o `rrl-*`.

## 2. Stato già completato

La VPS è stata verificata con:

- Ubuntu Server 24.04.5 LTS;
- 6 vCPU;
- 11 GiB RAM;
- 193 GB disco root;
- accesso SSH iniziale come `root`;
- aggiornamento completo del sistema e riavvio;
- utente `stefano` con privilegi `sudo`;
- accesso SSH tramite chiave ED25519;
- login SSH diretto di `root` disabilitato;
- autenticazione SSH tramite password disabilitata;
- UFW attivo;
- porte consentite: `22`, `80`, `443`;
- Docker Engine `29.1.3`;
- Docker Compose `2.40.3`;
- test `docker run --rm hello-world` riuscito;
- Git installato;
- directory `/srv/containers/shared` e `/srv/containers/rugbyradiolive` create;
- file Compose e template `.env.example` trasferiti in `/srv/containers/rugbyradiolive`.

Il collegamento SSH a GitHub non è configurato e non serve alla produzione: la VPS scaricherà le immagini da GHCR e non farà `git clone`.

### Gestione chiavi SSH per automazione

La chiave pubblica della chiave di deploy viene aggiunta in coda a `/home/stefano/.ssh/authorized_keys`, senza sostituire le chiavi esistenti.

Cambiare PC non richiede di rigenerare la chiave se la chiave privata viene trasferita in modo sicuro sul nuovo PC. La chiave privata usata da GitHub Actions è conservata nel secret GitHub `VPS_SSH_PRIVATE_KEY` e non dipende dal PC locale.

Rigenerare la chiave solo se:

- la chiave privata è stata persa;
- la chiave privata è stata esposta;
- si vuole revocare l'accesso a un dispositivo.

In questi casi aggiungere la nuova chiave pubblica alla VPS, aggiornare il secret GitHub e rimuovere la vecchia chiave da `authorized_keys` dopo la verifica.

### Cambio PC Windows

Per collegarsi dalla nuova macchina trasferire in modo sicuro:

```text
C:\Users\<utente>\.ssh\id_ed25519
C:\Users\<utente>\.ssh\id_ed25519.pub
```

Se sono state usate chiavi dedicate, trasferire anche i file corrispondenti, ad esempio:

```text
rrl-github-actions
rrl-github-actions.pub
```

Trasferire i file solo tramite password manager, supporto cifrato o altro canale protetto. Non inviarli via e-mail o chat.

Il file `known_hosts` è trasferibile ma può anche essere rigenerato collegandosi nuovamente alla VPS e verificando il fingerprint. Il file `config` è opzionale e contiene solo alias/opzioni SSH.

Sul nuovo PC verificare l'accesso:

```powershell
ssh -i "$env:USERPROFILE\.ssh\id_ed25519" stefano@77.237.246.2
```

Per la chiave dedicata alle Actions:

```powershell
ssh -i "$env:USERPROFILE\.ssh\rrl-github-actions" stefano@77.237.246.2
```

Non copiare la chiave privata dentro il repository. Se la chiave privata non è più disponibile, seguire la procedura di revoca e rigenerazione invece di tentare recuperi insicuri.

### Secret GitHub per il deploy automatico

In GitHub: `Settings` → `Secrets and variables` → `Actions` → `New repository secret`.

Creare:

```text
VPS_HOST=77.237.246.2
VPS_USER=stefano
VPS_SSH_PRIVATE_KEY=<contenuto della chiave privata rrl-github-actions>
VPS_KNOWN_HOSTS=<output di ssh-keyscan -H 77.237.246.2>
```

Recuperare la chiave privata sul PC con:

```powershell
Get-Content "$env:USERPROFILE\.ssh\rrl-github-actions"
```

Recuperare `known_hosts` con:

```powershell
ssh-keyscan -H 77.237.246.2
```

Verificare il fingerprint della chiave host prima di salvarla. Non pubblicare nessuno dei valori dei secret.

### Deploy automatico

Il workflow `Deploy VPS` viene avviato da GitHub Actions tramite `workflow_dispatch`.

Parametri:

```text
target: s1, s2 oppure hangfire
deploy_hangfire: true/false quando il target è s1 o s2
image_sha: opzionale; vuoto significa ultimo commit di master
```

Hangfire è un servizio singolo e non ha slot. Il workflow può aggiornarlo da solo oppure insieme allo slot API scelto. L'altro slot API non viene modificato. Per rollback è possibile valorizzare manualmente `image_sha` con uno SHA precedente.

## 3. Struttura runtime

```text
/srv/containers/
├── shared/
│   ├── .env.sqlserver
│   ├── .env.reverse-proxy
│   └── .env.sftp
└── rugbyradiolive/
    ├── compose.*.yml
    ├── .env.api
    ├── .env.hangfire
    ├── .env.registry
    ├── .env.storage
    ├── .env.sftp-blog
    ├── .env.blog
    └── .env.seo
```

I file `.env` reali non devono essere committati o pubblicati.

## 4. File runtime da trasferire

Da PowerShell, nella root del repository:

```powershell
scp compose*.yml .env.*.example stefano@77.237.246.2:/srv/containers/rugbyradiolive/
```

Verificare sulla VPS:

```bash
ls -la /srv/containers/rugbyradiolive
```

Non trasferire:

```text
.env.api
.env.hangfire
.env.registry
.env.sqlserver
FirebaseKey.json
```

Per l'accesso SFTP dedicato al blog usare `compose.sftp-blog.yml` e un `.env.sftp-blog` creato sulla VPS; non riutilizzare le credenziali dell'SFTP storage.

## 5. Database prima delle applicazioni

RRL usa SQL Server Express. Il database è infrastruttura condivisa e non deve essere pubblicato su Internet.

Creare la rete Docker una sola volta:

```bash
docker network create shared-net
```

Preparare il file SQL Server:

```bash
cd /srv/containers/rugbyradiolive
cp .env.sqlserver.example .env.sqlserver
nano .env.sqlserver
```

Impostare almeno:

```text
SHARED_SQLSERVER_SA_PASSWORD=<password-forte>
SHARED_SQLSERVER_HOST_PORT=14333
```

Avviare SQL Server:

```bash
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml up -d
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml ps
docker logs shared-sqlserver-express
```

Il volume persistente è `sqlserver-express-data`.

La porta host `14333` è legata a `127.0.0.1`; SQL Server non è esposto pubblicamente.

### Connessione da SQL Server Management Studio

Dal PC amministrativo aprire un tunnel SSH:

```powershell
ssh -N -o ExitOnForwardFailure=yes -L 11433:127.0.0.1:14333 stefano@77.237.246.2
```

Lasciare aperta la sessione SSH. In SSMS usare `127.0.0.1,11433`, autenticazione SQL Server, login `sa` e la password configurata in `.env.sqlserver`. Se richiesto, abilitare `Trust server certificate`.

Chiudendo la sessione SSH il collegamento SSMS viene interrotto. Non aprire la porta SQL Server su Internet.

## 6. Backup e ripristino database

Non ripristinare backup senza confermare che siano quelli corretti.

Trasferire i backup dalla macchina amministrativa:

```powershell
scp RugbyRadioLive.bak stefano@77.237.246.2:/srv/containers/rugbyradiolive/
scp RugbyRadioLive-HF.bak stefano@77.237.246.2:/srv/containers/rugbyradiolive/
```

Copiarli nel container:

```bash
docker exec shared-sqlserver-express mkdir -p /var/opt/mssql/backup
docker cp RugbyRadioLive.bak shared-sqlserver-express:/var/opt/mssql/backup/RugbyRadioLive.bak
docker cp RugbyRadioLive-HF.bak shared-sqlserver-express:/var/opt/mssql/backup/RugbyRadioLive-HF.bak
```

Prima del restore:

- verificare integrità e provenienza dei file;
- verificare nomi database e logical file name;
- verificare che il database di destinazione non contenga dati da conservare;
- eseguire `RESTORE VERIFYONLY`;
- usare password e comandi senza salvarli nella guida o in Git.

Il restore deve essere eseguito con `sqlcmd` e con percorsi MDF/LDF coerenti con il container SQL Server.

Al termine verificare:

```text
RugbyRadioLive
RugbyRadioLive-HF
```

## 7. Configurazione applicativa

Creare i file reali partendo dai template:

```bash
cd /srv/containers/rugbyradiolive
cp .env.api.example .env.api
cp .env.hangfire.example .env.hangfire
cp .env.registry.example .env.registry
cp .env.reverse-proxy.example .env.reverse-proxy
cp .env.storage.example .env.storage
cp .env.blog.example .env.blog
cp .env.seo.example .env.seo
cp .env.sftp.example .env.sftp
chmod 600 .env.*
```

Configurare le connection string API/Hangfire con:

```text
Server=sql-server-express,1433
```

e con la stessa password SQL Server definita in `.env.sqlserver`.

Configurare inoltre:

- chiave Firebase in un percorso sicuro sulla VPS;
- secret JWT API e Hangfire;
- domini pubblici reali;
- URL pubblici di API, storage, blog e SEO;
- SMTP, Sentry e integrazioni solo se necessari;
- password SFTP forte o, preferibilmente, accesso limitato tramite rete/VPN.

Non usare valori `localhost` in produzione.

Non incollare mai l'output completo di `docker compose config`: contiene i valori risolti degli `.env`, inclusi secret e password. Se viene esposto, ruotare immediatamente le credenziali coinvolte.

Hostname API VPS concordati:

```text
RRL_API_S1_PUBLIC_URL=https://api-s1-vps.rugbyradiolive.com
RRL_API_S2_PUBLIC_URL=https://api-s2-vps.rugbyradiolive.com
```

### Trasferimento Firebase

Il file Firebase deve essere trasferito prima di compilare `.env.api`.

Da PowerShell, dalla cartella che contiene il file:

```powershell
scp .\FirebaseKey.json stefano@77.237.246.2:/srv/containers/rugbyradiolive/
```

Sulla VPS:

```bash
cd /srv/containers/rugbyradiolive
mkdir -p secrets
mv FirebaseKey.json secrets/firebase-key.json
chmod 700 secrets
chmod 600 secrets/firebase-key.json
```

Solo dopo il trasferimento impostare in `.env.api`:

```text
RRL_API_FIREBASE_KEY_PATH=/srv/containers/rugbyradiolive/secrets/firebase-key.json
```

Il file JSON non deve essere committato, incollato in chat o incluso nelle immagini Docker.

## 8. Immagini GHCR

Il workflow CI esegue restore/build/test sui branch configurati, ma pubblica immagini GHCR solo dopo un push su `master`:

- `prod` dal branch `master`;
- un tag immutabile `sha-<commit>` per ogni build pubblicata.

I push sugli altri branch non creano né pubblicano immagini Docker.

Autenticare la VPS senza salvare il token nei file progetto:

```bash
docker login ghcr.io -u stebonf
```

Usare un token con permesso minimo `read:packages`.

Per produzione usare tag SHA, non `latest` e non un tag mobile come unico riferimento.

Esempio `.env.registry`:

```text
GHCR_OWNER=stebonf
RRL_API_S1_IMAGE_TAG=sha-<commit>
RRL_API_S2_IMAGE_TAG=sha-<commit>
RRL_HF_IMAGE_TAG=sha-<commit>
RRL_API_IMAGE_NAME=rrl-api
RRL_HF_IMAGE_NAME=rrl-hangfire
```

## 9. Due slot API

RRL mantiene sempre due servizi:

```text
rrl-api-s1
rrl-api-s2
```

Il file `.env.registry` permette tag indipendenti:

```text
RRL_API_S1_IMAGE_TAG=sha-versione-vecchia
RRL_API_S2_IMAGE_TAG=sha-versione-nuova
```

Regole:

1. scegliere esplicitamente lo slot da aggiornare;
2. modificare solo il tag dello slot scelto;
3. eseguire pull e recreate del solo servizio scelto;
4. verificare log e health check;
5. cambiare il reverse proxy verso lo slot verificato;
6. mantenere l'altro slot per rollback.

Non aggiornare contemporaneamente entrambi gli slot salvo operazione straordinaria concordata.

## 10. Infrastruttura condivisa

Avviare prima i servizi condivisi:

```bash
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml up -d
docker compose --env-file .env.reverse-proxy -f compose.reverse-proxy.yml up -d
docker compose --env-file .env.storage -f compose.storage.yml up -d
docker compose --env-file .env.blog -f compose.blog.yml up -d
docker compose --env-file .env.seo -f compose.seo.yml up -d
docker compose --env-file .env.sftp -f compose.sftp.yml up -d
```

Verificare:

```bash
docker compose -f compose.sqlserver.yml ps
docker ps
docker network inspect shared-net
docker volume ls
```

## 11. Primo avvio applicativo

Dopo database, backup, env e login GHCR:

```bash
cd /srv/containers/rugbyradiolive
docker compose --env-file .env.api --env-file .env.hangfire --env-file .env.registry \
  -f compose.api.yml -f compose.hangfire.yml -f compose.ghcr.yml pull
```

Avviare inizialmente lo slot selezionato e Hangfire secondo il piano di rilascio concordato. Non pubblicare direttamente le porte applicative su Internet.

Verificare:

```bash
docker ps
docker stats
docker compose -f compose.api.yml -f compose.hangfire.yml logs
free -h
df -h
ss -tulpn
```

## 12. Reverse proxy e DNS

Il reverse proxy deve essere l'unico punto pubblico HTTP/HTTPS.

### Configurazione Cloudflare

I nuovi hostname VPS devono usare record `A` verso:

```text
77.237.246.2
```

Record previsti:

```text
api-s1-vps.rugbyradiolive.com  A  77.237.246.2  Proxied
api-s2-vps.rugbyradiolive.com  A  77.237.246.2  Proxied
hf-vps.rugbyradiolive.com      A  77.237.246.2  Proxied
storage-vps.rugbyradiolive.com A  77.237.246.2  Proxied
blog.rugbyradiolive.com        A  77.237.246.2  Proxied
storage-sh.rugbyradiolive.com  A  77.237.246.2  Proxied
seo-sh.rugbyradiolive.com      A  77.237.246.2  Proxied
```

Non indicare porte nei record DNS. Cloudflare deve raggiungere il reverse proxy sulla porta `80`/`443`.

Configurare TLS Cloudflare su `Full (strict)` quando il certificato origin sarà installato sulla VPS.

Per il certificato Cloudflare Origin già disponibile usare:

```text
/srv/containers/rugbyradiolive/reverse-proxy/certs/origin.pem
/srv/containers/rugbyradiolive/reverse-proxy/certs/origin.key
```

Permessi:

```bash
chmod 700 /srv/containers/rugbyradiolive/reverse-proxy/certs
chmod 600 /srv/containers/rugbyradiolive/reverse-proxy/certs/origin.*
```

Per il certificato Cloudflare Origin già disponibile usare:

```text
/srv/containers/rugbyradiolive/reverse-proxy/certs/origin.pem
/srv/containers/rugbyradiolive/reverse-proxy/certs/origin.key
```

Permessi:

```bash
chmod 700 /srv/containers/rugbyradiolive/reverse-proxy/certs
chmod 600 /srv/containers/rugbyradiolive/reverse-proxy/certs/origin.*
```

Non pubblicare direttamente tramite DNS o firewall le porte Docker `5101`, `5102`, `5200` e `2222`. SFTP resta accessibile tramite tunnel SSH.

## Installare Metabase condiviso

Metabase viene aggiunto come servizio shared con container `shared-metabase`, immagine fissata a `metabase/metabase:v0.63.17.3`, raggiungibile dal reverse proxy su `shared-metabase:3000`. Il record DNS è `bi.rugbyradiolive.com` verso `77.237.246.2`, proxied su Cloudflare. Non pubblicare una porta host per Metabase.

Per questa installazione si usa H2, il database interno di Metabase, nel volume Docker `shared-metabase-data`. È una scelta deliberata senza backup: se il volume viene perso si perdono account, dashboard, domande e configurazioni e sarà necessario rifare il setup. Non eliminare questo volume quando si ricrea il container. Metabase raccomanda PostgreSQL per installazioni di produzione e considera H2 adatto alle demo; qui si accetta consapevolmente il relativo rischio di affidabilità.

Creare prima in Cloudflare il record `A bi` verso `77.237.246.2` con proxy attivo. Da PowerShell, nella cartella del repository `RugbyRadio`, trasferire i file:

```powershell
scp .\compose.metabase.yml stefano@77.237.246.2:/srv/containers/shared/
scp .\.env.metabase.example stefano@77.237.246.2:/srv/containers/shared/
```

Sulla VPS creare il file env locale. Prima del primo setup, generare due chiavi diverse e inserirle nel file; non incollarle in chat o nel repository:

```bash
cd /srv/containers/shared
cp .env.metabase.example .env.metabase
chmod 600 .env.metabase
openssl rand -base64 32
openssl rand -base64 32
nano .env.metabase
```

Usare i due risultati rispettivamente per `MB_ENCRYPTION_SECRET_KEY` e `MB_SESSION_SECRET_KEY`, poi conservarli in un password manager. La prima protegge le credenziali delle sorgenti dati salvate da Metabase: non perderla né cambiarla, altrimenti tali credenziali non saranno più leggibili. La seconda firma le sessioni; cambiarla invalida le sessioni attive. Se Metabase è già stato avviato senza `MB_ENCRYPTION_SECRET_KEY`, l'H2 può essere già inizializzato: se all'avvio compare l'errore che richiede `enable-encryption`, arrestare il servizio, eseguire la migrazione CLI con la chiave impostata, quindi riavviarlo. Metabase raccomanda un backup prima della migrazione; l'installazione corrente ha scelto di non mantenere backup H2, quindi si accetta il rischio di perdita della configurazione in caso di errore.

Avviare quindi Metabase:

```bash
docker compose --env-file .env.metabase -f compose.metabase.yml pull
docker compose --env-file .env.metabase -f compose.metabase.yml up -d
docker logs -f shared-metabase
```

Se il log riporta `MB_ENCRYPTION_SECRET_KEY is set but the database is not marked as encrypted`, eseguire la migrazione una sola volta (il container applicativo deve essere fermo):

```bash
docker compose --env-file .env.metabase -f compose.metabase.yml stop shared-metabase
docker compose --env-file .env.metabase -f compose.metabase.yml run --rm --no-deps shared-metabase enable-encryption
docker compose --env-file .env.metabase -f compose.metabase.yml up -d shared-metabase
docker logs --tail 80 shared-metabase
```

Attendere il messaggio di avvio completato nei log e uscire dalla visualizzazione con `Ctrl+C` (il container continua a funzionare). Solo dopo trasferire il template Nginx aggiornato e ricreare il reverse proxy:

```bash
```

Da PowerShell, nella cartella del repository:

```powershell
scp .\reverse-proxy\nginx.conf.template stefano@77.237.246.2:/srv/containers/rugbyradiolive/reverse-proxy/nginx.conf.template
```

Poi sulla VPS:

```bash
docker exec shared-reverse-proxy nginx -t
cd /srv/containers/rugbyradiolive
docker compose --env-file .env.reverse-proxy -f compose.reverse-proxy.yml up -d --force-recreate
```

Aprire `https://bi.rugbyradiolive.com`, completare il setup e creare utenti Metabase distinti con password robuste. SQL Server si aggiunge in Metabase come sorgente dati usando l'hostname Docker `sql-server-express`, porta `1433` e un login SQL dedicato in sola lettura. Non usare `sa` per le query BI.

## Portainer: gestione grafica Docker

Portainer CE viene installato come container separato. Usa il socket Docker per amministrare il motore, quindi equivale a un accesso amministrativo alla VPS.

Configurazione iniziale sicura:

- compose: `compose.portainer.yml`;
- volume dedicato: `portainer-data`;
- porta pubblicata solo su `127.0.0.1:9443`;
- accesso tramite tunnel SSH, senza DNS pubblico e senza apertura firewall.

Sul PC creare il tunnel:

```powershell
ssh -N -L 9443:127.0.0.1:9443 stefano@77.237.246.2
```

Poi aprire nel browser:

```text
https://localhost:9443
```

Il certificato iniziale di Portainer è autofirmato: accettare l'avviso solo per `localhost`.

Nelle versioni recenti Portainer richiede anche un Setup Token iniziale. Recuperarlo subito dopo l'avvio:

```bash
docker logs shared-portainer 2>&1 | grep -i setup_token
```

Inserire nel browser il token visualizzato, quindi completare la creazione dell'utente amministratore. Non usare la password di SSH o una password già usata altrove. La configurazione iniziale deve essere completata entro pochi minuti dall'avvio; in caso di scadenza:

```bash
docker compose -f compose.portainer.yml restart
```

Installazione sulla VPS:

```bash
cd /srv/containers/rugbyradiolive
docker compose -f compose.portainer.yml pull
docker compose -f compose.portainer.yml up -d
docker compose -f compose.portainer.yml ps
```

Non usare `--remove-orphans`: Portainer appartiene a un progetto Compose separato e i container applicativi non devono essere modificati.

In seguito, se servirà un accesso via hostname, usare Cloudflare Access o VPN prima di pubblicare Portainer tramite reverse proxy.

Prima di rendere operativi i record occorre:

- esporre il reverse proxy su `80` e `443`;
- configurare i virtual host per i quattro hostname;
- installare e verificare TLS origin;
- verificare gli endpoint attraverso Cloudflare.

Prima dello switch:

- configurare il dominio reale;
- configurare TLS/Cloudflare;
- verificare l'upstream dello slot attivo;
- verificare che SQL Server e SFTP non siano pubblici;
- verificare API, storage, blog e sitemap dall'esterno.

Il frontend non viene puntato alla VPS finché lo stack non supera i test applicativi.

## Blocco obbligatorio prima della produzione

Prima di migrare il database di produzione e cambiare i puntamenti del frontend di produzione è obbligatorio:

- ruotare la password SQL `sa` esposta durante la pre-verifica;
- ruotare i secret JWT API e Hangfire;
- ruotare la password SMTP esposta, se ancora valida;
- aggiornare tutti i file `.env` con i nuovi valori;
- verificare nuovamente accesso database, API e Hangfire;
- solo dopo procedere con il backup/database definitivo;
- solo dopo aggiornare DNS e puntamenti del frontend.

## 13. Sostituzione successiva del database

Quando la VPS è verificata:

1. fermare o mettere in manutenzione le API;
2. effettuare backup della situazione corrente;
3. sostituire il database con l'ultimo backup approvato;
4. verificare conteggi, schema e job Hangfire;
5. riavviare lo slot API verificato;
6. eseguire test funzionali;
7. cambiare i puntamenti del frontend;
8. monitorare errori e log.

## 14. Verifica finale

La VPS è pronta quando:

- SSH con chiave funziona;
- root/password SSH restano disabilitati;
- UFW consente solo `22`, `80`, `443`;
- Docker e Compose funzionano;
- SQL Server è persistente e non pubblico;
- i backup sono stati verificati e ripristinati;
- GHCR pull funziona con `read:packages`;
- API s1 e s2 usano tag indipendenti;
- Hangfire è Always On;
- reverse proxy e DNS funzionano;
- storage, blog e SEO sono raggiungibili;
- il frontend viene puntato solo alla fine;
- log, restart e rollback sono stati provati.

## 15. TODO ordinata per la migrazione in produzione

1. Rinnovare la VPS prima della fine del mese di prova: verificare scadenza, piano, metodo di pagamento e rinnovo automatico nel pannello Contabo.
2. [x] Completare i test del frontend UAT contro API s1/s2, Hangfire e storage.
3. [x] Configurare una connessione SFTP dedicata al volume del blog e verificare il caricamento delle pagine esistenti.
4. [x] Definire la procedura di backup completo di SQL Server e produrre un backup verificabile.
5. [n/a] Connessione SFTP dedicata ai backup SQL Server: non necessaria, perché la destinazione scelta è Google Drive tramite `rclone`.
6. [x] Automatizzare il backup SQL Server: esecuzione giornaliera, cifratura, trasferimento cloud e conservazione delle ultime 5 copie per database.
7. [x] Configurare lo spazio cloud per i backup: Google Drive tramite `rclone` con credenziali dedicate.
8. [n/a per ora] Restore da cloud: previsto solo in caso di disaster recovery, non richiesto nella pre-verifica.
9. [x] Pubblicare su `master` e verificare le automazioni GitHub Actions per deploy API a slot e Hangfire.
10. Studiare e implementare il backup completo dei contenuti applicativi: `rrl-storage-data`, immagini, audio, file statici, `rrl-blog-content` e `rrl-seo-content`.
11. [x] Ruotare tutte le credenziali di produzione: SQL `sa`, JWT, SMTP, Hangfire, SFTP, GHCR e altri secret applicativi.
12. [x] Aggiornare gli `.env` con i nuovi secret e verificare nuovamente API, Hangfire, storage e database.
13. [x] Eseguire il backup finale del database attuale e ripristinare l'ultimo backup approvato di produzione.
14. [x] Migrare i file di produzione: storage, immagini, blog e SEO.
15. [x] Eseguire i test funzionali finali con il database e i contenuti di produzione.
16. [x] Configurare/verificare il deploy dello slot API scelto e mantenere l'altro slot come rollback.
17. [x] Cambiare i puntamenti DNS del blog e SEO durante la finestra di migrazione.
18. [x] Cambiare i puntamenti del frontend di produzione verso le API VPS e verificare il funzionamento end-to-end.
19. Monitorare log, risorse e errori dopo lo switch; mantenere il piano di rollback pronto.

### Regola storage: nomi sempre lowercase

API, Hangfire e frontend devono usare esclusivamente path relativi storage in lowercase e con slash `/`. Il frontend rimuove inoltre le slash duplicate tra base URL e path.

Per bonificare il volume esistente, trasferire `scripts/normalize-storage-lowercase.sh` sulla VPS e lanciare prima l'anteprima:

```bash
sudo bash /srv/containers/rugbyradiolive/scripts/normalize-storage-lowercase.sh --dry-run
```

Se non vengono segnalate collisioni, applicare:

```bash
sudo bash /srv/containers/rugbyradiolive/scripts/normalize-storage-lowercase.sh --apply
```

Dopo la bonifica verificare immagini e media dal FE; in caso di collisione decidere manualmente quale file conservare prima di ripetere lo script.

Attività opzionale successiva: installare Netdata per grafici storici e alert. Non ci sono altri container applicativi obbligatori da aggiungere; Portainer è già installato.

## Rinnovo VPS

Prima della fine del mese di prova verificare nel pannello Contabo la data di scadenza, il piano, il metodo di pagamento e il rinnovo automatico. Il rinnovo deve essere confermato prima di procedere con la migrazione produttiva.

## 16. Stato corrente

La VPS è stata preparata fino al trasferimento dei file Compose e dei template `.env.example`.

Restano da fare, in ordine:

1. preparazione `.env.sqlserver`;
2. avvio SQL Server;
3. trasferimento e restore del backup approvato;
4. configurazione env applicativi;
5. configurazione token GHCR;
6. avvio infrastruttura condivisa;
7. deploy controllato di uno slot API;
8. verifica applicativa;
9. configurazione reverse proxy/DNS;
10. sostituzione database definitiva;
11. aggiornamento puntamenti frontend.
