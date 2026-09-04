---
title: "Backup USB (workflow)"
type: workflow
layer: workflow
---

# Backup USB (workflow)

## Obiettivo
Permettere all'operatore amministrativo RRL di eseguire tramite Hangfire una copia ricorsiva e incrementale dei dati importanti verso una destinazione USB locale.

## Trigger
Trigger Hangfire o avvio manuale dalla dashboard amministrativa. Frequenza operativa non deducibile dai RAW.

## Attori
- [[Amministratore (actor)]]

## Frontend coinvolto
Non deducibile.

## Backend coinvolto
- [[UsbBackupJob (api)]]
- [[HangfireDashboard (api)]]
- [[MaintenanceJob (api)]]

## Data coinvolti
- Backup SQL da `D:\Sql\Backup\` come sorgente candidata.
- Storage media e output statici come sorgenti candidate da confermare.

## Analytics tracking
Non deducibile.

## Failure points
- Destinazione USB assente o non scrivibile.
- Sorgente mancante o non accessibile.
- File bloccato da altro processo.
- Spazio insufficiente.
- Destinazione configurata dentro una sorgente.
- Collisione tra sorgenti con stesso nome cartella.

## Gap noti
- Cartelle ufficiali da includere nel backup non confermate.
- Frequenza operativa non definita.
- Cifratura, retention, checksum e notifiche sono fuori scope o rimandati.

## Note
Fonte: `llm-wiki/raw/analysis/TRRL-014-analisi-funzionale-backup-usb.md`. La pagina job canonica [[UsbBackupJob (api)]] documenta la configurazione implementativa rilevata.
