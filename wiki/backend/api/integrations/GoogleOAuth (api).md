---
title: "GoogleOAuth (api)"
type: backend-integration
layer: backend
---

# GoogleOAuth (api)

## Sintesi

Integrazione con Google Identity per validazione Google ID Token. Usa `GoogleJsonWebSignature.ValidateAsync` con audience limitata al `ClientId` configurato. Se validazione ok, crea o recupera l'utente corrispondente.

## Provider esterno

Google Identity — libreria `Google.Apis.Auth` (`GoogleJsonWebSignature`)

## Responsabilità

- Validazione Google ID Token ricevuto dall'app
- Estrazione payload: `Email`, `Name`, `Subject`
- Creazione o recupero utente corrispondente

## Services consumer

- [[UserService (api)]]

## Payload rilevanti

- Input: Google ID Token + `ClientId` come audience
- Output: `GoogleJsonWebSignature.Payload` con Email, Name, Subject

## Retry/fallback

Nessuno. Se payload `null` → lancia `NotAuthorized`.

## Side effects

Nessuno diretto (la creazione utente è operazione interna DB nel chiamante)

## Configurazioni

- `Providers:Google:ClientId` — in `appsettings.json`

## Classe responsabile

`UserService` — `src/RugbyRadio/Lib/Repositories/UserBox/UserService.cs`
