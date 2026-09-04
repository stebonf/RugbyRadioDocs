---
title: "Mappatura Sicurezza e Superfici Protette (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Sicurezza e Superfici Protette (comparison)

## Sintesi

Confronto tra meccanismi di sicurezza, superfici pubbliche, superfici autenticate e superfici amministrative documentate nella wiki.

## Scope

Include le pagine backend security, i controller API con regole auth esplicite, i workflow di autenticazione e amministrazione, e il modello di co-proprietà canale. Non include endpoint o policy non documentati nella wiki.

## Mappatura

### Meccanismi trasversali

| Meccanismo | Ambito | Note |
|---|---|---|
| [[JwtBearerAuthentication (api)]] | API con `[Authorize]` | Usa JWT Bearer con header `Authorization` o cookie `Authentication`; non esiste policy globale `RequireAuthorization()` documentata. |
| [[SecuritySettings (api)]] | Configurazione JWT | Mappa issuer, audience, secret key e scadenza token. |
| [[CorsPolicy (api)]] | Tutti gli endpoint API | Policy `AllowAllOrigins`, `AllowAnyHeader`, `AllowAnyMethod`. |
| [[AuditMiddleware (api)]] | Richieste HTTP API | Registra richieste e risposte su [[Audit (api)]] senza bloccare l'esecuzione applicativa. |

### Superfici pubbliche

| Superficie | Regola documentata | Consumer o workflow |
|---|---|---|
| [[AuthV1Controller (api)]] | Endpoint pubblici per registrazione, login, Google OAuth, attivazione e reset password. | [[Autenticazione Utente (workflow)]] |
| Endpoint pubblici di [[MatchesV1Controller (api)]] | `/v1/matches/public` e `/v1/matches/{matchId}/image` accessibili senza token. | [[Spettatore Partita (workflow)]] |
| Endpoint pubblici di [[ChannelsV1Controller (api)]] | `/public` e `/search` accessibili senza token. | [[Gestione Canale (workflow)]], [[Spettatore Partita (workflow)]] |

### Superfici autenticate utente

| Superficie | Regola documentata | Attori |
|---|---|---|
| [[UserV1Controller (api)]] | Profilo, modifica profilo, cancellazione account, token notifiche e feedback richiedono `[Authorize]`; avatar pubblici. | [[Cronista (actor)]], [[Spettatore (actor)]] |
| Endpoint gestione di [[MatchesV1Controller (api)]] | Gestione partita, notifiche e upload immagine richiedono autenticazione; alcuni endpoint verificano autorizzazione sulla partita o sul canale. | [[Cronista (actor)]], [[Spettatore (actor)]] |
| Endpoint gestione di [[ChannelsV1Controller (api)]] | Gestione canale richiede autenticazione e verifica ownership tramite `VerifyAuthAsync`. | [[Cronista (actor)]] |

### Superfici amministrative e operative

| Superficie | Regola documentata | Note |
|---|---|---|
| [[AdminV1Controller (api)]] | Usa `authKey` query parameter hardcoded; non usa JWT Bearer. | Collegato a [[Operazioni Amministrative (workflow)]]. |
| [[HangfireDashboard (api)]] | Regole auth non deducibili dalla wiki. | Superficie operativa per job Hangfire. |
| [[AdminMaintenancePage (web)]] | Dipende da flag `environment.maintenance`, non da API runtime documentata. | Citata in [[Operazioni Amministrative (workflow)]]. |

## Pattern

- Le API pubbliche espongono registrazione/login e contenuti pubblici di match/canali.
- Le API utente usano `[Authorize]` e sono collegate a [[Autenticazione Utente (workflow)]].
- La proprietà canale non è solo JWT: [[Co-proprietà (concept)]] documenta verifiche di owner primario e co-owner a livello di servizi backend.
- Le superfici amministrative sono eterogenee: [[AdminV1Controller (api)]] usa `authKey`, [[HangfireDashboard (api)]] non ha policy deducibile, [[AdminMaintenancePage (web)]] usa configurazione frontend.
- [[AuditMiddleware (api)]] osserva le richieste ma non è un meccanismo di autorizzazione.

## Gap noti

- Policy autorizzative complete di [[HangfireDashboard (api)]] non deducibili.
- Validazioni esatte di password, OTP, rate limiting e lockout non deducibili.
- Copertura completa `[Authorize]` per ogni endpoint non deducibile oltre quanto riportato nelle pagine controller.
- Gestione audit trail delle modifiche ai co-owner non deducibile.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`: pagine backend security, controller API, workflow, attori e [[Co-proprietà (concept)]]. Nessun RAW letto.
