---
title: "Mappatura Repository e Persistenza (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Repository e Persistenza (comparison)

## Sintesi

Mappa i principali repository backend, il contesto EF e le aree di persistenza note. La wiki mostra un modello repository-per-area con [[AppDbContext (api)]] come radice dati e servizi backend che orchestrano query, scritture e side effect.

## Scope

La pagina confronta repository e persistenza a livello architetturale usando solo repository, servizi ed entity gia documentati.

## Persistenza centrale

[[AppDbContext (api)]] espone DbSet per utenti, canali, team, giocatori, partite, eventi, lineup, commenti, reazioni, subscription, voti lineup, like, token utente, blog, OTP, email, system message, audit e fake agent settings. Gestisce conversioni enum e compressione dell'audit.

## Repository principali

| Repository | Area dati | Consumer principali | Note |
|---|---|---|---|
| [[UserRepository (api)]] | Utenti, lookup account, utenti senza canale training | [[UserService (api)]], [[CreateTrainingChannelJob (api)]] | Base del ciclo account e delle query utente. |
| [[ChannelRepository (api)]] | Canali, ownership, ricerca pubblica | [[ChannelService (api)]] | Include lookup per `PublicId` e query per owner/co-owner. |
| [[MatchRepository (api)]] | Partite, eventi, lineup e dati correlati | [[MatchService (api)]], [[CreateMatchBlogJob (api)]], [[CreateMatchBlogHtmlJob (api)]], [[RepairMatchImageJob (api)]], [[AiOllamaService (api)]] | Repository ad alta centralita, con include complessi e query su partite concluse senza blog. |
| [[BlogRepository (api)]] | Blog generati e query contenuti | [[BlogService (api)]], [[AiOllamaService (api)]], [[SeoUrlInventoryService (api)]] | Ponte tra partita, contenuti AI, staticizzazione e SEO. |
| [[UserTokenRepository (api)]] | Token FCM utente | [[UserService (api)]], [[MatchService (api)]] | Supporta notifiche push e pulizia token non validi. |
| [[UserOtpCodeRepository (api)]] | Codici OTP reset password | [[UserService (api)]] | Supporta il reset password OTP con scadenza documentata in [[Utente (concept)]]. |

## Relazioni con i servizi

- [[UserService (api)]] usa repository utente, token, OTP, canali, subscription e unit of work per ciclo account, profilo e notifiche.
- [[ChannelService (api)]] usa repository canali e relazioni di ownership per gestione canale e co-proprieta.
- [[MatchService (api)]] coordina partita, interazioni, notifiche e dati di dominio rugby.
- [[BlogService (api)]] collega persistenza blog e pubblicazione contenuti.

## Aggregati di dominio

| Aggregato | Entity/pagine collegate | Persistenza |
|---|---|---|
| Utente | [[User (api)]], [[UserToken (api)]], [[UserOtpCode (api)]] | Account, token JWT/FCM, OTP e preferenze. |
| Canale | [[Channel (api)]], [[ChannelUser (api)]] | Canali radio, owner, co-owner e visibilita pubblica. |
| Partita | [[Match (api)]], [[MatchEvent (api)]], [[LineupPlayer (api)]] | Match, eventi, lineup, stato e telecronaca. |
| Interazioni | [[Comment (api)]], [[EventReaction (api)]], [[MatchLike (api)]], [[Subscription (api)]], [[LineupPlayerRate (api)]] | Commenti, reazioni, like, follow e voti. |
| Contenuti | [[Blog (api)]], [[SystemMessage (api)]], [[SystemMessageDraft (api)]] | Blog generati, messaggi AI e bozze. |

## Gap noti

- La copertura completa di tutti i repository minori non e ricostruita in questa pagina.
- Le transazioni effettive e i confini di `IUnitOfWork` non sono deducibili in modo completo.
- Indici database, vincoli univoci e migrazioni non sono descritti nelle pagine lette.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`. Non sono state lette fonti RAW.
