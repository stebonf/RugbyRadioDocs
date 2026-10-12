# Decisione 14 - Reverse proxy come componente shared

## Decisione

Il reverse proxy viene introdotto come componente infrastrutturale condiviso, con container `reverse-proxy` senza prefisso `rrl-` e progetto Compose `shared`.

## Implementazione locale

Nginx ascolta su `127.0.0.1:8080` e instrada i domini `.localhost` verso i servizi sulla rete `shared-net`. L'istanza API attiva viene selezionata tramite `SHARED_REVERSE_PROXY_API_UPSTREAM`.

## Motivazione

Il reverse proxy è un punto di ingresso e non appartiene alla logica di un singolo progetto. La separazione consente di riutilizzarlo per altri container collegati alla rete condivisa e di tenere nel gruppo `shared` tutti i componenti infrastrutturali.

## Conseguenze

In locale restano disponibili le porte dirette per debug. In UAT e produzione il proxy dovrà diventare l'unico punto pubblico, terminare HTTPS e instradare i DNS reali. SQL Server e SFTP non vengono esposti tramite il proxy HTTP.
