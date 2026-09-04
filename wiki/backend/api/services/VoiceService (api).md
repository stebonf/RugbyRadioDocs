---
title: "VoiceService (api)"
type: backend-service
layer: backend
---

# VoiceService (api)

## Sintesi

Genera file audio MP3 via Azure Cognitive Services Text-to-Speech. Supporta più lingue e stili vocali (Arcaico, Influencer, Adolescente, Alieno, ExPlayer, Chef). File salvati su filesystem con cache: generato solo se non esiste già.

## Responsabilità

- `GetAudioAsync` — TTS da testo libero + lingua
- `GetAudioEventAsync` — TTS da evento partita (recupera messaggio di sistema localizzato)
- Cache file su filesystem `D:\Web\RugbyRadioStorage\audio\`
- Normalizzazione del path file in combinazione con [[VoicesV1Controller (api)]]

## Consumer

- [[VoicesV1Controller (api)]]

## Repository usati

- `IMatchEventRepository`
- `ISystemMessageRepository`
- `IMatchService` (dipendenza)

## Integrazioni usate

- [[AzureSpeech (api)]]

## Jobs usati

Nessuno diretto

## Entities coinvolte

- [[MatchEvent (api)]]
- [[SystemMessage (api)]]

## Workflow correlati

- [[Riproduzione Audio Telecronaca (workflow)]]

## Side effects

- Scrittura file MP3 su filesystem

## Failure points

- Lingua/stile non riconosciuti dal mapping `GetVoice(language)`
- `MatchEvent`, `MatchId` o `SystemMessage` assenti nel flusso audio evento
- Fallimento della sintesi Azure Speech
- Path storage hardcoded non disponibile

## Nome nel codice

`VoiceService` — `src/RugbyRadio/Lib/Services/VoiceService.cs`

## Note

Per preview voce il frontend passa tipicamente `sentence = "presentation"`; il servizio usa frasi hardcoded per lingua/stile. Per audio evento, se l'evento contiene un player, il servizio usa la descrizione evento gia renderizzata dal match localizzato.
