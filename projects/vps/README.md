# RRL — Piano vincolante di migrazione UAT a Docker/VPS

## Aggiornamento decisionale 2026-09-05

La precedente ipotesi di valutare PostgreSQL per UAT e' superata.

Decisione attiva: **RRL UAT usera' SQL Server Express**.

Motivo: l'analisi repository ha evidenziato impatti troppo ampi della migrazione PostgreSQL/Npgsql su API, Hangfire, provider EF Core, test, stored procedure e assenza di baseline migrations.

La decisione completa e' registrata in:

- `decisions/02 - SQL Server Express invece di PostgreSQL.md`

Di conseguenza, ogni sezione successiva di questo README che parla di PostgreSQL deve essere considerata storica/superata, salvo quando viene citata come scelta esplicitamente scartata.

## 1. Scopo del documento

Questo documento definisce le decisioni architetturali già prese per il test di migrazione di **Rugby Radio Live (RRL)** verso Docker su VPS Linux.

È una **specifica vincolante per Codex**, non un insieme di suggerimenti.

Codex deve:

- implementare quanto definito;
- procedere incrementalmente;
- chiedere conferma prima di modificare una decisione architetturale;
- non introdurre tecnologie o servizi non richiesti;
- non "migliorare" autonomamente l'architettura cambiando le decisioni qui riportate.

Se una decisione contenuta nel documento sembra tecnicamente discutibile, Codex deve:

1. segnalarla;
2. spiegare brevemente il problema;
3. proporre eventualmente un'alternativa;
4. **attendere conferma prima di applicarla**.

---

# 2. Obiettivo immediato

Il primo ambiente da migrare è:

**RRL UAT**

NON migrare inizialmente PROD.

L'obiettivo è utilizzare UAT come test completo per verificare:

- Docker;
- Linux;
- VPS;
- PostgreSQL;
- compatibilità EF Core;
- containerizzazione delle applicazioni;
- Hangfire;
- generazione Blog;
- Storage;
- networking;
- DNS;
- reverse proxy;
- deployment;
- persistenza;
- backup;
- export/import dati;
- disaster recovery.

Solo dopo il completamento positivo del test UAT verrà pianificata PROD.

---

# 3. Ambiente di sviluppo/test locale

La precedente idea di utilizzare:

```text
Windows
└── Hyper-V
    └── Ubuntu Server
```

è stata ABBANDONATA.

Sono stati riscontrati problemi di networking Hyper-V/Wi-Fi non pertinenti al progetto Docker.

Per preparare e testare localmente i container utilizzare:

**Docker Desktop su Windows con Linux containers.**

Docker Desktop serve per:

- costruire immagini;
- testare Dockerfile;
- testare Docker Compose;
- verificare networking tra container;
- verificare volumi;
- verificare environment variables;
- verificare PostgreSQL;
- verificare API;
- verificare Hangfire;
- verificare Blog;
- verificare Storage.

NON utilizzare Windows containers.

Le immagini devono essere Linux-compatible.

Evitare dipendenze da:

- Windows;
- IIS;
- path `C:\...`;
- Windows Services;
- filesystem Windows.

Il target reale rimane Linux.

---

# 4. VPS di test

Verrà acquistata inizialmente una VPS Contabo con contratto **mensile**.

Scopo:

- laboratorio reale;
- test RRL UAT;
- misurazione risorse;
- verifica prestazioni;
- verifica deployment.

NON acquistare inizialmente un contratto annuale/pluriennale.

Se il test è positivo, potrà essere creata successivamente una nuova VPS con contratto più conveniente.

La VPS temporanea deve quindi essere considerata:

**DISPOSABLE / REBUILDABLE**

Non progettare nulla assumendo che quella specifica VPS debba essere conservata.

---

# 5. Sistema operativo VPS

Target:

```text
Ubuntu Server 24.04 LTS
x86-64 / AMD64
```

NON utilizzare Ubuntu Desktop.

La VPS sarà amministrata tramite SSH.

---

# 6. Dimensionamento

Non assumere più che siano necessari 24 GB RAM.

Lo stack reale NON prevede contemporaneamente:

- SQL Server;
- PostgreSQL;
- Metabase;
- Redis.

