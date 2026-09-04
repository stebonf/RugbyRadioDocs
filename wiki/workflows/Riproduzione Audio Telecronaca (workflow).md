---
title: "Riproduzione Audio Telecronaca (workflow)"
type: workflow
layer: workflow
---

# Riproduzione Audio Telecronaca (workflow)

## Obiettivo
Permettere allo spettatore di ascoltare la preview di un AI-Talker, l'audio TTS di un singolo evento partita o una coda audio automatica tramite Modalita Radio Evento.

## Trigger
Lo spettatore seleziona la preview audio del telecronista, clicca il pulsante audio su un evento partita oppure preme Play Radio nella pagina partita o nella pagina pubblica `/g-radio/:matchId`.

## Attori
- [[Spettatore (actor)]]

## Frontend coinvolto
- [[MatchCommentatorComponent (web)]]
- [[MatchEventsComponent (web)]]
- [[GMatchEventsComponent (web)]]
- [[GMatchRadioPage (web)]]
- [[MatchRadioPlayerService (web)]]
- [[MatchRadioStorageService (web)]]
- [[VoiceService (web)]]
- [[UserService (web)]]

## Backend coinvolto
- [[VoicesV1Controller (api)]]
- [[VoiceService (api)]]
- [[AzureSpeech (api)]]

## Data coinvolti
- [[MatchEvent (api)]]
- [[SystemMessage (api)]]
- [[matchRadioDto (web)]]

## Analytics tracking
- `radio_play`
- `radio_play_from_start_enabled`
- `radio_pause`
- `radio_resume`
- `radio_stop`
- `radio_event_play_start`
- `radio_event_play_complete`
- `radio_event_audio_error`
- `radio_queue_lag`

## Failure points
- Lingua o stile non supportato dal mapping TTS.
- Evento partita, match o messaggio di sistema assenti.
- Generazione Azure Speech fallita.
- File MP3 non disponibile sul filesystem/storage.
- Alcuni talker hanno testi e profili UI ma non audio TTS.
- Browser blocca `Audio.play()` se non preceduto da gesture utente.
- localStorage non disponibile: la radio degrada a stato non persistente.

## Gap noti
- Supporto background audio, lock screen e Media Session API non ancora validati su browser mobile, PWA e TWA.
- Regole di caching oltre al controllo esistenza file non deducibili.

## Note
Evidenza da `llm-wiki/raw/docs/rrl-tts.md` e `llm-wiki/raw/dev/radio-live/rrl-202606-radiolive.md`. La chiusura progetto conferma MVP frontend-first: nessuna nuova API backend, nessuna tabella, nessuno streaming server-side e nessuna generazione AI realtime.
