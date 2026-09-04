---
title: "Mappatura Interazioni e Notifiche (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Interazioni e Notifiche (comparison)

## Sintesi

Confronto tra interazioni spettatore, follow, notifiche push e data-event collegati alla fruizione della partita.

## Scope

Include commenti, reazioni, like, follow, voti, notifiche FCM e data-event gia documentati nella wiki. Non include notifiche non deducibili, moderazione o analytics di consegna.

## Mappatura

| Area | Pagine collegate | Effetto principale |
|---|---|---|
| Evento partita | [[MatchEventCreated]] | Aggiorna feed e attiva notifiche push agli iscritti. |
| Commenti | [[CommentAdded]], [[Comment (api)]] | Scrive commenti visibili nel feed evento o partita. |
| Reazioni | [[ReactionAdded]], [[EventReaction (api)]] | Scrive reazioni emoji sugli eventi di telecronaca. |
| Like | [[MatchLiked]], [[MatchLike (api)]] | Toggle like partita con soft-delete. |
| Follow | [[SubscriptionChanged]], [[Subscription (api)]] | Iscrive o disiscrive utente da partita o canale. |
| Notifiche | [[Notifica (concept)]], [[FirebaseFCM (api)]], [[UserToken (api)]] | Invia push FCM e gestisce token dispositivo. |

## Pattern

- [[Interazione (concept)]] descrive le azioni dello spettatore sulla partita.
- [[Notifica (concept)]] usa follow e token FCM per raggiungere gli spettatori quando nasce un nuovo evento.
- [[Subscription (api)]] copre sia follow canale sia follow partita.
- La creazione di eventi partita e distinta dalle interazioni spettatore: il cronista produce [[MatchEventCreated]], lo spettatore produce commenti, reazioni, like, follow e voti.
- Diverse interazioni richiedono account autenticato secondo le pagine evento e workflow.

## Gap noti

- Notifiche push per nuovi commenti non deducibili.
- Analytics tracking di follow, notifiche e interazioni non deducibile.
- Rate limiting, moderazione e limiti quantitativi non deducibili.
- Meccanismo realtime completo di aggiornamento UI non deducibile.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`: [[Interazione (concept)]], [[Notifica (concept)]], data-event e [[Spettatore Partita (workflow)]]. Nessun RAW letto.
