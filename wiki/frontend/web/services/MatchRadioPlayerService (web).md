---
title: "MatchRadioPlayerService (web)"
type: frontend-service
layer: frontend
---

# MatchRadioPlayerService (web)

## Sintesi

Servizio frontend che gestisce la Modalita Radio Evento: coda audio, stato player, riproduzione sequenziale, deduplica, cambio AI-Talker per eventi futuri, analytics e persistenza locale tramite [[MatchRadioStorageService (web)]].

## Responsabilità

- Mantenere stato radio osservabile (`idle`, `waitingForEvents`, `loadingAudio`, `playing`, `paused`, `errorRecoverable`, `ended`)
- Ricevere snapshot successivi di `matchDto` e accodare solo nuovi eventi dopo il Play
- Accodare eventi pregressi quando lo spettatore abilita "ascolta dall'inizio"
- Deduplicare per `eventId + talkerId + language`
- Usare [[VoiceService (web)]] per recuperare il path MP3 evento
- Costruire l'URL audio finale con `environment.audioUrl`
- Gestire un solo `HTMLAudioElement` attivo
- Delegare il click audio manuale tramite `playSingleEvent`
- Tracciare analytics radio tramite [[AnalyticsService (web)]]
- Salvare preferenze, ultimi 5 item di coda e ultimo evento ascoltato sul dispositivo

## Consumer FE

- [[GMatchEventsComponent (web)]]
- [[MatchEventsComponent (web)]]
- [[GMatchRadioPage (web)]]

## API chiamate

- [[VoiceService (web)]] -> [[VoicesV1Controller (api)]]

## DTO o modelli usati

- [[matchRadioDto (web)]]
- [[matchDto (web)]]
- [[matchEventDto (web)]]

## Side effects

- Riproduzione audio browser tramite `HTMLAudioElement`
- Lettura/scrittura localStorage tramite [[MatchRadioStorageService (web)]]
- Invio eventi Firebase Analytics tramite [[AnalyticsService (web)]]

## Decisioni

- Nessuna nuova API backend per MVP
- Nessuna persistenza server-side della sessione radio
- Stop conserva lo stato locale fino a un nuovo Play
- Eventi gia accodati poi eliminati o corretti vengono ignorati dalla coda esistente
- La codifica lingua/talker riusa quella gia esistente per audio evento

## Note

Il RAW di chiusura progetto conferma che Play e l'unico comando di avvio, Stop e l'unico comando di spegnimento, il cambio tab non avvia ne ferma la radio e le risposte TTS arrivate dopo Stop vengono ignorate.
