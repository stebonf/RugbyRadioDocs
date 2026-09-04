---
title: "Interazione (concept)"
type: concept
layer: concept
---

# Interazione (concept)

## Sintesi

Insieme delle azioni che uno spettatore puo compiere su una partita: commentare eventi, reagire con emoji, mettere like, seguire canali o partite e votare giocatori.

## Scope

L'interazione spettatore-comprende:

- commenti testuali su eventi partita tramite [[Comment (api)]];
- reazioni emoji su eventi partita tramite [[EventReaction (api)]] (evento [[ReactionAdded]]);
- like su partite tramite [[MatchLike (api)]];
- follow (sottoscrizione) a canali e partite tramite [[Subscription (api)]];
- voti giocatori tramite [[LineupPlayerRate (api)]].

## Componenti coinvolti

- [[Spettatore (actor)]]
- [[Comment (api)]]
- [[EventReaction (api)]]
- [[MatchLike (api)]]
- [[Subscription (api)]]
- [[LineupPlayerRate (api)]]
- [[MatchService (api)]]
- [[MatchEventsComponent (web)]]
- [[GMatchEventsComponent (web)]]
- [[GMatchPage (web)]]
- [[MatchPage (web)]]
- [[FavoritesPage (web)]]
- [[MatchService (web)]]
- [[UserService (web)]]
- [[LoginCallbackService (web)]]
- [[AuthGuardService (web)]]

## Relazioni principali

- Lo spettatore commenta un evento tramite [[MatchEventsComponent (web)]] in modalita pubblica o edit.
- Lo spettatore reagisce con emoji a un evento tramite [[MatchEventsComponent (web)]], con ReactionType memorizzato come stringa libera.
- Lo spettatore mette like a una partita tramite [[GMatchPage (web)]] o [[GMatchEventsComponent (web)]]; l'evento `like` e propagato verso il parent.
- Lo spettatore segue un canale tramite [[FavoritesPage (web)]] o [[GMatchPage (web)]]; l'evento `follow` e propagato da [[GMatchEventsComponent (web)]].
- Lo spettatore vota i giocatori di una partita; i dettagli UI non sono deducibili dalle pagine wiki disponibili.
- [[MatchService (api)]] orchestra le scritture per tutte le entita di interazione (Comment, EventReaction, MatchLike, Subscription).
- Like, follow, commenti e reazioni richiedono account utente: [[LoginCallbackService (web)]] gestisce il reindirizzamento al login, mentre [[AuthGuardService (web)]] protegge le pagine di admin/edit.
- Le interazioni in lettura (visualizzazione eventi, commenti, reazioni) sono pubbliche e non richiedono autenticazione.

## Decisioni architetturali

- Ogni forma di interazione ha una propria entita nel database, con tabella dedicata (Comments, EventReactions, MatchLikes, Subscriptions).
- Follow canale e follow partita condividono la stessa entita [[Subscription (api)]], differenziata dal FK (ChannelId vs MatchId).
- Le reazioni emoji usano ReactionType come stringa libera; i valori ammessi non sono deducibili dal codice entity.
- I commenti sono testuali e associati a un evento specifico tramite EventId, oppure a una partita tramite MatchId.
- Il voto giocatore ([[LineupPlayerRate (api)]]) e un'interazione separata, con Repository e Service dedicati.

## Rischi

- Vincoli esatti di validazione (limite commenti per evento, emoji consentite, like duplicati, voto singolo per utente) non deducibili dalla wiki.
- Frequenza e meccanismi di aggiornamento in tempo reale delle interazioni (polling, SignalR, refresh) non deducibili.
- Relazioni tra interazioni e analytics tracking ([[AnalyticsService (web)]]) non deducibili dalle pagine wiki.
- Dettagli di moderazione contenuti (cancellazione commenti, segnalazione abusi) non deducibili.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`. Le entita backend, i componenti frontend e i servizi coinvolti sono documentati nelle rispettive pagine canoniche. I dettagli implementativi specifici (validazione, polling, moderazione) non sono ricostruibili dalla wiki attuale.
