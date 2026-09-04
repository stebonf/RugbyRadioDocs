---
title: "AzureSpeech (api)"
type: backend-integration
layer: backend
---

# AzureSpeech (api)

## Sintesi

Integrazione con Azure Cognitive Services Text-to-Speech. Genera file audio MP3 da testo. Supporta più lingue e stili vocali (Arcaico, Influencer, Adolescente, Alieno, ExPlayer, Chef). File cachati su filesystem.

## Provider esterno

Microsoft Azure Cognitive Services — Speech SDK (`Microsoft.CognitiveServices.Speech`)

## Responsabilità

- Sintesi vocale da testo tramite SDK Azure TTS
- Output: file MP3 in `D:\Web\RugbyRadioStorage\audio\`
- Cache su filesystem: genera solo se il file non esiste già

## Services consumer

- [[VoiceService (api)]]

## Payload rilevanti

- Input: testo stringa + voce selezionata da `GetVoice(language)`
- Output: `byte[]` audio MP3 scritto su file
- Formato output: `Audio16Khz32KBitRateMonoMp3`

## Retry/fallback

Nessun retry. Ritorna `null` se lingua non supportata o sintesi fallisce.

## Side effects

- Scrittura file MP3 su filesystem

## Configurazioni

- `subscriptionKey` — hardcoded nel codice sorgente (non in configurazione esterna)
- `region` — hardcoded: `swedencentral`
- Path storage: `D:\Web\RugbyRadioStorage\audio\` — hardcoded

## Note

La chiave di sottoscrizione è hardcoded nel codice sorgente: andrebbe spostata in configurazione.

Le voci Azure sono scelte dal mapping applicativo in [[VoiceService (api)]]. Il RAW TTS documenta supporto audio per base language e per Arcaico, Influencer, Adolescente, Alieno, Chef ed ExPlayer.

## Classe responsabile

`VoiceService` — `src/RugbyRadio/Lib/Services/VoiceService.cs`
