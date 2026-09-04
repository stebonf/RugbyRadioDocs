---
title: "Gestione Canale (workflow)"
type: workflow
layer: workflow
---

# Gestione Canale (workflow)

## Obiettivo

Permettere al cronista di creare, consultare e aggiornare un canale di telecronaca, inclusi dati base, layout e co-editor.

## Trigger

Il cronista apre la lista dei canali autenticata, crea un nuovo canale o seleziona un canale esistente da gestire.

## Attori

- [[Cronista (actor)]]

## Frontend coinvolto

- [[ChannelsPage (web)]]
- [[ChannelPage (web)]]
- [[ChannelService (web)]]
- [[ChannelUserService (web)]]
- [[ChannelTabIdModel (web)]]
- [[channelTableDto (web)]]

## Backend coinvolto

- [[ChannelsV1Controller (api)]]
- [[ChannelService (api)]]
- [[CreateChannelImageJob (api)]]
- [[CreateChannelImageInstagramJob (api)]]

## Data coinvolti

- [[Channel (api)]]
- [[ChannelUser (api)]]

## Analytics tracking

- [[Platform Stats 2026-05-13 (analytic)]]

## Failure points

- AuthGuardService richiesto per le pagine di gestione canale.
- Verifica ownership del canale tramite owner primario o co-owner.
- Validazione form nella creazione canale.
- Aggiornamento layout o dati canale non autorizzato.
- Generazione o conversione immagine canale non completata.

## Gap noti

- Dettaglio completo dei componenti interni delle tab canale non deducibile dalla wiki.
- Eventuali eventi analytics specifici del workflow non deducibili dalla wiki.

## Note

Workflow creato da pagine wiki esistenti e suggerimento lint. Il flusso e distinto dalla telecronaca partita perche riguarda gestione e configurazione del canale.
