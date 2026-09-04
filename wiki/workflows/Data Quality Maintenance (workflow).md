---
title: "Data Quality Maintenance (workflow)"
type: workflow
layer: workflow
---

# Data Quality Maintenance (workflow)

## Obiettivo

Mantenere coerenti i dati operativi pubblici e backend correggendo anomalie note tramite un job Hangfire periodico, senza intervento manuale e senza side effect non necessari.

## Trigger

Esecuzione oraria proposta di [[HfFixJob (api)]] tramite Hangfire.

## Attori

- [[Amministratore (actor)]] — beneficia della riduzione di interventi manuali e controlla l'esito operativo tramite Hangfire/log.
- [[Cronista (actor)]] — evita partite abbandonate che restano visibili come live.
- [[Spettatore (actor)]] — consulta liste, canali e partite con dati pubblici piu coerenti.

## Frontend coinvolto

Non e prevista una nuova superficie frontend nell'MVP.

Pagine e componenti pubblici o autenticati possono beneficiare indirettamente di dati corretti, ma il closeout non indica consumer frontend specifici da aggiornare.

## Backend coinvolto

- [[HfFixJob (api)]] — orchestratore di bonifica dati.
- [[RepairMatchImageJob (api)]] — riferimento per logica di riparazione immagini partita.
- [[CreateChannelImageJob (api)]] — riferimento per logiche immagine canale.
- [[FakeLeagueAgentJob (api)]] — fonte delle logiche Fake Agent da rendere riusabili.
- [[FakeLastYearAgentJob (api)]] — fonte delle logiche Fake Agent da rendere riusabili.
- [[MatchRepository (api)]] — query e aggiornamenti su partite.
- [[TeamRepository (api)]] — query e aggiornamenti su team senza nome.
- [[ChannelRepository (api)]] — query e aggiornamenti su canali senza nome o immagine.
- [[UserRepository (api)]] — query e aggiornamenti su utenti senza nickname.

## Data coinvolti

- [[Match (api)]] — `Status`, `DateUtc`, `ImageUrl`.
- [[Team (api)]] — `Name`, `ChannelId`.
- [[Channel (api)]] — `Name`, `ImageUrl`.
- [[User (api)]] — `Nickname`.

## Analytics tracking

Non sono previsti impatti Analytics, GA, AdSense o SEO diretti nel closeout.

## Failure points

- Partite storiche con `DateUtc` non affidabile.
- Generazione AI non disponibile o risposta non valida.
- Canale o contesto team mancante.
- Pool immagini vuoto.
- Errori filesystem nelle logiche immagine.
- Errori di salvataggio DB su singola riga.
- Overlap tra esecuzioni se manca anti-concorrenza.

## Gap noti

- [[HfFixJob (api)]] non risulta ancora implementato.
- La logica esatta da estrarre da [[RepairMatchImageJob (api)]] deve essere verificata nel codice.
- La logica di associazione immagine canale deve essere verificata in `ChannelService` e nei flussi di creazione canale.
- La validita di `DateUtc` sulle partite storiche deve essere confermata su dati reali.
- L'eventuale interfaccia interna `IHfFixCheck` e rinviata finche l'orchestratore resta leggibile.

## Note

Workflow creato da `raw/projects/job-hf-fix/job-hf-fix-closeout.md`.
