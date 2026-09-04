---
title: "Pipeline Contenuti Post Partita (article)"
type: article
layer: concept
---

# Pipeline Contenuti Post Partita (article)

## Sintesi

La pipeline contenuti post partita trasforma una partita terminata in contenuti testuali, immagini, pagine statiche, pubblicazioni social e URL indicizzabili.

## Scope

Questa pagina presenta in forma editoriale la catena descritta da [[Pipeline Contenuti (concept)]].

## Componenti coinvolti

- [[Pipeline Contenuti (concept)]]
- [[CreateMatchBlogJob (api)]]
- [[CreateMatchImageJob (api)]]
- [[CreateMatchBlogHtmlJob (api)]]
- [[FacebookJob (api)]]
- [[GenerateSeoSitemapJob (api)]]
- [[Blog (api)]]
- [[Match (api)]]

## Relazioni principali

- La partita `FullTime` e la sorgente primaria della pipeline.
- La fase blog produce testi multilingua collegati a [[Blog (api)]].
- La fase immagini genera asset per partita e canale.
- La staticizzazione HTML pubblica contenuto navigabile e indicizzabile.
- La pubblicazione social e gestita da [[FacebookJob (api)]] e collegata a [[Pubblicazione Social (concept)]].
- La generazione sitemap rende scopribili i contenuti pubblici.

## Note

Articolo creato usando solo conoscenza presente in wiki. Frequenze Hangfire, analytics di fase e dettagli completi della pubblicazione Instagram non sono deducibili.

