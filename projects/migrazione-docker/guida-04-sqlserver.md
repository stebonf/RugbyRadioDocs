# Guida 04 - SQL Server in Docker

## Obiettivo

Avviare SQL Server in un container Docker indipendente.

---

## 1. Collegarsi via SSH

Da PowerShell:

```powershell
ssh stefano@192.168.4.33
```

---

## 2. Verificare RAM

```bash
free -h
```

---

## 3. Entrare nella Directory SQL Server

```bash
cd ~/rrl-lab/containers/sqlserver
pwd
```

Risultato atteso:

```text
/home/stefano/rrl-lab/containers/sqlserver
```

---

## 4. Creare .env

```bash
nano .env
```

Contenuto:

```env
MSSQL_SA_PASSWORD=RrlSql-Lab-2026!
```

---

## 5. Creare .env.example

```bash
nano .env.example
```

Contenuto:

```env
MSSQL_SA_PASSWORD=change-me
```

---

## 6. Creare compose.yml

```bash
nano compose.yml
```

Contenuto:

```yaml
services:
  sqlserver:
    image: mcr.microsoft.com/mssql/server:2022-latest
    container_name: rrl-sqlserver
    environment:
      ACCEPT_EULA: "Y"
      MSSQL_PID: "Developer"
      MSSQL_SA_PASSWORD: "${MSSQL_SA_PASSWORD}"
    ports:
      - "1433:1433"
    volumes:
      - sqlserver-data:/var/opt/mssql
    networks:
      rrl-backend:
        aliases:
          - sqlserver
    restart: unless-stopped

volumes:
  sqlserver-data:
    name: rrl-sqlserver-data

networks:
  rrl-backend:
    external: true
```

---

## 7. Avviare SQL Server

```bash
docker compose up -d
docker compose ps
docker compose logs -f sqlserver
```

Uscire dai log:

```text
CTRL+C
```

---

## 8. Testare sqlcmd

```bash
docker exec -it rrl-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'RrlSql-Lab-2026!' -C
```

Dentro `sqlcmd`:

```sql
SELECT @@VERSION;
GO
EXIT
```

---

## 9. Creare Database Test

```bash
docker exec -it rrl-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'RrlSql-Lab-2026!' -C
```

Dentro `sqlcmd`:

```sql
CREATE DATABASE RRL_Test;
GO

SELECT name FROM sys.databases;
GO

EXIT
```

---

## 10. Testare Persistenza

```bash
cd ~/rrl-lab/containers/sqlserver
docker compose down
docker compose up -d
```

```bash
docker exec -it rrl-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'RrlSql-Lab-2026!' -C
```

Dentro `sqlcmd`:

```sql
SELECT name FROM sys.databases;
GO
EXIT
```

---

## 11. Copiare Backup .bak da Windows

Da PowerShell, nella cartella del backup:

```powershell
scp .\RRL.bak stefano@192.168.4.33:/home/stefano/rrl-lab/backups/sqlserver/RRL.bak
```

---

## 12. Copiare Backup nel Container

Dentro Ubuntu:

```bash
docker exec -it rrl-sqlserver mkdir -p /var/opt/mssql/backup
docker cp ~/rrl-lab/backups/sqlserver/RRL.bak rrl-sqlserver:/var/opt/mssql/backup/RRL.bak
docker exec -it rrl-sqlserver ls -lh /var/opt/mssql/backup
```

---

## 13. Leggere Logical Name

```bash
docker exec -it rrl-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'RrlSql-Lab-2026!' -C
```

Dentro `sqlcmd`:

```sql
RESTORE FILELISTONLY
FROM DISK = '/var/opt/mssql/backup/RRL.bak';
GO
EXIT
```

Annotare i valori della colonna `LogicalName`.

---

## 14. Ripristinare Database

```bash
docker exec -it rrl-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'RrlSql-Lab-2026!' -C
```

