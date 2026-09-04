---
title: "VoicesV1Controller (api)"
type: backend-api
layer: backend
---

# VoicesV1Controller (api)

## Sintesi

Controller per la generazione di audio TTS (Text-to-Speech). Espone endpoint per generare file MP3 da testo o da evento di partita tramite Azure Cognitive Services. Accesso non deducibile (nessun attributo auth).

## Base route

`/v1/voices`

## Endpoints

- GET `/v1/voices` — genera audio da testo/lingua (VOC-01)
- GET `/v1/voices/events` — genera audio per evento partita usando query string `language` ed `eventId` (VOC-02)

## DTO input

- `language` (query param) — codice lingua
- `sentence` (query param) — testo da sintetizzare (VOC-01)
- `eventId` (query param) — identificativo evento partita (VOC-02)

## DTO output

- `string` — path file MP3 generato (o null se fallisce)

## Backend services usati

- [[VoiceService (api)]]

## Regole auth

Non deducibile: nessun `[Authorize]` né `[AllowAnonymous]` a livello controller o endpoint. Accesso di fatto non protetto da JWT.

## Consumer FE

- [[VoiceService (web)]]
- [[MatchCommentatorComponent (web)]]
- [[MatchEventsComponent (web)]]

## Workflow correlati

- [[Riproduzione Audio Telecronaca (workflow)]]

## Nome nel codice

`VoicesV1Controller` — `src/RugbyRadio/Api/Controllers/VoicesV1Controller.cs`

## Note

File MP3 generati e cachati su filesystem. Se il file esiste già non viene rigenerato. Gli endpoint restituiscono `text/plain` con il path relativo dell'MP3, non uno stream audio.