Quella era una precedente ipotesi errata.

Il target iniziale deve essere dimensionato sullo stack effettivamente necessario.

La VPS da circa **12 GB RAM** è attualmente considerata un candidato plausibile per UAT.

Il dimensionamento definitivo deve essere deciso tramite misurazioni reali:

```bash
docker stats
free -h
htop
df -h
```

Non sovradimensionare preventivamente.

---

# 7. Database — decisione attuale

Per il nuovo ambiente Docker/UAT vogliamo **valutare concretamente PostgreSQL al posto di SQL Server Express**.

Motivazioni:

- ambiente Linux/Docker più naturale;
- minore footprint;
- database open source;
- nessuna necessità di mantenere SQL Server per compatibilità infrastrutturale;
- possibilità di utilizzare VPS più piccole;
- semplificazione dello stack futuro.

RRL utilizza Entity Framework Core.

Non risultano stored procedure o logiche significative implementate direttamente nel database.

Questo rende plausibile una migrazione relativamente semplice.

## IMPORTANTE

NON eseguire automaticamente una conversione completa di RRL.

Prima:

1. analizzare il progetto;
2. identificare eventuali dipendenze SQL Server-specific;
3. produrre un elenco delle incompatibilità;
4. proporre le modifiche;
5. attendere conferma.

Controllare in particolare:

- `UseSqlServer`;
- provider EF Core;
- raw SQL;
- `HasColumnType`;
- default SQL;
- `GETDATE()`;
- `NEWID()`;
- identity;
- sequences;
- `DateTime`;
- `DateOnly`;
- `decimal`;
- collation;
- case sensitivity;
- query SQL native;
- migration esistenti.

Il provider PostgreSQL previsto è:

```text
Npgsql.EntityFrameworkCore.PostgreSQL
```

---

# 8. Una sola istanza PostgreSQL

PostgreSQL NON deve essere dedicato esclusivamente a RRL.

Il database server deve poter servire **più progetti**.

Architettura:

```text
postgres container
│
├── rrl_uat
├── future_project_a
├── future_project_b
└── ...
```

NON creare un container PostgreSQL per ogni progetto senza esplicita autorizzazione.

Le applicazioni devono utilizzare database separati e, quando opportuno, utenti/ruoli separati.

---

# 9. PostgreSQL NON deve essere pubblico

PostgreSQL deve essere raggiungibile esclusivamente dalla rete Docker/backend.

NON pubblicare:

```text
5432
```

su Internet.

NON configurare accesso PostgreSQL dall'home server.

Uno degli obiettivi della migrazione è eliminare la necessità di mantenere servizi RRL sull'home server.

---

# 10. Redis

Redis NON è attualmente un requisito.

NON aggiungerlo automaticamente.

Potrà essere valutato in futuro se emerge un caso d'uso reale per:

- caching;
- distributed cache;
- messaging;
- Hangfire storage;
- altro.

Se serve una cache in futuro, valutare Redis o alternative gratuite/open source.

Per ora:

**Redis = NON installare.**

---

# 11. Metabase

Metabase NON è un requisito per il primo ambiente.

È opzionale.

NON installarlo automaticamente.

Prima deve funzionare lo stack applicativo RRL.

Metabase potrà essere aggiunto successivamente se realmente utile.

---

# 12. Containerizzazione

I componenti applicativi devono essere container indipendenti.

Target concettuale:

```text
Docker Compose
│
├── postgres
│
├── rrl-api
│
├── rrl-hangfire
│
├── rrl-storage
│
├── rrl-blog
│
├── rrl-seo
│
└── reverse-proxy
```

L'elenco definitivo deve essere verificato contro i repository/progetti RRL reali.

NON creare container arbitrari.

NON accorpare automaticamente servizi diversi.

NON dividere automaticamente ulteriormente i servizi.

Prima di cambiare la granularità definita sopra chiedere conferma.

---

# 13. Principio di indipendenza dei container

Ogni applicazione deve:

- avere il proprio lifecycle;
- poter essere riavviata indipendentemente;
- poter essere aggiornata indipendentemente;
- avere una propria Docker image quando appropriato;
- comunicare con gli altri servizi tramite rete Docker o volumi esplicitamente condivisi.

