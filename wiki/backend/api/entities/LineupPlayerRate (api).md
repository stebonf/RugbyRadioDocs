---
title: "LineupPlayerRate (api)"
type: backend-entity
layer: backend
---

# LineupPlayerRate (api)

## Sintesi

Rappresenta il voto assegnato da un utente a un giocatore in formazione per una partita. Permette di tracciare chi ha votato quale giocatore.

## Proprietà

- `Id` (`string`) — max 20 caratteri
- `LineupPlayerId` (`string?`) — FK verso `LineupPlayer`
- `UserId` (`string?`) — FK verso `User`
- `Rate` (`int`) — voto, NotNull
- `IsDeleted`, `Ts` (da EntityBase)

## Relazioni entity

- `LineupPlayer` — molti-a-uno → FK `LineupPlayerId`
- `User` — molti-a-uno → FK `UserId`

## Repository correlati

- [[LineupPlayerRateRepository (api)]]

## Services correlati

- [[MatchService (api)]]

## Workflow correlati

Non deducibile

## Tabella DB

`[Table("LineupPlayerRates")]`

## Note

Il validator contiene la regola `Id` duplicata tre volte (probabile errore copy-paste nel codice sorgente).

## Nome nel codice

`LineupPlayerRate` — `src/RugbyRadio/Lib/Repositories/LineupPlayerRateBox/LineupPlayerRate.cs`
