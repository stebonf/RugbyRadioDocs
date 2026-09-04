---
title: "matchRadioDto (web)"
type: frontend-model
layer: frontend
---

# matchRadioDto (web)

## Sintesi

Modelli frontend della Modalita Radio Evento. Definiscono contesto, selezione AI-Talker, item di coda e stato osservabile usati dal player radio.

## Proprietà

| Nome | Tipo | Uso |
|---|---|---|
| `MatchRadioSource` | type/enum | Origine dell'item radio, ad esempio evento live, evento passato o riproduzione manuale. |
| `MatchRadioQueueStatus` | type/enum | Stato del singolo item nella coda audio. |
| `MatchRadioStatus` | type/enum | Stato globale del player: `idle`, `loadingAudio`, `playing`, `paused`, `waitingForEvents`, `errorRecoverable`, `ended`. |
| `MatchRadioContext` | interface | Contesto partita e source view (`g_match_events` o `g_radio`). |
| `RadioCommentatorSelection` | interface | AI-Talker, lingua e disponibilita audio correnti. |
| `RadioQueueItem` | interface | Item audio accodato con evento, talker, lingua, stato, path audio e metadati temporali. |
| `MatchRadioState` | interface | Snapshot di stato radio, item corrente, coda, preferenze e ultimo errore. |

## Origine dati

`src/RugbyRadioWeb/src/app/dto/matchRadioDto.ts`

## Consumer FE

- [[MatchRadioPlayerService (web)]]
- [[MatchRadioStorageService (web)]]
- [[GMatchEventsComponent (web)]]
- [[GMatchRadioPage (web)]]

## API correlate

- [[VoiceService (web)]]
- [[VoicesV1Controller (api)]]

## Note

La chiave di deduplica radio e `eventId:talkerId:language`. I modelli rappresentano solo stato frontend e persistenza locale: non introducono entity backend, tabelle o nuove API.
