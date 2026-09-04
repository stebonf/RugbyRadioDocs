---
title: "Search Console Index Coverage 2026-05 (analytic)"
type: analytics-report
layer: analytics
---

# Search Console Index Coverage 2026-05 (analytic)

## Sintesi
Copertura indicizzazione Search Console e problemi critici rilevati a maggio 2026.

## Fonte dati
RAW CSV GSC:
- `gsc-202605-Grafico.csv`
- `gsc-202605-Problemi critici.csv`
- `gsc-202605-Problemi non critici.csv`
- `gsc-20260513-Pagine indicizzate.csv`
- `gsc-202605-Latest links.csv`
- `gsc-202605-Metadati.csv`
- `gsc-202605-More sample links.csv`
- `gsc-20260531-Grafico.csv`
- `gsc-20260531-Problemi critici.csv`
- `gsc-20260531-Problemi non critici.csv`
- `gsc-20260531-Metadati.csv`
- `gsc-Aspetto nella ricerca.csv`

## Periodo
Maggio 2026, con serie grafico aggiornata fino al 2026-05-29.

## Metriche
Problemi critici:
- Pagina alternativa con tag canonical appropriato: 48 pagine
- Pagina con reindirizzamento: 13 pagine
- Pagina duplicata senza URL canonico selezionato dall'utente: 7 pagine
- Non trovata 404: 2 pagine
- Bloccata 403: 2 pagine
- Pagina scansionata ma attualmente non indicizzata: 140 pagine
- Pagina duplicata, Google ha scelto una canonica diversa: 20 pagine
- Errore server 5xx: 0 pagine

Ultimo punto della serie `gsc-20260531-Grafico.csv`:
- 2026-05-29: 232 non indicizzate, 706 indicizzate, 84 impressioni.

## Trend
Le pagine indicizzate crescono da 183 nel RAW `gsc-202605-Grafico.csv` dell'8 maggio a 706 nel RAW `gsc-20260531-Grafico.csv` del 29 maggio. Anche le non indicizzate crescono da 141 a 232 nello stesso confronto.

## Implicazioni
La copertura mostra criticita principali su canonical, redirect, duplicati e pagine scansionate non indicizzate.

## Workflow correlati
Non deducibile.

## Backlink profile

I CSV `gsc-202605-Latest links.csv` e `gsc-202605-More sample links.csv` documentano circa 90 backlink esterni verso `https://play.google.com/store/apps/details?id=com.rugbyradiolive.www.twa` (Play Store TWA) e `https://chrome-stats.com/d/com.rugbyradiolive.www.twa`, con prime scansioni tra luglio 2025 e maggio 2026. La maggior parte delle varianti riguarda localizzazioni lingua (70+ hreflang) della stessa pagina Play Store. Backlink rilevanti da `forum.rugby.it` e `twstalker.com`.

## Note
`gsc-202605-Metadati.csv` e `gsc-20260531-Metadati.csv` indicano sitemap: tutte le pagine note. Fonti link: `gsc-202605-Latest links.csv`, `gsc-202605-More sample links.csv`.
