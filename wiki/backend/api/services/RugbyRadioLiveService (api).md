---
title: "RugbyRadioLiveService (api)"
type: backend-service
layer: backend
---

# RugbyRadioLiveService (api)

## Sintesi

Orchestratore di alto livello per la creazione rapida di canale + squadre + partita + formazioni in un'unica operazione wizard (`WizardFastAddChannelAsync`). Usato alla registrazione utente, per creazione rapida partita e dai job di simulazione.

## Responsabilità

- `WizardFastAddChannelAsync` — crea o recupera canale, due squadre, una partita e le rispettive formazioni (46 record `LineupPlayer`)
- Gestisce il flag `isTestChannel` per canali di training

## Consumer

- [[AuthV1Controller (api)]] — registrazione utente
- [[MatchesV1Controller (api)]] — creazione rapida partita (MTC-17)
- [[CreateTrainingChannelJob (api)]]

## Repository usati

- `IChannelRepository`
- `IUnitOfWork`

## Integrazioni usate

Nessuna diretta

## Jobs usati

Nessuno diretto (è usato dai job)

## Entities coinvolte

- [[Channel (api)]]
- [[Team (api)]]
- [[Match (api)]]
- [[LineupPlayer (api)]]

## Workflow correlati

Non deducibile

## Side effects

- Scrittura DB: `Channel`, `Team` (×2), `Match`, `LineupPlayer` (×46)
- Eventuale spostamento file immagine su filesystem

## Nome nel codice

`RugbyRadioLiveService` — `src/RugbyRadio/Lib/Services/RugbyRadioLiveService.cs`

## Note

Non deducibile dai RAW disponibili.
