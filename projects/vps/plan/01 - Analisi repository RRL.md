# 01 - Analisi repository RRL

## Scopo

Analizzare il codice reale di RRL prima di qualsiasi modifica implementativa, confrontando repository, applicazioni, configurazioni e dipendenze con l'architettura target descritta nel README VPS.

Questa fase serve a evitare conversioni o containerizzazioni basate su assunzioni.

## Obiettivo

Produrre un report decisionale che permetta di confermare o correggere il piano tecnico delle fasi successive.

## Struttura nota da verificare

Usare questa mappa come punto di partenza dell'analisi, verificandola comunque contro solution, `.csproj`, configurazioni e codice reale:

| Percorso | Ruolo atteso | Note operative |
| --- | --- | --- |
| `src/RugbyRadio/Api` | API di RRL | Candidata a container `rrl-api`. Verificare EF Core, endpoint pubblici, configurazioni e dipendenze da filesystem. |
| `src/RugbyRadio/HF` | Hangfire | Candidata a container `rrl-hangfire`. Verificare job, storage Hangfire, always-on e output verso Blog/Sitemap. |
| `src/RugbyRadio/Lib` | Librerie comuni | Dipendenza condivisa da API e Hangfire. Non e' un container autonomo salvo evidenza contraria. |
| `src/RugbyRadio/Tests` | Unit test per API e Hangfire | Usare per validare modifiche a API, HF e librerie comuni. |
| `src/RugbyRadioBlog` | Pagine statiche HTML del Blog | Contenuti scritti da job Hangfire. Verificare path, volume persistente e modalita' di serving. |
| `src/RugbyRadio/Web` | Frontend Angular | Da escludere dalla migrazione VPS perche' resta su Firebase Hosting. Analizzare solo eventuali contratti/API e configurazioni UAT. |
| `src/RugbyRadioSitemap` | Sito utility Sitemap | Contenuti sitemap scritti da job Hangfire. Candidato al ruolo `rrl-seo`/sitemap, da confermare con il codice reale. |

Le altre cartelle sotto `src` sono esperimenti non in uso e devono essere ignorate, salvo emergano dipendenze reali dai progetti sopra elencati.

Il report deve includere:

- progetti/applicazioni individuati;
- dipendenze tra applicazioni;
- uso attuale di SQL Server ed Entity Framework Core;
- funzionamento attuale di Hangfire;
- modo in cui Hangfire genera contenuti Blog;
- funzionamento dello Storage;
- accessi al filesystem;
- configurazioni dipendenti da Windows o IIS;
- potenziali problemi per Docker/Linux;
- impatti e rischi di una eventuale conversione database;
- differenze tra codice reale e README;
- piano proposto per la Fase 2.

## Vincoli

- Non modificare codice.
- Non aggiungere pacchetti.
- Non creare Dockerfile.
- Non cambiare connection string.
- Non convertire EF Core a PostgreSQL.
- Non modificare DNS, CI/CD, infrastruttura o secrets.
- Non introdurre servizi non richiesti.

## Come procedere

1. Inventariare i repository RRL disponibili.
2. Identificare solution, progetti `.csproj`, applicazioni web, worker, librerie condivise e progetti test, partendo dalla struttura nota.
3. Separare esplicitamente componenti in uso, componenti da ignorare ed eventuali dipendenze inattese.
4. Cercare riferimenti a:
   - `UseSqlServer`;
   - `Microsoft.EntityFrameworkCore.SqlServer`;
   - raw SQL;
   - `HasColumnType`;
   - default SQL;
   - `GETDATE()`;
   - `NEWID()`;
   - identity, sequences, collation, case sensitivity;
   - path assoluti o path Windows;
   - IIS, Windows Services, registry, event log Windows.
5. Individuare Hangfire:
   - processo host;
   - storage usato;
   - dashboard eventuale;
   - job ricorrenti;
   - dipendenze da traffico HTTP;
   - output prodotti per Blog;
   - output prodotti per Sitemap/SEO.
6. Individuare Storage:
   - endpoint pubblici;
   - cartelle usate;
   - modalità di upload/download;
   - dipendenze da filesystem locale;
   - configurazioni CDN o DNS.
7. Verificare dove sono configurati secrets ed environment variables.
8. Mappare differenze tra implementazione reale e architettura target.

## Deliverable

Creare un documento di analisi con sezioni separate per:

- inventario applicazioni;
- componenti in uso e cartelle ignorate;
- matrice dipendenze;
- SQL Server/EF Core;
- Hangfire;
- Blog generation;
- Storage;
- filesystem;
- Windows/IIS;
- Docker/Linux risks;
- impatti conversione database;
- gap rispetto al README;
- proposta Fase 2.

## Criteri di uscita

La fase e' completa quando:

- ogni applicazione reale e' stata identificata;
- ogni dipendenza critica e' documentata;
- sono note le incompatibilita' principali con Linux/Docker;
- sono noti gli impatti principali di una eventuale conversione database;
- esiste una proposta concreta per containerizzare una sola applicazione semplice nella fase successiva.

## Stop point

Fermarsi e chiedere conferma prima di passare alla Fase 2.

Nessuna modifica implementativa deve essere effettuata in questa fase.
