---
title: "UsbBackupJob (api)"
type: backend-job
layer: backend
---

# UsbBackupJob (api)

## Sintesi

Esegue backup locale incrementale verso una destinazione USB configurata, copiando ricorsivamente una o piu cartelle sorgenti e preservando una root destinazione distinta per ogni sorgente.

## Trigger

Hangfire RecurringJobAdmin — cron non configurato nel codice.

## Responsabilità

- Caricare `UsbBackupSettings` dalla sezione `UsbBackup`.
- Validare che il backup sia abilitato prima di eseguire lavoro.
- Delegare la copia filesystem a `IUsbBackupService`.
- Scrivere riepilogo e warning su Hangfire Console e logging applicativo.
- Fallire il job quando ci sono errori parziali su sorgenti o file copiabili.

## Services usati

- `IUsbBackupService` — scansione sorgenti, validazione path, copia incrementale e riepilogo.

## Configurazione

Sezione `UsbBackup` in `src/RugbyRadio/HF/appsettings.json`:

- `Enabled`
- `DestinationPath`
- `CopyOnlyChangedFiles`
- `PreserveSourceRootFolder`
- `FailOnMissingSource`
- `SourceFolders[].Name`
- `SourceFolders[].Path`
- `SourceFolders[].DeleteDestinationFilesNotInSource`

La configurazione di default e disabilitata e include `D:\Sql\Backup` come sorgente candidata `SqlBackup`.
La cancellazione dei file destinazione non piu presenti nella sorgente e opt-in per singola sorgente tramite `DeleteDestinationFilesNotInSource`; di default resta disattivata.

## Side effects

- Lettura ricorsiva delle cartelle sorgenti configurate.
- Scrittura nella cartella destinazione configurata.
- Creazione delle directory destinazione mancanti.
- Copia tramite file temporaneo e sostituzione finale del file destinazione.
- Se `SourceFolders[].DeleteDestinationFilesNotInSource = true`, eliminazione dei file nella root destinazione della sorgente che non esistono piu nella cartella sorgente.

## Failure points

- `UsbBackup:DestinationPath` vuoto, inesistente o non scrivibile.
- Nessuna sorgente configurata.
- Nomi o path sorgente duplicati.
- Destinazione contenuta dentro una sorgente o sorgente contenuta nella destinazione.
- Sorgente mancante con `FailOnMissingSource = true`.
- Cancellazione sorgente abilitata con piu sorgenti e `PreserveSourceRootFolder = false`, configurazione rifiutata per evitare che una sorgente cancelli file di un'altra.
- Errori di I/O, permessi, file bloccati o path non supportati.

## Note

Implementa TRRL-014 per la parte locale USB. Backup cloud, cifratura, retention su chiavetta e checksum restano fuori scope.

## Nome nel codice

`UsbBackupJob` — `src/RugbyRadio/HF/Jobs/UsbBackupJob.cs`
