---
title: "AdminV1Controller (api)"
type: backend-api
layer: backend
---

# AdminV1Controller (api)

## Sintesi

Controller amministrativo per la gestione dei messaggi di sistema draft e statistiche. Usa autenticazione custom via query parameter `authKey` (non standard ASP.NET Core). Non usa JWT Bearer.

## Base route

`/v1/admin`

## Endpoints

- GET `/v1/admin/messages/draft` — lista messaggi draft (ADM-01)
- DELETE `/v1/admin/messages/draft/{messageId}` — elimina draft (ADM-02)
- PUT `/v1/admin/messages/draft/{messageId}` — aggiorna draft (ADM-03)
- PUT `/v1/admin/messages/draft/{messageId}/verify` — approva draft (ADM-04)
- GET `/v1/admin/messages/statistics` — statistiche messaggi per tipo evento (ADM-05)

## DTO input

- `MessageDraftItemEditDto` (ADM-03)

## DTO output

- `IList<MessageDraftDto>` / `MessageDraftItemDto` (ADM-01)
- `IList<MessageStatisticsDto>` (ADM-05)

## Backend services usati

Accesso diretto ai repository (nessun service layer intermedio):

- `IMatchRepository`
- `IMatchEventRepository`
- `ISystemMessageRepository`
- `ISystemMessageDraftRepository`
- `IUnitOfWork`

## Regole auth

Autenticazione custom via query parameter `authKey` (valore hardcoded come costante nel controller). Nessun `[Authorize]` ASP.NET Core. Non deducibile dallo schema standard.

## Consumer FE

Non deducibile

## Workflow correlati

- [[Operazioni Amministrative (workflow)]]
- [[Sistema Messaggi Telecronaca AI (concept)]]

## Nome nel codice

`AdminV1Controller` — `src/RugbyRadio/Api/Controllers/AdminV1Controller.cs`

## Note

La chiave `authKey` è hardcoded nel controller. Pattern non standard: tutti gli endpoint admin passano in chiaro la chiave come query parameter.
