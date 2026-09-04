---
title: "UserOtpCode (api)"
type: backend-entity
layer: backend
---

# UserOtpCode (api)

## Sintesi

Rappresenta un codice OTP temporaneo per il reset password. Contiene il codice numerico a 6 cifre, la scadenza (1 ora) e un flag di utilizzo.

## Proprietà

- `Id` (`string`) — max 20 caratteri
- `UserId` (`string`) — FK verso `User`, NotNull MaxLength 20
- `OtpCode` (`int`) — 6 cifre, generato con `Random().Next(100000, 999999)`
- `Expiration` (`DateTime`) — scadenza a +1 ora dalla generazione
- `IsUsed` (`bool`) — `true` dopo il cambio password
- `IsDeleted`, `Ts` (da EntityBase)

## Relazioni entity

Nessuna navigation property esplicita

## Repository correlati

- [[UserOtpCodeRepository (api)]]

## Services correlati

- [[UserService (api)]]

## Workflow correlati

- [[Autenticazione Utente (workflow)]]

## Tabella DB

`[Table("UserOtpCodes")]` — DbSet ha typo `UserOptCodes` nel codice

## Nome nel codice

`UserOtpCode` — `src/RugbyRadio/Lib/Repositories/UserOtpCodeBox/UserOtpCode.cs`
