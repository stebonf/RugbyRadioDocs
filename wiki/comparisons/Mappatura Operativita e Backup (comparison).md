---
title: "Mappatura Operativita e Backup (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Operativita e Backup (comparison)

## Sintesi

Confronto tra superfici operative, manutenzione, backup database, backup USB, audit logging e configurazioni amministrative.

## Scope

Include solo operativita backend e workflow amministrativi gia documentati nella wiki. Non include procedure operative esterne o runbook non formalizzati.

## Mappatura

| Area | Pagine collegate | Side effects o responsabilita |
|---|---|---|
| Manutenzione frontend | [[AdminMaintenancePage (web)]] | Mostra pagina statica quando `environment.maintenance = true`. |
| Dashboard job | [[HangfireDashboard (api)]] | Superficie per osservare o gestire job Hangfire; policy auth non deducibile. |
| Manutenzione DB | [[MaintenanceJob (api)]] | Esegue stored procedure manutenzione/backup e cancella `.bak` vecchi. |
| Backup USB | [[UsbBackupJob (api)]], [[Backup USB (workflow)]] | Copia incrementale da sorgenti configurate verso destinazione USB. |
| Admin API | [[AdminV1Controller (api)]] | Gestisce messaggi draft e statistiche con `authKey` custom. |
| Audit | [[AuditMiddleware (api)]], [[Audit (api)]] | Registra richieste HTTP senza bloccare le risposte. |

## Pattern

- [[Operativita Backend (concept)]] raccoglie superfici e job operativi, separandoli dalla pipeline contenuti.
- [[Operazioni Amministrative (workflow)]] copre supervisione job, manutenzione, messaggi draft, backup e audit.
- Backup database e backup USB sono separati: il primo produce e ripulisce `.bak`, il secondo copia cartelle verso USB.
- La maintenance mode frontend non risulta guidata da una API runtime documentata.
- Alcune superfici operative hanno limiti espliciti: `authKey` admin, filtri Hangfire non deducibili, secret JWT in configurazione.

## Gap noti

- Frequenze cron dei job operativi non deducibili.
- Cartelle definitive da includere in backup USB non confermate.
- Notifiche operative su fallimento backup o job non deducibili.
- Runbook di restore non documentato.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`: [[Operativita Backend (concept)]], [[Operazioni Amministrative (workflow)]], [[Backup USB (workflow)]], [[MaintenanceJob (api)]] e [[UsbBackupJob (api)]]. Nessun RAW letto.
