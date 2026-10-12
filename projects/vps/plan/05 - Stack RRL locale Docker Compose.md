# 05 - Stack RRL locale Docker Compose

## Stato corrente

In esecuzione progressiva: `rrl-hangfire` e' il primo servizio dello stack aggiunto in questa fase.

## Scopo

Containerizzare progressivamente lo stack RRL UAT locale con Docker Compose, verificando comunicazione, persistenza e lifecycle indipendente dei servizi.

Questa fase trasforma le prove isolate in uno stack locale coerente con l'architettura target.

## Obiettivo

Arrivare a uno stack locale concettualmente composto da:

```text
sql-server-express
sftp
rrl-api-s1 e rrl-api-s2
rrl-hangfire
rrl-storage
rrl-blog
rrl-seo
reverse-proxy
```

L'elenco definitivo deve rispettare le applicazioni reali emerse dalla Fase 1.

## Mappatura iniziale nota

Usare questa mappatura come ipotesi iniziale, da confermare contro il codice reale:

| Servizio target | Percorso sorgente atteso | Note |
| --- | --- | --- |
| `rrl-api-s1`, `rrl-api-s2` | `src/RugbyRadio/Api` | Due istanze API equivalenti per consentire il rilascio su una istanza e lo switch del frontend o del reverse proxy senza interrompere il servizio. |
| `rrl-hangfire` | `src/RugbyRadio/HF` | Worker Hangfire always-on. Scrive contenuti Blog e Sitemap/SEO. |
| librerie comuni | `src/RugbyRadio/Lib` | Dipendenza build di API e HF, non servizio runtime autonomo. |
| test | `src/RugbyRadio/Tests` | Test unitari per API e HF. Da eseguire in CI. |
| `rrl-blog` | `src/RugbyRadioBlog` | Sito/pagine statiche HTML del Blog, alimentate da job HF tramite storage persistente. |
| frontend Angular | `src/RugbyRadio/Web` | Fuori scope VPS: resta su Firebase Hosting. |
| `rrl-seo` o sitemap | `src/RugbyRadioSitemap` | Sito utility con sitemap scritte da job HF. Confermare naming e ruolo `rrl-seo`. |

Le altre cartelle sotto `src` sono da ignorare in questa fase perche' esperimenti non in uso, salvo dipendenze reali documentate.

## Vincoli

- Non creare container arbitrari.
- Non accorpare servizi diversi senza conferma.
- Non dividere ulteriormente i servizi senza conferma.
- Non containerizzare il frontend Firebase.
- Non installare Redis o Metabase.
- Non salvare dati nel filesystem effimero dei container.
- Non esporre porte interne non necessarie.

## Come procedere

1. Definire compose locale per i servizi approvati.
   - completato per `rrl-hangfire` con `compose.hangfire.yml`;
   - completato per `rrl-seo` con `compose.seo.yml`;
   - completato per `sftp` con `compose.sftp.yml`;
   - completato per `reverse-proxy` con `compose.reverse-proxy.yml`;
   - completato per `rrl-blog` con `compose.blog.yml`;
   - completato per `rrl-storage` con `compose.storage.yml`;
2. Creare reti Docker distinte:
   - rete pubblica/front per reverse proxy e servizi pubblici;
   - rete backend per API, Hangfire e SQL Server Express.
3. Usare Docker DNS/service discovery, ad esempio `sql-server-express,1433`.
4. Configurare named volumes per:
   - SQL Server Express;
   - storage immagini/audio;
   - contenuti Blog generati.
   - accesso SFTP condiviso al volume storage;
5. Configurare `rrl-hangfire` come processo/container sempre attivo.
   - implementato con restart policy `unless-stopped`;
6. Usare restart policy appropriata, indicativamente `unless-stopped`.
7. Collegare Hangfire e Blog tramite volume persistente condiviso, se confermato dall'analisi reale.
   - implementato con `rrl-blog-content`, scritto da Hangfire e servito da `rrl-blog`;
8. Collegare Hangfire e Sitemap/SEO tramite volume persistente o altra modalita' esistente confermata.
   - implementato con `rrl-seo-content`, scritto da Hangfire in `/data/seo` e servito da `rrl-seo`;
9. Configurare Storage come servizio indipendente con volume persistente.
   - implementato con `rrl-storage`, volume `rrl-storage-data`, seed dal backup e mount condiviso in API/Hangfire;
   - implementato con `sftp`, mount in lettura/scrittura del volume `rrl-storage-data` e accesso locale SFTP;
   - implementato con `rrl-storage`, volume `rrl-storage-data`, seed dal backup e mount condiviso in API/Hangfire;
10. Introdurre reverse proxy locale solo dopo aver deciso il prodotto o aver ottenuto conferma.
   - implementato con Nginx nel progetto Compose `shared`, routing `.localhost` e switch API tramite `SHARED_REVERSE_PROXY_API_UPSTREAM`;
11. Verificare restart, reboot Docker e persistenza.

## Verifiche

Eseguire almeno:

```bash
docker compose up -d
docker compose ps
docker compose logs
docker stats
docker compose restart <service>
docker compose down
docker compose up -d
```

Verificare che `docker compose down` non perda dati.

Non eseguire `docker compose down -v` su dati reali.

## Deliverable

- `compose.yml` locale.
- `.env.example`.
- `.gitignore` per secrets.
- Dockerfile applicativi necessari.
- Documentazione startup locale.
- Report verifiche comunicazione/persistenza/restart.

## Criteri di uscita

La fase e' completa quando:

- tutti i container approvati partono localmente;
- API, Hangfire, Blog, Storage e SEO comunicano come previsto;
- Hangfire resta always on;
- Blog legge contenuti generati da volume persistente;
- Sitemap/SEO legge contenuti generati da Hangfire o documenta la modalita' reale equivalente;
- Storage usa volume persistente;
- SFTP accede al volume Storage senza duplicare i file;
- Docker Desktop raggruppa SQL Server/SFTP nel progetto `shared` e i servizi applicativi nel progetto `rrl`;
- il reverse proxy condiviso instrada i domini locali verso i servizi corretti;
- SQL Server Express non e' pubblico nello stack target;
- i dati sopravvivono a `docker compose down`.

## Stop point

Fermarsi dopo la verifica locale del reverse proxy e chiedere conferma prima di procedere con DNS pubblici, HTTPS e VPS.
