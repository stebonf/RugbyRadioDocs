# 03 - SQL Server Express condiviso multi progetto

## Decisione

SQL Server Express deve essere gestito come container infrastrutturale separato e condiviso, non come servizio privato del compose API.

RRL usera' questo SQL Server come consumer tramite rete Docker condivisa e database dedicato.

## Data

2026-09-05

## Motivazione

Il database deve essere trasversale a piu' progetti. Legarlo al solo compose API renderebbe piu' difficile:

- riusarlo da Hangfire;
- riusarlo da altri progetti;
- gestire backup e restore in modo uniforme;
- separare lifecycle infrastrutturale e lifecycle applicativo;
- portare lo stesso modello su VPS.

## Convenzioni adottate

- Compose dedicato: `compose.sqlserver.yml`.
- Env template dedicato: `.env.sqlserver.example`.
- Container name: `sqlserver-express`.
- Network Docker condivisa: `shared-net`.
- Volume Docker condiviso: `sqlserver-express-data`.
- Alias interno: `sql-server-express`.
- Porta host diagnostica locale: `127.0.0.1:14333`.

## Impatti

- `compose.api.yml` non crea SQL Server, ma si collega alla rete esterna `shared-net`.
- La API usa nella connection string il server `sql-server-express,1433`.
- I futuri compose Hangfire e stack potranno collegarsi alla stessa rete.
- In VPS SQL Server non dovra' essere esposto pubblicamente.

## Vincoli

- Nessun segreto SQL Server deve essere committato.
- Il file reale `.env.sqlserver` deve restare locale e ignorato da Git.
- Ogni progetto deve usare un database/logical schema dedicato dentro l'istanza condivisa.
- Non usare la porta host come meccanismo di comunicazione tra container: i container devono usare rete Docker e alias interno.
