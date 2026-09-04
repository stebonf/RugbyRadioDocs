# Guida 05 - API RRL in Docker

## Obiettivo

Avviare la API RRL in un container Docker indipendente collegato a SQL Server tramite rete Docker.

---

## 1. Collegarsi via SSH

Da PowerShell:

```powershell
ssh stefano@192.168.4.33
```

---

## 2. Verificare SQL Server

```bash
cd ~/rrl-lab/containers/sqlserver
docker compose ps
```

---

## 3. Testare Login Applicativo SQL

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

## 4. Portare Codice Sorgente nella VM

Da PowerShell su Windows:

```powershell
scp -r C:\Repositories\RRL stefano@192.168.4.33:/home/stefano/rrl-lab/src/RRL
```

Verificare:

```bash
ls -la ~/rrl-lab/src/RRL/src/RugbyRadio
```

---

## 5. Creare Dockerfile API

Nel repository, creare:

```text
src/RugbyRadio/Api/Dockerfile
```

Contenuto:

```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY Api/Api.csproj Api/
COPY Lib/Lib.csproj Lib/
RUN dotnet restore Api/Api.csproj

COPY . .
RUN dotnet publish Api/Api.csproj -c Release -o /publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=build /publish .
ENTRYPOINT ["dotnet", "Api.dll"]
```

---

## 6. Creare .dockerignore

Nel repository, creare:

```text
src/RugbyRadio/.dockerignore
```

Contenuto:

```dockerignore
**/bin/
**/obj/
**/.vs/
**/.idea/
**/.vscode/
**/logs/

.git/
.gitignore

**/appsettings.Development.json
**/appsettings.json
**/UserSecrets/

**/*Key*.json
**/google*.json
**/FirebaseKey.json
```

---

## 7. Copiare FirebaseKey.json

Da PowerShell, dentro `C:\Repositories\RRL\src\RugbyRadio\Api`:

```powershell
scp .\FirebaseKey.json stefano@192.168.4.33:/home/stefano/rrl-lab/secrets/api/FirebaseKey.json
```

Verificare da Ubuntu:

```bash
ls -lh ~/rrl-lab/secrets/api/FirebaseKey.json
```

---

## 8. Entrare nella Directory API

```bash
cd ~/rrl-lab/containers/api
pwd
```

Risultato atteso:

```text
/home/stefano/rrl-lab/containers/api
```

---

## 9. Creare .env

```bash
nano .env
```

Contenuto:

```env
RRL_APP_DB_PASSWORD=RrlApp-Lab-2026!
RRL_JWT_SECRET_KEY=RrlJwt-Lab-Secret-Key-Change-Me-2026
RRL_SECURITY_VALID_ISSUER=http://localhost
RRL_SECURITY_VALID_AUDIENCE=http://localhost
```

---

## 10. Creare .env.example

```bash
nano .env.example
```

Contenuto:

```env
RRL_APP_DB_PASSWORD=change-me
RRL_JWT_SECRET_KEY=change-me
RRL_SECURITY_VALID_ISSUER=http://localhost
RRL_SECURITY_VALID_AUDIENCE=http://localhost
```

---

## 11. Creare compose.yml

```bash
nano compose.yml
```

Contenuto:

```yaml
services:
  api:
    build:
      context: /home/stefano/rrl-lab/src/RRL/src/RugbyRadio
      dockerfile: Api/Dockerfile
    container_name: rrl-api
    environment:
      ASPNETCORE_ENVIRONMENT: "Development"
      ASPNETCORE_URLS: "http://+:8080"
      ConnectionStrings__App: "Server=sqlserver,1433;Database=RRL;User Id=rrl_app;Password=${RRL_APP_DB_PASSWORD};TrustServerCertificate=True;"
      Security__ValidIssuer: "${RRL_SECURITY_VALID_ISSUER}"
      Security__ValidAudience: "${RRL_SECURITY_VALID_AUDIENCE}"
      Security__SecretKey: "${RRL_JWT_SECRET_KEY}"
    ports:
      - "5110:8080"
    volumes:
      - /home/stefano/rrl-lab/secrets/api/FirebaseKey.json:/app/FirebaseKey.json:ro
    networks:
      - rrl-frontend
      - rrl-backend
    restart: unless-stopped

networks:
  rrl-frontend:
    external: true
  rrl-backend:
    external: true
```

---

## 12. Build API

```bash
cd ~/rrl-lab/containers/api
docker compose build api
```

---

## 13. Avviare API

```bash
docker compose up -d
docker compose ps
docker compose logs -f api
```

Uscire dai log:

```text
CTRL+C
```

---

## 14. Testare API dalla VM

```bash
curl -i http://localhost:5110/openapi/v1.json
```

---

## 15. Testare API da Windows

Da PowerShell:

```powershell
curl http://192.168.4.33:5110/openapi/v1.json
```

Test porta:

```powershell
Test-NetConnection 192.168.4.33 -Port 5110
```

---

## 16. Comandi Utili

```bash
cd ~/rrl-lab/containers/api
docker compose ps
docker compose logs api
docker compose logs -f api
docker compose build api
docker compose build --no-cache api
docker compose down
docker compose up -d
docker exec -it rrl-api /bin/bash
```

---

## Risultato Atteso

```text
container rrl-api avviato
API buildata da Dockerfile multi-stage
API raggiungibile su porta 5110 della VM
API collegata a SQL Server tramite rrl-backend
SQL Server e API gestiti da compose.yml separati
```

---

## Note Finali

La API e' un container indipendente. La sua configurazione vive in:

```text
~/rrl-lab/containers/api
```

SQL Server vive separatamente in:

```text
~/rrl-lab/containers/sqlserver
```

I due container non condividono lo stesso `compose.yml` e non condividono lo stesso `.env`.

La comunicazione tra API e SQL Server avviene tramite rete Docker esterna:

```text
rrl-backend
```

La connection string interna deve usare:

```text
Server=sqlserver,1433
```

Non usare `localhost` nella connection string del container API.

`FirebaseKey.json` viene montato a runtime e non deve entrare nell'immagine Docker.

La porta `5110:8080` serve solo per test locali. In seguito l'esposizione pubblica passera' da reverse proxy.
