# 02 - SQL Server Express invece di PostgreSQL

## Decisione

Per la migrazione UAT Docker/VPS di RRL non si procede con la migrazione a PostgreSQL.

Il database target per UAT sara' SQL Server Express.

## Data

2026-09-05

## Motivazione

La decisione deriva dagli impatti evidenziati nello step 1 di analisi repository.

Il codice reale usa SQL Server in modo trasversale:

- API configurata con `UseSqlServer`;
- Hangfire configurato con `Hangfire.SqlServer`;
- libreria comune dipendente da `Microsoft.EntityFrameworkCore.SqlServer`;
- test che costruiscono il modello con provider SQL Server;
- stored procedure `sp_Maintenance` e `sp_Backup`;
- connection string esistenti orientate a SQL Server/SQLEXPRESS.

Migrare a PostgreSQL introdurrebbe contemporaneamente:

- cambio provider EF Core;
- verifica mapping e query;
- revisione storage Hangfire;
- riscrittura o rimozione stored procedure;
- creazione baseline migrations assenti;
- rischio su collation, case sensitivity e gestione date/time.

Per UAT l'obiettivo principale e' validare Docker/VPS, non cambiare database engine. SQL Server Express consente una migrazione piu' incrementale e con minore rischio applicativo.

## Impatti sul piano

- La Fase 3 diventa `SQL Server Express locale`.
- La Fase 4 diventa `Porting dati SQL Server Express`.
- Lo stack locale e VPS usera' SQL Server Express come servizio interno non pubblico.
- Hangfire manterra' storage SQL Server.
- Le verifiche di monitoraggio e disaster recovery riguarderanno backup/restore SQL Server Express.
- PostgreSQL resta fuori scope per questa migrazione UAT.

## Vincoli confermati

- SQL Server non deve essere esposto pubblicamente.
- I dati devono stare su volume persistente, non nel filesystem effimero del container.
- Credenziali, backup e dump non devono essere committati.
- Eventuali prove su dati reali devono usare UAT o copie esplicitamente autorizzate/sanitizzate.

## Conseguenza operativa

Il prossimo passo consigliato e' implementare la Fase 3: aggiungere SQL Server Express al compose locale, collegare la API tramite service name Docker e verificare startup, persistenza e reachability database.
