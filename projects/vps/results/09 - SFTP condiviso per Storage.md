# 09 - SFTP condiviso per Storage

## Obiettivo

Rendere disponibile un accesso SFTP in lettura/scrittura al contenuto dello storage, senza duplicare i file e senza legarlo a un singolo servizio applicativo.

## Implementazione

- Compose: `src/RugbyRadio/compose.sftp.yml`.
- Progetto Compose: `shared`.
- Container: `sftp`.
- Immagine: `atmoz/sftp:latest`.
- Porta locale: `127.0.0.1:2222`.
- Volume montato: `rrl-storage-data`.
- Directory utente: `/storage`.
- Rete: `shared-net`.

Il volume è lo stesso usato da `rrl-storage`, API e Hangfire. L'SFTP consente di aggiungere, modificare e rimuovere file; `rrl-storage` li espone immediatamente via HTTP come CDN.

## Configurazione

Il template `.env.sftp.example` contiene:

```dotenv
SHARED_SFTP_HOST_PORT=2222
SHARED_SFTP_USER=storage
SHARED_SFTP_PASSWORD=
```

Lo script genera `.env.sftp` e valorizza i parametri dalla sezione iniziale dello script.

## Raggruppamento Docker Desktop

I Compose condivisi dichiarano `name: shared`; i Compose applicativi dichiarano `name: rrl`. Docker Desktop mostra quindi SQL Server e SFTP nel gruppo `shared`, mentre API, Hangfire, Storage, Blog e SEO nel gruppo `rrl`.

## Verifica

```powershell
docker compose --env-file .env.sftp -f compose.sftp.yml config --quiet
docker ps --filter name=sftp
```

La verifica funzionale consiste nel collegarsi con un client SFTP a `127.0.0.1:2222`, creare un file in `/storage` e verificarne la disponibilità tramite `http://localhost:5300`.
