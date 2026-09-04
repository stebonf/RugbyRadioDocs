# Migrazione Home Server a Ubuntu + Docker

## 1. Obiettivo

Migrare progressivamente i servizi attualmente eseguiti sull'home server Windows verso un'infrastruttura basata su:

* Ubuntu Server 24.04 LTS
* Docker Engine
* Docker Compose
* container separati per applicazioni e servizi
* volumi persistenti per i dati
* configurazione tramite environment variables / `.env`
* reverse proxy per l'esposizione HTTP/HTTPS
* backup esterni

L'ambiente deve essere progettato in modo da poter essere eseguito inizialmente in locale e successivamente trasferito quasi senza modifiche su un VPS Ubuntu, probabilmente Contabo.

Principio fondamentale:

```text
Ubuntu locale
    ↓
stesso Docker Compose
    ↓
VPS Ubuntu
```

Non devono esserci dipendenze specifiche da Windows.

---

# 2. Scenario attuale

L'home server attuale è Windows 11 e ospita diversi servizi, principalmente relativi a Rugby Radio Live (RRL).

Hardware attuale:

```text
CPU: Intel Core i5-10400F
RAM: 32 GB
SSD: 480 GB
HDD: 1 TB
GPU: NVIDIA GTX 1660 SUPER
Network: Vodafone FTTH 1 Gbit + eero mesh
```

Servizi principali attuali:

* API .NET
* Hangfire / background jobs
* SQL Server
* Redis dove necessario
* Metabase
* Storage service
* Blog
* SEO / sitemap service
* Cloudflare Tunnel
* altri piccoli progetti .NET

Attualmente alcuni servizi sono pubblicati attraverso Cloudflare Tunnel.

Esempio:

```text
api-s1-sh.rugbyradiolive.com
api-s2-sh.rugbyradiolive.com
storage-sh.rugbyradiolive.com
blog.rugbyradiolive.com
bi.rugbyradiolive.com
seo-sh.rugbyradiolive.com
```

Non sono previsti LLM locali.

Eventuali funzionalità AI utilizzeranno servizi esterni/cloud, ad esempio Ollama Cloud.

---

# 3. Target iniziale

Prima di acquistare o configurare un VPS, realizzare un ambiente di test locale.

Architettura:

```text
Host
│
└── Ubuntu Server 24.04 LTS
    │
    └── Docker
        ├── SQL Server
        ├── PostgreSQL (se necessario)
        ├── Redis
        ├── Metabase
        ├── RRL API
        ├── RRL Hangfire
        ├── RRL Storage
        ├── RRL Blog
        ├── RRL SEO
        └── Reverse Proxy
```

Ubuntu deve essere la versione:

```text
Ubuntu Server 24.04 LTS AMD64
```

Non Ubuntu Desktop.

Non è necessaria un'interfaccia grafica.

La macchina deve essere amministrabile tramite SSH.

---

# 4. VPS target

Come possibile destinazione finale è stata valutata una VPS Contabo.

Configurazione interessante:

```text
8 vCPU
24 GB RAM
300 GB SSD
Ubuntu Server 24.04
```

Questa configurazione dovrebbe offrire sufficiente margine per:

* più applicazioni .NET
* Hangfire
* SQL Server
* PostgreSQL
* Redis
* Metabase
* reverse proxy
* piccoli progetti futuri

Le vCPU del VPS sono condivise e non devono essere considerate equivalenti a 8 core fisici/dedicati.

Il workload previsto non è comunque particolarmente CPU-intensive.

La RAM è considerata più importante della potenza CPU assoluta.

---

# 5. Strategia Docker

Utilizzare Docker Compose come principale strumento di orchestrazione.

NON utilizzare Kubernetes.

L'obiettivo è mantenere l'infrastruttura semplice e facilmente ricostruibile.

Idealmente deve essere possibile partire da una nuova Ubuntu e arrivare a un sistema funzionante con qualcosa di simile a:

```bash
git clone <infrastructure-repository>
cd infrastructure

cp .env.example .env

# configurare secrets

docker compose up -d
```

---

# 6. Database

## SQL Server

Non è necessario creare un container SQL Server per ogni database.

Utilizzare normalmente:

```text
1 container SQL Server
    │
    ├── RRL
    ├── ProjectA
    ├── ProjectB
    └── ...
```

Le applicazioni utilizzeranno database diversi tramite connection string differenti.

Esempio:

```text
Server=sqlserver;Database=RRL;...
Server=sqlserver;Database=ProjectA;...
```

