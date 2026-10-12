# Decisione 12 - SEO statico scritto da Hangfire

## Decisione

I file SEO e sitemap vengono erogati da un container separato chiamato `rrl-seo`, basato su Nginx. La loro generazione e il loro aggiornamento restano responsabilità di Hangfire.

## Motivazione

Il servizio SEO deve essere indipendente dalle API e deve poter servire file statici con un comportamento semplice e prevedibile. Hangfire deve poter aggiornare gli stessi file senza introdurre un endpoint di scrittura nel web server.

## Struttura

- Hangfire monta `rrl-seo-content` in `/data/seo` con permessi di scrittura.
- `rrl-seo` monta lo stesso volume in `/usr/share/nginx/html` e lo espone per la pubblicazione HTTP.
- Lo script locale copia inizialmente i file da `src/RugbyRadioSitemap` nel volume.
- Il servizio è pubblicato localmente su `http://localhost:5500`.
- In produzione il dominio sarà valorizzato tramite `$SeoPublicUrl` nello script e tramite la configurazione DNS/reverse proxy.

## Conseguenze

Il volume SEO è dati applicativi generati, non una sorgente da modificare manualmente nel container. Il bootstrap locale è distruttivo e quindi ricrea il volume e reimporta i file iniziali a ogni esecuzione.
