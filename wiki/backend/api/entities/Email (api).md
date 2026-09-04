---
title: "Email (api)"
type: backend-entity
layer: backend
---

# Email (api)

## Sintesi

Rappresenta un'email da inviare o già inviata. Usata per il tracking degli invii transazionali. Contiene stato (`Pending`, `Sent`, `Failed`) e contatore tentativi.

## Proprietà

- `Id` (`string`) — max 20 caratteri
- `UserId` (`string`) — FK verso `User`, NotEmpty MaxLength 20
- `Subject` (`string`) — NotEmpty MaxLength 100
- `Body` (`string`) — NotEmpty
- `Status` (`EmailStatus`) — `Pending=10`, `Sent=20`, `Failed=30`
- `Retry` (`int`) — contatore tentativi, ≥ 0
- `IsDeleted`, `Ts` (da EntityBase)

## Relazioni entity

Nessuna

## Repository correlati

- `EmailRepository`

## Services correlati

- [[EmailService (api)]]

## Workflow correlati

Non deducibile

## Tabella DB

`[Table("Emails")]`

## Nome nel codice

`Email` — `src/RugbyRadio/Lib/Repositories/EmailBox/Email.cs`
