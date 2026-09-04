# Guida 03 - Docker Engine

## Obiettivo

Installare Docker Engine, Docker Compose plugin e creare la struttura base del laboratorio.

---

## 1. Collegarsi via SSH

Da PowerShell:

```powershell
ssh stefano@192.168.4.33
```

---

## 2. Installare Prerequisiti

```bash
sudo apt update
sudo apt install -y ca-certificates curl
```

---

## 3. Configurare Repository Docker

```bash
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

```bash
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
```

---

## 4. Installare Docker

```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

---

## 5. Abilitare Docker

```bash
sudo systemctl enable --now docker
sudo systemctl status docker
```

---

## 6. Testare Docker

```bash
sudo docker run hello-world
```

---

## 7. Abilitare Docker Senza sudo

```bash
sudo usermod -aG docker $USER
exit
```

Ricollegarsi:

```powershell
ssh stefano@192.168.4.33
```

Testare:

```bash
docker run hello-world
```

---

## 8. Creare Directory Laboratorio

```bash
mkdir -p ~/rrl-lab/containers/sqlserver
mkdir -p ~/rrl-lab/containers/api
mkdir -p ~/rrl-lab/secrets/api
mkdir -p ~/rrl-lab/backups/sqlserver
mkdir -p ~/rrl-lab/src
```

Verificare:

```bash
find ~/rrl-lab -maxdepth 3 -type d | sort
```

---

## 9. Creare Reti Docker Condivise

```bash
docker network inspect rrl-backend >/dev/null 2>&1 || docker network create rrl-backend
docker network inspect rrl-frontend >/dev/null 2>&1 || docker network create rrl-frontend
```

Verificare:

```bash
docker network ls
```

---

## 10. Verifiche Finali

```bash
docker --version
docker compose version
docker run hello-world
docker network inspect rrl-backend
docker network inspect rrl-frontend
```

---

## Risultato Atteso

```text
Docker Engine installato
Docker Compose plugin installato
Docker usabile senza sudo
directory ~/rrl-lab creata
rete rrl-backend creata
rete rrl-frontend creata
```

---

## Note Finali

Ogni container avra' una directory indipendente:

```text
~/rrl-lab/containers/sqlserver
~/rrl-lab/containers/api
```

Ogni directory avra' il proprio:

```text
compose.yml
.env
.env.example
```

I container non saranno nello stesso file Compose. Comunicheranno solo tramite reti Docker esterne condivise.

Il gruppo `docker` equivale di fatto a privilegi amministrativi sulla VM.
