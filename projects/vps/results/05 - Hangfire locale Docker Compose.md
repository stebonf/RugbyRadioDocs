# 05 - Hangfire locale Docker Compose

## Stato

Step verificato localmente. Lo script di setup esegue sempre reset completo, restore dei due database e avvio del container Hangfire.

## Obiettivo

Aggiungere `rrl-hangfire` allo stack locale come container always-on separato dalle API, con database Hangfire dedicato e output Blog/SEO persistenti.

## Componenti creati

- `C:\Repositories\RRL\src\RugbyRadio\HF\Dockerfile`;
- `C:\Repositories\RRL\src\RugbyRadio\compose.hangfire.yml`;
- `C:\Repositories\RRL\src\RugbyRadio\.env.hangfire.example`;
- contenuti `Prompts`, `Templates` e `Fonts` inclusi nella pubblicazione HF;
- script PowerShell aggiornato con generazione env e restore Hangfire.

## Configurazione runtime

```text
container: rrl-hangfire
image: rrl-hangfire:latest
dashboard locale: http://localhost:5200
rete: shared-net
database applicativo: RugbyRadioLive
database Hangfire: RugbyRadioLive-HF
```

Volumi:

```text
rrl-blog-content -> /data/blog
rrl-seo-content  -> /data/seo
```

## Restore automatizzato

Il backup disponibile e':

```text
C:\Repositories\RRL\backup\RugbyRadioLive-HF.bak
```

Il comando completo previsto e' senza flag:

```powershell
.\projects\vps\scripts\Initialize-LocalRrl.ps1
```

Lo script copia il `.bak` nel container SQL Server, esegue `RESTORE VERIFYONLY`, quindi invoca lo script di restore parametrizzando database, backup e file MDF/LDF. Ogni variabile `sqlcmd` viene passata con un'opzione `-v` separata. La stessa sequenza viene eseguita anche per `RugbyRadioLive.bak`.

## Verifiche eseguite

- `docker compose config --quiet`: superato;
- parsing PowerShell: superato;
- `dotnet build HF/HF.csproj`: superato con 0 errori;
- warning esistenti: due NU1902 su dipendenze e due warning nullable nel codice HF.

## Smoke test runtime

Eseguito lo script completo senza flag:

```powershell
.\projects\vps\scripts\Initialize-LocalRrl.ps1
```

Esito:

- `RugbyRadioLive` ripristinato e `ONLINE`;
- `RugbyRadioLive-HF` ripristinato e `ONLINE`;
- `rrl-api-s1` avviato;
- `rrl-api-s2` avviato;
- `rrl-hangfire` avviato;
- Hangfire ha eseguito query sul database applicativo;
- prima della correzione, `http://localhost:5200/hangfire` rispondeva `401`;

Il `401` iniziale era causato dal filtro predefinito Hangfire, che vedeva la richiesta del PC come proveniente dalla rete Docker e non da localhost. E' stato aggiunto `HangfireDashboardAuthorizationFilter`, controllato da `HangfireDashboard:AllowLocal`; con `RRL_HF_DASHBOARD_ALLOW_LOCAL=true` la dashboard locale risponde `200`.

Durante il test è stato corretto il restore parametrizzato: le direttive `:setvar` del file SQL sovrascrivevano i valori passati a `sqlcmd`. Lo script genera ora una copia temporanea con database, backup e percorsi MDF/LDF risolti prima dell'esecuzione.

## Verifiche da eseguire

- restore di `RugbyRadioLive-HF.bak`;
- avvio del container `rrl-hangfire`;
- accesso alla dashboard su `http://localhost:5200`;
- presenza dei volumi `rrl-blog-content` e `rrl-seo-content`;
- verifica log Hangfire e connessione a entrambi i database;
- restart del container senza perdita degli output persistenti.
