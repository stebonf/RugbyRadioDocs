# 11 - Avvio CI e GitHub Container Registry

## Stato

Step 6 completato il 2026-09-17.

La verifica iniziale ha confermato che il workspace documentale contiene la specifica dello step e che il
workspace applicativo contiene già i Dockerfile e i Compose locali. Il checkout ora è disponibile con remote
verificato `https://github.com/stebonf/RugbyRadio.git` e branch corrente `feat/vps`.

## Componenti verificati

Immagini applicative già presenti:

- `rrl-api`, da `src/RugbyRadio/Api/Dockerfile`;
- `rrl-hangfire`, da `src/RugbyRadio/HF/Dockerfile`.

Componenti statici/shared già basati su immagini ufficiali:

- `rrl-storage`, `nginx:1.27-alpine`;
- `rrl-blog`, `nginx:1.27-alpine`;
- `rrl-seo`, `nginx:1.27-alpine`.

Il frontend `RugbyRadioWeb` resta escluso, coerentemente con la decisione di mantenerlo su Firebase Hosting.

## Verifica del checkout

Il repository applicativo rilevante è `C:\Repositories\RRL\src\RugbyRadio`; contiene API, Hangfire e Lib. La directory
`C:\Repositories\RRL` è invece un contenitore di più progetti/repository. Il remote verificato identifica owner
`stebonf` e repository `RugbyRadio`; il branch di lavoro è `feat/vps`.

Non serve creare un repository Git aggiuntivo per lo step 6: il workflow applicativo va nel repository
`RugbyRadio`. Un eventuale repository separato di infrastruttura potrà contenere in futuro il Compose runtime della
VPS, ma non è prerequisito per la build e la pubblicazione delle immagini.

## Implementazione locale

Sono stati aggiunti:

- `.github/workflows/ci-ghcr.yml`, con restore, build, test e publish di `rrl-api` e `rrl-hangfire`;
- `compose.ghcr.yml`, override runtime senza `build` e con immagini GHCR parametrizzate;
- `.env.registry.example`, senza credenziali.

Il workflow pubblica il tag `feat-vps` sul branch corrente e `uat` sul branch `uat`, oltre al tag immutabile
`sha-<commit>`. Per i pull request esegue solo verifica applicativa, senza pubblicare immagini.

## Verifica finale

- GitHub Actions completato sul repository `stebonf/RugbyRadio`.
- Build e test applicativi completati.
- Immagini private `rrl-api` e `rrl-hangfire` pubblicate su GHCR.
- Pull locale verificato con Docker Desktop.
- Avvio locale verificato tramite `compose.ghcr.yml`, senza build applicativo locale.
- Nessun token o secret registrato nel repository o nella documentazione.

## Prossimo lavoro tecnico

Nel repository `RugbyRadio` sono stati aggiunti il workflow GitHub Actions, l'override Compose runtime con
`image:` parametrizzate e `.env.registry.example`. Il login VPS previsto è:

```bash
echo "$GHCR_TOKEN" | docker login ghcr.io -u "$GHCR_USER" --password-stdin
docker compose --env-file .env.api --env-file .env.hangfire --env-file .env.registry \
  -f compose.api.yml -f compose.hangfire.yml -f compose.ghcr.yml pull
```

Il token non va salvato nel repository né nel file `.env.registry`.

La pubblicazione, il pull e l'avvio runtime sono stati verificati nel laboratorio Docker locale.

## Stop point

Lo step è chiuso. La VPS reale resta una verifica successiva della Fase 7; il flusso di immagini non cambia.
