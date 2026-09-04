---
title: "Co-proprietà (concept)"
type: concept
layer: concept
---

# Co-proprietà (concept)

## Sintesi

Modello di proprietà condivisa dei canali di telecronaca, basato su due ruoli: owner primario (proprietario) e co-owner (co-editor). L'owner primario ha accesso completo, inclusa la gestione dei giocatori; il co-owner puo gestire squadre, partite e contenuti ma non l'anagrafica giocatori. Entrambi i ruoli sono verificati da `VerifyAuthAsync` nei servizi backend.

## Ruoli

### Owner primario

- `UserId` su [[Channel (api)]] — FK diretta verso `User`
- Accesso completo: modifica canale, layout, editor, squadre, partite, giocatori
- Gestisce i co-owner (aggiunta/rimozione tramite [[ChannelUsersV1Controller (api)]])
- Verificato da `channel.UserId == userId` in [[PlayerService (api)]]

### Co-owner (co-editor)

- Record [[ChannelUser (api)]] — associazione `ChannelId` + `UserId`
- Gestito via [[ChannelUsersV1Controller (api)]]: GET lista (CUS-01), POST aggiunta per email (CUS-02), DELETE rimozione (CUS-03)
- Può gestire squadre ([[TeamService (api)]]: "owner primario o co-owner")
- Può gestire partite e formazioni ([[MatchService (api)]]: verifica gerarchica match → canale)
- **Non può** gestire giocatori ([[PlayerService (api)]]: solo `channel.UserId`)
- `Channel.IsOwner(userId)` interroga sia la FK primaria sia [[ChannelUser (api)]] per autorizzazione

## Componenti coinvolti

### Backend

- [[Channel (api)]] — entità canale con FK owner primario e navigazione `Owners`
- [[ChannelUser (api)]] — entità associazione co-owner
- [[ChannelService (api)]] — `VerifyAuthAsync` per entrambi i ruoli, CRUD co-editor
- [[ChannelRepository (api)]] — `GetByPublicIdIncludeAsync` include `Owners`; `FindByUserAsync` per entrambi i ruoli
- [[ChannelUsersV1Controller (api)]] — gestione co-editor via API
- [[PlayerService (api)]] — verifica solo owner primario
- [[TeamService (api)]] — verifica owner primario o co-owner
- [[MatchService (api)]] — verifica gerarchica match → canale

### Frontend

- [[ChannelPage (web)]] — tab `Editors` per gestione co-editor
- [[ChannelsPage (web)]] — lista canali dove l'utente è owner o co-editor
- [[ChannelUserService (web)]] — API client FE per gestione co-editor

### Workflow

- [[Gestione Canale (workflow)]] — verifica ownership nel ciclo di vita del canale

### Concetti correlati

- [[Radio Canale (concept)]] — entità di dominio di cui si possiede la proprietà
- [[Cronista (actor)]] — attore che possiede canali e assegna co-owner
- [[Squadra (concept)]] — documento la distinzione owner/co-owner per gestione squadre
- [[Utente (concept)]] — soggetto della proprietà
- [[Ciclo di Vita Partita (concept)]] — riferisce controlli ownership

## Regole di autorizzazione

| Azione | Owner primario | Co-owner |
|--------|---------------|----------|
| Modificare canale (nome, layout) | ✅ | ❌ |
| Gestire co-editor (aggiungere/rimuovere) | ✅ | ❌ |
| Gestire squadre | ✅ | ✅ |
| Gestire partite e formazioni | ✅ | ✅ |
| Gestire giocatori (creare/aggiornare/eliminare) | ✅ | ❌ |
| Eliminare canale | ✅ | ❌ |

## Decisioni architetturali

- `VerifyAuthAsync` implementato a livello di servizio, non di controller: ogni servizio decide quali ruoli ammettere
- [[PlayerService (api)]] e [[TeamService (api)]] hanno policy diverse nonostante operino sullo stesso canale
- La gerarchia di verifica in [[MatchService (api)]] risale da match a canale, consentendo al co-owner di operare su partite del canale
- [[ChannelRepository (api)]] include `Owners` nelle query per evitare N+1 nella verifica co-ownership

## Gap noti

- `ChannelUserAddDto` e `ChannelUserDto` non hanno pagine dedicate nella wiki
- Criteri di promozione da co-owner a owner primario non deducibili
- Limite massimo di co-owner per canale non deducibile
- Flusso di invito (notifica via email all'aggiunta) non deducibile dalla wiki
- Audit trail delle modifiche alla lista co-owner non deducibile
- Gestione conflitti in caso di modifiche concorrenti tra co-owner non deducibile