"Container indipendenti" NON significa che non possano comunicare.

---

# 14. Hangfire

Nel contesto di questo progetto:

```text
HF = Hangfire
```

NON Hugging Face.

Non sono previsti LLM locali.

Eventuali AI future utilizzeranno servizi cloud, eventualmente Ollama Cloud.

---

# 15. Hangfire deve essere Always On

Hangfire deve funzionare continuamente.

NON deve dipendere da traffico HTTP per rimanere attivo.

NON utilizzare IIS Always On.

Su Docker il processo Hangfire deve rimanere attivo come servizio/container.

Preferenza architetturale:

```text
rrl-hangfire
```

come container/processo dedicato.

Configurare una restart policy appropriata, indicativamente:

```yaml
restart: unless-stopped
```

Il container deve ripartire automaticamente:

- dopo reboot VPS;
- dopo restart Docker;
- dopo crash del processo/container, quando appropriato.

Verificare il comportamento realmente.

---

# 16. Hangfire e Blog

Hangfire genera anche contenuti/pagine utilizzati dal Blog.

I due componenti possono rimanere container separati.

Per il primo design preferire la soluzione semplice:

```text
rrl-hangfire
      │
      │ scrive
      ▼
shared persistent volume
      ▲
      │ legge/serve
      │
rrl-blog
```

Il volume condiviso deve essere persistente.

Esempio concettuale:

```text
blog-content
```

NON incorporare i contenuti generati dentro la Docker image del Blog.

Prima di implementare verificare come Hangfire genera attualmente le pagine e dove vengono scritte.

Se la struttura attuale rende preferibile una API interna Blog invece del volume condiviso, proporla ma NON implementarla senza conferma.

---

# 17. Storage RRL

RRL possiede un servizio Storage utilizzato come una sorta di CDN applicativa.

Contiene principalmente:

- immagini;
- audio;
- altri asset RRL.

Lo Storage deve essere un container/servizio indipendente.

Deve essere raggiungibile tramite DNS custom.

Esempio:

```text
storage.rugbyradiolive.com
```

oppure hostname UAT equivalente.

I file NON devono essere salvati dentro il filesystem effimero del container.

Devono utilizzare storage persistente.

Esempio concettuale:

```text
rrl-storage
      │
      ▼
persistent volume
      │
      ├── images
      ├── audio
      └── ...
```

Lo storage deve essere incluso nella strategia di backup.

---

# 18. Frontend

Il frontend RRL NON viene migrato sulla VPS.

Rimane su:

**Firebase Hosting**

La VPS ospita esclusivamente backend e servizi correlati.

Architettura:

```text
Firebase
RRL Frontend
     │
     │ HTTPS
     ▼
api*.rugbyradiolive.com
     │
     ▼
VPS
```

NON creare container per il frontend salvo richiesta esplicita futura.

---

# 19. DNS custom

Le API devono poter essere raggiunte tramite domini/subdomain RRL.

Esempi concettuali:

```text
api-uat.rugbyradiolive.com
storage-uat.rugbyradiolive.com
blog-uat.rugbyradiolive.com
seo-uat.rugbyradiolive.com
```

I nomi definitivi devono essere confermati prima di modificare DNS.

NON inventare autonomamente hostname di produzione.

---

# 20. Cloudflare

Cloudflare rimane il gestore DNS/proxy.

La VPS dispone di IP pubblico, quindi Cloudflare Tunnel NON è obbligatorio.

Architettura target:

```text
Firebase frontend
        │
        ▼
Cloudflare
        │
        ▼
VPS :443
        │
        ▼
reverse proxy
        │
        ├── RRL API
        ├── Storage
        ├── Blog
        └── SEO
```

Non configurare Cloudflare Tunnel senza esplicita necessità.

---

# 21. Reverse proxy

Utilizzare un reverse proxy davanti ai servizi pubblici.

Possibili candidati:

- Caddy;
- Nginx;
- Traefik.

NON scegliere automaticamente un prodotto senza discuterne se la scelta comporta differenze significative nella gestione.

Preferire semplicità.

