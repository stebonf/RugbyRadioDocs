# 02 - Docker locale prima applicazione

## Scopo

Validare Docker Desktop su Windows con Linux containers usando una sola applicazione RRL semplice, scelta in base all'analisi della fase precedente.

Questa fase serve a confermare il ciclo minimo build/start/config/logging senza affrontare ancora tutto lo stack.

## Obiettivo

Containerizzare una sola applicazione e dimostrare che puo':

- essere compilata in immagine Linux-compatible;
- avviarsi in container;
- leggere configurazione da environment variables;
- esporre o consumare la rete Docker prevista;
- produrre log leggibili;
- non dipendere da path Windows, IIS o filesystem effimero.

## Vincoli

- Usare Docker Desktop su Windows con Linux containers.
- Non usare Windows containers.
- Non containerizzare il frontend Firebase.
- Non introdurre Redis, Metabase, Portainer o altri servizi.
- Non scegliere una granularita' diversa da quella approvata senza conferma.
- Non modificare PROD.

## Come procedere

1. Scegliere l'applicazione candidata dalla Fase 1.
2. Motivare la scelta:
   - minori dipendenze;
   - rischio basso;
   - utilita' per validare il pattern Docker.
3. Considerare come candidati iniziali solo componenti in uso:
   - `src/RugbyRadio/Api`;
   - `src/RugbyRadio/HF`;
   - `src/RugbyRadioBlog`;
   - `src/RugbyRadioSitemap`.
4. Escludere `src/RugbyRadio/Web` dalla containerizzazione VPS perche' il frontend resta su Firebase Hosting.
5. Escludere le altre cartelle sotto `src` indicate come esperimenti, salvo dipendenze reali rilevate.
6. Creare un Dockerfile minimale coerente con lo stack reale.
7. Usare immagini base Linux ufficiali e compatibili con la versione .NET del progetto.
8. Spostare configurazioni runtime su environment variables.
9. Evitare secrets hardcoded.
10. Aggiungere o aggiornare `.dockerignore` se necessario.
11. Creare un compose locale minimo solo per questa applicazione se utile.
12. Avviare il container e verificare:
   - startup;
   - health o endpoint base, se esistente;
   - log;
   - variabili ambiente;
   - porte esposte;
   - comportamento su restart.

## Verifiche

Eseguire almeno:

```bash
docker build
docker run
docker logs
docker ps
docker inspect
```

Se si usa compose:

```bash
docker compose up -d
docker compose logs
docker compose down
```

Non usare `docker compose down -v` su dati reali.

## Deliverable

- Dockerfile della singola applicazione.
- Eventuale compose locale minimo.
- Note di configurazione richieste.
- Esito dei test di build e startup.
- Problemi riscontrati e modifiche necessarie per procedere.

## Criteri di uscita

La fase e' completa quando:

- l'immagine viene costruita localmente;
- il container parte;
- la configurazione e' esterna all'immagine;
- i log sono ispezionabili;
- non sono emerse dipendenze bloccanti da Windows/IIS;
- sono documentati i limiti residui.

## Stop point

Fermarsi e chiedere conferma prima di passare alla Fase 3.
