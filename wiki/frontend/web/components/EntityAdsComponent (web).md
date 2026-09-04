---
title: "EntityAdsComponent (web)"
type: frontend-component
layer: frontend
---

# EntityAdsComponent (web)

## Sintesi

Componente riutilizzabile per visualizzazione annunci AdSense nei feed lista. Inserisce banner pubblicitari a frequenza configurabile tramite input `adsFrequency`.

## Responsabilità

- Visualizzare banner AdSense nei feed paginati
- Inserire annunci con frequenza configurabile (`adsFrequency` elementi)
- Supportare configurazione dinamica di client ID e slot ID AdSense

## Parent pages

- [[MatchCardListComponent (web)]]
- [[ChannelCardListComponent (web)]]
- [[MatchEventsComponent (web)]]
- [[HomePage (web)]]
- [[GStatsPage (web)]]

## Child components

Nessuno.

## Servizi FE usati

Nessuno.

## Modelli FE usati

Nessuno.

## Eventi input/output

| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | adClient | string | ID client AdSense |
| Input | adSlot | string | ID slot AdSense |
| Input | adsFrequency | number | Frequenza inserimento ads nella lista |

## Note

Il componente viene inserito nei feed lista a intervalli regolari definiti da `adsFrequency`. Le 14 unita pubblicitarie AdSense attive sono documentate in [[Monetizzazione (monetization)]]. Performance e slot specifici sono tracciati in [[AdSense Placements 2026-05 (analytic)]] e [[AdSense Performance 2026-01 2026-06 (analytic)]]. Dettagli implementativi del componente (template, stili, logica di rotazione annunci) non deducibili dalla wiki.