Dentro `sqlcmd`, sostituendo i logical name se diversi:

```sql
RESTORE DATABASE RRL
FROM DISK = '/var/opt/mssql/backup/RRL.bak'
WITH
    MOVE 'RRL' TO '/var/opt/mssql/data/RRL.mdf',
    MOVE 'RRL_log' TO '/var/opt/mssql/data/RRL_log.ldf',
    RECOVERY,
    STATS = 10;
GO

SELECT name FROM sys.databases;
GO

EXIT
```

---

## 15. Sovrascrivere Database Esistente

Usare solo se il database `RRL` esiste gia' e deve essere sostituito.

```bash
docker exec -it rrl-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'RrlSql-Lab-2026!' -C
```

Dentro `sqlcmd`, sostituendo i logical name se diversi:

```sql
ALTER DATABASE RRL SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

RESTORE DATABASE RRL
FROM DISK = '/var/opt/mssql/backup/RRL.bak'
WITH
    MOVE 'RRL' TO '/var/opt/mssql/data/RRL.mdf',
    MOVE 'RRL_log' TO '/var/opt/mssql/data/RRL_log.ldf',
    REPLACE,
    RECOVERY,
    STATS = 10;
GO

ALTER DATABASE RRL SET MULTI_USER;
GO

EXIT
```

---

## 16. Creare Login Applicativo

```bash
docker exec -it rrl-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P 'RrlSql-Lab-2026!' -C
```

Dentro `sqlcmd`:

```sql
USE master;
GO

CREATE LOGIN rrl_app
WITH PASSWORD = 'RrlApp-Lab-2026!',
     CHECK_POLICY = ON,
     CHECK_EXPIRATION = OFF;
GO

USE RRL;
GO

CREATE USER rrl_app FOR LOGIN rrl_app;
GO

ALTER ROLE db_datareader ADD MEMBER rrl_app;
ALTER ROLE db_datawriter ADD MEMBER rrl_app;
GO

GRANT EXECUTE TO rrl_app;
GO

EXIT
```

---

## 17. Testare Login Applicativo

```bash
docker exec -it rrl-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U rrl_app -P 'RrlApp-Lab-2026!' -d RRL -C
```

Dentro `sqlcmd`:

```sql
SELECT DB_NAME() AS CurrentDatabase;
GO
EXIT
```

---

## 18. Connessione da SSMS

Da SQL Server Management Studio:

```text
Server type: Database Engine
Server name: 192.168.4.33,1433
Authentication: SQL Server Authentication
Login: rrl_app
Password: RrlApp-Lab-2026!
Trust server certificate: attivo
```

Test rete da PowerShell:

```powershell
Test-NetConnection 192.168.4.33 -Port 1433
```

---

## 19. Comandi Utili

```bash
cd ~/rrl-lab/containers/sqlserver
docker compose ps
docker compose logs sqlserver
docker compose logs -f sqlserver
docker compose down
docker compose up -d
docker volume ls
docker volume inspect rrl-sqlserver-data
```

---

## Risultato Atteso

```text
container rrl-sqlserver avviato
volume rrl-sqlserver-data creato
database RRL ripristinato oppure RRL_Test creato
login rrl_app creato
SQL Server raggiungibile sulla rete Docker rrl-backend come sqlserver
```

---

## Note Finali

SQL Server e' un container indipendente. La sua configurazione vive in:

```text
~/rrl-lab/containers/sqlserver
```

Il volume dati ha nome esplicito:

```text
rrl-sqlserver-data
```

La API non deve stare nello stesso `compose.yml`. Si colleghera' al database tramite la rete esterna `rrl-backend` e il nome DNS `sqlserver`.

La porta `1433:1433` serve per test locali e SSMS. Su VPS pubblica non esporre SQL Server direttamente su Internet.

Non usare `sa` nelle applicazioni. Usare login dedicati come `rrl_app`.
