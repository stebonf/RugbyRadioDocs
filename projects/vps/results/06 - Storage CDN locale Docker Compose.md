# 06 - Storage/CDN locale Docker Compose

## Obiettivo

Aggiungere uno storage statico condiviso da API e Hangfire, esposto localmente come CDN e inizializzato dal contenuto di `C:\Repositories\RRL\backup\RugbyRadioStorage`.

## Implementazione

- `compose.storage.yml` crea `rrl-storage` con immagine Nginx Alpine.
- Il volume nominato `rrl-storage-data` contiene tutti i file dello storage.
- Nginx pubblica il volume su `http://localhost:5300`; il container non espone endpoint di scrittura e il volume resta scrivibile per API, Hangfire e la fase di seed.
- `compose.api.yml` monta il volume in `/data/storage` su entrambe le istanze API.
- `compose.hangfire.yml` monta lo stesso volume in `/data/storage`.
- `RRL_STORAGE_ROOT_PATH` sostituisce i percorsi Windows hardcoded nella libreria condivisa e nei servizi audio.
- `Initialize-LocalRrl.ps1` verifica la cartella di backup, ricrea il volume e copia il contenuto con `docker cp <cartella>\.`; la copia comprende file e sottodirectory.

## Verifica eseguita

```text
images.jpg -> HTTP 200
Content-Type -> image/jpeg
dimensione risposta -> 26787 byte
rrl-storage -> 127.0.0.1:5300->80
API S1/S2 e Hangfire -> rrl-storage-data:/data/storage rw=true
RRL_STORAGE_ROOT_PATH -> /data/storage
```

Il ciclo completo dello script è terminato senza errori: SQL Server e i due database sono stati ripristinati, il volume è stato ricreato e il seed è stato copiato.

La configurazione attuale è locale: il reverse proxy futuro potrà collegare un hostname pubblico, ad esempio `storage-sh.rugbyradiolive.com`, al servizio `rrl-storage` senza cambiare il volume o i writer.

## Nota operativa

Lo script locale è distruttivo per scelta: a ogni esecuzione rimuove anche `rrl-storage-data` e lo ripopola dal backup configurato. Non usare questo comportamento su dati UAT o produzione senza sostituire il lifecycle distruttivo con una procedura di deploy non distruttiva.
