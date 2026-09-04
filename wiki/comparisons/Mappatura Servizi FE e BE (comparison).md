---
title: "Mappatura Servizi FE e BE (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Servizi FE e BE (comparison)

## Sintesi

Confronto tra servizi frontend (`web`) e API backend (`api`) di [[Rugby Radio Live (architecture)]], con lo scopo di chiarire il confine FE/BE, identificare i service che chiamano API e quelli che operano solo lato UI, e mostrare il pattern di mappatura.

## Scope

Tutti i servizi frontend documentati in `wiki/frontend/web/services/` e tutti i controller API documentati in `wiki/backend/api/apis/`.

## Mappatura

### Servizi FE con API BE diretta

| Servizio FE | API BE chiamata |
|---|---|
| [[UserService (web)]] | [[AuthV1Controller (api)]], [[UserV1Controller (api)]] |
| [[MatchService (web)]] | [[MatchesV1Controller (api)]], [[MatchEventsV1Controllers (api)]], [[MatchLineupsV1Controller (api)]] |
| [[ChannelService (web)]] | [[ChannelsV1Controller (api)]] |
| [[ChannelUserService (web)]] | [[ChannelUsersV1Controller (api)]] |
| [[TeamService (web)]] | [[TeamsV1Controller (api)]] |
| [[PlayerService (web)]] | [[PlayersV1Controller (api)]] |
| [[LineupService (web)]] | [[MatchLineupsV1Controller (api)]] |
| [[BlogService (web)]] | [[BlogV1Controller (api)]] |
| [[StatsService (web)]] | [[StatsV1Controller (api)]] |
| [[VoiceService (web)]] | [[VoicesV1Controller (api)]] |

### Servizi FE senza API BE diretta

| Servizio FE | Ruolo |
|---|---|
| [[BaseService (web)]] | Classe base HTTP astratta; non chiama API di dominio |
| [[BusService (web)]] | Event bus UI; stato condiviso tra componenti |
| [[ToastService (web)]] | Notifiche toast; solo UI |
| [[AnalyticsService (web)]] | Wrapper Firebase Analytics; SDK nativo |
| [[LoggingService (web)]] | Logger su sessionStorage; solo client |
| [[ErrorHandlerService (web)]] | Persistenza errori su localStorage; solo client |
| [[PlatformService (web)]] | Rilevamento piattaforma; solo client |
| [[LoginCallbackService (web)]] | Gestione redirect post-login; solo client |
| [[AuthGuardService (web)]] | Route guard; solo client |
| [[SeoMetadataService (web)]] | Metadata SEO runtime; aggiorna DOM/head |

### API BE senza FE service diretto

I seguenti controller API backend non hanno un corrispondente service frontend dedicato:

- [[AdminV1Controller (api)]] — pagine admin usano chiamate dirette o non documentate
- [[MatchLineupsV1Controller (api)]] — chiamato da [[MatchService (web)]] e [[LineupService (web)]]
- [[MatchEventsV1Controllers (api)]] — chiamato da [[MatchService (web)]]

## Pattern

- I servizi FE che chiamano API backend estendono [[BaseService (web)]] e condividono logging e gestione errori.
- I servizi FE senza API (UI/infrastruttura) non estendono BaseService e operano solo su DOM, localStorage, sessionStorage o SDK nativi.
- Alcuni servizi FE ([[MatchService (web)]]) aggregano chiamate a piu API BE, mentre la maggior parte ha una corrispondenza 1:1 con un controller API.
- [[LoginCallbackService (web)]] e [[AuthGuardService (web)]] si coordinano indirettamente con [[UserService (web)]] e [[AuthV1Controller (api)]] senza chiamate HTTP dirette.
- [[SeoMetadataService (web)]] aggiorna i metadati SEO runtime; le API backend per SEO ([[SeoUrlInventoryService (api)]]) operano offline via job Hangfire, senza contatto FE diretto.

## Note

La mappatura e dedotta dalle pagine wiki esistenti. I consumer FE effettivi di alcuni controller API (es. [[AdminV1Controller (api)]]) non sono deducibili con certezza dalla wiki. Alcuni service frontend (es. [[BaseService (web)]]) sono classi base e non hanno un corrispondente API BE diretto per definizione.
