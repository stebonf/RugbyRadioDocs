# 15 - Deploy selettivo API blue green

## Decisione

RRL mantiene due container API permanenti:

```text
rrl-api-s1
rrl-api-s2
```

Ad ogni rilascio è possibile scegliere quale slot aggiornare. Lo slot non selezionato resta attivo con la versione precedente e costituisce lo slot di continuità/rollback.

## Regole operative

- non aggiornare automaticamente entrambi gli slot;
- selezionare esplicitamente `s1` o `s2` ad ogni deploy;
- verificare health check e log del nuovo slot prima dello switch del reverse proxy;
- cambiare il routing del proxy verso lo slot verificato;
- mantenere l'altro slot disponibile per rollback;
- usare tag immutabili per identificare le versioni rilasciate;
- non usare `latest` per il deploy di produzione.

## Impatto sul Compose

Il Compose attuale usa una sola variabile `RRL_IMAGE_TAG` per entrambi i servizi API. Per supportare davvero uno slot vecchio e uno nuovo occorre introdurre un tag indipendente per ciascuno slot, ad esempio:

```text
RRL_API_S1_IMAGE_TAG
RRL_API_S2_IMAGE_TAG
```

Il deploy dovrà aggiornare solo il servizio scelto e il reverse proxy dovrà continuare a puntare allo slot attivo fino alla verifica del nuovo rilascio.

## Stato

Decisione attiva dal 17/09/2026. L'adeguamento del workflow CI, del Compose runtime e dello script di deploy è necessario prima del primo deploy di produzione.
