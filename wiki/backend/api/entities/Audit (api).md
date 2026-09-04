---
title: "Audit (api)"
type: backend-entity
layer: backend
---

# Audit (api)

## Sintesi

Log di audit di ogni richiesta HTTP. Contiene metodo, path, corpo richiesta e risposta (compressi con Zip), status code, tempo risposta, user ID, lingua e nome operazione interno.

## Proprietà

- `Id` (`string`) — max 20 caratteri
- `ResponseTime` (`long?`) — ms
- `ResponseStatus` (`int?`) — HTTP status code
- `UserLanguage` (`string?`) — da header `X-USER-LANGUAGE`
- `CommentaryLanguage` (`string?`) — da header `X-COMMENTARY-LANGUAGE`
- `RequestPath`, `RequestMethod`, `RequestInternalName` (`string?`)
- `RequestSerialized`, `ResponseSerialized` (`string?`) — corpi compressi
- `UserId` (`string?`) — null se anonimo
- `Message`, `LongMessage` (`string?`) — errore / stack trace
- `IsDeleted`, `Ts` (da EntityBase)

## Relazioni entity

Nessuna

## Repository correlati

- `AuditRepository`

## Services correlati

- [[AuditMiddleware (api)]]

## Workflow correlati

Non deducibile

## Tabella DB

Attributo `[Table]` assente. Probabile `Audits` per convenzione EF Core.

## Nome nel codice

`Audit` — `src/RugbyRadio/Lib/Repositories/AuditBox/Audit.cs`
