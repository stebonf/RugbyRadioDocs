---
title: "VoiceService (web)"
type: frontend-service
layer: frontend
---

# VoiceService (web)

## Sintesi

API client per la generazione di audio TTS (Text-To-Speech). La risposta è di tipo `text/plain` e contiene il path del file audio generato dal backend.

## Responsabilità

- Invio del testo al backend per la sintesi vocale
- Richiesta audio evento tramite `eventId`
- Ricezione del path del file audio generato

## Consumer FE

- [[MatchCommentatorComponent (web)]]
- [[MatchEventsComponent (web)]]

## API chiamate

- [[VoicesV1Controller (api)]]

## DTO o modelli usati

- Nessuno (risposta `text/plain`)

## Side effects

- Chiamata HTTP con `responseType: 'text'` verso le API backend
- Costruzione indiretta dell'audio riproducibile nei componenti consumer tramite `environment.audioUrl`

## Workflow correlati

- [[Riproduzione Audio Telecronaca (workflow)]]

## Note

La richiesta è configurata con `responseType: 'text'` per gestire la risposta non-JSON del backend. Il path ricevuto viene poi utilizzato dal componente per riprodurre l'audio della telecronaca o degli eventi di partita. Gli endpoint chiamati sono `/voices?language={language}&sentence={sentence}` e `/voices/events?language={language}&eventId={eventId}`.
