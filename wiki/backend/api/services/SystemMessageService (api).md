---
title: "SystemMessageService (api)"
type: backend-service
layer: backend
---

# SystemMessageService (api)

## Sintesi

Crea e gestisce i messaggi di sistema per la telecronaca tramite Ollama AI. Genera messaggi in italiano per ogni tipo di evento partita, traduce nelle altre lingue (EN, FR, ES, JA) e nei vari stili talker. Verifica coerenza testo e lingua. Pubblica i messaggi approvati in `SystemMessage`.

## Responsabilità

- `AiTalkersCreateOllama` — generazione messaggi draft per lingua via AI
- `AiTalkersTranslateOllama` / `AiTalkersTranslateOllamaLanguage` — traduzione messaggi
- `AiTalkerCheckSentences` / `AiTalkerCheckMessage` — verifica qualità e coerenza via AI
- `AiTalkerProcessMessages` — processing batch messaggi
- `AddCommonMessageAsync` e vari `AddMatchEvent*Async` — aggiunta messaggi di sistema per tipo evento

## Consumer

- [[CreateMatchEventJob (api)]]
- [[CreateMatchEventAdminJob (api)]]

## Repository usati

- `ISystemMessageRepository`
- `ISystemMessageDraftRepository`
- `IUnitOfWork`

## Integrazioni usate

- [[OllamaAI (api)]] — generazione e traduzione testi
- `TailoorTalkerHelper` — helper HTTP verso Tailoor Talker AI

## Jobs usati

Nessuno diretto

## Entities coinvolte

- [[SystemMessage (api)]]
- [[SystemMessageDraft (api)]]

## Workflow correlati

- [[Sistema Messaggi Telecronaca AI (concept)]]

## Side effects

- Scrittura DB: `SystemMessageDraft`, `SystemMessage`
- Chiamate HTTP esterne a Ollama / Tailoor Talker

## Nome nel codice

`SystemMessageService` — `src/RugbyRadio/Lib/Repositories/SystemMessageBox/SystemMessageService.cs`

## Note

Molti metodi `AddMatchEvent*Async` letti solo per firma; dettaglio interno parzialmente dedotto.
