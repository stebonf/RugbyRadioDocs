# 12 - VPS Contabo ordinata

## Data

17/09/2026

## Dati ordine

- Provider: Contabo
- Customer ID: `15419227`
- Order ID: `15419228`
- Contratto: mensile
- Location: Hub Europe

## Dati VPS

- Piano: **Cloud VPS 6 (2026) (no setup)**
- IPv4: `77.237.246.2`
- IPv6 subnet: `2a02:c207:2358:7715:0000:0000:0000:0001/64`
- Utente iniziale: `root`

## Sicurezza

La password non è riportata in questo documento né nel repository. Deve essere conservata in un password manager o in un altro archivio sicuro.

L'accesso operativo previsto è SSH. Prima del deploy UAT occorre applicare hardening di base, creare un utente amministrativo nominativo con chiave SSH e limitare l'accesso `root` secondo la procedura concordata.

## Fonte

E-mail di conferma ordine Contabo ricevuta il 17/09/2026.

## Verifica accesso e risorse

Verificata il 17/09/2026 tramite SSH:

- Sistema: Ubuntu Server 24.04.5 LTS (Noble Numbat)
- Kernel: Linux 6.8.0-138-generic x86_64
- CPU: 6 vCPU
- Memoria: 11 GiB visibili
- Disco root: 193 GB, 2.2 GB utilizzati
- Swap: non configurata
- IPv4 attivo: `77.237.246.2`
- IPv6 attivo: `2a02:c207:2358:7715::1`

La VPS richiede un riavvio. Prima del deploy Docker eseguire aggiornamento pacchetti, riavvio controllato e hardening SSH/firewall.

## Aggiornamento iniziale

Completati il 17/09/2026:

- aggiornamento dell'indice pacchetti;
- aggiornamento completo dei pacchetti di sistema;
- riavvio controllato della VPS.

Prossimo passo: configurazione dell'utente amministrativo nominativo, accesso tramite chiave SSH e firewall.

## Accesso amministrativo

Completati il 17/09/2026:

- creato l'utente amministrativo `stefano`;
- aggiunto `stefano` al gruppo `sudo`;
- configurato l'accesso tramite chiave SSH ED25519;
- verificato l'accesso SSH come `stefano`;
- verificati i privilegi `sudo`.

La sessione `root` è stata mantenuta disponibile durante la configurazione.

## Firewall

Completato il 17/09/2026:

- installato/configurato UFW;
- traffico in ingresso negato per impostazione predefinita;
- traffico in uscita consentito;
- consentite solo le porte TCP `22`, `80` e `443`.

## Hardening SSH

Completato il 17/09/2026:

- disabilitato il login SSH diretto di `root`;
- disabilitata l'autenticazione SSH tramite password;
- mantenuta attiva l'autenticazione tramite chiave pubblica;
- verificato il nuovo accesso SSH con l'utente `stefano`;
- validata la configurazione SSH prima del reload del servizio.

## Docker

Completato il 17/09/2026:

- Docker Engine installato e attivo;
- Docker configurato per l'avvio automatico;
- Compose v2 installato e disponibile;
- utente `stefano` abilitato all'uso del Docker daemon;
- eseguito con successo `docker run --rm hello-world`, incluso pull dell'immagine e avvio del container.

Versioni verificate:

- Docker `29.1.3`
- Docker Compose `2.40.3`

## Destinazione applicativa

La VPS è considerata ambiente di **produzione**, non laboratorio UAT.

Per supportare più progetti viene adottata la root generica:

```text
/srv/containers/
├── shared/
├── rugbyradiolive/
├── progetto-b/
└── ...
```

Non utilizzare directory con nomi specifici di laboratorio come `rrl-lab`. I segreti di produzione devono restare fuori da Git, con permessi filesystem limitati.

## Preparazione runtime

Completato il 17/09/2026:

- installato il pacchetto `git` sulla VPS.

Non sono ancora stati eseguiti il clone del repository né la creazione delle directory applicative.

Successivamente completato il 17/09/2026:

- creata `/srv/containers/shared`;
- creata `/srv/containers/rugbyradiolive`;
- assegnata la proprietà delle directory a `stefano`;
- verificata la struttura multi-progetto.

## Accesso GitHub

Verificato il 17/09/2026 il collegamento SSH a GitHub. La rete è raggiungibile e la chiave host di `github.com` è stata registrata, ma la VPS non è ancora autorizzata al repository (`Permission denied (publickey)`).

Non è stato eseguito alcun clone e non è stata configurata alcuna chiave SSH GitHub.

## Runtime trasferito

Completato il 17/09/2026:

- trasferiti in `/srv/containers/rugbyradiolive` i file `compose*.yml`;
- trasferiti i soli template `.env.*.example`;
- non trasferiti sorgenti, file `.env` reali o credenziali.
