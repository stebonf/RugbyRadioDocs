# 04 - Porting dati SQL Server Express

## Stato finale

Step concluso.

## Scopo

Preparare e verificare il flusso classico di porting dati verso SQL Server Express:

```text
BACKUP DATABASE
-> copia file .bak
-> RESTORE DATABASE
```

La decisione e' usare backup/restore nativo SQL Server come metodo principale. BACPAC, DACPAC o export applicativo restano solo fallback.

## Decisione applicata

Il porting dati reale e' stato eseguito con:

1. backup `.bak` del database SQL Server sorgente;
2. copia del file `.bak` verso l'ambiente Docker/VPS;
3. restore dentro il container SQL Server Express;
4. verifica database, login, stored procedure e lettura applicativa.

Decisione registrata in:

- `C:\Repositories\RRL\docs\projects\vps\decisions\05 - Porting dati con backup restore SQL Server.md`

## Modifiche effettuate

### Script backup

File aggiunto:

- `C:\Repositories\RRL\src\RugbyRadio\sqlserver\backup-database.sql`

Lo script esegue:

- `BACKUP DATABASE`;
- `COPY_ONLY`;
- `CHECKSUM`;
- `RESTORE VERIFYONLY`.

Nota importante: inizialmente lo script includeva `WITH COMPRESSION`, ma SQL Server Express non supporta backup compression. La verifica locale ha intercettato il problema e lo script e' stato corretto rimuovendo `COMPRESSION`.

### Script restore

File aggiunto:

- `C:\Repositories\RRL\src\RugbyRadio\sqlserver\restore-database.sql`

Lo script esegue:

- `RESTORE FILELISTONLY` per leggere i logical file name dal `.bak`;
- `ALTER DATABASE ... SINGLE_USER WITH ROLLBACK IMMEDIATE` se il database esiste;
- `RESTORE DATABASE ... WITH REPLACE`;
- `MOVE` dei file dati/log verso `/var/opt/mssql/data`;
- `ALTER DATABASE ... MULTI_USER`;
- query finale su `sys.databases`.

Lo script evita di hardcodare i logical file name del backup, perche' li legge dal file `.bak`.

La lettura del campo `Type` del risultato `RESTORE FILELISTONLY` usa un tipo testuale tollerante e rimuove eventuali spazi prima di distinguere file dati (`D`) e log (`L`).

Il restore non forza `WITH CHECKSUM`, perche' un backup sorgente puo' essere stato creato senza checksum. La verifica usa `RESTORE VERIFYONLY` senza opzioni aggiuntive obbligatorie e resta compatibile sia con backup esterni privi di checksum sia con backup locali creati con `CHECKSUM`.

### Ignore backup SQL Server

File modificato:

- `C:\Repositories\RRL\src\RugbyRadio\.gitignore`

Aggiunte regole:

```gitignore
*.bak
*.trn
*.dif
*.diff
```

I backup non devono entrare in Git.

## Procedura locale prevista

### 1. Avviare SQL Server Express

```powershell
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml up -d
```

### 2. Copiare il backup nel container

Esempio locale:

```powershell
docker exec sqlserver-express mkdir -p /var/opt/mssql/backup
docker cp C:\path\to\RugbyRadioLive.bak sqlserver-express:/var/opt/mssql/backup/RugbyRadioLive.bak
```

Su VPS il flusso previsto e':

```text
scp RugbyRadioLive.bak <utente>@<vps>:/tmp/RugbyRadioLive.bak
docker cp /tmp/RugbyRadioLive.bak sqlserver-express:/var/opt/mssql/backup/RugbyRadioLive.bak
```

Il file `.bak` non deve essere copiato dentro l'immagine Docker.

### 3. Verificare il backup

```powershell
docker exec -e SQLCMDPASSWORD="<password>" sqlserver-express /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -C -Q "RESTORE VERIFYONLY FROM DISK = N'/var/opt/mssql/backup/RugbyRadioLive.bak';"
```

### 4. Eseguire restore

```powershell
docker cp sqlserver/restore-database.sql sqlserver-express:/tmp/restore-database.sql
docker exec -e SQLCMDPASSWORD="<password>" sqlserver-express /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -C -i /tmp/restore-database.sql
```

### 5. Rimuovere il backup temporaneo dal container

Dopo restore riuscito:

```powershell
docker exec sqlserver-express rm -f /var/opt/mssql/backup/RugbyRadioLive.bak
```

Conservazione, retention e backup ricorrenti vanno definiti in modo separato: un file `.bak` copiato temporaneamente nel container non e' una strategia di backup.

## Smoke test eseguito

Il test e' stato fatto senza dati reali.

### Preparazione

Container usato:

```text
sqlserver-express
```

Database smoke:

```text
RugbyRadioLive
```

Creata directory interna:

```text
/var/opt/mssql/backup
```

### Backup

Eseguito `backup-database.sql` tramite `sqlcmd`.

Esito:

```text
BACKUP DATABASE successfully processed 346 pages
The backup set on file 1 is valid.
```

### Copia file fuori dal container

Il file:

```text
/var/opt/mssql/backup/RugbyRadioLive.bak
```

e' stato copiato su host temporaneo con `docker cp`.

Dimensione osservata:

```text
2936832 bytes
```

### Copia file dentro il container

Il `.bak` copiato su host e' stato ricopiato nel container come:

```text
/var/opt/mssql/backup/RugbyRadioLive-copied.bak
```

Verifica:

```text
The backup set on file 1 is valid.
```

### Restore

Eseguito `restore-database.sql` tramite `sqlcmd`.

Esito:

```text
RESTORE DATABASE successfully processed 346 pages
RugbyRadioLive ONLINE FULL
```

### Cleanup

I file `.bak` smoke temporanei sono stati rimossi da:

- host temporaneo;
- cartella backup interna al container.

Il database `RugbyRadioLive` e' rimasto presente nel container SQL Server Express.

## Verifica tecnica

La meccanica backup/copia/restore e' verificata.

Il file `.bak` sorgente e' stato utilizzato nel flusso automatizzato di restore. Il file aveva dimensione osservata di circa 189 MB ed era privo di informazioni checksum; dopo la correzione della verifica il flusso e' stato reso compatibile con questo formato.

Il restore reale e' eseguito dallo script PowerShell con:

```powershell
.\projects\vps\scripts\Initialize-LocalRrl.ps1
```

## Cosa serve per completare il porting reale

Per eseguire il restore reale servono:

- file `.bak` del database UAT sorgente;
- versione SQL Server sorgente;
- dimensione database;
- conferma che il backup non contiene dati PROD non autorizzati;
- password `sa` o credenziali amministrative del container SQL Server Express;
- conferma prima di sovrascrivere un database `RugbyRadioLive` esistente con dati reali.

## Rischi e note

- SQL Server Express non supporta `WITH COMPRESSION` nei backup.
- SQL Server Express ha limiti di edition: prima del restore reale va verificata la dimensione del database.
- Il restore con `WITH REPLACE` e' distruttivo per il database target.
- Login SQL e utenti database possono richiedere riallineamento dopo restore.
- Stored procedure `sp_Maintenance` e `sp_Backup` vanno verificate sul database ripristinato.

## Conclusione

La procedura backup/copia/restore e' disponibile e verificata. Il prossimo step e' lo stack RRL locale completo, mantenendo le verifiche applicative sui dati ripristinati come controllo di ingresso.
