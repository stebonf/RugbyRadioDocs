# 03 - SQL Server Express locale

## Scopo

Preparare SQL Server Express in Docker come database locale/UAT condiviso, mantenendo il provider EF Core attuale e riducendo l'impatto della migrazione VPS.

Questa fase sostituisce la precedente ipotesi di migrazione a PostgreSQL. La decisione nasce dagli impatti emersi nella Fase 1: API, Hangfire, test, stored procedure e pacchetti sono gia' orientati a SQL Server.

Il container SQL Server Express deve essere separato dai container applicativi e trasversale a piu' progetti. RRL deve usarlo come consumer tramite rete Docker e database dedicato, non possederlo come servizio privato della sola API.

## Obiettivo

Creare un database SQL Server Express locale, non pubblico, raggiungibile dai container applicativi tramite rete Docker e compatibile con il codice esistente.

## Vincoli

- Usare SQL Server Express come target UAT.
- Gestire SQL Server Express in un compose separato dai compose applicativi.
- Usare nome rete, volume e variabili con prefisso condiviso, non specifico RRL.
- Non migrare a PostgreSQL.
- Non introdurre Npgsql o provider EF alternativi.
- Non esporre SQL Server pubblicamente.
- Non salvare dati nel filesystem effimero del container.
- Usare volume persistente per i dati SQL Server.
- Non lavorare su dati PROD.
- Testare con database vuoto o copia UAT.
- Non eseguire operazioni distruttive senza conferma.

## Come procedere

1. Aggiungere un compose locale separato per SQL Server Express condiviso.
2. Usare immagine Microsoft SQL Server Linux con edition Express, ad esempio configurando `MSSQL_PID=Express`.
3. Configurare una password amministrativa tramite variabile d'ambiente/secret locale, mai in Git.
4. Esporre la porta SQL Server solo in locale se serve per diagnostica con tool esterni; nello stack target tenerla solo su rete backend.
5. Creare named volume per i dati SQL Server.
6. Creare database applicativo `RugbyRadioLive`.
7. Creare eventuali login/utente applicativo dedicato con permessi minimi necessari.
8. Aggiornare `.env.sqlserver.example` e `.env.api.example` con variabili non sensibili e placeholder.
9. Configurare `ConnectionStrings__App` della API verso alias Docker condiviso, ad esempio `sql-server-express,1433`.
10. Preparare la futura configurazione Hangfire mantenendo storage SQL Server.
11. Verificare startup, persistenza e raggiungibilita' dalla API.

## Aree da controllare

- `UseSqlServer` in API e HF;
- `Microsoft.EntityFrameworkCore.SqlServer`;
- `Hangfire.SqlServer`;
- stored procedure `sp_Maintenance` e `sp_Backup`;
- connection string SQLEXPRESS attuali;
- compatibilita' SQL Server Linux rispetto a path Windows;
- strategia backup/restore su container;
- collation e timezone;
- permessi utente applicativo.

## Deliverable

- Compose locale aggiornato con SQL Server Express.
- Compose SQL Server separato dai compose applicativi.
- Rete Docker condivisa e documentata per consumer multi-progetto.
- Volume persistente SQL Server documentato.
- `.env.sqlserver.example` e `.env.api.example` senza segreti.
- Connection string containerizzata per API.
- Decisione su pubblicazione porta SQL solo locale o nessuna pubblicazione.
- Report di verifica startup/persistenza.

## Criteri di uscita

La fase e' completa quando:

- SQL Server Express parte in Docker;
- il database UAT e' creato o ripristinabile;
- la API puo' raggiungere SQL Server tramite service name Docker;
- i dati sopravvivono a restart e `docker compose down`;
- SQL Server non e' esposto pubblicamente;
- e' chiaro come configurare Hangfire nello step successivo.

## Stop point

Fermarsi e chiedere conferma prima di passare alla Fase 4.
