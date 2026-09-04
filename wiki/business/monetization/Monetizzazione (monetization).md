---
title: "Monetizzazione (monetization)"
type: business-monetization
layer: business
---

# Monetizzazione (monetization)

## Sintesi

Modello di monetizzazione di [[Rugby Radio Live (product)]] basato esclusivamente su annunci AdSense distribuiti su pagine pubbliche, pagine globali, blog statico e pagina architecture statica.

## Canali di monetizzazione

- **AdSense**: unico canale attivo, presente prima di gennaio 2026 e ampliato a maggio 2026 con nuovi annunci su pagine pubbliche e statiche ([[Product Updates 2026 (article)]]).
- **Banner architecture**: slot `PAGE-ARCHITECTURE: 4750353703` sulla pagina statica pubblica `architecture.html` ([[Rugby Radio Live (architecture)]]).

## Copertura pagine

Annunci configurati su 14 unita pubblicitarie ([[AdSense Placements 2026-05 (analytic)]]):
- HOME, BLOG-HOME, G-CHANNEL, G-CHANNELS, G-MATCH-EVENTS, G-MATCHES, G-TEAM, G-STATS
- PAGE-HOW-TO, PAGE-TUTORIAL, PAGE-WHY, PAGE-TALKERS, PAGE-NEWS, PAGE-ARCHITECTURE

Per il blog statico, `BLOG-HOME: 6223722056` e lo slot unico per home, landing, indici paginati e pagine match/post ([[AdSense Blog Alignment 2026-06 (analytic)]]).

A livello frontend, gli annunci sono inseriti nei feed lista tramite `EntityAdsComponent` con frequenza configurabile (`adsFrequency` input) in:
- [[MatchCardListComponent (web)]] — feed partite
- [[ChannelCardListComponent (web)]] — feed canali
- [[MatchEventsComponent (web)]] — feed eventi partita
- [[HomePage (web)]], [[GStatsPage (web)]] — banner puntuali

## Performance

Gennaio-giugno 2026 ([[AdSense Performance 2026-01 2026-06 (analytic)]]):
- Earnings medi: ~0.08 EUR/mese
- Impressions medie: ~163/mese
- Clicks totali: 2 in 5 mesi
- Ad requests medie: ~208/mese

Il volume pubblicitario resta basso; marzo registra il massimo earnings (0.11 EUR), aprile il minimo impressions (70).

## Componenti coinvolti

- `EntityAdsComponent (web)` — componente riutilizzabile per visualizzazione annunci
- [[MatchCardListComponent (web)]], [[ChannelCardListComponent (web)]] — liste con ads a frequenza configurabile
- [[MatchEventsComponent (web)]] — feed eventi con ads
- [[HomePage (web)]], [[GStatsPage (web)]] — pagine con banner AdSense

## Workflow correlati

Non deducibile. I workflow documentati non includono eventi analytics specifici della monetizzazione.

## Note

Pagina creata da pagine wiki esistenti: analytics AdSense, articolo aggiornamenti prodotto, pagine frontend con EntityAdsComponent e pagina architecture. La wiki non documenta contratti AdSense, CPM, soglie di pagamento ne obiettivi di revenue. Non esistono pagine di monetizzazione alternativa (donazioni, abbonamenti, sponsor) nella wiki.
