---
title: "Operativita Backend (concept)"
type: concept
layer: concept
---

# Operativita Backend (concept)

## Sintesi

Insieme delle superfici e dei job backend usati per manutenzione, backup, osservazione operativa e controllo amministrativo della piattaforma Rugby Radio Live.

## Scope

L'operativita backend comprende:

- modalita manutenzione frontend documentata in [[AdminMaintenancePage (web)]];
- dashboard Hangfire documentata in [[HangfireDashboard (api)]];
- manutenzione e backup database tramite [[MaintenanceJob (api)]];
- bonifica conservativa dati operativi tramite [[HfFixJob (api)]], proposta per il workflow [[Data Quality Maintenance (workflow)]];
- backup locale verso USB tramite [[UsbBackupJob (api)]];
- funzioni amministrative sui messaggi draft tramite [[AdminV1Controller (api)]];
- audit HTTP applicativo tramite [[AuditMiddleware (api)]] e [[Audit (api)]];
- configurazione sicurezza JWT tramite [[SecuritySettings (api)]] e [[JwtBearerAuthentication (api)]].

## Componenti coinvolti

- [[AdminMaintenancePage (web)]]
- [[HangfireDashboard (api)]]
- [[MaintenanceJob (api)]]
- [[HfFixJob (api)]]
- [[UsbBackupJob (api)]]
- [[AdminV1Controller (api)]]
- [[AuditMiddleware (api)]]
- [[Audit (api)]]
- [[SecuritySettings (api)]]
- [[JwtBearerAuthentication (api)]]

## Relazioni principali

- [[AdminMaintenancePage (web)]] rappresenta la superficie utente quando `environment.maintenance = true` redireziona tutte le route verso la pagina di manutenzione.
- [[HangfireDashboard (api)]] e la superficie operativa per osservare o gestire job Hangfire; le regole autorizzative non sono completamente deducibili dalla wiki.
- [[MaintenanceJob (api)]] esegue stored procedure di manutenzione e backup database, poi rimuove backup `.bak` piu vecchi di 5 giorni.
- [[HfFixJob (api)]] e proposto per chiudere partite abbandonate, correggere nomi mancanti e riparare immagini mancanti in modo idempotente e non bloccante.
- [[UsbBackupJob (api)]] copia in modo incrementale cartelle sorgenti configurate verso una destinazione USB.
- [[AdminV1Controller (api)]] espone endpoint amministrativi per messaggi draft e statistiche messaggi usando `authKey` come query parameter.
- [[AuditMiddleware (api)]] registra richieste HTTP in [[Audit (api)]] senza bloccare la risposta applicativa.

## Decisioni architetturali

- I job operativi sono eseguiti tramite Hangfire, ma le frequenze cron non sono deducibili dalle pagine wiki disponibili.
- La maintenance mode frontend e governata da flag di environment e non da una API runtime documentata.
- Alcune superfici operative usano regole non standard o non completamente documentate: [[AdminV1Controller (api)]] usa `authKey` query parameter, mentre [[HangfireDashboard (api)]] non espone nella wiki filtri autorizzativi deducibili.
- Backup database e backup USB sono separati: [[MaintenanceJob (api)]] produce e ripulisce backup `.bak`, mentre [[UsbBackupJob (api)]] copia cartelle sorgenti configurate verso destinazione USB.
- La bonifica dati proposta da [[HfFixJob (api)]] deve restare separata da notifiche, pubblicazione social, rigenerazione blog e cancellazioni.

## Rischi

- [[MaintenanceJob (api)]] non ha retry automatici e usa percorso backup hardcoded.
- [[HfFixJob (api)]] deve confermare l'affidabilita di `DateUtc` sui dati storici prima del rilascio.
- [[UsbBackupJob (api)]] puo fallire per configurazione destinazione, sorgenti mancanti, permessi, file bloccati o path non supportati.
- [[AdminV1Controller (api)]] usa una chiave hardcoded passata come query parameter.
- [[HangfireDashboard (api)]] non documenta nella wiki policy o filtri auth deducibili.
- [[SecuritySettings (api)]] indica `Security:SecretKey` presente in configurazione in chiaro.

## Note

Pagina ponte creata usando solo pagine gia presenti in `llm-wiki/wiki`. Non introduce un workflow operativo perche la wiki non documenta un attore amministrativo canonico ne un trigger end-to-end tra maintenance page, dashboard Hangfire e job.
