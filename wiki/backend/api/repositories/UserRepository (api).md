---
title: "UserRepository (api)"
type: backend-repository
layer: backend
---

# UserRepository (api)

## Sintesi

Repository per la gestione della persistenza degli utenti. Estende `Repository<User>`. Espone query specifiche per login, attivazione, ricerca per email e token.

## Responsabilità

- Lookup utente per email (case-insensitive), token attivazione, credenziali login
- Ricerca utenti senza canale training

## Entities gestite

- [[User (api)]]

## Query rilevanti

- `GetByEmailAsync(email)` — filtra su `Email == email.ToLower() && !IsDeleted`
- `GetByTokenAsync(token)` — filtra su `ActivationToken == token && !IsDeleted`
- `GetByLoginAsync(email, password)` — filtra su email, password, `IsActive && !IsDeleted`
- `FindWithoutTrainingChannelAsync()` — utenti i cui canali sono tutti non di test

## Consumer

- [[UserService (api)]]
- [[CreateTrainingChannelJob (api)]]

## Nome nel codice

`UserRepository` — `src/RugbyRadio/Lib/Repositories/UserBox/UserRepository.cs`
