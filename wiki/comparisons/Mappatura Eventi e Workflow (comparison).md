---
title: "Mappatura Eventi e Workflow (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Eventi e Workflow (comparison)

## Sintesi

Confronto tra data-event, workflow e concetti di dominio documentati nella wiki, con lo scopo di chiarire quali eventi applicativi alimentano la telecronaca, il ciclo di vita partita e le interazioni dello spettatore.

## Scope

Include i data-event presenti in `wiki/data/events/` e i workflow collegati dalle rispettive sezioni "Workflow correlati". Non include eventi analytics, eventi tecnici non formalizzati come data-event o side effect citati solo come dettaglio dei job.

## Mappatura

### Eventi di telecronaca e ciclo partita

| Data event | Trigger principale | Workflow correlati | Attore prevalente | Note |
|---|---|---|---|---|
| [[MatchEventCreated]] | Creazione evento partita tramite [[MatchEventsV1Controllers (api)]] | [[Cronista Telecronaca (workflow)]], [[Spettatore Partita (workflow)]] | [[Cronista (actor)]] | Attiva notifica push e generazione asincrona bozze AI tramite [[CreateMatchEventJob (api)]]. |
| [[MatchStatusChanged]] | Cambio stato partita tramite [[MatchesV1Controller (api)]] | [[Cronista Telecronaca (workflow)]], [[Spettatore Partita (workflow)]] | [[Cronista (actor)]] | Collega stati Scheduled, InProgress, Halftime e FullTime a visibilita pubblica e automazioni post-partita. |

### Eventi di interazione spettatore

| Data event | Trigger principale | Workflow correlati | Entita persistente | Note |
|---|---|---|---|---|
| [[CommentAdded]] | Commento su partita o evento tramite [[MatchesV1Controller (api)]] | [[Spettatore Partita (workflow)]], [[Autenticazione Utente (workflow)]] | [[Comment (api)]] | Richiede utente autenticato; il commento puo riferirsi a un evento o alla partita. |
| [[ReactionAdded]] | Reazione emoji a evento tramite [[MatchesV1Controller (api)]] | [[Spettatore Partita (workflow)]] | [[EventReaction (api)]] | Richiede utente autenticato; valori ammessi di `ReactionType` non deducibili. |
| [[MatchLiked]] | Toggle like partita tramite [[MatchesV1Controller (api)]] | [[Spettatore Partita (workflow)]] | [[MatchLike (api)]] | Usa soft-delete per unlike; aggiorna conteggi aggregati esposti sul canale. |
| [[LineupPlayerRated]] | Voto giocatore tramite [[MatchesV1Controller (api)]] | [[Spettatore Partita (workflow)]] | [[LineupPlayerRate (api)]] | Attivo a fine partita secondo [[Squadra (concept)]]. |
| [[SubscriptionChanged]] | Follow/unfollow partita o canale tramite [[MatchesV1Controller (api)]] e [[ChannelsV1Controller (api)]] | [[Spettatore Partita (workflow)]] | [[Subscription (api)]] | La stessa entita copre follow canale e follow partita. |

## Pattern

- [[Cronista Telecronaca (workflow)]] produce eventi che cambiano il racconto della partita: creazione evento e cambio stato.
- [[Spettatore Partita (workflow)]] consuma eventi di telecronaca e produce interazioni sociali leggere: commenti, reazioni, like, follow e voti.
- [[Autenticazione Utente (workflow)]] e prerequisito esplicito per commenti e richiamato come prerequisito nelle note degli eventi di interazione.
- [[Interazione (concept)]] raccoglie gli eventi spettatore basati su entita dedicate: [[Comment (api)]], [[EventReaction (api)]], [[MatchLike (api)]], [[Subscription (api)]] e [[LineupPlayerRate (api)]].
- [[Ciclo di Vita Partita (concept)]] fornisce il contesto temporale per [[MatchStatusChanged]] e per le interazioni disponibili durante o dopo la partita.

## Gap noti

- Analytics tracking dei singoli data-event non deducibile dalla wiki.
- Meccanismi realtime completi per aggiornare la UI dopo le interazioni non deducibili.
- Vincoli esatti di validazione, rate limiting, moderazione e concorrenza non deducibili.
- Non risultano formalizzati come data-event separati gli eventi tecnici dei job post-FullTime.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`: data-event esistenti, workflow correlati, [[Interazione (concept)]], [[Ciclo di Vita Partita (concept)]] e pagine entity/API linkate dai data-event. Nessun RAW letto.
