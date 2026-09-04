---
title: "FirebaseFCM (api)"
type: backend-integration
layer: backend
---

# FirebaseFCM (api)

## Sintesi

Integrazione con Firebase Cloud Messaging per notifiche push. Inizializzata in `Program.cs` tramite `FirebaseApp.Create` con credenziali da file `FirebaseKey.json`. Invio in `MatchService.SendNotifications`.

## Provider esterno

Google Firebase Cloud Messaging — SDK `FirebaseAdmin`

## Responsabilità

- Invio notifiche push a singoli device token FCM
- Eliminazione token non validi dal DB in caso di `InvalidArgument`

## Services consumer

- [[MatchService (api)]]

## Payload rilevanti

- `Message` FCM: `Notification` (title, body), `Data` (`matchId`, `eventId`), `Token`, `WebpushConfig`
- Fire-and-forget: nessuna risposta applicativa

## Retry/fallback

Nessun retry esplicito. `FirebaseMessagingException` con `ErrorCode.InvalidArgument` → eliminazione token dal DB. Altre eccezioni ignorate silenziosamente.

## Side effects

- Invio notifica push FCM
- Eliminazione token FCM non validi da `UserToken`

## Configurazioni

- `FirebaseKey.json` — file credenziali Google Service Account; path: `src/RugbyRadio/Api/FirebaseKey.json`

## Classe responsabile

`MatchService` — `src/RugbyRadio/Lib/Repositories/MatchBox/MatchService.cs`

## Note

Non deducibile