All'interno della rete Docker il server deve essere identificato attraverso il nome del service/container e NON tramite IP.

Esempio:

```text
Server=sqlserver
```

SQL Server deve utilizzare storage persistente.

Indicativamente sul VPS da 24 GB si può valutare un limite di memoria di circa 4-6 GB, da verificare successivamente con metriche reali.

---

## PostgreSQL

Stesso principio.

Un singolo container PostgreSQL può contenere più database:

```text
postgres
│
├── project_a
├── project_b
└── project_c
```

Non creare container PostgreSQL separati senza una reale necessità di isolamento.

SQL Server e PostgreSQL possono coesistere sulla stessa macchina.

Non è prevista al momento una migrazione obbligatoria da SQL Server a PostgreSQL.

---

# 7. Persistenza

I dati NON devono vivere esclusivamente nel filesystem effimero dei container.

Utilizzare Docker volumes o bind mounts appropriati.

Servizi che richiedono persistenza:

```text
SQL Server
PostgreSQL
Redis (se persistence abilitata)
Metabase
Storage RRL
eventuali altri servizi stateful
```

Esempio concettuale:

```yaml
volumes:
  sql-data:
  postgres-data:
  redis-data:
  metabase-data:
```

Il comando:

```bash
docker compose down
```

NON deve causare perdita di dati.

Dopo:

```bash
docker compose up -d
```

il sistema deve ritornare nello stato precedente.

---

# 8. Backup

I Docker volumes NON sono un backup.

I database devono avere procedure di backup dedicate.

Idealmente:

```text
VPS
│
├── SQL Server
├── PostgreSQL
├── Storage
│
└── backup automatici
       │
       ▼
Storage esterno
```

Non considerare sicuro un backup conservato esclusivamente sullo stesso VPS.

Devono essere previste procedure sia di:

```text
backup
```

sia di:

```text
restore
```

Il restore deve essere effettivamente testato.

---

# 9. Networking Docker

Creare almeno una rete interna per i servizi backend.

Possibile organizzazione:

```text
Internet
   │
Reverse Proxy
   │
frontend network
   │
   ├── API
   ├── Blog
   ├── SEO
   └── Metabase

backend network
   │
   ├── API
   ├── Hangfire
   ├── SQL Server
   ├── PostgreSQL
   └── Redis
```

SQL Server, PostgreSQL e Redis NON devono essere esposti pubblicamente.

I container devono comunicare tramite DNS Docker.

Esempi:

```text
sqlserver:1433
postgres:5432
redis:6379
metabase:3000
```

Non utilizzare IP statici dei container salvo reale necessità.

---

# 10. Reverse Proxy

In una fase successiva aggiungere un reverse proxy.

Possibili soluzioni:

* Caddy
* Nginx
* Traefik

Preferenza iniziale: soluzione semplice da configurare e mantenere.

Possibile architettura futura:

```text
Internet
   │
Cloudflare DNS / Proxy
   │
   ▼
VPS :443
   │
Reverse Proxy
   │
   ├── api.rugbyradiolive.com     → api:8080
   ├── storage.rugbyradiolive.com → storage:8080
   ├── blog.rugbyradiolive.com    → blog:8080
   ├── seo.rugbyradiolive.com     → seo:8080
   └── bi.rugbyradiolive.com      → metabase:3000
```

Su VPS Cloudflare Tunnel non è strettamente necessario perché la macchina dispone di connettività pubblica.

Cloudflare può comunque continuare ad essere utilizzato come DNS/proxy.

---

# 11. Sicurezza VPS

Quando l'ambiente verrà portato sul VPS, esporre pubblicamente solo ciò che è necessario.

Indicativamente:

```text
22    SSH
80    HTTP
443   HTTPS
```

Valutare successivamente di restringere ulteriormente SSH.

NON esporre direttamente:

```text
1433 SQL Server
5432 PostgreSQL
6379 Redis
3000 Metabase
```

Metabase deve essere raggiunto attraverso reverse proxy e opportunamente protetto.

Secrets e password NON devono essere salvati nel repository Git.

Utilizzare:

```text
.env
```

con:

```gitignore
.env
```

e fornire:

```text
.env.example
```

senza valori sensibili.

---

# 12. Applicazioni .NET

Ogni applicazione deve avere il proprio `Dockerfile`.

Utilizzare multi-stage build.

Schema indicativo:

```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY . .
RUN dotnet publish -c Release -o /publish

FROM base AS final
WORKDIR /app
COPY --from=build /publish .

ENTRYPOINT ["dotnet", "Application.dll"]
```

Il Dockerfile reale deve essere adattato alla struttura della solution/progetto.

Creare anche `.dockerignore`.

---

# 13. Hangfire

HF nelle discussioni relative a questa infrastruttura significa:

```text
HF = Hangfire
```

NON Hugging Face.

Hangfire può essere eseguito normalmente all'interno di Docker.

Possibile architettura:

```text
API container
     │
     ▼
SQL Server / Redis
     ▲
     │
Hangfire Worker container
```

Se Hangfire è un'applicazione/worker .NET separata, deve avere il proprio Dockerfile.

Deve poter accedere ai database attraverso la rete Docker.

---

# 14. AI

Non devono essere dimensionate risorse per LLM locali.

NON sono richieste:

* GPU
* CUDA
* Ollama locale
* Hugging Face inference locale
* vLLM
* modelli locali

Eventuali servizi AI utilizzeranno provider esterni/cloud.

Possibile utilizzo futuro:

```text
Ollama Cloud
```

Il server deve solamente effettuare chiamate HTTP verso questi servizi.

---

# 15. Struttura repository infrastruttura

Una possibile struttura da valutare:

```text
infrastructure/
│
├── compose.yml
├── .env.example
├── .gitignore
│
├── proxy/
│   └── ...
│
├── scripts/
│   ├── backup/
│   ├── restore/
│   └── deploy/
│
└── README.md
```

I sorgenti delle applicazioni possono rimanere nei rispettivi repository.

Non duplicare necessariamente tutto il codice applicativo nel repository infrastructure.

---

# 16. Docker Compose target

Il risultato finale sarà indicativamente simile a:

```yaml
services:

  sqlserver:
    image: mcr.microsoft.com/mssql/server:2022-latest
    volumes:
      - sql-data:/var/opt/mssql
    networks:
      - backend

  postgres:
    image: postgres:18
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - backend

  redis:
    image: redis:8
    volumes:
      - redis-data:/data
    networks:
      - backend

  api:
    image: rrl-api
    depends_on:
      - sqlserver
      - redis
    networks:
      - frontend
      - backend

  hangfire:
    image: rrl-hangfire
    depends_on:
      - sqlserver
      - redis
    networks:
      - backend

  metabase:
    image: metabase/metabase
    networks:
      - frontend
      - backend

volumes:
  sql-data:
  postgres-data:
  redis-data:

networks:
  frontend:
  backend:
```

Questo è solamente uno scheletro.

NON utilizzarlo direttamente in produzione senza completare:

* environment variables
* secrets
* health checks
* restart policies
* resource limits
* persistence
* backup
* logging
* configurazione database
* reverse proxy
* sicurezza

---

# 17. Strategia di migrazione

La migrazione deve essere incrementale.

NON tentare di containerizzare tutto contemporaneamente.

## Fase 1 — Ubuntu

Preparare:

```text
Ubuntu Server 24.04 LTS
OpenSSH
Docker Engine
Docker Compose
```

Verificare:

```bash
docker --version
docker compose version
docker run hello-world
```

---

## Fase 2 — Infrastructure playground

Avviare inizialmente solo:

```text
SQL Server
Redis
```

Verificare:

* startup
* networking
* connection da applicazioni
* persistenza
* restart

---

## Fase 3 — Metabase

Aggiungere:

```text
Metabase
```

Verificare collegamento ai database.

---

## Fase 4 — Prima applicazione .NET

Scegliere una singola applicazione semplice.

Creare:

```text
Dockerfile
.dockerignore
```

Verificare:

```bash
docker build
docker run
```

Poi inserirla nel Compose.

---

## Fase 5 — RRL

Containerizzare progressivamente:

```text
RRL API
RRL Hangfire
RRL Storage
RRL Blog
RRL SEO
```

Un servizio alla volta.

Ogni servizio deve funzionare correttamente prima di passare al successivo.

---

## Fase 6 — Reverse Proxy

Aggiungere Caddy/Nginx/Traefik.

Prima test locale.

Successivamente configurazione reale dei domini.

---

## Fase 7 — Backup

Implementare:

* SQL Server backup
* PostgreSQL backup
* backup storage applicativo
* eventuale backup configurazioni

Prevedere destinazione esterna.

Testare il restore.

---

## Fase 8 — Test infrastruttura completa

Eseguire almeno:

```bash
docker compose ps
docker stats
docker compose logs
```

