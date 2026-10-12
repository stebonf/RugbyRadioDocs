# 03 - SQL Server Express locale

## Scopo

Preparare SQL Server Express come container Docker locale, separato dai container applicativi e riusabile da piu' progetti.

La scelta confermata e' che SQL Server Express non deve essere un servizio privato della API RRL. Deve vivere come infrastruttura condivisa, con rete e volume propri.

## Modifiche effettuate

### Compose SQL Server condiviso

File aggiunto:

- `C:\Repositories\RRL\src\RugbyRadio\compose.sqlserver.yml`

Il compose definisce un solo servizio:

```yaml
sql-server-express
```

Caratteristiche principali:

- immagine `mcr.microsoft.com/mssql/server:2022-latest`;
- edition Express tramite `MSSQL_PID=Express`;
- container name `sqlserver-express`;
- volume persistente `sqlserver-express-data`;
- rete Docker condivisa `shared-net`;
- alias interno `sql-server-express`;
- porta host diagnostica solo su `127.0.0.1`.

La porta host configurata e':

```text
127.0.0.1:14333 -> 1433/tcp
```

Questo consente diagnosi locali da host, ma non espone SQL Server sulla LAN.

I container applicativi non devono usare la porta host `14333`; devono usare:

```text
sql-server-express,1433
```

sulla rete Docker condivisa.

### Template env SQL Server

File aggiunto:

- `C:\Repositories\RRL\src\RugbyRadio\.env.sqlserver.example`

Contiene solo placeholder e documenta le variabili del container SQL condiviso:

- `SHARED_SQLSERVER_SA_PASSWORD`;
- `SHARED_SQLSERVER_HOST_PORT`.

Il file reale locale deve essere:

```text
.env.sqlserver
```

e non deve essere committato.

Avvio previsto:

```powershell
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml up -d
```

### Collegamento della API alla rete SQL condivisa

File modificato:

- `C:\Repositories\RRL\src\RugbyRadio\compose.api.yml`

La API non crea SQL Server. Si collega invece alla rete esterna:

```yaml
networks:
  shared-net:
    external: true
    name: shared-net
```

Questo significa che prima deve essere avviato il compose SQL Server.

### Template env API aggiornato

File modificato:

- `C:\Repositories\RRL\src\RugbyRadio\.env.api.example`

La connection string di esempio ora punta all'alias Docker condiviso:

```text
Server=sql-server-express,1433;Database=RugbyRadioLive;...
```

Questo e' il formato corretto per comunicazione container-to-container.

## Come usarlo

### Avviare SQL Server Express condiviso

Creare un file locale non committato:

```text
.env.sqlserver
```

partendo da:

```text
.env.sqlserver.example
```

Poi eseguire:

```powershell
docker compose --env-file .env.sqlserver -f compose.sqlserver.yml up -d
```

### Avviare la API come consumer

Creare o aggiornare:

```text
.env.api
```

partendo da:

```text
.env.api.example
```

La API deve usare una connection string verso:

```text
sql-server-express,1433
```

Poi eseguire:

```powershell
docker compose --env-file .env.api -f compose.api.yml up --build
```

### Riutilizzo da altri progetti

Un altro progetto/container puo' usare lo stesso SQL Server se:

1. si collega alla rete Docker `shared-net`;
2. usa `sql-server-express,1433` come server;
3. usa un database dedicato;
4. non usa la porta host `14333` per comunicare da container.

Questo mantiene separati:

- lifecycle del database condiviso;
- lifecycle della API;
- lifecycle futuro di Hangfire;
- lifecycle di eventuali altri progetti.

## Verifiche eseguite

### Validazione compose SQL Server

Comando eseguito con variabili temporanee di shell:

```powershell
docker compose -f compose.sqlserver.yml config
```

Esito:

- configurazione valida;
- volume `sqlserver-express-data` risolto correttamente;
- rete `shared-net` risolta correttamente;
- porta pubblicata solo su `127.0.0.1`.

### Validazione compose API

Comando eseguito con variabili temporanee di shell:

```powershell
docker compose -f compose.api.yml config
```

Esito:

- configurazione valida;
- API collegata a rete esterna `shared-net`;
- connection string risolta verso `sql-server-express,1433`.

### Avvio SQL Server Express

Comando eseguito:

```powershell
docker compose -f compose.sqlserver.yml up -d
```

Esito:

- immagine SQL Server scaricata;
- volume `sqlserver-express-data` creato;
- rete `shared-net` creata;
- container `sqlserver-express` avviato.

Stato osservato:

```text
sqlserver-express Up
127.0.0.1:14333->1433/tcp
```

Log rilevante:

```text
SQL Server is now ready for client connections.
```

### Test porta locale

Comando eseguito:

```powershell
Test-NetConnection -ComputerName 127.0.0.1 -Port 14333
```

Esito:

```text
TcpTestSucceeded : True
```

Questo prova che la porta diagnostica locale funziona. Non e' il meccanismo da usare tra container.

### Creazione database UAT

Eseguito `sqlcmd` dentro il container SQL Server per creare, se assente:

```text
RugbyRadioLive
```

Esito:

```text
RugbyRadioLive
```

Il database e' presente.

### Persistenza dopo restart

Il container SQL Server e' stato riavviato.

Dopo il restart, una query su `sys.databases` ha confermato che:

```text
RugbyRadioLive
```

e' ancora presente.

Questo conferma che i dati stanno nel volume persistente e non nel filesystem effimero del container.

### Test da container separato sulla rete condivisa

Eseguito un container temporaneo collegato a:

```text
shared-net
```

Il container temporaneo ha interrogato SQL Server usando:

```text
sql-server-express
```

Esito:

```text
RugbyRadioLive
```

Questo verifica il punto piu' importante dello step: SQL Server Express e' raggiungibile da container separati tramite rete Docker condivisa, quindi puo' essere usato da API, HF e altri progetti.

## Stato finale

Step 3 completato per la parte infrastrutturale locale.

Sono disponibili:

- container SQL Server Express condiviso;
- volume persistente;
- rete Docker condivisa;
- alias interno stabile;
- env template dedicato;
- API compose collegato come consumer della rete SQL.

## Limiti intenzionali

Non sono stati ancora implementati:

- utente applicativo dedicato diverso da `sa`;
- restore di dati UAT reali;
- stored procedure applicative;
- backup ricorrenti;
- health endpoint API con check database;
- integrazione Hangfire;
- compose stack completo.

Questi punti sono candidati naturali per gli step successivi.

## Condizioni per passare allo step 4

Per procedere allo step 4 serve scegliere il metodo di porting dati verso SQL Server Express UAT:

- backup/restore `.bak`, se compatibile;
- DACPAC/BACPAC;
- script export/import solo se backup/restore non basta.

Prima di usare dati reali serve confermare:

- origine database UAT;
- dimensione database;
- versione SQL Server sorgente;
- presenza e stato delle stored procedure;
- eventuale necessita' di sanitizzazione.
