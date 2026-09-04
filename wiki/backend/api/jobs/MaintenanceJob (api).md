---
title: "MaintenanceJob (api)"
type: backend-job
layer: backend
---

# MaintenanceJob (api)

## Sintesi

Esegue stored procedure di manutenzione e backup database. Elimina file `.bak` più vecchi di 5 giorni dalla cartella `D:\Sql\Backup\`.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile

## Responsabilità

- `EXEC sp_Maintenance` — stored procedure manutenzione DB
- `EXEC sp_Backup` — stored procedure backup DB
- Eliminazione file `.bak` > 5 giorni da `D:\Sql\Backup\`

## Services usati

- `IUnitOfWork` — per esecuzione SQL raw

## Entities coinvolte

Nessuna entity EF diretta

## Side effects

- Esecuzione stored procedure DB
- Cancellazione file `.bak` da filesystem

## Failure points

- `[AutomaticRetry(Attempts = 0)]` — nessun retry
- Se cartella backup non esiste → early return

## Note

Percorso backup hardcoded: `D:\Sql\Backup\`. Retention: 5 giorni hardcoded.

## Nome nel codice

`MaintenanceJob` — `src/RugbyRadio/HF/Jobs/MaintenanceJob.cs`
