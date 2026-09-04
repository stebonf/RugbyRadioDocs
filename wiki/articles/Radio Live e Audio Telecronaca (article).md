---
title: "Radio Live e Audio Telecronaca (article)"
type: article
layer: concept
---

# Radio Live e Audio Telecronaca (article)

## Sintesi

Radio Live permette allo spettatore di ascoltare eventi di telecronaca tramite audio TTS singolo o coda audio automatica.

## Scope

Questa pagina chiarisce il rapporto tra pagina radio, servizi frontend, TTS e workflow audio.

## Componenti coinvolti

- [[Riproduzione Audio Telecronaca (workflow)]]
- [[GMatchRadioPage (web)]]
- [[MatchRadioPlayerService (web)]]
- [[MatchRadioStorageService (web)]]
- [[VoiceService (web)]]
- [[VoicesV1Controller (api)]]
- [[VoiceService (api)]]
- [[AzureSpeech (api)]]
- [[matchRadioDto (web)]]

## Relazioni principali

- [[GMatchRadioPage (web)]] espone la pagina pubblica `/g-radio/:matchId`.
- [[MatchRadioPlayerService (web)]] gestisce riproduzione e coda audio.
- [[MatchRadioStorageService (web)]] conserva stato locale quando disponibile.
- [[VoicesV1Controller (api)]] e [[VoiceService (api)]] collegano il frontend alla sintesi vocale.
- [[AzureSpeech (api)]] rappresenta l'integrazione TTS.

## Note

Articolo creato usando solo pagine wiki esistenti. Background audio, lock screen, Media Session API e regole di caching non sono deducibili.