Il reverse proxy sarà l'unico punto di ingresso HTTP/HTTPS ai container applicativi.

---

# 22. Porte pubbliche

Idealmente la VPS deve esporre solamente:

```text
22   SSH
80   HTTP
443  HTTPS
```

Valutare successivamente hardening SSH.

NON esporre pubblicamente:

```text
5432 PostgreSQL
```

né altre porte interne dei container.

---

# 23. Docker networking

Utilizzare Docker networks.

Schema concettuale:

```text
Internet
   │
   ▼
reverse-proxy
   │
   ├──────── frontend/public network
   │
   ├── rrl-api
   ├── rrl-storage
   ├── rrl-blog
   └── rrl-seo

backend network
   │
   ├── rrl-api
   ├── rrl-hangfire
   └── postgres
```

Utilizzare Docker DNS/service discovery.

Esempio:

```text
postgres:5432
```

NON utilizzare IP statici dei container salvo necessità dimostrata.

---

# 24. Docker images applicative

Le immagini applicative NON devono essere costruite normalmente sulla VPS.

Flusso target:

```text
GitHub private repository
        │
        ▼
GitHub Actions
        │
        ├── build
        ├── test
        ├── docker build
        └── docker push
                │
                ▼
        GitHub Container Registry
                │
                ▼
             VPS
         docker compose pull
```

La VPS deve essere principalmente un ambiente runtime.

---

# 25. GitHub repository

I repository RRL sono:

**PRIVATI**

Non assumere repository pubblici.

Non rendere pubblico alcun repository o package senza esplicita autorizzazione.

---

# 26. GitHub Container Registry

Utilizzare preferibilmente:

**GitHub Container Registry (GHCR)**

per le immagini applicative private.

Naming concettuale:

```text
ghcr.io/<owner>/rrl-api:<tag>
ghcr.io/<owner>/rrl-hangfire:<tag>
ghcr.io/<owner>/rrl-storage:<tag>
ghcr.io/<owner>/rrl-blog:<tag>
ghcr.io/<owner>/rrl-seo:<tag>
```

Non hardcodare `<owner>` senza verificarlo nel repository/configurazione reale.

---

# 27. Retention immagini

La retention storica delle Docker images NON è importante.

Non progettare sistemi complessi di retention.

È sufficiente mantenere un numero limitato di immagini/tag utili.

Possibili tag:

```text
uat
prod
<version>
```

La strategia esatta verrà definita successivamente.

NON implementare automaticamente cleanup distruttivi prima di avere conferma.

---

# 28. GitHub Actions

I repository sono privati.

GitHub Actions può essere utilizzato per:

- build;
- test;
- Docker build;
- push GHCR.

L'obiettivo è rimanere entro le quote gratuite disponibili per repository privati.

Non introdurre servizi CI/CD a pagamento.

Non configurare runner self-hosted senza necessità.

---

# 29. VPS e GHCR

La VPS deve poter scaricare le immagini private da GHCR.

Flusso:

```text
docker login ghcr.io
docker compose pull
docker compose up -d
```

Utilizzare credenziali/token con privilegi minimi necessari.

NON utilizzare token GitHub personali con permessi inutilmente ampi.

NON committare token.

---

# 30. Secrets

I secrets NON devono essere salvati in Git.

Esempi:

- password PostgreSQL;
- connection string;
- API keys;
- GHCR credentials;
- eventuali token Cloudflare;
- eventuali credenziali AI/cloud.

Prevedere:

```text
.env.example
```

nel repository.

Il vero:

```text
.env
```

deve essere ignorato da Git.

Non inserire secrets nei Dockerfile.

---

# 31. Docker images vs dati

Separazione fondamentale:

## Stateless

Docker images:

```text
GHCR
├── API
├── Hangfire
├── Storage
├── Blog
└── SEO
```

Devono essere ricreabili dai sorgenti.

## Stateful

Dati:

```text
PostgreSQL
Storage images/audio
Blog generated content
```

NON devono dipendere dalle Docker images.

Devono essere persistenti e sottoposti a backup.

---

# 32. Export/import dati RRL

Per migrare SQL Server → PostgreSQL si preferisce valutare uno strumento applicativo .NET dedicato.

Concetto:

