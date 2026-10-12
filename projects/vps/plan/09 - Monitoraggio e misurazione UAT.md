# 09 - Monitoraggio e misurazione UAT

## Scopo

Misurare risorse, stabilita' e comportamento runtime dello stack UAT sulla VPS usando strumenti semplici.

Questa fase serve a decidere il dimensionamento reale e scoprire problemi operativi prima della pianificazione PROD.

## Obiettivo

Raccogliere dati su:

- RAM;
- CPU;
- disco;
- disk I/O;
- network;
- restart container;
- errori applicativi;
- SQL Server Express;
- Hangfire Always On;
- Storage;
- Blog generation.

## Vincoli

- Non installare automaticamente Prometheus, Grafana, ELK o stack pesanti.
- Non sovradimensionare preventivamente.
- Non acquistare servizi di monitoraggio.
- Non introdurre Redis o Metabase.
- Non trattare Docker volumes come backup.

## Come procedere

1. Definire una finestra di osservazione UAT.
2. Eseguire misurazioni periodiche con strumenti base:
   - `docker stats`;
   - `free -h`;
   - `htop`;
   - `df -h`;
   - `docker compose ps`;
   - `docker compose logs`;
   - log applicativi.
3. Verificare riavvio servizi:
   - restart container;
   - restart Docker;
   - reboot VPS.
4. Controllare Hangfire:
   - job ricorrenti;
   - continuita' esecuzione;
   - recupero dopo restart;
   - errori.
5. Controllare SQL Server Express:
   - uso memoria;
   - dimensione database;
   - connessioni;
   - errori log.
6. Controllare Storage e Blog:
   - persistenza file;
   - contenuti generati;
   - permessi filesystem;
   - accesso pubblico via reverse proxy.
7. Documentare picchi e anomalie.

## Metriche minime

- RAM media e picco per container.
- CPU media e picco per container.
- Spazio disco usato da volumi.
- Numero restart container.
- Errori applicativi critici.
- Tempo startup stack.
- Tempo recovery dopo reboot.
- Esito job Hangfire principali.

## Deliverable

- Report misurazioni UAT.
- Raccomandazione dimensionamento VPS.
- Elenco colli di bottiglia.
- Elenco problemi applicativi o infrastrutturali.
- Proposta strumenti futuri solo se giustificati dai dati.

## Criteri di uscita

La fase e' completa quando:

- esistono misurazioni reali;
- la VPS candidata e' confermata o scartata con motivazione;
- Hangfire e persistenza sono stati osservati dopo restart;
- gli errori critici sono stati identificati o esclusi;
- il dimensionamento non dipende piu' da ipotesi.

## Stop point

Procedere alla Fase 10 solo quando UAT e' stabile abbastanza da testare disaster recovery.
