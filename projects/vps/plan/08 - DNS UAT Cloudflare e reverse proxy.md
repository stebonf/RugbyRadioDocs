# 08 - DNS UAT Cloudflare e reverse proxy

## Scopo

Esporre i servizi pubblici UAT tramite domini RRL, Cloudflare e reverse proxy sulla VPS.

Questa fase rende raggiungibili API, Storage, Blog e SEO tramite HTTPS pubblico, senza esporre servizi interni.

## Obiettivo

Configurare un ingresso pubblico:

```text
Cloudflare
    -> VPS :443
    -> reverse proxy
    -> servizi RRL pubblici
```

## Vincoli

- Confermare i nomi DNS prima di modificarli.
- Non inventare hostname PROD.
- Non configurare Cloudflare Tunnel senza necessita' esplicita.
- Non esporre SQL Server.
- Non esporre porte interne dei container.
- Non modificare il frontend Firebase.
- Scegliere reverse proxy discutendo alternative se la scelta impatta gestione futura.

## Decisioni da confermare

Prima di modificare DNS, confermare hostname UAT, ad esempio:

- `api-uat.rugbyradiolive.com`;
- `storage-uat.rugbyradiolive.com`;
- `blog-uat.rugbyradiolive.com`;
- `seo-uat.rugbyradiolive.com`.

Nota: `seo-uat` deve essere confermato contro il ruolo reale di `src/RugbyRadioSitemap`, che oggi rappresenta il sito utility con i sitemap scritti da un job Hangfire.

Confermare anche il reverse proxy tra:

- Caddy;
- Nginx;
- Traefik.

Preferire semplicita', ma non trasformare questa preferenza in decisione senza approvazione.

## Come procedere

1. Presentare alternative reverse proxy con impatti pratici:
   - configurazione HTTPS;
   - reload;
   - integrazione Docker;
   - manutenzione;
   - complessita'.
2. Ottenere conferma su reverse proxy e hostname.
3. Configurare record DNS Cloudflare verso IP VPS.
4. Configurare proxy Cloudflare secondo necessita' UAT.
5. Configurare reverse proxy come unico ingresso HTTP/HTTPS.
6. Mappare hostname verso servizi:
   - API;
   - Storage;
   - Blog;
   - SEO.
7. Verificare certificati HTTPS.
8. Verificare che solo 80/443 siano pubblici per web traffic.

## Verifiche

- DNS risolve verso VPS.
- HTTPS funziona.
- Ogni hostname raggiunge il servizio corretto.
- SQL Server non e' raggiungibile dall'esterno.
- I container applicativi non espongono porte pubbliche inutili.
- Cloudflare non maschera errori applicativi rilevanti durante il test.

## Deliverable

- Configurazione reverse proxy.
- Elenco record DNS UAT.
- Report porte pubbliche.
- Report test HTTPS.
- Documentazione rollback DNS.

## Criteri di uscita

La fase e' completa quando:

- gli hostname UAT approvati funzionano;
- HTTPS e' attivo;
- reverse proxy instrada correttamente;
- solo 22, 80 e 443 sono esposte salvo eccezioni approvate;
- i servizi interni restano privati.

## Stop point

Passare alla Fase 9 dopo conferma che UAT e' raggiungibile e utilizzabile dai flussi previsti.
