---
title: "Operazioni Amministrative (workflow)"
type: workflow
layer: workflow
---

# Operazioni Amministrative (workflow)

## Obiettivo

Permettere all'amministratore di gestire la manutenzione della piattaforma, supervisionare job Hangfire, gestire messaggi di sistema draft, eseguire backup operativi e monitorare audit logging.

## Trigger

L'amministratore accede alla dashboard Hangfire, attiva la modalità manutenzione tramite flag di configurazione `environment.maintenance`, o richiede operazioni amministrative via API su [[AdminV1Controller (api)]].

## Attori

- [[Amministratore (actor)]]

## Frontend coinvolto

- [[AdminMaintenancePage (web)]] — pagina statica di manutenzione

## Backend coinvolto

- [[AdminV1Controller (api)]] — gestione messaggi di sistema draft e statistiche
- [[HangfireDashboard (api)]] — dashboard operativa job Hangfire
- [[MaintenanceJob (api)]] — stored procedure manutenzione e backup database
- [[HfFixJob (api)]] — bonifica conservativa dati operativi proposta
- [[UsbBackupJob (api)]] — backup incrementale USB
- [[AuditMiddleware (api)]] — audit logging HTTP su tutte le richieste

## Data coinvolti

- [[SystemMessage (api)]] — messaggi di sistema localizzati per telecronaca AI
- [[SystemMessageDraft (api)]] — messaggi in attesa di approvazione
- [[Audit (api)]] — log audit richieste HTTP
- [[SecuritySettings (api)]] — configurazione sicurezza JWT

## Analytics tracking

Non deducibile dalla wiki

## Failure points

- AdminMaintenancePage non ha API runtime; dipende da flag di environment, non da un endpoint attivabile via UI
- AdminV1Controller usa `authKey` come query parameter hardcoded (non JWT standard)
- MaintenanceJob ha `[AutomaticRetry(Attempts = 0)]` — nessun retry automatico su fallimento
- HfFixJob deve gestire skip per singola riga senza interrompere l'intero job
- UsbBackupJob può fallire per configurazione destinazione, permessi, file bloccati o path non supportati
- HangfireDashboard non documenta filtri autorizzativi deducibili
- SecuritySettings.SecretKey presente in `appsettings.json` in chiaro

## Gap noti

- Cron job Hangfire frequenze non deducibili
- HfFixJob non risulta ancora implementato; frequenza oraria e configurazione manuale derivano dal closeout di progetto
- Trigger end-to-end tra maintenance page, dashboard Hangfire e job non documentati
- Analytics tracking del workflow non deducibile
- Nessuna superficie frontend admin per messaggi draft (AdminV1Controller consumato direttamente via API)

## Note

Workflow creato da pagine wiki esistenti: [[Amministratore (actor)]], [[Operativita Backend (concept)]], [[AdminV1Controller (api)]], [[AdminMaintenancePage (web)]], [[HangfireDashboard (api)]], [[MaintenanceJob (api)]], [[UsbBackupJob (api)]], [[AuditMiddleware (api)]], [[Audit (api)]], [[SystemMessage (api)]], [[SystemMessageDraft (api)]], [[SecuritySettings (api)]], [[JwtBearerAuthentication (api)]], [[Rugby Radio Live (product)]]. Nessun RAW letto.
