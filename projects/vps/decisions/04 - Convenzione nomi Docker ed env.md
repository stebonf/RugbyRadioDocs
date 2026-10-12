# 04 - Convenzione nomi Docker ed env

## Decisione

I nomi Docker e i file env per RRL UAT devono usare una convenzione breve, stabile e senza suffisso `local` nei nomi principali.

Il suffisso `local` viene rimosso dai file compose/env perche' l'ambiente locale e' gia' implicito nel contesto di esecuzione. In seguito, eventuali ambienti diversi saranno distinti da file o cartelle dedicate.

## Data

2026-09-05

## Convenzione approvata

### File Compose

- `compose.api.yml`
- `compose.sqlserver.yml`

### File Env

- `.env.api.example`
- `.env.api`
- `.env.sqlserver.example`
- `.env.sqlserver`

### Servizi Compose

- `rrl-api-s1`
- `rrl-api-s2`
- `sql-server-express`

### Immagini Docker

- `rrl-api:latest`
- `mcr.microsoft.com/mssql/server:2022-latest`

### Container Name

- `sqlserver-express`
- `rrl-api-test` solo per test temporanei manuali

### Network Docker

- `shared-net`

### Volume Docker

- `sqlserver-express-data`

### Alias interno Docker

- `sql-server-express`

### Database

- `RugbyRadioLive`

### Variabili Env

- `RRL_API_*`
- `SHARED_SQLSERVER_*`

## Motivazione

La convenzione separa il ruolo tecnico dall'ambiente:

- i file descrivono quale componente si sta avviando;
- le risorse Docker hanno nomi brevi e riusabili;
- SQL Server Express resta infrastruttura condivisa;
- la API resta un consumer del database;
- il tag `latest` e' esplicito per la build locale API.

## Impatti

- Rinominare `compose.api.local.yml` in `compose.api.yml`.
- Rinominare `compose.sqlserver.local.yml` in `compose.sqlserver.yml`.
- Rinominare `.env.api.local.example` in `.env.api.example`.
- Rinominare `.env.sqlserver.local.example` in `.env.sqlserver.example`.
- Usare `.env.api` e `.env.sqlserver` come file reali locali non committati.
- Aggiornare documentazione, decision log e risultati degli step 02/03.
