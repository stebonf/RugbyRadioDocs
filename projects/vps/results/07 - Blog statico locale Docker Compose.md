# 07 - Blog statico locale Docker Compose

## Obiettivo

Pubblicare `src\RugbyRadioBlog` come sito statico Docker, con `index.html` come pagina di default e aggiornamenti generati da Hangfire.

## Implementazione

- `compose.blog.yml` crea il container `rrl-blog` basato su Nginx Alpine.
- Il container pubblica il volume `rrl-blog-content` su `http://localhost:5400`.
- Hangfire usa lo stesso volume montato in `/data/blog`.
- Hangfire usa `RRL_HF_STORAGE_PUBLIC_URL` per costruire gli URL assoluti delle immagini inserite nell'HTML.
- Lo script copia ricorsivamente la sorgente `src\RugbyRadioBlog` nel volume prima dell'avvio di Hangfire.
- Durante la copia, lo script sostituisce nei file testuali `https://storage-sh.rugbyradiolive.com` con `$StoragePublicUrl` tramite una staging directory temporanea, senza modificare la sorgente.
- Nginx serve automaticamente `/usr/share/nginx/html/index.html` quando viene richiesto `/`.

In locale il valore viene assegnato dallo script tramite `$StoragePublicUrl` ed è `http://localhost:5300`; in UAT/produzione viene sostituito con il dominio pubblico del CDN.

Verifica eseguita dopo il bootstrap completo:

```text
GET http://localhost:5400/ -> HTTP 200
index.html servito -> contiene http://localhost:5300
index.html servito -> non contiene https://storage-sh.rugbyradiolive.com
sorgente nel repository -> invariata
```

## Flusso di aggiornamento

1. `rrl-blog` espone i file presenti nel volume.
2. Hangfire scrive nuove pagine HTML e sitemap in `/data/blog`.
3. Le modifiche diventano immediatamente disponibili tramite Nginx senza rebuild dell'immagine.

## Nota operativa

Il bootstrap locale è distruttivo come il resto dello script: `rrl-blog-content` viene ricreato e ripopolato dalla sorgente. In UAT e produzione il volume dovrà essere persistente e il deploy non dovrà cancellarlo.
