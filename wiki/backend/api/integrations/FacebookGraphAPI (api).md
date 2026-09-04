---
title: "FacebookGraphAPI (api)"
type: backend-integration
layer: backend
---

# FacebookGraphAPI (api)

## Sintesi

Integrazione con Facebook Graph API. Gestisce scambio token OAuth, info utente, recupero pagine, pubblicazione post con immagine su pagina Facebook, revoca permessi.

## Provider esterno

Meta / Facebook — Graph API v{versione configurata}

## Responsabilità

- Scambio token short-lived → long-lived (`/oauth/access_token`)
- Recupero info utente (`/me`)
- Verifica token (`/debug_token`)
- Lista pagine Facebook (`/me/accounts`)
- Pubblicazione post con immagine (`/{pageId}/photos` form-encoded)
- Revoca permessi OAuth (`DELETE /me/permissions`)

## Services consumer

- [[FacebookService (api)]]

## Payload rilevanti

- POST `/{pageId}/photos`: form-encoded con `access_token`, `message`, `url` (URL immagine)
- GET `/me?fields=id,name,email,picture`

## Retry/fallback

Nessuno esplicito nei metodi.

## Side effects

- Pubblicazione post su pagina Facebook

## Configurazioni

- `Meta:FbAppId`, `Meta:FbAppSecret`, `Meta:FbApiUrl`, `Meta:FbAccessToken` — sensibili, non in `appsettings.json` principale
- `Meta:FbAccessTokenRefreshThreshold` — soglia refresh token

## Classe responsabile

`FacebookService` — `src/RugbyRadio/Lib/Services/FacebookService.cs`
