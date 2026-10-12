# Guida — Aggiungere un nuovo progetto API alla VPS

Procedura per aggiungere servizi API mantenendo separate le risorse applicative e riusando l'infrastruttura condivisa.

## 1. Regole di naming

- risorse condivise: prefisso `shared-`;
- progetto RRL: prefisso `rrl-`;
- nuovo progetto: prefisso proprio, ad esempio `foo-`;
- container, servizi, immagini GHCR e volumi devono mantenere il prefisso del progetto;
- non usare nomi già presenti e non creare una seconda rete o un secondo SQL Server condiviso.

Esempi per un progetto `foo`:

```text
foo-api-s1
foo-api-s2
foo-worker
foo-storage-data
```

## 2. Risorse condivise disponibili

La VPS dispone già di:

| Risorsa | Nome/uso |
|---|---|
| Rete Docker | `shared-net` |
| Reverse proxy | `shared-reverse-proxy`, porte pubbliche 80/443 |
| SQL Server | `shared-sqlserver-express`, raggiungibile dai container tramite alias `sql-server-express:1433` |
| Storage RRL | `rrl-storage-data`, da usare solo se il progetto deve condividere esplicitamente i media RRL |
| Portainer | `shared-portainer` |
| Metabase | `shared-metabase` su `https://bi.rugbyradiolive.com`, per dashboard BI condivise |

Il nuovo progetto deve collegarsi alla rete esterna `shared-net`:

```yaml
networks:
  shared-net:
    external: true
    name: shared-net
```

Non dichiarare una rete con lo stesso nome senza `external: true`.

## 3. Struttura del progetto

Usare una directory dedicata:

```bash
sudo mkdir -p /srv/containers/foo
sudo chown stefano:stefano /srv/containers/foo
cd /srv/containers/foo
```

Conservare nel repository:

- `compose.api.yml`;
- eventuale `compose.worker.yml`;
- `compose.ghcr.yml` per il deploy da registry;
- `.env.example` senza valori reali;
- configurazione del reverse proxy;
- script e documentazione del progetto.

I file `.env` reali restano solo sulla VPS e non vanno committati.

## 4. Compose minimo

Esempio di due slot API che usano la rete condivisa:

```yaml
name: foo

services:
  foo-api-s1:
    image: ghcr.io/OWNER/foo-api:${FOO_API_S1_TAG:?Set FOO_API_S1_TAG}
    container_name: foo-api-s1
    environment:
      ASPNETCORE_URLS: http://+:8080
      ConnectionStrings__App: ${FOO_API_CONNECTION_STRING:?Set FOO_API_CONNECTION_STRING}
    networks:
      - shared-net
    restart: unless-stopped

  foo-api-s2:
    image: ghcr.io/OWNER/foo-api:${FOO_API_S2_TAG:?Set FOO_API_S2_TAG}
    container_name: foo-api-s2
    environment:
      ASPNETCORE_URLS: http://+:8080
      ConnectionStrings__App: ${FOO_API_CONNECTION_STRING:?Set FOO_API_CONNECTION_STRING}
    networks:
      - shared-net
    restart: unless-stopped

networks:
  shared-net:
    external: true
    name: shared-net
```

Non pubblicare direttamente le porte API su Internet se il servizio è raggiungibile dal reverse proxy. Se servono porte locali per debug, usare `127.0.0.1`, mai `0.0.0.0` senza una motivazione.

## 5. Reverse proxy

Aggiungere un vhost dedicato nella configurazione condivisa, con hostname DNS proprio, ad esempio:

```nginx
server {
    listen 443 ssl;
    server_name api-foo-vps.rugbyradiolive.com;

    ssl_certificate /etc/nginx/certs/origin.pem;
    ssl_certificate_key /etc/nginx/certs/origin.key;

    location / {
        proxy_pass http://foo-api-s1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
    }
}
```

Il cambio slot deve essere esplicito e deve puntare a `foo-api-s1` oppure `foo-api-s2`. Dopo la modifica:

```bash
docker exec shared-reverse-proxy nginx -t
docker compose --env-file .env.reverse-proxy -f compose.reverse-proxy.yml up -d --force-recreate
```

## 6. DNS e secret

Creare in Cloudflare un record dedicato, normalmente proxied:

```text
api-foo-vps.rugbyradiolive.com -> 77.237.246.2
```

Generare secret separati per ogni progetto. Non riutilizzare password SQL, JWT, SFTP o token GHCR di RRL.

## 7. Deploy da GHCR

Sul server autenticarsi al registry solo se l'immagine è privata:

```bash
echo "$GHCR_TOKEN" | docker login ghcr.io -u GITHUB_USER --password-stdin
```

Scaricare e avviare solo lo slot scelto:

```bash
docker compose --env-file .env.foo -f compose.api.yml pull foo-api-s1
docker compose --env-file .env.foo -f compose.api.yml up -d foo-api-s1
```

Verificare il nuovo slot prima di modificare il reverse proxy:

```bash
docker ps --filter name=foo-api
docker logs --tail 100 foo-api-s1
curl -i http://127.0.0.1:5103/health
```

## 8. SQL Server e storage

Usare SQL Server condiviso tramite:

```text
Server=sql-server-express,1433
```

Creare un database e credenziali applicative dedicate. Non usare automaticamente `sa` nei nuovi progetti.

Non montare `rrl-storage-data` in un nuovo progetto se non è richiesto. Preferire un volume con prefisso proprio, ad esempio `foo-storage-data`, e aggiungere la relativa strategia di backup prima di andare in produzione.

## 9. Verifiche obbligatorie

- [ ] prefisso del progetto scelto e non già utilizzato;
- [ ] nessuna rete o risorsa shared duplicata;
- [ ] container collegati a `shared-net`;
- [ ] secret presenti solo nel `.env` della VPS;
- [ ] immagine GHCR disponibile e deployabile;
- [ ] health check funzionante;
- [ ] reverse proxy validato con `nginx -t`;
- [ ] DNS e TLS verificati;
- [ ] slot S1/S2 e rollback testati;
- [ ] backup del database e dei volumi definito;
- [ ] guide utente e VPS aggiornate.

## 10. Regola finale

Un nuovo progetto può riusare rete, reverse proxy, SQL Server e monitoraggio condivisi, ma deve mantenere isolati codice, immagini, secret, container, volumi, database logici e procedure di backup.
