---
title: "ChannelRepository (api)"
type: backend-repository
layer: backend
---

# ChannelRepository (api)

## Sintesi

Repository per la gestione dei canali. Include `Owners` nelle query di dettaglio per supportare i controlli di co-ownership. Supporta lookup per `PublicId` e ricerca paginata per filtro.

## Responsabilità

- Lookup canale per ID, `PublicId` (con e senza include owners)
- Ricerca canali per utente (owner primario o co-owner)
- Ricerca paginata canali pubblici per filtro
- Conteggio canali per utente

## Entities gestite

- [[Channel (api)]]

## Query rilevanti

- `GetByPublicIdIncludeAsync(publicId)` — include `Owners`
- `FindByUserAsync(userId)` — canali dove l'utente è owner primario o co-owner
- `FindByFilterAsync(ChannelSearchDto)` — ricerca paginata pubblica
- `CountByUserAsync(userId)` — conteggio canali utente

## Consumer

- [[ChannelService (api)]]

## Nome nel codice

`ChannelRepository` — `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelRepository.cs`
