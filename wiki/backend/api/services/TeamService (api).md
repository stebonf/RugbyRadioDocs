---
title: "TeamService (api)"
type: backend-service
layer: backend
---

# TeamService (api)

## Sintesi

Gestisce il ciclo di vita delle squadre: creazione, aggiornamento, ricerca per canale, verifica ownership, recupero loghi disponibili. Supporta creazione "get-or-create" per il wizard.

## Responsabilità

- Creazione e aggiornamento squadra
- Ricerca squadre per canale
- Verifica ownership: canale deve appartenere all'utente (owner primario o co-owner)
- `GetOrCreateTeamAsync` per wizard creazione rapida
- Recupero catalogo loghi

## Consumer

- [[TeamsV1Controller (api)]]
- [[MatchLineupsV1Controller (api)]]
- [[RugbyRadioLiveService (api)]]

## Repository usati

- `ITeamRepository`
- `IChannelRepository`
- `IUnitOfWork`

## Integrazioni usate

Nessuna

## Jobs usati

Nessuno diretto

## Entities coinvolte

- [[Team (api)]]
- [[Channel (api)]]

## Workflow correlati

Non deducibile

## Side effects

- Scrittura DB: `Team`

## Nome nel codice

`TeamService` — `src/RugbyRadio/Lib/Repositories/TeamBox/TeamService.cs`

## Note

Non deducibile dai RAW disponibili.
