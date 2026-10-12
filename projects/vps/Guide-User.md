# Guida utente VPS RRL

Guida operativa per usare la VPS Contabo e mantenere coerente l'ambiente quando verranno aggiunti altri progetti.

Non contiene password, token, chiavi private o valori degli `.env`. Questi dati devono essere conservati in un password manager cifrato.

## 1. Dati principali

| Voce | Valore |
|---|---|
| Provider | Contabo |
| Piano | Cloud VPS 6 (2026) |
| Sistema | Ubuntu 24.04 LTS |
| IPv4 | `77.237.246.2` |
| Utente operativo | `stefano` |
| Root | Solo tramite `sudo`, login SSH root disabilitato |
| Runtime | Docker Engine + Docker Compose |
| Directory runtime | `/srv/containers` |
| Progetto RRL | `/srv/containers/rugbyradiolive` |
| Area condivisa | `/srv/containers/shared` |
| Rete Docker condivisa | `shared-net` |

### Convenzione nomi Docker

Le risorse condivise della VPS usano il prefisso `shared-`, ad esempio `shared-reverse-proxy`, `shared-sqlserver-express` e `shared-portainer`.

Ogni progetto futuro deve usare un prefisso distintivo e coerente per container, servizi e, quando opportuno, volumi Docker. Per RRL il prefisso è `rrl-`; un nuovo progetto dovrà usare ad esempio `foo-api`, `foo-worker` e `foo-data`, senza riutilizzare nomi `shared-*` o `rrl-*`.

## 2. Stato corrente

La VPS ospita RRL in produzione. Metabase è in fase di predisposizione e non va considerato disponibile finché il container e il DNS non sono stati attivati e verificati.

Container previsti/attivi:

| Container | Funzione | Stato operativo/accesso |
|---|---|---|
| `shared-reverse-proxy` | Nginx, TLS e routing HTTP/HTTPS condiviso | Pubblico su porte 80/443 |
| `rrl-api-s1` | API slot 1 | `https://api-s1-vps.rugbyradiolive.com` |
| `rrl-api-s2` | API slot 2 | `https://api-s2-vps.rugbyradiolive.com` |
| `rrl-hangfire` | Job e dashboard Hangfire | `https://hf-vps.rugbyradiolive.com/hangfire` |
| `rrl-storage` | File statici, immagini e media | `https://storage-sh.rugbyradiolive.com` |
| `rrl-blog` | Pagine del blog | `https://blog.rugbyradiolive.com` dopo il cambio DNS |
| `rrl-seo` | Pagine/sitemap SEO | `https://seo-sh.rugbyradiolive.com` per pre-verifica/migrazione; DNS produzione da cambiare se necessario |
| `shared-sqlserver-express` | Database SQL Server Express | Solo VPS: `127.0.0.1:14333`, da SSMS tramite tunnel SSH |
| `rrl-sftp-storage` | Accesso file allo storage | Solo VPS: `127.0.0.1:2222`, tramite tunnel SSH |
| `rrl-sftp-blog` | Accesso file al blog | Solo VPS: `127.0.0.1:2223`, tramite tunnel SSH |
| `shared-portainer` | Gestione grafica Docker | Solo VPS: `127.0.0.1:9443`, tramite tunnel SSH |
| `shared-metabase` | Metabase condiviso, configurazione pronta per l'installazione | `https://bi.rugbyradiolive.com` dopo l'attivazione |

Netdata non è installato. È opzionale e potrà essere aggiunto per grafici storici e alert.

### Metabase

Metabase sarà raggiungibile su `https://bi.rugbyradiolive.com` e userà il login/password gestito da Metabase. Creare account separati per ogni persona dalla sezione amministrativa, senza condividere l'account amministratore. Non è configurata una protezione aggiuntiva davanti al login.

La configurazione applicativa di Metabase è salvata nel volume H2 `shared-metabase-data`, escluso dai backup per scelta. Se il volume viene perso, occorre rifare la configurazione iniziale e ricreare utenti, dashboard e connessioni dati.

Le chiavi `MB_ENCRYPTION_SECRET_KEY` e `MB_SESSION_SECRET_KEY` risiedono solo in `/srv/containers/shared/.env.metabase` (permessi `600`) e nel password manager. La chiave di cifratura è indispensabile per leggere le credenziali delle sorgenti dati salvate; conservarla anche fuori dalla VPS. Non inserirle in repository o guide.

### SQL Server da SQL Server Management Studio

