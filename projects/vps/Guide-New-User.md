# Guida — Aggiungere un nuovo utente alla VPS

Procedura per creare un account Linux personale, con accesso SSH tramite chiave ED25519.
L'utente operativo attuale è `stefano`. Ogni persona deve usare il proprio account: non condividere utenti, password o chiavi private.

## 1. Preparare la chiave sul PC dell'utente

Sul PC di Viviana, in PowerShell:

```powershell
ssh-keygen -t ed25519 -C "viviana@rrl-vps"
```

Accettare il percorso predefinito oppure usare un nome dedicato, ad esempio:

```text
C:\Users\Viviana\.ssh\rrl-vps
C:\Users\Viviana\.ssh\rrl-vps.pub
```

La chiave privata non deve essere inviata né inserita nella VPS. Copiare solo il contenuto del file `.pub`.

## 2. Creare l'utente sulla VPS

Accedere con `stefano` e usare `sudo`:

```bash
sudo adduser viviana
```

Impostare una password locale robusta quando richiesto. La password servirà per `sudo` solo se l'utente viene autorizzato a usarlo; l'accesso SSH sarà tramite chiave.

Creare la directory SSH e installare la chiave pubblica:

```bash
sudo install -d -m 700 -o viviana -g viviana /home/viviana/.ssh
sudo nano /home/viviana/.ssh/authorized_keys
```

Incollare una sola riga completa `ssh-ed25519 ...`, quindi applicare i permessi:

```bash
sudo chown viviana:viviana /home/viviana/.ssh/authorized_keys
sudo chmod 600 /home/viviana/.ssh/authorized_keys
```

## 3. Decidere i privilegi

Per un utente che deve solo accedere alla VPS e consultare i propri file, non aggiungerlo a `sudo` né al gruppo Docker.

Se deve amministrare la VPS:

```bash
sudo usermod -aG sudo viviana
```

Non aggiungere automaticamente Viviana al gruppo `docker`: equivale di fatto ad avere privilegi amministrativi sulla macchina. Valutare l'autorizzazione caso per caso.

Per collaborare sui file di un progetto, creare invece un gruppo dedicato e concedere solo quella directory:

```bash
sudo groupadd rrl-operators
sudo usermod -aG rrl-operators viviana
sudo chown -R stefano:rrl-operators /srv/containers/rugbyradiolive
sudo chmod -R g+rX /srv/containers/rugbyradiolive
```

Non concedere scrittura ai file `.env`, alle chiavi TLS, ai secret o ai backup senza una necessità esplicita.

## 4. Testare l'accesso

Dal PC di Viviana:

```powershell
ssh -i $env:USERPROFILE\.ssh\rrl-vps viviana@77.237.246.2
```

Se la chiave usa il nome predefinito, OpenSSH può trovarla automaticamente:

```powershell
ssh viviana@77.237.246.2
```

Verificare sulla VPS:

```bash
whoami
id
sudo -n true
```

L'ultimo comando deve riuscire solo se l'utente è stato autorizzato a usare `sudo` senza password; in caso contrario è normale che richieda la password.

## 5. Trasferire la configurazione su un nuovo PC

Trasferire in modo sicuro:

- la chiave privata SSH;
- il file `config` SSH, se utilizzato;
- eventualmente il fingerprint/record di `known_hosts`.

Non trasferire `authorized_keys`: quello resta sulla VPS. Impostare i permessi restrittivi sulla chiave privata e non inviarla via e-mail o chat.

## 6. Revocare l'accesso

Per bloccare temporaneamente l'account:

```bash
sudo passwd -l viviana
```

Per revocare una sola chiave, rimuovere la relativa riga:

```bash
sudo nano /home/viviana/.ssh/authorized_keys
```

Per rimuovere definitivamente l'utente, verificare prima i suoi file e processi:

```bash
ps -u viviana
sudo deluser viviana
```

Non usare `--remove-home` senza aver verificato che non servano dati da conservare.

## Checklist

- [ ] chiave ED25519 generata sul PC dell'utente;
- [ ] copiata solo la chiave pubblica;
- [ ] account creato con privilegi minimi;
- [ ] test SSH riuscito;
- [ ] accesso SFTP/tunnel concesso solo se necessario;
- [ ] credenziali e chiavi registrate nel password manager;
- [ ] procedura di revoca documentata.
