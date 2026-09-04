---
title: "Mappatura Job e Side Effects (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Job e Side Effects (comparison)

## Sintesi

Confronto tra i job backend Hangfire documentati nella wiki e i principali side effects prodotti su database, filesystem, servizi esterni, social e sitemap.

## Scope

Include i job backend canonici in `wiki/backend/api/jobs/` e i concept che li aggregano: [[Pipeline Contenuti (concept)]], [[Generazione Immagini (concept)]], [[Pubblicazione Social (concept)]], [[Operativita Backend (concept)]] e [[Fake Agent (concept)]]. Non include metodi interni non formalizzati come pagine job.

## Mappatura

### Pipeline contenuti e SEO

| Job | Area | Side effects principali |
|---|---|---|
| [[CreateMatchBlogJob (api)]] | Blog AI | Scrive record [[Blog (api)]] per lingua e chiama AI esterna Tailoor Talker. |
| [[CreateMatchBlogHtmlJob (api)]] | Blog statico | Scrive HTML statici, indici paginati, landing e sitemap blog; aggiorna `Blog.IsBlogStatic`. |
| [[GenerateSeoSitemapJob (api)]] | SEO sitemap | Scrive `sitemap.xml` e sitemap sezionali su filesystem configurato tramite [[SitemapXmlWriter (api)]]. |

### Generazione immagini

| Job | Area | Side effects principali |
|---|---|---|
| [[CreateMatchImageJob (api)]] | Immagini partita | Genera WebP partita su filesystem e chiama Tailoor Painter. |
| [[CreateChannelImageJob (api)]] | Immagini canale | Genera WebP canale su filesystem e chiama Tailoor Painter. |
| [[CreateMatchImageInstagramJob (api)]] | Immagini Instagram partita | Converte WebP partita in JPG 1080x1350; side effects `WritePost` non deducibili. |
| [[CreateChannelImageInstagramJob (api)]] | Immagini Instagram canale | Converte WebP canale in JPG 1080x1350; side effects `WritePost` non deducibili. |
| [[RepairMatchImageJob (api)]] | Riparazione immagini partita | Copia/sposta WebP, aggiorna `Match.ImageUrl` e compone tabellino visuale. |

### Social publishing

| Job | Area | Side effects principali |
|---|---|---|
| [[FacebookJob (api)]] | Facebook | Genera immagine, compone tabellino e pubblica post tramite [[FacebookService (api)]] e [[FacebookGraphAPI (api)]]. |

### Telecronaca AI e localizzazione

| Job | Area | Side effects principali |
|---|---|---|
| [[CreateMatchEventJob (api)]] | Bozze telecronaca AI | Genera bozze AI per eventi partita dopo [[MatchEventCreated]]. |
| [[CreateMatchEventAdminJob (api)]] | Pubblicazione/admin messaggi | Gestisce pubblicazione o verifica amministrativa di messaggi evento secondo le pagine wiki collegate. |
| [[TranslateMatchEventFemaleJob (api)]] | Localizzazione voce femminile | Traduce messaggi evento per voce femminile nel perimetro di [[Localizzazione (concept)]]. |

### Operativita backend

| Job | Area | Side effects principali |
|---|---|---|
| [[MaintenanceJob (api)]] | Manutenzione DB | Esegue stored procedure DB e cancella `.bak` piu vecchi di 5 giorni. |
| [[UsbBackupJob (api)]] | Backup USB | Copia cartelle sorgenti verso destinazione USB e scrive file/directory su filesystem. |

### Simulazione dati

| Job | Area | Side effects principali |
|---|---|---|
| [[FakeLastYearAgentJob (api)]] | Dati fake storici | Crea canali, squadre, giocatori, partite ed eventi simulati. |
| [[FakeLeagueAgentJob (api)]] | Dati fake lega | Legge [[FakeAgentSetting (api)]] e crea dati simulati per lega configurata. |
| [[FakeFantasyAgentJob (api)]] | Dati fake fantasy | Stub senza implementazione funzionale documentata. |

## Pattern

- I job della [[Pipeline Contenuti (concept)]] trasformano partite terminate in contenuti pubblici: blog, immagini, HTML statici, social e sitemap.
- I job di [[Generazione Immagini (concept)]] separano generazione WebP, conversione Instagram e riparazione immagini assegnate alle partite.
- I job operativi descritti in [[Operativita Backend (concept)]] agiscono su database e filesystem, ma non producono contenuti pubblici direttamente.
- I job Fake Agent sono separati dalla pipeline pubblica: generano dati artificiali di simulazione e possono influire sulle statistiche aggregate.
- Molti job dichiarano `[AutomaticRetry(Attempts = 0)]`, quindi i fallimenti non vengono ritentati automaticamente secondo le pagine job disponibili.

## Gap noti

- Cron expression dei job Hangfire non deducibili dalla wiki.
- Side effects `WritePost` dei job Instagram non completamente deducibili.
- Dettaglio completo dei job di telecronaca AI e localizzazione non ricostruibile in questa comparison senza leggere codice o RAW.
- Analytics tracking delle singole fasi job non deducibile.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`. La classificazione per area deriva dalle pagine job canoniche e dai concept ponte gia esistenti. Nessun RAW letto.
