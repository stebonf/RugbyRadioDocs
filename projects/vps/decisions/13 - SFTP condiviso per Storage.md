# Decisione 13 - SFTP condiviso per Storage

## Decisione

Viene introdotto un container chiamato `sftp`, senza prefisso `rrl-`, perché il servizio è infrastrutturale e potenzialmente riutilizzabile da più progetti.

Il container monta il volume `rrl-storage-data` in lettura/scrittura e usa SFTP, non FTP classico.

## Raggruppamento Compose

- `name: shared`: SQL Server Express e SFTP.
- `name: rrl`: API, Hangfire, Storage, Blog e SEO.

Il raggruppamento è ottenuto tramite il nome del progetto Compose e viene visualizzato da Docker Desktop.

## Motivazione

SFTP cifra autenticazione e trasferimento, mentre FTP classico esporrebbe le credenziali e i file in chiaro salvo configurazioni aggiuntive. Il volume condiviso evita copie intermedie e rende immediatamente disponibili via CDN i file modificati tramite SFTP.

## Conseguenze

Il servizio deve restare limitato alla rete o agli IP autorizzati. La password locale è solo per sviluppo; in UAT/produzione è preferibile usare chiavi SSH, firewall e accesso tramite VPN o tunnel.