```text
SQL Server
    │
    ▼
RRL Data Migration Export
    │
    ▼
formato intermedio
    │
    ▼
RRL Data Migration Import
    │
    ▼
PostgreSQL
```

Possibile formato:

- JSON;
- NDJSON;
- altro formato semplice e versionabile.

NON scegliere definitivamente il formato senza analizzare volume e struttura dei dati.

---

# 33. Obiettivo dello strumento di migrazione

Lo strumento non deve essere necessariamente un convertitore SQL Server → PostgreSQL diretto.

Preferenza:

**migrazione a livello applicativo/modello dati**.

Questo permette di disaccoppiare export e import dal database specifico.

Concettualmente:

```bash
dotnet RRL.DataMigration.dll export ...
dotnet RRL.DataMigration.dll import ...
```

Lo strumento deve preservare:

- primary key;
- foreign key;
- relazioni;
- valori null;
- date;
- decimal;
- enum;
- eventuali binary/blob se presenti;
- ordine corretto delle dipendenze.

Prima di implementarlo analizzare lo schema reale.

---

# 34. EF migrations

PostgreSQL UAT deve partire da schema controllato tramite EF Core migrations.

Flusso previsto:

```text
PostgreSQL vuoto
       │
       ▼
EF Core migrations
       │
       ▼
schema pronto
       │
       ▼
DataMigration import
       │
       ▼
RRL UAT
```

Non utilizzare dump SQL Server come meccanismo principale di creazione schema PostgreSQL.

---

# 35. Persistenza Docker

Tutti i dati stateful devono utilizzare named volumes o altra persistenza esplicitamente progettata.

Preferire named volumes quando non esiste una ragione concreta per usare bind mount host-specific.

Il comando:

```bash
docker compose down
```

NON deve perdere dati.

Prestare attenzione:

```bash
docker compose down -v
```

È distruttivo per i named volumes.

NON eseguire comandi distruttivi senza avvisare e ottenere conferma quando contengono dati reali.

---

# 36. Backup

I Docker volumes NON sono backup.

Devono essere previsti backup esterni per almeno:

```text
PostgreSQL
RRL Storage
Blog generated content
```

La destinazione definitiva del backup esterno non è ancora stata scelta.

NON scegliere/acquistare autonomamente un servizio di backup.

Prima proporre alternative e costi.

---

# 37. Disaster recovery

Uno degli obiettivi principali del test UAT è dimostrare che la VPS è sostituibile.

Test finale:

```text
NUOVA VPS VUOTA
       │
       ▼
Ubuntu Server
       │
       ▼
Docker
       │
       ▼
infrastructure repository
       │
       ▼
.env / secrets
       │
       ▼
docker compose pull
       │
       ▼
docker compose up -d
       │
       ▼
EF migrations
       │
       ▼
restore/import dati
       │
       ▼
RRL UAT operativo
```

Il sistema non deve dipendere da configurazioni manuali non documentate.

---

# 38. Repository infrastruttura

Prevedere un repository Git dedicato o una struttura equivalente per l'infrastruttura.

Possibile struttura:

```text
rrl-infrastructure/
│
├── compose.yml
├── .env.example
├── .gitignore
│
├── proxy/
│
├── scripts/
│   ├── setup/
│   ├── deploy/
│   ├── backup/
│   └── restore/
│
└── README.md
```

Non duplicare inutilmente i sorgenti applicativi.

---

# 39. Deploy target

Una volta predisposta la VPS, il deploy applicativo deve essere semplice.

Obiettivo:

```bash
docker compose pull
docker compose up -d
```

Successivamente si potrà valutare automazione ulteriore.

NON implementare automaticamente deployment continuo direttamente su PROD.

Prima deve funzionare UAT.

---

# 40. Ordine di implementazione obbligatorio

Procedere per fasi.

## Fase 1 — Analisi

Prima di modificare codice:

1. analizzare repository RRL;
2. identificare applicazioni realmente presenti;
3. identificare dipendenze;
4. identificare accessi filesystem;
5. identificare Hangfire;
6. identificare generazione Blog;
7. identificare Storage;
8. identificare dipendenze SQL Server;
9. identificare configurazioni/secrets;
10. produrre un piano basato sul codice reale.

