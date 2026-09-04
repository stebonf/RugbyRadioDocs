---
title: "EntityBase (api)"
type: backend-entity
layer: backend
---

# EntityBase (api)

## Sintesi

Classe base comune a tutte le entity persistenti. Fornisce chiave primaria (`Id`, 20 char, generata dal repository base), flag soft-delete (`IsDeleted`) e timestamp (`Ts`).

## Proprietà

- `Id` (`string`) — chiave primaria, max 20 caratteri, generata come datetime UTC + GUID uppercase
- `IsDeleted` (`bool`) — soft-delete, default `false`
- `Ts` (`DateTime`) — timestamp creazione/ultima modifica, aggiornato automaticamente

## Relazioni entity

Nessuna diretta (classe base)

## Repository correlati

- `Repository<T>` — repository base generico

## Services correlati

Non deducibile a livello base

## Workflow correlati

Non deducibile

## Nome nel codice

`EntityBase` — `src/RugbyRadio/Lib/Core/Entities/EntityBase.cs`
