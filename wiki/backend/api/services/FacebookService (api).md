---
title: "FacebookService (api)"
type: backend-service
layer: backend
---

# FacebookService (api)

## Sintesi

Client per la Facebook Graph API. Gestisce scambio token (short-lived → long-lived), recupero info utente e pagine, pubblicazione post con immagine, revoca permessi OAuth.

## Responsabilità

- `GetAccessTokenAsync` — scambio token OAuth
- `GetUserInfoAsync` — recupero profilo utente Facebook
- `GetPagesAsync` — lista pagine Facebook dell'utente
- `PostAsync` — pubblica post con immagine su pagina Facebook (form-encoded)
- `RevokePermissionsAsync` — revoca permessi OAuth
- `ShouldRefreshToken` — verifica se il token è prossimo alla scadenza

## Consumer

- [[FacebookJob (api)]]

## Repository usati

Nessuno diretto

## Integrazioni usate

- [[FacebookGraphAPI (api)]]
- [[HttpClientService (api)]] — client HTTP generico (RestSharp)

## Jobs usati

Nessuno diretto (è chiamato dai job)

## Entities coinvolte

Nessuna diretta (le entità DB sono gestite dal chiamante)

## Workflow correlati

Non deducibile

## Side effects

- Chiamate HTTP esterne a Facebook Graph API
- Pubblicazione post su pagina Facebook

## Nome nel codice

`FacebookService` — `src/RugbyRadio/Lib/Services/FacebookService.cs`

## Note

Non deducibile dai RAW disponibili.
