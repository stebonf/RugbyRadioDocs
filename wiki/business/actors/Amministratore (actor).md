---
title: "Amministratore (actor)"
type: business-actor
layer: business
---

# Amministratore (actor)

## Sintesi

Account amministrativo con accesso a superfici operative di manutenzione, gestione messaggi di sistema, supervisione job e configurazioni di sicurezza della piattaforma [[Rugby Radio Live (product)]].

## Obiettivi

- Gestire messaggi di sistema draft: approvare, modificare, eliminare draft in attesa di verifica
- Attivare la modalitÃ  manutenzione tramite flag `environment.maintenance`
- Supervisionare job Hangfire e dashboard operativa
- Eseguire manutenzione e backup database
- Gestire backup incrementale USB
- Monitorare audit logging delle richieste HTTP
- Configurare impostazioni di sicurezza JWT

## Pain points

- Autenticazione amministrativa non standard: [[AdminV1Controller (api)]] usa `authKey` come query parameter hardcoded, non JWT Bearer
- SecretKey JWT presente in chiaro in `appsettings.json` ([[SecuritySettings (api)]])
- [[HangfireDashboard (api)]] non documenta filtri autorizzativi deducibili
- [[MaintenanceJob (api)]] non ha retry automatici e usa percorso backup hardcoded
- [[UsbBackupJob (api)]] puÃ² fallire per configurazione destinazione, permessi o path non supportati
- [[AdminV1Controller (api)]] accede direttamente ai repository senza service layer intermedio

## Workflow usati

[[Operazioni Amministrative (workflow)]]

## Superfici operative

- [[AdminV1Controller (api)]] — endpoint amministrativi per messaggi draft e statistiche
- [[AdminMaintenancePage (web)]] — pagina statica di manutenzione
- [[HangfireDashboard (api)]] — dashboard job Hangfire
- [[MaintenanceJob (api)]] — manutenzione e backup database
- [[UsbBackupJob (api)]] — backup incrementale USB
- [[AuditMiddleware (api)]] — audit logging HTTP
- [[SecuritySettings (api)]] — configurazione sicurezza

## KPI rilevanti

- Job Hangfire completati con successo
- Backup database e USB completati
- Messaggi draft approvati
- Metriche di audit (richieste HTTP, errori)

## Note

Attore amministrativo dedotto da pagine wiki esistenti. La wiki non documenta un workflow operativo end-to-end nÃ© trigger espliciti tra le superfici amministrative. L'assenza di un attore amministrativo canonico Ã¨ segnalata in [[Operativita Backend (concept)]].
