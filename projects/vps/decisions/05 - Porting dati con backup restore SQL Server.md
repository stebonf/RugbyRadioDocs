# 05 - Porting dati con backup restore SQL Server

## Decisione

Il porting dati verso SQL Server Express UAT usera' il flusso classico:

```text
BACKUP DATABASE
-> copia file .bak
-> RESTORE DATABASE
```

## Data

2026-09-06

## Motivazione

Dato che la migrazione PostgreSQL e' stata esclusa e il target resta SQL Server Express, il backup/restore nativo e' la strada piu' semplice, prevedibile e vicina al funzionamento operativo reale.

Questo evita:

- export applicativi non necessari;
- trasformazioni di schema;
- differenze introdotte da formati intermedi;
- tool aggiuntivi come BACPAC/DACPAC se non necessari.

## Convenzioni

- Database target: `RugbyRadioLive`.
- Container SQL Server: `sqlserver-express`.
- Alias interno Docker: `sql-server-express`.
- Backup temporanei nel container: `/var/opt/mssql/backup`.
- Data/log file ripristinati in: `/var/opt/mssql/data`.
- Script di supporto:
  - `sqlserver/backup-database.sql`;
  - `sqlserver/restore-database.sql`.

## Vincoli

- I file `.bak` non devono essere committati.
- I file `.bak` non devono essere copiati dentro l'immagine Docker.
- Il restore su database esistente e' distruttivo e richiede conferma quando contiene dati reali.
- Prima del restore reale serve verificare versione sorgente, dimensione database e compatibilita' con SQL Server Express.
- Dopo il restore, il file `.bak` temporaneo nel container va rimosso o gestito secondo una policy backup esplicita.

## Fallback

BACPAC/DACPAC o export applicativo restano fallback solo se il backup/restore `.bak` non e' compatibile con edition/versione sorgente o con i limiti di SQL Server Express.

## Nota tecnica aggiunta

Il backup sorgente usato nella prova finale non conteneva informazioni checksum. Di conseguenza la procedura di restore usa `RESTORE VERIFYONLY` senza `WITH CHECKSUM` e non forza `CHECKSUM` nel `RESTORE DATABASE`. Gli script di backup locali possono comunque creare backup con checksum quando l'opzione e' supportata.

## Stato

Decisione applicata e step di porting concluso.
