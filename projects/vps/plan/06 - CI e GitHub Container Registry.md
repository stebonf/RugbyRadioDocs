# 06 - CI e GitHub Container Registry

## Scopo

Configurare build, test, Docker build e push verso GitHub Container Registry per immagini applicative private.

Questa fase sposta la VPS verso il ruolo corretto: runtime che scarica immagini gia' costruite.

## Obiettivo

Creare un flusso:

```text
GitHub private repository
    -> GitHub Actions
    -> build/test/docker build
    -> GHCR private
    -> VPS docker compose pull
```

## Vincoli

- I repository RRL sono privati.
- Non rendere pubblici repository o package.
- Non usare servizi CI/CD a pagamento.
- Non configurare runner self-hosted senza necessita'.
- Non hardcodare owner GHCR senza verificarlo.
- Non committare token o secrets.
- Non implementare deployment continuo su PROD.

## Come procedere

1. Verificare owner, nome repository e permessi disponibili.
2. Verificare quali sorgenti producono immagini runtime e quali sono solo dipendenze/test:
   - `src/RugbyRadio/Api` produce `rrl-api`;
   - `src/RugbyRadio/HF` produce `rrl-hangfire`;
   - `src/RugbyRadio/Lib` viene buildata come dipendenza comune;
   - `src/RugbyRadio/Tests` viene eseguita come test suite;
   - `src/RugbyRadioBlog` produce o alimenta `rrl-blog`, secondo implementazione reale;
   - `src/RugbyRadioSitemap` produce o alimenta `rrl-seo`/sitemap, secondo implementazione reale;
   - `src/RugbyRadio/Web` resta escluso dalle immagini VPS.
3. Definire naming immagini GHCR, ad esempio:
   - `ghcr.io/<owner>/rrl-api:<tag>`;
   - `ghcr.io/<owner>/rrl-hangfire:<tag>`;
   - `ghcr.io/<owner>/rrl-storage:<tag>`;
   - `ghcr.io/<owner>/rrl-blog:<tag>`;
   - `ghcr.io/<owner>/rrl-seo:<tag>`.
4. Confermare tag strategy minima:
   - `uat`;
   - eventuale versione;
   - `prod` solo in fase futura.
5. Creare workflow GitHub Actions per:
   - restore;
   - build;
   - test;
   - docker build;
   - docker push.
6. Usare credenziali GitHub Actions con privilegi minimi.
7. Aggiornare compose per puntare alle immagini GHCR invece che buildare sulla VPS.
8. Documentare login GHCR dalla VPS con token a permessi minimi.

## Verifiche

- Workflow avviato su branch UAT o branch dedicato.
- Build applicativa completata.
- Test eseguiti.
- Docker image pubblicata su GHCR privato.
- Pull dell'immagine riuscito da ambiente autorizzato.
- Nessun secret presente in repository.

## Deliverable

- Workflow GitHub Actions.
- Compose aggiornato con immagini GHCR.
- `.env.example` aggiornato senza secrets.
- Documentazione login GHCR.
- Report permessi/token richiesti.

## Criteri di uscita

La fase e' completa quando:

- almeno una immagine applicativa viene buildata e pubblicata su GHCR privato;
- il pull da ambiente runtime funziona;
- le credenziali sono documentate ma non committate;
- il flusso e' replicabile per gli altri container.

## Stop point

Fermarsi e chiedere conferma prima di passare alla Fase 7.
