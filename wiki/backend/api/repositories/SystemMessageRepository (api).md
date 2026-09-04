---
title: "SystemMessageRepository (api)"
type: backend-repository
layer: backend
---

# SystemMessageRepository (api)

## Sintesi

Repository per i messaggi di sistema localizzati usati nella telecronaca. Supporta lookup per codice evento e lingua, ricerca messaggi senza variante femminile.

## Responsabilità

- `FindByCodeAsync(code, language)` — messaggio di sistema per tipo evento e lingua
- `FindFemaleNotTranslated(language, limit)` — messaggi senza `MessageFemale` (batch)
- CRUD messaggi di sistema

## Entities gestite

- [[SystemMessage (api)]]

## Query rilevanti

- `FindByCodeAsync(code, language)` — usato da `VoiceService` e job AI
- `FindFemaleNotTranslated(language, limit)` — usato da `TranslateMatchEventFemaleJob`

## Consumer

- [[SystemMessageService (api)]]
- [[VoiceService (api)]]
- [[AdminV1Controller (api)]]
- [[TranslateMatchEventFemaleJob (api)]]

## Nome nel codice

`SystemMessageRepository` — `src/RugbyRadio/Lib/Repositories/SystemMessageBox/SystemMessageRepository.cs`
