---
title: "MatchService (api)"
type: backend-service
layer: backend
---

# MatchService (api)

## Sintesi

Servizio centrale della piattaforma. Gestisce l'intero ciclo di vita delle partite: creazione, aggiornamento, cambio stato, eventi di telecronaca, formazioni, reazioni, commenti, like, votazioni giocatore, notifiche push Firebase, follow, ricerca pubblica, compositing immagini.

## Responsabilità

- CRUD partita e aggiornamento stato (`Scheduled`, `InProgress`, `Halftime`, `FullTime`)
- Aggiunta/eliminazione eventi partita (`MatchEvent`)
- Gestione formazioni: aggiornamento, aggiunta, rimozione ruoli (`LineupPlayer`)
- Like partita, commenti, reazioni evento, votazione giocatore
- Follow partita (iscrizione per notifiche push)
- Invio notifiche push FCM via Firebase (`SendNotifications`)
- Verifica gerarchica ownership (`VerifyAuthAsync`): match → channel → lineup
- Eliminazione commenti vincolata alla partita richiesta: `DeleteCommentAsync(matchId, commentId)` rifiuta commenti appartenenti ad altra partita
- Ricerca pubblica partite
- Compositing immagine partita con tabellino visuale

## Consumer

- [[MatchesV1Controller (api)]]
- [[MatchLineupsV1Controller (api)]]
- `MatchEventsV1Controllers`
- [[RugbyRadioLiveService (api)]]
- [[CreateMatchBlogJob (api)]]
- [[VoiceService (api)]]

## Repository usati

- `IMatchRepository`
- `IMatchEventRepository`
- `ILineupPlayerRepository`
- `ILineupPlayerRateRepository`
- `IChannelRepository`
- `ITeamRepository`
- `IPlayerRepository`
- `ICommentRepository`
- `IEventReactionRepository`
- `IMatchLikeRepository`
- `ISubscriptionRepository`
- [[UserTokenRepository (api)]]
- `ISystemMessageRepository`
- `IUnitOfWork`

## Integrazioni usate

- [[FirebaseFCM (api)]] — notifiche push

## Jobs usati

Nessuno diretto (consumato dai job)

## Entities coinvolte

- [[Match (api)]]
- [[MatchEvent (api)]]
- [[LineupPlayer (api)]]
- [[LineupPlayerRate (api)]]
- [[Comment (api)]]
- [[EventReaction (api)]]
- [[MatchLike (api)]]
- [[Subscription (api)]]

## Workflow correlati

Non deducibile

## Side effects

- Scrittura DB: tutte le entity sopra
- Invio notifiche push FCM
- Scrittura/spostamento file immagine su filesystem
- Eliminazione token FCM non validi

## Nome nel codice

`MatchService` — `src/RugbyRadio/Lib/Repositories/MatchBox/MatchService.cs`

## Note

Servizio più esteso (~2000 righe). Dettaglio completo di `GetMatchAsync` e `UpdateMatchAsync` non verificato integralmente.
