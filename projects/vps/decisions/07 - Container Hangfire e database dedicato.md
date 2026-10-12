# Decisione 07 - Container Hangfire e database dedicato

## Decisione

Hangfire viene eseguito in un container dedicato:

- container: `rrl-hangfire`;
- immagine: `rrl-hangfire:latest`;
- compose: `compose.hangfire.yml`;
- porta locale dashboard: `127.0.0.1:5200` verso `8080` nel container;
- rete: `shared-net`;
- database Hangfire: `RugbyRadioLive-HF`;
- backup iniziale: `C:\Repositories\RRL\backup\RugbyRadioLive-HF.bak`.

Il container usa inoltre la connessione applicativa verso `RugbyRadioLive`, perché i job leggono e aggiornano i dati RRL.

## Output persistenti

Gli output prodotti dai job vengono scritti su volumi Docker nominati:

- `rrl-blog-content`, montato in `/data/blog`;
- `rrl-seo-content`, montato in `/data/seo`.

I volumi sono predisposti per essere condivisi in seguito con i container `rrl-blog` e `rrl-seo`.

## Restore

Il restore del database Hangfire e' eseguito automaticamente dallo script PowerShell insieme al restore di `RugbyRadioLive`. Lo script non accetta flag ed e' intenzionalmente distruttivo nella fase locale corrente.

## Motivazione

Hangfire ha un ciclo di vita e responsabilita' diversi dalle API: esegue job persistenti, usa storage SQL Server dedicato e produce contenuti consumati da altri servizi. Separarlo consente restart, log e rilascio indipendenti.