**FERMARSI e chiedere conferma.**

---

## Fase 2 — Docker locale

Utilizzare Docker Desktop Windows/Linux containers.

Containerizzare inizialmente UNA applicazione semplice.

Verificare:

- build;
- startup;
- configuration;
- networking;
- logging.

**FERMARSI e chiedere conferma.**

---

## Fase 3 — PostgreSQL locale

Creare PostgreSQL in Docker.

Configurare un test EF Core/Npgsql.

Verificare compatibilità.

NON migrare ancora tutto.

Produrre eventuali incompatibilità.

**FERMARSI e chiedere conferma.**

---

## Fase 4 — Migrazione dati

Progettare e implementare export/import.

Testare su copia dati UAT.

Verificare conteggi e integrità.

**FERMARSI e chiedere conferma.**

---

## Fase 5 — Stack RRL locale

Containerizzare progressivamente:

```text
postgres
rrl-api
rrl-hangfire
rrl-storage
rrl-blog
rrl-seo
```

Verificare:

- comunicazione;
- persistenza;
- Hangfire Always On;
- Blog generation;
- Storage;
- restart.

**FERMARSI e chiedere conferma.**

---

## Fase 6 — CI / Registry

Completata il 17/09/2026 nel laboratorio Docker locale:

```text
GitHub Actions
      ↓
GHCR private
```

Verificati build, test, pubblicazione, pull e avvio delle immagini API/Hangfire tramite Compose runtime.

---

## Fase 7 — VPS Contabo mensile — produzione

Preparare Ubuntu Server 24.04.

Installare Docker.

Configurare sicurezza base.

Deployare gli stack applicativi negli ambienti approvati, con particolare cautela perché questa VPS è di produzione.

### Convenzione directory multi-progetto

La VPS non deve usare directory specifiche come `rrl-lab`.

Root generica per tutti i progetti:

```text
/srv/containers/
├── shared/
├── rugbyradiolive/
├── progetto-b/
└── ...
```

Ogni progetto mantiene qui Compose, file di configurazione non sensibili e script di deploy. I segreti reali restano fuori da Git e con permessi limitati.

### Strategia deploy API

RRL usa due slot API permanenti (`rrl-api-s1` e `rrl-api-s2`). Ogni rilascio aggiorna uno slot scelto esplicitamente, mentre l'altro mantiene la versione precedente per continuità e rollback. Il routing del reverse proxy viene spostato solo dopo la verifica del nuovo slot.

### VPS ordinata il 17/09/2026

- Provider: Contabo
- Piano: **Cloud VPS 6 (2026) (no setup)**
- Contratto: mensile
- Location: Hub Europe
- IPv4: `77.237.246.2`
- IPv6 subnet: `2a02:c207:2358:7715:0000:0000:0000:0001/64`
- Utente iniziale: `root`
- Customer ID: `15419227`
- Order ID: `15419228`

La password non viene registrata nei documenti del repository: resta quella scelta durante l'ordine e deve essere gestita come segreto.

---

## Fase 8 — DNS UAT

Solo dopo verifica locale/VPS:

- configurare hostname UAT;
- Cloudflare;
- HTTPS;
- reverse proxy.

Chiedere conferma sui nomi DNS prima di modificarli.

---

## Fase 9 — Monitoraggio

Misurare almeno:

```text
RAM
CPU
disk
disk I/O
network
container restart
application errors
PostgreSQL
```

Utilizzare inizialmente strumenti semplici.

NON installare automaticamente stack pesanti Prometheus/Grafana/ELK.

---

## Fase 10 — Disaster recovery

Ricostruire l'ambiente da zero.

Misurare il tempo necessario.

Target indicativo:

**massimo mezza giornata**, idealmente molto meno.

---

# 41. Cose esplicitamente NON richieste

Codex NON deve introdurre autonomamente:

