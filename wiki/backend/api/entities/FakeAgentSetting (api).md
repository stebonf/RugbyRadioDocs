---
title: "FakeAgentSetting (api)"
type: backend-entity
layer: backend
---

# FakeAgentSetting (api)

## Sintesi

Configurazione per un agente simulatore di partite (Fake Agent). Contiene parametri per la generazione automatica di partite simulate: anno/mese, canale base, squadra principale, lingua, limiti di generazione e data prossima partita.

## Proprietà

- `Id` (`string`) — max 20 caratteri
- `Year`, `Month` (`int`)
- `ChannelId` (`string`) — FK verso `Channel`, NotNull
- `MainTeamId` (`string`) — FK verso `Team`, NotNull
- `Language` (`string`) — NotNull
- `MaxTeams`, `MaxMatches` (`int`)
- `NextMatchDate` (`DateTime?`)
- `ViewerIds` (`string?`) — formato serializzazione non deducibile
- `IsDeleted`, `Ts` (da EntityBase)

## Relazioni entity

FK `ChannelId` e `MainTeamId` come proprietà scalari (nessuna navigation property)

## Repository correlati

- `FakeAgentSettingRepository`

## Services correlati

Non deducibili dai controller API (usato nei job HF)

## Workflow correlati

Non deducibile

## Tabella DB

`[Table("FakeAgentSettings")]`

## Nome nel codice

`FakeAgentSetting` — `src/RugbyRadio/Lib/Repositories/FakeAgentBox/FakeAgentSetting.cs`
