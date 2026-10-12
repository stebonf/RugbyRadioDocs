# 04 - Porting dati SQL Server Express

## Stato

Completato.

## Scopo

Definire un flusso controllato per portare i dati RRL da SQL Server esistente a SQL Server Express UAT su Docker/VPS usando il flusso classico backup, copia file e restore.

Questa fase non converte schema o provider: mantiene SQL Server e si concentra su backup, restore, sanitizzazione eventuale e verifica funzionale.

## Obiettivo

Realizzare un flusso ripetibile:

```text
SQL Server sorgente UAT
    -> BACKUP DATABASE .bak
    -> copia file .bak
    -> RESTORE DATABASE su SQL Server Express UAT
    -> verifiche applicative
```

## Vincoli

- Non migrare a PostgreSQL.
- Non usare dati PROD senza autorizzazione esplicita.
- Preferire dati UAT o copia sanitizzata.
- Non committare backup, dump, connection string o credenziali.
- Non eseguire restore distruttivi senza conferma.
- Documentare versione SQL Server sorgente e target.
- Verificare compatibilita' tra edition sorgente e SQL Server Express.
- Tenere SQL Server non pubblico anche durante le prove.

## Come procedere

1. Identificare database sorgente UAT e versione SQL Server.
2. Stimare dimensione database e verificare limiti di SQL Server Express.
3. Usare come metodo principale backup/restore `.bak`.
4. Preparare directory locale temporanea fuori da Git per gli artefatti dati.
5. Eseguire `BACKUP DATABASE` dal database sorgente.
6. Verificare il backup con `RESTORE VERIFYONLY`.
7. Copiare il file `.bak` nel contesto runtime previsto senza includerlo nell'immagine Docker:
   - locale: `docker cp`;
   - VPS: `scp` verso server e poi `docker cp` verso container, oppure bind mount approvato.
8. Eseguire `RESTORE FILELISTONLY` per leggere i logical file name.
9. Eseguire `RESTORE DATABASE` nel container SQL Server Express con `MOVE` verso `/var/opt/mssql/data`.
10. Rimuovere il file `.bak` temporaneo dal container dopo restore riuscito, salvo decisione diversa.
11. Ricreare o verificare login/utente applicativo.
12. Verificare eventuali stored procedure richieste da API/HF, in particolare manutenzione e backup.
13. Aggiornare connection string UAT.
14. Eseguire test applicativi su endpoint che leggono dati reali.

## Verifiche

Controllare almeno:

- database online dopo restore/import;
- dimensione compatibile con SQL Server Express;
- conteggio righe per tabelle principali;
- integrita' foreign key;
- stored procedure presenti o decisione documentata;
- login e permessi applicativi;
- query API principali;
- avvio Hangfire quando verra' incluso nello stack;
- persistenza dopo restart container.

## Deliverable

- Procedura backup/copia/restore.
- Script operativi `backup-database.sql` e `restore-database.sql`.
- `.env.api.example` e `.env.sqlserver.example` aggiornati con placeholder.
- Report porting dati UAT.
- Elenco anomalie o incompatibilita' edition/versione.
- Decisione su gestione backup ricorrenti nello stack VPS.

## Criteri di uscita

La fase e' completa quando:

- il database UAT e' disponibile su SQL Server Express;
- il porting usa un file `.bak` verificato;
- la API legge dati reali dal database containerizzato;
- conteggi e relazioni principali sono verificati;
- login e permessi sono riproducibili;
- le anomalie residue sono documentate.

Nota operativa: il restore automatizzato accetta anche backup `.bak` privi di informazioni checksum. In questo caso `RESTORE VERIFYONLY` viene eseguito senza `WITH CHECKSUM`; i backup creati dallo script locale continuano invece a includere `CHECKSUM`.

## Stop point

Lo step e' concluso. Prima di passare alla Fase 5 restano eventualmente da completare solo le verifiche applicative sui dati UAT ripristinati.
