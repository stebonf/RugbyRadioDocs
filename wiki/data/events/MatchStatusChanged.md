---
title: "MatchStatusChanged"
type: data-event
layer: data
---

# MatchStatusChanged

## Sintesi

Evento generato quando lo stato di una partita viene aggiornato manualmente dal cronista. Ogni transizione (Scheduled, InProgress, Halftime, FullTime) determina vincoli di accesso, visibilità pubblica e automazioni backend asincrone documentate in [[Ciclo di Vita Partita (concept)]].

## Trigger

- `PUT /v1/channels/{channelId}/matches/{matchId}/status` su [[MatchesV1Controller (api)]] (endpoint MTC-05)
- Chiamata a `MatchService.UpdateMatchStatusAsync` in [[MatchService (api)]]

## Payload

- **Input**: nuovo valore `MatchStatus` (`Scheduled=10`, `InProgress=20`, `Halftime=25`, `FullTime=30`)
- **Output persistito**: [[Match (api)]] aggiornato — `Id`, `ChannelId`, `Status`, `Date`, `HomeTeamId`, `AwayTeamId`, `HomeScore`, `AwayScore`, `IsArchived`

## Consumer

- [[MatchPage (web)]] — editor cronista attivo solo per partite Scheduled e InProgress
- [[ChannelsPage (web)]] — elenco partite del cronista filtrato per stato
- [[ChannelPage (web)]] — gestione partite del canale con visibilità stato
- [[GMatchPage (web)]], [[GMatchesPage (web)]], [[GChannelPage (web)]] — visibilità pubblica attiva da InProgress

## Side effects

- **Scheduled→InProgress**: la partita diventa visibile pubblicamente; commenti, reazioni e voti giocatore si attivano (cfr. [[Interazione (concept)]])
- **InProgress→Halftime**: interruzione temporanea aggiornamenti di gioco; eventi registrati restano visibili
- **FullTime**: automazioni asincrone attivate via job Hangfire:
  - [[CreateMatchBlogJob (api)]] — generazione post blog AI multilingua
  - [[CreateMatchImageJob (api)]] — generazione copertina WebP 1200x630
  - [[CreateMatchImageInstagramJob (api)]] — conversione JPG 1080x1350
  - [[RepairMatchImageJob (api)]] — assegnazione immagine pool e compositing tabellino
  - [[FacebookJob (api)]] — pubblicazione su pagina Facebook
  - [[CreateMatchBlogHtmlJob (api)]] — staticizzazione blog HTML, indici e sitemap
  - [[GenerateSeoSitemapJob (api)]] — aggiornamento sitemap SEO
- **IsArchived**: flag booleano separato (`IsArchived = true`) esclude la partita da viste attive senza modificarne la visibilità pubblica; gestito da [[MatchService (api)]]
- Scrittura su DB nella tabella `Matches` tramite `IMatchRepository` in [[MatchService (api)]]

## Workflow correlati

- [[Cronista Telecronaca (workflow)]]
- [[Spettatore Partita (workflow)]]

## Note

Le transizioni sono manuali (cronista via MTC-05), non automatiche. L'archiviazione con `IsArchived` è un flag booleano separato dall'enum `MatchStatus`. Le frequenze cron dei job Hangfire post-FullTime non sono deducibili dalla wiki. Vincoli di validazione sulle transizioni (es. Scheduled→FullTime diretto) non deducibili. Pagina creata da pagine wiki esistenti: Ciclo di Vita Partita, Match, MatchesV1Controller, MatchService, Pipeline Contenuti, Generazione Immagini, CreateMatchBlogJob, CreateMatchImageJob, RepairMatchImageJob, FacebookJob, CreateMatchBlogHtmlJob, GenerateSeoSitemapJob. Nessun RAW letto.
