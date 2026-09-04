---
title: "Pubblicazione Social Post Partita (article)"
type: article
layer: concept
---

# Pubblicazione Social Post Partita (article)

## Sintesi

La pubblicazione social post partita pubblica su Facebook contenuti relativi a partite terminate, usando immagine e tabellino visuale.

## Scope

Questa pagina spiega il flusso social documentato da [[Pubblicazione Social (concept)]].

## Componenti coinvolti

- [[Pubblicazione Social (concept)]]
- [[FacebookJob (api)]]
- [[FacebookService (api)]]
- [[FacebookGraphAPI (api)]]
- [[Blog (api)]]
- [[Match (api)]]
- [[MatchStatusChanged]]
- [[Generazione Immagini (concept)]]
- [[Pipeline Contenuti (concept)]]

## Relazioni principali

- [[MatchStatusChanged]] collega il raggiungimento di `FullTime` al flusso social.
- [[FacebookJob (api)]] orchestra generazione immagine, compositing e pubblicazione.
- [[FacebookService (api)]] pubblica su Facebook tramite [[FacebookGraphAPI (api)]].
- `Blog.IsFacebookPosted` evita doppie pubblicazioni quando aggiornato correttamente.

## Note

Articolo creato usando solo pagine wiki esistenti. Cron, retry e sovrapposizione con pubblicazione Instagram non sono completamente deducibili.

