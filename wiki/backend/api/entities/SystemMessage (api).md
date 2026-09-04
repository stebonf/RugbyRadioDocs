---
title: "SystemMessage (api)"
type: backend-entity
layer: backend
---

# SystemMessage (api)

## Sintesi

Tabella dei messaggi di sistema localizzati usati nella telecronaca automatica. Ogni record ha un codice (es. `MatchEventType-300`), lingua, versione, testo maschile/femminile e flag per messaggi che includono il nome del giocatore.

## Proprietà

- `Id` (`string`)
- `Code` (`string?`) — codice identificativo (es. `MatchEventType-300`)
- `Language` (`string?`) — IT, EN, FR, ES, JA
- `FlagPlayer` (`bool?`) — `true` se il testo include il nome del giocatore
- `Message` (`string?`) — testo maschile
- `MessageFemale` (`string?`) — testo femminile
- `Version` (`int?`)
- `IsDeleted`, `Ts` (da EntityBase)

## Relazioni entity

Nessuna

## Repository correlati

- [[SystemMessageRepository (api)]]

## Services correlati

- [[SystemMessageService (api)]]
- [[VoiceService (api)]]

## Workflow correlati

- [[Sistema Messaggi Telecronaca AI (concept)]]

## Tabella DB

`[Table("SystemMessages")]`

## Note

Validator senza regole (tabella di sistema, validazione disabilitata).

## Nome nel codice

`SystemMessage` — `src/RugbyRadio/Lib/Repositories/SystemMessageBox/SystemMessage.cs`
