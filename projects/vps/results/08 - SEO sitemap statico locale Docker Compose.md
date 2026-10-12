# 08 - SEO sitemap statico locale Docker Compose

## Obiettivo

Predisporre un container indipendente per erogare i file SEO e sitemap generati da Hangfire.

## Implementazione

- Compose: `src/RugbyRadio/compose.seo.yml`.
- Container: `rrl-seo`.
- Immagine: `nginx:1.27-alpine`.
- Porta locale: `127.0.0.1:5500`.
- Sorgente iniziale: `src/RugbyRadioSitemap`.
- Volume: `rrl-seo-content`.
- Directory Nginx: `/usr/share/nginx/html`.
- Directory Hangfire: `/data/seo`.
- Rete: `shared-net`.

Il volume è condiviso tra `rrl-seo` e `rrl-hangfire`: Nginx serve i file, mentre Hangfire può crearli e aggiornarli. Non vengono riscritte le URL canoniche contenute nei sitemap.

## Configurazione

Il template `src/RugbyRadio/.env.seo.example` contiene la porta locale:

```dotenv
RRL_SEO_HOST_PORT=5500
```

Lo script `Initialize-LocalRrl.ps1` genera `.env.seo`, ricrea il volume e copia ricorsivamente i file iniziali dalla cartella `RugbyRadioSitemap`.

## Verifica

```powershell
Invoke-WebRequest http://localhost:5500/sitemap.xml -UseBasicParsing
docker inspect rrl-seo
docker inspect rrl-hangfire
```

Risultato atteso: `sitemap.xml` risponde con HTTP 200; entrambi i container mostrano il volume `rrl-seo-content`, montato rispettivamente in `/usr/share/nginx/html` e `/data/seo`.

## Criteri di completamento

- il container parte sulla rete `shared-net`;
- il file `sitemap.xml` è raggiungibile;
- il contenuto iniziale viene copiato dallo script;
- Hangfire e Nginx condividono il volume SEO;
- il volume viene ricreato durante il bootstrap locale distruttivo.
