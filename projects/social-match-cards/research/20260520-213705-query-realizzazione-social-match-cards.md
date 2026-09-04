---
type: query-note
created: 2026-05-20T21:37:05+02:00
source: query
slug: realizzazione-social-match-cards
---

# Realizzazione social match cards

## Domanda

Mi piace l'idea 2, ma come realizzo facilmente le card?

## Risposta

Approccio MVP: generare card da template grafici statici, non da AI generativa per ogni card. I dati arrivano da match, eventi, punteggio, minuto, testo evento e immagini/loghi gia referenziabili. La piattaforma ha gia job immagini, conversione Instagram, pubblicazione Facebook e URL media pubblici.

Flusso consigliato:

1. Definire 3 template iniziali: full time, evento forte, card partita live.
2. Popolare template con dati match/evento: squadre, punteggio, minuto, tipo evento, testo, link partita.
3. Renderizzare immagine server-side in JPG 1080x1350 e/o WebP 1200x630.
4. Salvare su storage pubblico.
5. Aggiungere link alla card nella partita/evento o pubblicarla tramite job social.

Il punto piu semplice e riusare la logica gia vicina a CreateMatchImageJob, CreateMatchImageInstagramJob e FacebookJob, ma separando la card deterministica dall'immagine AI.

## Pagine wiki usate

- [[CreateMatchImageJob (api)]]
- [[CreateMatchImageInstagramJob (api)]]
- [[FacebookJob (api)]]
- [[FacebookService (api)]]
- [[FacebookGraphAPI (api)]]
- [[SocialShareUrlIntegration (api)]]
- [[PublicMediaUrlReferenceIntegration (api)]]
- [[Match (api)]]
- [[MatchEvent (api)]]
- [[matchEventDto (web)]]
- [[GMatchPage (web)]]

## Note per ingest

- Nota generata da query e candidata a ingest se utile.
- Non contiene informazioni esterne alla wiki.
