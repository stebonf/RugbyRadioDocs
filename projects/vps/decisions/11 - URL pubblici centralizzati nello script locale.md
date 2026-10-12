# 11 - URL pubblici centralizzati nello script locale

## Decisione

Gli URL pubblici e i futuri DNS dell'ambiente locale sono definiti nella sezione `URL PUBBLICI / DNS` di `Initialize-LocalRrl.ps1`.

Lo script li trasferisce nei file `.env` generati a runtime. I template `.env.*.example` restano privi dei valori specifici dell'ambiente.

## Parametri

- `$ApiS1PublicUrl`
- `$ApiS2PublicUrl`
- `$HangfirePublicUrl`
- `$StoragePublicUrl`
- `$BlogPublicUrl`

## Motivazione

La stessa configurazione deve poter passare da localhost ai DNS UAT e produzione senza modificare i Compose o il codice applicativo. Le variabili obbligatorie nei Compose impediscono l'avvio con template incompleti.

## Distinzione

Gli URL pubblici indicano come un browser raggiunge un servizio. Restano distinti dai percorsi filesystem, come `RRL_STORAGE_ROOT_PATH=/data/storage`, usati dai container per leggere e scrivere i contenuti.
