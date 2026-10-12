# Decisione 06 - Due istanze API per rilascio senza downtime

## Decisione

Lo stack locale e UAT prevede due container API equivalenti:

- `rrl-api-s1`, esposto localmente sulla porta `5101`;
- `rrl-api-s2`, esposto localmente sulla porta `5102`.

Entrambi usano l'immagine `rrl-api:latest`, lo stesso codice applicativo, la stessa configurazione applicativa, la rete `shared-net` e il database condiviso.

## Motivazione

La separazione consente di preparare e verificare una nuova versione su un'istanza mentre l'altra continua a servire richieste. Lo switch del traffico verra' gestito dal frontend o, preferibilmente in UAT/VPS, dal reverse proxy.

## Conseguenze

- Il Compose API deve definire entrambi i servizi.
- Le porte host devono essere diverse; la porta interna del container resta `8080`.
- Lo script di avvio e rilascio deve eseguire build e avvio di entrambe le istanze insieme.
- Prima dello switch occorre verificare separatamente salute, log e compatibilita' database della nuova istanza.
- La configurazione del frontend/reverse proxy e' uno step successivo e non viene automatizzata da questa modifica.
