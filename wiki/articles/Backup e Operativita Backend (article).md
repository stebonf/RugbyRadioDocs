---
title: "Backup e Operativita Backend (article)"
type: article
layer: concept
---

# Backup e Operativita Backend (article)

## Sintesi

L'operativita backend copre manutenzione, dashboard Hangfire, audit, backup database e backup USB incrementale.

## Scope

Questa pagina collega le superfici operative gia documentate in wiki.

## Componenti coinvolti

- [[Operativita Backend (concept)]]
- [[Backup USB (workflow)]]
- [[UsbBackupJob (api)]]
- [[MaintenanceJob (api)]]
- [[HangfireDashboard (api)]]
- [[AdminMaintenancePage (web)]]
- [[AuditMiddleware (api)]]
- [[Audit (api)]]

## Relazioni principali

- [[MaintenanceJob (api)]] gestisce manutenzione e backup database.
- [[UsbBackupJob (api)]] copia cartelle sorgenti verso destinazione USB.
- [[HangfireDashboard (api)]] e la superficie operativa dei job.
- [[AdminMaintenancePage (web)]] rappresenta la modalita manutenzione lato frontend.
- [[AuditMiddleware (api)]] registra richieste HTTP in [[Audit (api)]].

## Note

Articolo creato usando solo pagine wiki esistenti. Frequenze operative, retention completa, cifratura, checksum e notifiche non sono deducibili.

