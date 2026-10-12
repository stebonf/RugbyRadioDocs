# 10 - Blog statico scritto da Hangfire

## Decisione

Il blog viene esposto dal container indipendente `rrl-blog`, basato su Nginx e collegato al volume Docker `rrl-blog-content`.

Hangfire monta lo stesso volume in `/data/blog` e resta l'unico componente applicativo incaricato di generare o aggiornare le pagine statiche. `rrl-blog` ha il solo ruolo di servirle via HTTP.

## Configurazione

- hostname locale: `http://localhost:5400`;
- pagina di default: `/index.html`;
- sorgente iniziale: `C:\Repositories\RRL\src\RugbyRadioBlog`;
- copia iniziale ricorsiva eseguita da `Initialize-LocalRrl.ps1`;
- sostituzione runtime del dominio storage nei file testuali copiati, usando `$StoragePublicUrl`;
- volume condiviso tra Nginx e Hangfire: `rrl-blog-content`.
- dominio immagini generato da Hangfire: `RRL_HF_STORAGE_PUBLIC_URL`;
- percorso filesystem dei writer: `RRL_STORAGE_ROOT_PATH`.

## Motivazione

La separazione consente di aggiornare i contenuti senza ricostruire il container web e mantiene Hangfire come responsabile della generazione, mentre Nginx svolge una funzione semplice e stateless di pubblicazione.

Il dominio pubblico dello storage non è più hardcoded nel job: può cambiare tra locale, UAT e produzione senza modificare il codice.

Durante il seed iniziale lo script applica la stessa sostituzione anche ai file già presenti nella sorgente del blog, ma solo nella copia temporanea destinata al volume Docker. La sorgente versionata resta invariata.
