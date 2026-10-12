# 07 - VPS Contabo UAT

## Scopo

Preparare una VPS Contabo mensile e disposable per eseguire RRL UAT su Ubuntu Server 24.04 LTS con Docker.

Questa fase porta lo stack dal locale a un laboratorio reale, senza toccare PROD.

## Obiettivo

Deployare lo stack UAT sulla VPS con:

```bash
docker compose pull
docker compose up -d
```

## Vincoli

- Acquistare solo contratto mensile.
- Considerare la VPS disposable/rebuildable.
- Usare Ubuntu Server 24.04 LTS x86-64/AMD64.
- Non usare Ubuntu Desktop.
- Amministrare via SSH.
- Non modificare PROD.
- Non esporre SQL Server pubblicamente.
- Esporre idealmente solo 22, 80 e 443.
- Non buildare normalmente immagini applicative sulla VPS.

## Come procedere

1. Acquistare VPS mensile solo dopo conferma.
2. Installare Ubuntu Server 24.04 LTS.
3. Creare accesso SSH amministrativo.
4. Applicare hardening base:
   - aggiornamenti sistema;
   - firewall;
   - utenti e chiavi SSH;
   - disabilitazioni o restrizioni minime concordate.
5. Installare Docker Engine e plugin Compose.
6. Creare directory runtime per infrastruttura.
7. Clonare o copiare repository infrastruttura.
8. Preparare `.env` reale fuori da Git.
9. Eseguire login GHCR con token minimo.
10. Eseguire:
    - `docker compose pull`;
    - `docker compose up -d`;
    - restore/import dati UAT su SQL Server Express.
11. Verificare container, log, porte e volumi.

## Verifiche

Eseguire almeno:

```bash
docker ps
docker compose ps
docker compose logs
docker stats
free -h
htop
df -h
ss -tulpn
```

Verificare che SQL Server non sia pubblicato su Internet.

## Deliverable

- VPS UAT funzionante.
- Documentazione setup ripetibile.
- Compose runtime.
- `.env.example` in Git e `.env` reale non committato.
- Report porte esposte.
- Report consumo iniziale risorse.

## Criteri di uscita

La fase e' completa quando:

- Docker e Compose funzionano sulla VPS;
- lo stack UAT parte;
- le immagini arrivano da GHCR;
- SQL Server Express usa persistenza e non e' pubblico;
- i servizi interni comunicano;
- le risorse sono misurate.

## Stop point

Proseguire alla Fase 8 solo dopo verifica VPS e conferma dei nomi DNS UAT.
