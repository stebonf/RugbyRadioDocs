---
title: "Notifica (concept)"
type: concept
layer: concept
---

# Notifica (concept)

## Sintesi

Sistema di notifiche push di [[Rugby Radio Live (product)]] basato su Firebase Cloud Messaging (FCM). Permette di notificare gli spettatori in tempo reale quando un cronista crea un nuovo evento di telecronaca.

## Scope

- Notifiche push FCM per eventi partita
- Follow partita e canale come meccanismo di iscrizione alle notifiche
- Registrazione token FCM lato client
- Persistenza e gestione token FCM su database
- Eliminazione token non validi su errore Firebase

## Componenti coinvolti

### Backend

- [[FirebaseFCM (api)]] — integrazione FCM per invio notifiche push
- [[MatchService (api)]] — invio notifiche push FCM via `SendNotifications`
- [[UserService (api)]] — salvataggio token FCM
- [[UserV1Controller (api)]] — endpoint `POST /v1/user/notification-token`
- [[MatchesV1Controller (api)]] — endpoint `POST /v1/matches/{matchId}/notification` (MTC-13)
- [[UserToken (api)]] — entita token FCM per dispositivo
- [[UserTokenRepository (api)]] — repository token FCM
- [[Subscription (api)]] — entita follow partita o canale (iscrizione notifiche)
- [[SubscriptionRepository (api)]] — recupero token FCM degli iscritti
- [[User (api)]] — navigazione `NotificationTokens` verso UserToken

### Frontend

- [[UserService (web)]] — registrazione token Firebase FCM
- [[ProfilePage (web)]] — configurazione notifiche push

### Data

- [[MatchEventCreated]] — evento che attiva la notifica push

### Workflow

- [[Cronista Telecronaca (workflow)]] — failure point su notifiche non consegnate
- [[Spettatore Partita (workflow)]] — ricezione notifiche evento
- [[Autenticazione Utente (workflow)]] — autenticazione richiesta per follow e token

### Concetti

- [[Utente (concept)]] — token FCM, gestione dispositivi

## Relazioni principali

- Il cronista crea un evento partita → [[MatchService (api)]] chiama `SendNotifications` → [[FirebaseFCM (api)]] invia notifica push ai token degli iscritti
- Lo spettatore si iscrive (follow) a una partita o canale tramite [[Subscription (api)]]
- Il client FE registra il token FCM via `POST /v1/user/notification-token` ([[UserV1Controller (api)]]), persistito in [[UserToken (api)]]
- [[MatchService (api)]] recupera i token FCM degli iscritti tramite [[SubscriptionRepository (api)]]
- I token FCM non validi vengono eliminati su errore `FirebaseMessagingException` con `ErrorCode.InvalidArgument`
- Un utente puo avere piu token FCM (dispositivi multipli) in [[UserToken (api)]]

## Decisioni architetturali

- Invio fire-and-forget: nessuna risposta applicativa dopo la notifica
- Nessun retry esplicito documentato: eccezioni diverse da `InvalidArgument` ignorate silenziosamente
- Follow partita e follow canale condividono la stessa entita [[Subscription (api)]], differenziati da `ChannelId` / `MatchId`
- Payload FCM: `Notification` (title, body), `Data` (`matchId`, `eventId`), `Token`, `WebpushConfig`
- Token FCM salvato in tabella `UserTokens` con relazione molti-a-uno verso `User`

## Rischi

- Notifiche per nuovi commenti: non deducibili dalla wiki ([[CommentAdded]] nota "Meccanismi di notifica push per nuovi commenti non deducibili")
- Dettaglio completo flusso registrazione token FCM lato frontend non deducibile
- Analytics tracking delle consegne notifiche non deducibile
- Rate limiting o policy FCM (quota project, throttle) non deducibili

## Note

Pagina creata da pagine wiki esistenti su FirebaseFCM, MatchService, UserService, UserToken, Subscription, MatchEventCreated, MatchesV1Controller, UserV1Controller e concetti/workflow correlati. Nessun RAW letto.
