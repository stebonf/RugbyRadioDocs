# Guida 02 - Aggiornamento Ubuntu Server

## Obiettivo

Aggiornare Ubuntu Server e verificare RAM, disco, rete e SSH.

---

## 1. Collegarsi via SSH

Da PowerShell:

```powershell
ssh stefano@192.168.4.33
```

---

## 2. Aggiornare Sistema

Dentro Ubuntu:

```bash
sudo apt update
sudo apt upgrade -y
sudo reboot
```

Ricollegarsi via SSH dopo il riavvio.

---

## 3. Installare Utility Base

```bash
sudo apt install -y ca-certificates curl git
```

---

## 4. Verificare SSH

```bash
sudo systemctl status ssh
```

Se non e' attivo:

```bash
sudo systemctl enable --now ssh
```

---

## 5. Verificare Sistema

```bash
lsb_release -a
free -h
df -h
ip addr
```

---

## 6. Spegnere VM

Quando serve:

```bash
sudo shutdown now
```

---

## Risultato Atteso

```text
Ubuntu aggiornato
SSH attivo
curl installato
git installato
RAM visibile: circa 8 GB
disco disponibile: circa 100 GB
IP VM noto
```

---

## Note Finali

Se `free -h` mostra meno di 4 GB, spegnere la VM e correggere la memoria in Hyper-V.

Configurazione consigliata:

```text
RAM di avvio: 8192 MB
Memoria dinamica: disattivata
```
