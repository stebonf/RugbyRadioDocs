---
title: "SubscriptionRepository (api)"
type: backend-repository
layer: backend
---

# SubscriptionRepository (api)

## Sintesi

Repository per le iscrizioni (follow canale e follow partita). Gestisce toggle iscrizione, recupero iscrizioni per utente/canale/partita.

## Responsabilità

- `GetChannelSubAsync(publicId, userId)` — iscrizione canale per utente
- `FindChannelSubIncludeByUserIdAsync(userId)` — canali seguiti dall'utente (con include)
- Inserimento/eliminazione iscrizione (toggle follow)
- Recupero token FCM degli iscritti a una partita (per notifiche push)

## Entities gestite

- [[Subscription (api)]]

## Query rilevanti

- `GetChannelSubAsync` — lookup iscrizione canale specifica
- `FindChannelSubIncludeByUserIdAsync` — tutti i canali seguiti

## Consumer

- [[ChannelService (api)]]
- [[MatchService (api)]]
- [[UserService (api)]]

## Nome nel codice

`SubscriptionRepository` — `src/RugbyRadio/Lib/Repositories/SubscriptionBox/SubscriptionRepository.cs`