SQL Server ascolta solo sulla VPS e non deve essere esposto pubblicamente. Dal PC aprire:

```powershell
ssh -N -o ExitOnForwardFailure=yes -L 11433:127.0.0.1:14333 stefano@77.237.246.2
```

Lasciare aperta la finestra SSH e configurare SSMS con:

| Campo | Valore |
|---|---|
| Server | `127.0.0.1,11433` |
| Autenticazione | SQL Server Authentication |
| Login | `sa` |
| Password | quella configurata in `.env.sqlserver` |
| Certificato | abilitare `Trust server certificate` se richiesto |

Il tunnel va riaperto se la sessione SSH viene chiusa.

Verifica rapida:

```bash
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
docker volume ls
docker network inspect shared-net
```

## 3. Accesso alla VPS

SSH:

```powershell
ssh stefano@77.237.246.2
```

Per il lavoro ordinario usare l'utente `stefano` con `sudo`. Non usare il login root e non riabilitare l'accesso SSH con password.

### Portainer

Creare un tunnel dal PC e lasciarlo aperto:

```powershell
ssh -N -L 9443:127.0.0.1:9443 stefano@77.237.246.2
```

Aprire [https://localhost:9443](https://localhost:9443). Portainer usa il volume `portainer-data` e controlla Docker tramite il socket; l'accesso deve quindi restare limitato al tunnel SSH.

### SFTP storage

Creare il tunnel:

```powershell
ssh -N -L 2222:127.0.0.1:2222 stefano@77.237.246.2
```

Configurazione del client SFTP:

| Campo | Valore |
|---|---|
| Host | `127.0.0.1` |
| Porta | `2222` |
| Protocollo | SFTP |
| Utente | valore di `SHARED_SFTP_USER` in `.env.sftp` |
| Password | valore di `SHARED_SFTP_PASSWORD` in `.env.sftp` |
| Directory remota | `/storage` |

L'SFTP attuale accede al volume `rrl-storage-data`. Non usarlo per il blog o per i backup SQL: servono utenti/percorso dedicati da configurare.

### Convenzione nomi storage

Tutti i file e i percorsi caricati nello storage devono essere lowercase. API, Hangfire e FE normalizzano i nuovi path; il volume Linux resta case-sensitive.

Per verificare e bonificare i file già presenti:

```bash
sudo bash /srv/containers/rugbyradiolive/scripts/normalize-storage-lowercase.sh --dry-run
sudo bash /srv/containers/rugbyradiolive/scripts/normalize-storage-lowercase.sh --apply
```

Il primo comando è solo anteprima. Non eseguire `--apply` se l'anteprima segnala collisioni: ad esempio `Logo.webp` e `logo.webp` sono due file distinti su Linux ma avrebbero lo stesso nome finale.

### SFTP blog

Il blog usa un servizio SFTP separato e accede solo al volume `rrl-blog-content`.

Creare il tunnel:

```powershell
ssh -N -L 2223:127.0.0.1:2223 stefano@77.237.246.2
```

Configurare il client SFTP con host `127.0.0.1`, porta `2223`, protocollo SFTP, utente e password definiti in `.env.sftp-blog`, directory remota `/blog`.

### SQL Server

SQL Server non è pubblico. Per collegarsi dal PC creare un tunnel:

```powershell
ssh -N -L 14333:127.0.0.1:14333 stefano@77.237.246.2
```

Usare poi `localhost,14333` nel client SQL. La password `sa` non va inserita nella guida.

### Blog e SEO in test locale

Creare un tunnel per il reverse proxy:

```powershell
ssh -N -L 8080:127.0.0.1:8080 stefano@77.237.246.2
```

Per i test HTTP usare gli host locali già configurati dal reverse proxy:

```bash
curl -i -H "Host: blog.localhost" http://127.0.0.1:8080/
curl -i -H "Host: seo.localhost" http://127.0.0.1:8080/
```

I DNS pubblici di blog e SEO non vengono duplicati per UAT; il loro cambio è previsto nella finestra di migrazione in produzione.

## 4. Deploy

### Deploy ordinario: GitHub Actions

Il codice viene pubblicato su `master`. La build crea le immagini GHCR con tag `prod` e `sha-<commit>`.

Per rilasciare:

1. aprire GitHub Actions;
2. selezionare `Deploy VPS`;
3. scegliere `s1`, `s2` oppure `hangfire`;
4. lasciare vuoto `image_sha` per usare automaticamente l'ultimo commit di `master`;
5. avviare il workflow.

Per rollback indicare esplicitamente un tag `sha-<40 caratteri esadecimali>` già pubblicato.

Regola operativa: aggiornare uno slot API alla volta. Lo slot non aggiornato resta disponibile per test o rollback. Hangfire è un servizio unico e non ha slot s1/s2.

### Deploy manuale di emergenza

Da usare solo se GitHub Actions non è disponibile. Sulla VPS:

```bash
cd /srv/containers/rugbyradiolive
./scripts/deploy-vps.sh s1 sha-<40-caratteri>
./scripts/deploy-vps.sh s2 sha-<40-caratteri>
./scripts/deploy-vps.sh hangfire sha-<40-caratteri>
```

Non modificare manualmente i tag degli `.env` come procedura ordinaria e non usare `docker compose down` sui progetti applicativi durante un deploy.

## 5. Schema del network

Tutti i container applicativi, SQL Server, SFTP e reverse proxy condividono la rete Docker esterna `shared-net`. I nomi dei container funzionano come hostname Docker.

```text
Internet / FE UAT / FE produzione
              |
        Cloudflare DNS/TLS
              |
       shared-reverse-proxy :80/:443
          /      |       \                    \
       API s1  API s2   Hangfire          shared-metabase
          \      |       /                    |
             SQL Server <----------------------+ 
                 |
       rrl-storage / blog / seo
                 |
                SFTP

Portainer -- Docker socket (accesso solo via tunnel SSH)
```

Collegamenti principali:

| Origine | Destinazione | Endpoint interno |
|---|---|---|
| Reverse proxy | API s1 | `rrl-api-s1:8080` |
| Reverse proxy | API s2 | `rrl-api-s2:8080` |
| Reverse proxy | Hangfire | `rrl-hangfire:8080` |
| Reverse proxy | Metabase | `shared-metabase:3000` |
| Reverse proxy | Storage | `rrl-storage:80` |
| API | SQL Server | `sql-server-express:1433` |
| Hangfire | SQL Server | `sql-server-express:1433` |
| Metabase | SQL Server (origine dati) | `sql-server-express:1433` |
| API/Hangfire | Storage | volume `rrl-storage-data` |
| Hangfire | Blog | volume `rrl-blog-content` |
| Hangfire | SEO | volume `rrl-seo-content` |
| SFTP | Storage | volume `rrl-storage-data` |

Le porte dirette `5101` e `5102` servono solo per debug e devono essere rimosse o chiuse prima della produzione se non necessarie. Il punto pubblico ufficiale deve restare il reverse proxy.

## 6. Volumi e dati

| Volume | Contenuto |
|---|---|
| `sqlserver-express-data` | File dati SQL Server |
| `rrl-storage-data` | Immagini, media e file statici |
| `rrl-blog-content` | Pagine del blog |
| `rrl-seo-content` | Contenuti/sitemap SEO |
| `portainer-data` | Configurazione Portainer |
| `shared-metabase-data` | Database H2 interno: account, dashboard, domande e configurazione Metabase |

Non cancellare volumi con `docker compose down -v` o `docker volume rm` senza backup e conferma esplicita.

## 7. Backup

### Stato attuale

- I database di pre-verifica sono stati ripristinati da file `.bak`.
- SQL Server usa il volume persistente `sqlserver-express-data`.
- Il backup automatico SQL Server è attivo tramite `systemd timer` giornaliero.
- I file vengono cifrati e copiati su Google Drive tramite `rclone`.
- La rotazione è di 5 copie per database, quindi 10 file cifrati complessivi.
- Il recupero dal cloud e restore su SQL Server è previsto solo in caso di disaster recovery.
- Non considerare il volume Docker locale come backup sufficiente.
- `shared-metabase-data` usa il database H2 interno ed è escluso dai backup per scelta. La perdita del volume comporta la perdita degli account, delle dashboard e delle configurazioni Metabase.

### Procedura prevista

Il backup non dovrà dipendere da un comando manuale. Il comando manuale verrà usato solo per verificare lo script automatico prima di attivare la pianificazione.

La procedura definitiva dovrà:

1. creare un backup completo SQL Server a orario pianificato;
2. comprimere e cifrare il file;
3. copiarlo in uno spazio cloud esterno, Google Drive tramite `rclone`;
4. conservare le ultime 5 copie per ciascun database;
6. eliminare automaticamente i backup più vecchi solo dopo aver verificato il trasferimento;
7. registrare esito e errori;
8. verificare periodicamente un restore di prova.

La soluzione prevista è uno script sulla VPS eseguito ogni giorno tramite `systemd timer`:

```text
SQL Server
    -> backup .bak locale
    -> verifica RESTORE VERIFYONLY
    -> compressione/cifratura
    -> trasferimento SFTP o cloud
    -> conservazione degli ultimi 5 backup
    -> log dell'esito
```

Google Drive non espone direttamente un endpoint SFTP: per Google Drive usare `rclone`; usare SFTP solo se la destinazione esterna fornisce realmente un server SFTP.

File e unità da installare sulla VPS:

```text
/srv/containers/rugbyradiolive/.env.sqlbackup
/srv/containers/rugbyradiolive/.sqlbackup-passphrase
/usr/local/sbin/rrl-sql-backup.sh
/etc/systemd/system/rrl-sql-backup.service
/etc/systemd/system/rrl-sql-backup.timer
```

Prerequisiti:

```bash
sudo apt install -y gpg rclone
```

Prima di attivare il timer configurare il remote `rclone`, eseguire lo script manualmente e verificare che i file cifrati siano presenti sia in `/srv/backups/sqlserver` sia nella destinazione remota. Solo dopo:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now rrl-sql-backup.timer
systemctl list-timers rrl-sql-backup.timer
```

Test manuale dello stesso processo automatico:

```bash
sudo systemctl start rrl-sql-backup.service
journalctl -u rrl-sql-backup.service -n 100 --no-pager
```

I backup devono essere separati dallo storage applicativo e non devono usare l'utente SFTP `storage`.

## 8. Sicurezza dei secret

Conservare in un password manager cifrato:

- password SSH e Contabo;
- token GHCR e GitHub Actions;
- password SQL `sa`;
- secret JWT, SMTP e Hangfire;
- password SFTP;
- chiavi SSH private e certificati.

Non salvare valori reali nella guida, nel repository, negli screenshot o nei messaggi. Prima della migrazione produttiva ruotare i secret già usati nella pre-verifica.

## 9. Regole per aggiungere altri progetti

Per ogni nuovo progetto:

1. creare `/srv/containers/<nome-progetto>`;
2. usare un nome container con prefisso del progetto;
3. usare volumi con lo stesso prefisso;
4. collegare il servizio a `shared-net` solo se deve comunicare con altri container;
5. pubblicare porte solo su `127.0.0.1`, salvo il reverse proxy;
6. aggiungere un file `compose.<servizio>.yml` separato;
7. creare un `.env.<servizio>.example` senza secret reali;
8. aggiungere il routing al reverse proxy solo se serve un accesso HTTP/HTTPS;
9. documentare URL, tunnel SSH, volumi, backup e rollback;
10. preferire GitHub Actions per il deploy ripetibile.

Ogni progetto deve poter essere aggiornato o riavviato senza ricreare gli altri progetti e senza usare `--remove-orphans` su un Compose project diverso.

## 10. Comandi diagnostici essenziali

```bash
docker ps
docker stats
docker logs --tail 100 <container>
docker inspect <container>
docker network inspect shared-net
docker volume ls
df -h
free -h
sudo ufw status verbose
```

Prima di un'operazione rischiosa salvare almeno:

```bash
docker ps > /tmp/rrl-docker-ps.txt
docker volume ls > /tmp/rrl-docker-volumes.txt
```

## 11. Checklist prima della produzione

- [ ] rinnovo VPS Contabo verificato prima della fine del mese di prova;
- [x] test FE-UAT completati;
- [x] pagine blog caricabili via SFTP;
- [x] backup SQL Server manuale verificato;
- [x] backup automatico off-site attivo;
- [n/a] restore di prova: previsto solo in caso di disaster recovery;
- [x] rotazione configurata: 5 copie per database;
- [x] secret di produzione ruotati;
- [x] `.env` aggiornati con i secret di produzione;
- [x] database definitivo ripristinato;
- [x] pagine e contenuti del blog migrati;
- [ ] strategia di backup per storage, immagini, audio, blog e SEO definita e verificata;
- [x] contenuti storage/blog/SEO migrati;
- [x] slot API e rollback verificati;
- [x] DNS blog/SEO aggiornati nella finestra di migrazione;
- [x] FE produzione puntato alla VPS;
- [ ] monitoraggio post-migrazione attivo.
