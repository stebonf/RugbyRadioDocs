# 10 - Disaster recovery e ricostruzione VPS

## Scopo

Dimostrare che RRL UAT non dipende da una singola VPS e puo' essere ricostruito da zero su una macchina vuota.

Questa fase valida il principio finale del README: rendere RRL indipendente dalla macchina che lo ospita.

## Obiettivo

Ricostruire l'ambiente con il flusso:

```text
nuova VPS vuota
    -> Ubuntu Server
    -> Docker
    -> infrastructure repository
    -> .env / secrets
    -> docker compose pull
    -> docker compose up -d
    -> restore/import database SQL Server Express
    -> RRL UAT operativo
```

Target indicativo:

- massimo mezza giornata;
- idealmente molto meno.

## Vincoli

- Non usare configurazioni manuali non documentate.
- Non dipendere dalla VPS temporanea originale.
- Non usare dati non sottoposti a backup o export.
- Non eseguire comandi distruttivi su dati reali senza conferma.
- Non scegliere destinazione backup definitiva senza proposta e approvazione.
- Non pianificare PROD finche' UAT non supera il test.

## Come procedere

1. Preparare o confermare un backup/export aggiornato di:
   - SQL Server Express;
   - RRL Storage;
   - Blog generated content.
2. Documentare origine, formato e data del backup.
3. Preparare una VPS vuota o ambiente equivalente approvato.
4. Installare Ubuntu Server 24.04 LTS.
5. Installare Docker e Compose.
6. Recuperare repository infrastruttura.
7. Preparare `.env` e secrets senza committarli.
8. Eseguire login GHCR.
9. Eseguire:
   - `docker compose pull`;
   - `docker compose up -d`;
   - restore/import dati SQL Server.
10. Verificare endpoint UAT.
11. Verificare Storage e Blog.
12. Verificare Hangfire Always On.
13. Misurare tempo totale e passaggi manuali residui.

## Verifiche

- Stack parte su macchina nuova.
- Dati SQL Server Express ripristinati o importati.
- Storage ripristinato.
- Blog generated content ripristinato o rigenerato correttamente.
- DNS/reverse proxy funzionano o sono documentati come passaggio ripetibile.
- Nessun passaggio critico dipende da memoria umana.
- Tempo totale entro target o con cause documentate.

## Deliverable

- Runbook disaster recovery.
- Report tempo di ricostruzione.
- Elenco passaggi manuali da automatizzare.
- Elenco rischi residui.
- Raccomandazione go/no-go per pianificare PROD.

## Criteri di uscita

La fase e' completa quando:

- una VPS vuota e' stata ricostruita fino a UAT operativo;
- backup/export e restore/import sono verificati;
- il runbook permette di ripetere il processo;
- i rischi residui sono noti;
- esiste una decisione documentata per procedere o non procedere verso PROD.

## Stop point

Fermarsi e chiedere conferma prima di qualsiasi pianificazione o modifica PROD.