Monitorare:

* RAM
* CPU
* disk usage
* disk I/O
* restart container
* errori applicativi

Testare:

```bash
docker compose down
docker compose up -d
```

e verificare che tutti i dati persistano.

---

## Fase 9 — Disaster recovery test

Obiettivo:

essere in grado di partire da una Ubuntu vuota e ricostruire tutto.

Idealmente:

```text
Ubuntu pulita
     │
install Docker
     │
clone infrastructure
     │
configura .env
     │
restore dati
     │
docker compose up -d
     │
     ▼
sistema operativo
```

Questo test è fondamentale prima della migrazione definitiva.

---

# 18. Migrazione verso Contabo

Solo quando l'ambiente locale è stabile:

1. creare VPS Ubuntu Server 24.04;
2. installare Docker;
3. configurare firewall;
4. clonare repository infrastructure;
5. trasferire/configurare secrets;
6. trasferire/restore dei database;
7. trasferire storage persistente;
8. avviare Docker Compose;
9. verificare servizi internamente;
10. configurare reverse proxy;
11. configurare DNS Cloudflare;
12. testare HTTPS;
13. monitorare il sistema;
14. mantenere temporaneamente il vecchio server disponibile per rollback.

---

# 19. Dimensionamento

Target VPS attualmente considerato:

```text
8 vCPU
24 GB RAM
300 GB SSD
```

Non utilizzare tutta la memoria disponibile senza limiti.

Valutare resource limits per i servizi più pesanti.

In particolare monitorare:

```text
SQL Server
Metabase
PostgreSQL
```

Indicativamente SQL Server può iniziare con un limite nell'ordine di:

```text
4-6 GB
```

da modificare sulla base dell'utilizzo reale.

Il dimensionamento definitivo deve essere fatto misurando il workload reale, non tramite stime teoriche.

---

# 20. Principi da seguire durante l'implementazione

Codex deve seguire questi principi:

1. procedere incrementalmente;
2. non introdurre Kubernetes;
3. preferire Docker Compose;
4. evitare complessità non necessaria;
5. non esporre database su Internet;
6. utilizzare Docker networking e service discovery;
7. rendere persistenti tutti i dati necessari;
8. non salvare secrets in Git;
9. utilizzare `.env.example`;
10. utilizzare immagini Docker ufficiali quando disponibili;
11. fissare versioni/tag ragionevoli evitando dipendenze implicite da `latest` quando opportuno;
12. aggiungere health checks ai servizi importanti;
13. utilizzare restart policies appropriate;
14. implementare logging gestibile;
15. evitare dipendenze dall'host Windows;
16. mantenere compatibilità con Ubuntu Server 24.04;
17. progettare pensando al successivo deploy su VPS;
18. documentare i comandi necessari nel README;
19. prevedere backup e restore fin dall'inizio;
20. privilegiare semplicità, riproducibilità e manutenibilità.

---

# 21. Obiettivo finale

L'infrastruttura deve diventare indipendente dalla macchina fisica.

Il risultato desiderato è:

```text
                 Git
                  │
          infrastructure
                  │
                  ▼
        ┌─────────────────┐
        │ Ubuntu + Docker │
        └────────┬────────┘
                 │
       docker compose up
                 │
                 ▼
┌────────────────────────────────┐
│ SQL Server                     │
│ PostgreSQL                     │
│ Redis                          │
│ Metabase                       │
│ RRL API                        │
│ RRL Hangfire                   │
│ RRL Storage                    │
│ RRL Blog                       │
│ RRL SEO                        │
│ Reverse Proxy                  │
└────────────────────────────────┘
                 │
                 ▼
             Cloudflare
                 │
                 ▼
              Internet
```

La stessa infrastruttura deve poter essere eseguita:

```text
Ubuntu locale
```

oppure:

```text
Contabo VPS
```

con differenze minime di configurazione.

## Primo task per Codex

NON implementare immediatamente l'intera infrastruttura.

Partire dalla **Fase 1**.

Preparare una guida passo-passo per configurare una macchina Ubuntu Server 24.04 LTS pulita con:

1. aggiornamento sistema;
2. OpenSSH;
3. Docker Engine dalla repository ufficiale Docker;
4. Docker Compose plugin;
5. configurazione dell'utente per utilizzare Docker senza `sudo`;
6. verifica con `hello-world`;
7. creazione della directory iniziale per il laboratorio Docker.

Dopo questa fase fermarsi e attendere conferma prima di procedere con SQL Server e Redis.
