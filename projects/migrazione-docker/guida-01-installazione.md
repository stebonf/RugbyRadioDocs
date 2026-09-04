# Guida 01 - Hyper-V e Ubuntu Server

## Obiettivo

Creare una VM Ubuntu Server 24.04 LTS su Hyper-V.

---

## 1. Scaricare Ubuntu Server

Scaricare:

```text
Ubuntu Server 24.04 LTS AMD64
```

Da:

```text
https://ubuntu.com/download/server
```

---

## 2. Abilitare Hyper-V

Aprire:

```text
Pannello di controllo
  -> Programmi
  -> Attiva o disattiva funzionalita' di Windows
```

Abilitare:

```text
Hyper-V
Piattaforma macchina virtuale
Piattaforma hypervisor Windows
```

Riavviare Windows.

---

## 3. Creare Commutatore Virtuale

Aprire:

```text
Gestione Hyper-V
  -> Gestione commutatori virtuali...
```

Creare:

```text
Nuovo commutatore di rete virtuale
Tipo: Esterno
Nome: LAN Esterna
Scheda: Ethernet o Wi-Fi principale
Consenti al sistema operativo di gestione di condividere questa scheda: attivo
```

Confermare:

```text
Applica
OK
```

---

## 4. Creare VM

In Hyper-V:

```text
Nuovo
  -> Macchina virtuale...
```

Impostare:

```text
Nome: rrl-ubuntu-lab
Generazione: Generazione 2
Memoria di avvio: 8192 MB
Usa memoria dinamica: disattivato
Connessione: LAN Esterna
Disco rigido virtuale: 100 GB, espansione dinamica
Installazione: file immagine ISO Ubuntu Server
```

Completare:

```text
Fine
```

---

## 5. Controllare Impostazioni VM

Aprire:

```text
tasto destro su rrl-ubuntu-lab
  -> Impostazioni...
```

Controllare:

```text
Processore
  -> Numero di processori virtuali: 4
```

Controllare:

```text
Memoria
  -> RAM di avvio: 8192 MB
  -> Memoria dinamica: disattivata
```

Se Ubuntu non parte:

```text
Sicurezza
  -> Modello: Autorita' di certificazione UEFI Microsoft
```

Oppure:

```text
Sicurezza
  -> Avvio protetto: disattivato
```

---

## 6. Installare Ubuntu Server

Avviare:

```text
tasto destro su rrl-ubuntu-lab
  -> Connetti...
  -> Avvia
```

Durante il wizard impostare:

```text
Ubuntu Server
Tastiera: layout usato abitualmente
Rete: DHCP
Proxy: vuoto
Mirror: default
Storage: usare tutto il disco virtuale
OpenSSH Server: installare
Featured server snaps: nessuno
```

Creare utente amministrativo, ad esempio:

```text
stefano
```

Riavviare a fine installazione.

---

## 7. Rimuovere ISO

Se la VM riparte dalla ISO, spegnerla.

Aprire:

```text
tasto destro su rrl-ubuntu-lab
  -> Impostazioni...
  -> Controller SCSI
  -> Unita' DVD
  -> Supporto: Nessuno
  -> Applica
  -> OK
```

Riavviare la VM.

---

## 8. Recuperare IP VM

Dentro Ubuntu:

```bash
ip addr
```

Annotare l'IP, ad esempio:

```text
192.168.4.33
```

---

## 9. Collegarsi via SSH

Da PowerShell:

```powershell
ssh stefano@192.168.4.33
```

Sostituire utente e IP con quelli reali.

---

## Risultato Atteso

```text
VM Ubuntu Server 24.04 LTS avviata
SSH funzionante da Windows
RAM VM: 8192 MB
CPU VM: 4 vCPU
Disco VM: 100 GB
```

---

## Note Finali

Per questo laboratorio usare memoria fissa da 8192 MB. SQL Server in Docker richiede almeno 2 GB visibili alla VM, ma 8 GB evitano problemi durante restore, API e test successivi.

Il commutatore esterno rende la VM raggiungibile dalla LAN tramite IP, come una piccola VPS locale.
