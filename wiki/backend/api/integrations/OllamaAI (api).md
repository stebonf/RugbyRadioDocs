---
title: "OllamaAI (api)"
type: backend-integration
layer: backend
---

# OllamaAI (api)

## Sintesi

Integrazione con istanza Ollama (LLM self-hosted) via SDK OllamaSharp. Due utilizzi: generazione post blog (`AiOllamaService`) e generazione/traduzione messaggi di telecronaca (`SystemMessageService`). Configurazione da `Db/Ai-Talkers.json`.

## Provider esterno

Ollama — SDK `OllamaSharp` — istanza self-hosted (URI configurabile)

## Responsabilità

- Generazione post blog per partite FullTime in più lingue
- Generazione e traduzione messaggi di sistema per eventi telecronaca
- Chiamata streaming (`Chat.SendAsync`) con parametri: temperatura 0.8, TopP 0.7, seed random

## Services consumer

- [[AiOllamaService (api)]]
- [[SystemMessageService (api)]]

## Payload rilevanti

- Input: system prompt (con eventuali embedding concatenati), domanda, history messaggi
- Output: stream token testuali concatenati in stringa
- Modelli e URI configurati in `Db/Ai-Talkers.json`

## Retry/fallback

Nessuno. Risposta vuota se errore.

## Side effects

Nessuno diretto (scrittura DB gestita dal chiamante)

## Configurazioni

- `ConnectionStrings:AiTalkers` — path del file JSON: `Db\Ai-Talkers.json`
- `AiSettings.OllamaUri`, `AiSettings.ChatModels`, `AiSettings.CheckModel` — da file JSON

## Classi responsabili

- `AiOllamaService` — `src/RugbyRadio/Lib/Services/AiOllamaService.cs`
- `SystemMessageService` — `src/RugbyRadio/Lib/Repositories/SystemMessageBox/SystemMessageService.cs`
