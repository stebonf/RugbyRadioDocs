---
title: "UserTokenRepository (api)"
type: backend-repository
layer: backend
---

# UserTokenRepository (api)

## Sintesi

Repository per la persistenza dei token FCM associati agli utenti.

## Responsabilità

- Gestire la persistenza di [[UserToken (api)]].
- Supportare il salvataggio dei token notifiche push in [[UserService (api)]].
- Supportare l'uso dei token FCM nei flussi partita gestiti da [[MatchService (api)]].

## Entities gestite

- [[UserToken (api)]]

## Query rilevanti

Non deducibile dalla wiki attuale.

## Consumer

- [[UserService (api)]]
- [[MatchService (api)]]

## Nome nel codice

`UserTokenRepository` / `IUserTokenRepository`

## Note

Pagina creata da riferimenti gia presenti nella wiki; dettagli implementativi non deducibili dalla wiki attuale.
