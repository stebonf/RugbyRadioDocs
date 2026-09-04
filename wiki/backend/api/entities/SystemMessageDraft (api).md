---
title: "SystemMessageDraft (api)"
type: backend-entity
layer: backend
---

# SystemMessageDraft (api)

## Sintesi

Tabella di staging per i messaggi di sistema in attesa di approvazione. Stessi campi di `SystemMessage` più campi per il processo di revisione: `GroupId`, percentuali di verifica e flag `IsVerified`.

## Proprietà

- `Id` (`string`)
- `Code`, `Language`, `FlagPlayer`, `Message` (come SystemMessage)
- `GroupId` (`string`) — raggruppamento logico, NotNull
- `VerifyValue` (`int`) — percentuale verifica contenuto
- `VerifyLanguageValue` (`int`) — percentuale verifica lingua
- `Version` (`int?`)
- `IsVerified` (`bool`) — `true` se approvato
- `IsDeleted`, `Ts` (da EntityBase)

## Relazioni entity

Nessuna

## Repository correlati

- `SystemMessageDraftRepository`

## Services correlati

- [[SystemMessageService (api)]]
- [[AdminV1Controller (api)]] — accesso diretto dal controller

## Workflow correlati

- [[Sistema Messaggi Telecronaca AI (concept)]]

## Tabella DB

`[Table("SystemMessagesDraft")]`

## Nome nel codice

`SystemMessageDraft` — `src/RugbyRadio/Lib/Repositories/SystemMessageDraftBox/SystemMessageDraft.cs`
