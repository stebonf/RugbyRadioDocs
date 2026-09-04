---
title: "Ciclo di Vita Partita (concept)"
type: concept
layer: concept
---

# Ciclo di Vita Partita (concept)

## Sintesi

Il ciclo di vita di una [[Partita (concept)]] e definito da quattro stati (Scheduled, InProgress, Halftime, FullTime) gestiti da [[MatchService (api)]] e [[MatchesV1Controller (api)]]. Ogni transizione di stato determina vincoli di accesso, visibilita pubblica e automazioni backend asincrone.

## Stati e transizioni

### Scheduled (10)

Partita creata ma non ancora iniziata. Visibile solo al cronista proprietario nelle pagine di gestione [[ChannelsPage (web)]] e [[ChannelPage (web)]].

**Trigger**: Creazione via [[MatchesV1Controller (api)]] (MTC-01, MTC-03, MTC-17) o [[MatchService (api)]]. Creazione rapida wizard gestita da [[RugbyRadioLiveService (api)]].

**Vincoli**: Solo il cronista owner o co-owner del canale puo creare e modificare la partita. Le formazioni e squadre possono essere configurate prima dell'inizio.

### InProgress (20)

Partita in corso. Visibile pubblicamente su [[GMatchPage (web)]], [[GMatchesPage (web)]] e [[GChannelPage (web)]]. Eventi di telecronaca aggiungibili dal [[Cronista (actor)]] tramite [[MatchPage (web)]].

**Trigger**: Cambio stato via `PUT /v1/channels/{channelId}/matches/{matchId}/status` (MTC-05).

**Azioni consentite**:
- Il cronista clicca eventi di telecronaca su [[MatchPage (web)]]; ogni evento genera notifica push FCM via [[FirebaseFCM (api)]]
- Gli [[Spettatore (actor)]] seguono gli eventi in tempo reale su [[GMatchPage (web)]]
- Commenti, reazioni emoji, like e voti giocatore sono attivi (cfr. [[Interazione (concept)]])
- Punteggio, minuto e statistiche di campo vengono aggiornati in tempo reale

### Halftime (25)

Intervallo tra i due tempi. Stato intermedio che blocca temporaneamente gli aggiornamenti di gioco ma mantiene visibili gli eventi registrati.

**Trigger**: Cambio stato manuale via MTC-05.

### FullTime (30)

Partita terminata. Le interazioni (commenti, reazioni, voti) restano leggibili. La partita e visibile pubblicamente con riepilogo completo.

**Trigger**: Cambio stato manuale via MTC-05.

**Automazioni backend**: Al raggiungimento di FullTime, i job Hangfire asincroni attivano la generazione contenuti post-partita:

- [[CreateMatchBlogJob (api)]] — partite FullTime con meno di 5 post blog generano testi AI multilingua
- [[CreateMatchImageJob (api)]] — generazione copertina WebP 1200x630
- [[CreateMatchImageInstagramJob (api)]] — conversione JPG 1080x1350 per Instagram
- [[RepairMatchImageJob (api)]] — assegnazione immagine pool e compositing tabellino
- [[FacebookJob (api)]] — generazione immagine e pubblicazione su pagina Facebook
- [[CreateMatchBlogHtmlJob (api)]] — staticizzazione blog in HTML, indici e sitemap
- [[GenerateSeoSitemapJob (api)]] — aggiornamento sitemap SEO

Questo flusso e descritto in [[Pipeline Contenuti (concept)]] e [[Generazione Immagini (concept)]].

### Archiviazione

`IsArchived = true` esclude la partita da viste attive senza modificarne la visibilita pubblica. Il flag e gestito da [[MatchService (api)]].

## Componenti coinvolti

### Backend

- [[Match (api)]] — entita con proprieta `Status` (MatchStatus enum: Scheduled=10, InProgress=20, Halftime=25, FullTime=30)
- [[MatchesV1Controller (api)]] — endpoint MTC-05 per cambio stato
- [[MatchService (api)]] — logica aggiornamento stato e orchestrazione
- [[RugbyRadioLiveService (api)]] — wizard creazione rapida partita
- [[AppDbContext (api)]] — conversione `MatchStatus` → `int`

### Frontend

- [[MatchPage (web)]] — editor cronista per partite in corso
- [[GMatchPage (web)]] — vista pubblica partita
- [[ChannelPage (web)]] — gestione partite del canale
- [[ChannelsPage (web)]] — elenco canali del cronista

### Workflow

- [[Cronista Telecronaca (workflow)]] — creazione partita e inserimento eventi
- [[Spettatore Partita (workflow)]] — fruizione pubblica partita

### Concetti

- [[Partita (concept)]] — concetto di dominio della partita
- [[Pipeline Contenuti (concept)]] — generazione contenuti post-FullTime
- [[Generazione Immagini (concept)]] — generazione immagini post-FullTime
- [[Match Event Types (concept)]] — tipi evento registrabili
- [[Interazione (concept)]] — commenti, reazioni, like e voti
- [[Notifica (concept)]] — notifiche push FCM a ogni evento

### Data

- [[MatchEventCreated]] — evento di dominio per nuova creazione evento

## Decisioni architetturali

- La transizione di stato e manuale (cronista via MTC-05), non automatica
- Le automazioni post-FullTime sono asincrone via job Hangfire, non sincrone sulla richiesta di cambio stato
- L'archiviazione e un flag booleano separato (`IsArchived`), non uno stato dell'enum `MatchStatus`
- La creazione wizard (MTC-17) crea canale, squadre, partita e formazioni in un'unica operazione atomica

## Rischi

- Frequenze cron dei job Hangfire non deducibili dalla wiki
- Analytics tracking delle transizioni di stato non deducibile
- Vincoli di validazione sulle transizioni (es. Scheduled → FullTime diretto) non deducibili

## Note

Pagina creata da pagine wiki esistenti: Match, MatchesV1Controller, MatchService, Partita, Cronista Telecronaca, Spettatore Partita, Pipeline Contenuti, Generazione Immagini, CreateMatchBlogJob, CreateMatchImageJob, RepairMatchImageJob, FacebookJob, CreateMatchBlogHtmlJob, GenerateSeoSitemapJob, RugbyRadioLiveService, AppDbContext. Nessun RAW letto.
