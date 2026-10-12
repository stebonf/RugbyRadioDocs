# 10 - Reverse proxy condiviso locale

## Obiettivo

Introdurre un punto di ingresso unico per provare in locale il routing verso API, Storage, Blog, SEO e Hangfire.

## Implementazione

- Compose: `src/RugbyRadio/compose.reverse-proxy.yml`.
- Progetto Compose: `shared`.
- Container: `reverse-proxy`.
- Immagine: `nginx:1.27-alpine`.
- Porta locale: `127.0.0.1:8080`.
- Configurazione: `reverse-proxy/nginx.conf.template`.
- Rete: `shared-net`.

Il componente è condiviso perché non contiene logica RRL specifica e può instradare anche altri servizi collegati alla rete Docker condivisa.

## Routing locale

| Host | Destinazione |
| --- | --- |
| `api.localhost` | API S1 o S2 selezionata dall'env |
| `storage.localhost` | `rrl-storage:80` |
| `blog.localhost` | `rrl-blog:80` |
| `seo.localhost` | `rrl-seo:80` |
| `hf.localhost` | `rrl-hangfire:8080` |

Il valore `SHARED_REVERSE_PROXY_API_UPSTREAM` seleziona l'istanza API attiva. Il default locale è `rrl-api-s1`.

## Verifica

```powershell
$headers = @{ Host = 'storage.localhost' }
Invoke-WebRequest http://127.0.0.1:8080/images.jpg -Headers $headers -UseBasicParsing
Invoke-WebRequest http://127.0.0.1:8080 -Headers @{ Host = 'blog.localhost' } -UseBasicParsing
Invoke-WebRequest http://127.0.0.1:8080/sitemap.xml -Headers @{ Host = 'seo.localhost' } -UseBasicParsing
Invoke-WebRequest http://127.0.0.1:8080/hangfire -Headers @{ Host = 'hf.localhost' } -UseBasicParsing
Invoke-WebRequest http://127.0.0.1:8080 -Headers @{ Host = 'api.localhost' } -UseBasicParsing
```

L'uso di `127.0.0.1` con l'header `Host` rende la verifica affidabile anche da PowerShell, che in alcune configurazioni Windows non risolve automaticamente i nomi `*.localhost`. I browser moderni possono invece usare direttamente gli URL con dominio locale.

Per provare lo switch API:

1. modificare `SHARED_REVERSE_PROXY_API_UPSTREAM=rrl-api-s2` in `.env.reverse-proxy`;
2. ricreare solo il servizio con `docker compose --env-file .env.reverse-proxy -f compose.reverse-proxy.yml up -d --force-recreate`;
3. ripetere la richiesta a `http://api.localhost:8080`.

## Limiti locali

La configurazione usa HTTP e domini `.localhost`. HTTPS, DNS pubblici, certificati e chiusura delle porte dirette sono attività successive per UAT/produzione.