- Kubernetes;
- Docker Swarm;
- Redis;
- Metabase;
- Elasticsearch;
- OpenSearch;
- RabbitMQ;
- Kafka;
- Prometheus;
- Grafana;
- ELK;
- Portainer;
- SQL Server + PostgreSQL contemporaneamente;
- LLM locali;
- Ollama locale;
- GPU;
- Windows containers;
- IIS;
- Cloudflare Tunnel;
- database pubblicamente raggiungibile;
- frontend Firebase dentro Docker;
- servizi cloud a pagamento;
- nuovi provider;
- microservizi aggiuntivi;
- refactoring architetturali non necessari.

Se uno di questi diventa utile, Codex deve proporlo e attendere conferma.

---

# 42. Regola fondamentale per Codex

**NON PRENDERE DECISIONI ARCHITETTURALI IN AUTONOMIA.**

Codex può prendere autonomamente normali decisioni implementative locali e reversibili.

Esempi consentiti:

- naming di una variabile locale;
- organizzazione interna di un metodo;
- piccoli refactoring necessari alla compilazione;
- comandi diagnostici non distruttivi.

Codex NON può decidere autonomamente:

- nuovo database;
- nuovo servizio;
- nuovo container;
- nuova infrastruttura;
- nuova dipendenza infrastrutturale;
- nuovo provider;
- esposizione di porte;
- modifica DNS;
- modifica networking;
- strategia backup;
- strategia deploy;
- modifica sostanziale dello schema DB;
- modifica del modello di persistenza;
- modifica della granularità dei servizi;
- eliminazione dati;
- modifica PROD.

Quando esistono più alternative architetturali ragionevoli:

**STOP → presentare alternative → attendere decisione.**

---

# 43. Architettura target attuale

```text
                         INTERNET
                            │
            ┌───────────────┴───────────────┐
            │                               │
         Firebase                       Cloudflare
       RRL Frontend                         │
                                            ▼
                                      VPS Contabo
                                            │
                                    Reverse Proxy
                                            │
             ┌──────────────┬───────────────┼──────────────┐
             │              │               │              │
             ▼              ▼               ▼              ▼
          RRL API      RRL Storage       RRL Blog       RRL SEO
             │              │               ▲
             │              │               │
             │              ▼               │
             │       persistent storage     │
             │                              │
             │                     shared blog-content
             │                              ▲
             │                              │
             └──────────────┐        RRL Hangfire
                            │              │
                            ▼              ▼
                              PostgreSQL
                                   │
                          multiple databases
                                   │
                      ┌────────────┴────────────┐
                      │                         │
                   RRL UAT              future projects
```

---

# 44. Principio finale

L'obiettivo non è semplicemente:

> "far funzionare RRL su Contabo"

L'obiettivo è:

> **rendere RRL indipendente dalla macchina che lo ospita.**

Codice:

```text
GitHub private repositories
```

Build:

```text
GitHub Actions
```

Docker images:

```text
GHCR private
```

Runtime:

```text
Ubuntu + Docker Compose
```

Frontend:

```text
Firebase
```

DNS/proxy:

```text
Cloudflare
```

Database:

```text
PostgreSQL
```

Dati persistenti:

```text
Docker volumes / persistent storage
```

Backup:

```text
external storage — da definire
```

La VPS deve essere considerata una risorsa sostituibile.

In futuro deve essere possibile passare:

```text
Contabo
   ↓
Hetzner
```

o altro provider compatibile Linux/Docker senza modificare l'architettura applicativa.

---

# 45. Prima istruzione operativa a Codex

Prima di creare o modificare file:

> Leggi integralmente questo documento. Analizza il repository RRL e confronta l'implementazione reale con l'architettura descritta. Non modificare nulla. Produci solamente:
>
> 1. elenco dei progetti/applicazioni individuati;
> 2. dipendenze tra essi;
> 3. utilizzo attuale di SQL Server/EF Core;
> 4. funzionamento attuale di Hangfire;
> 5. modalità con cui Hangfire genera il Blog;
> 6. funzionamento dello Storage;
> 7. accessi al filesystem;
> 8. configurazioni dipendenti da Windows/IIS;
> 9. potenziali problemi per Docker/Linux;
> 10. potenziali problemi per PostgreSQL/Npgsql;
> 11. differenze tra il codice reale e questo documento;
> 12. piano proposto per la Fase 2.
>
> **Non implementare ancora nulla.**
>
> Al termine fermati e attendi approvazione.
