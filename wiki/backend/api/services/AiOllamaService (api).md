---
title: "AiOllamaService (api)"
type: backend-service
layer: backend
---

# AiOllamaService (api)

## Sintesi

Client per istanza Ollama (LLM self-hosted). Genera post blog per partite terminate in più lingue. Costruisce tabellino testuale della partita come contesto per il modello. Configurazione caricata da `Db/Ai-Talkers.json`.

## Responsabilità

- `CallAi` — chiamata LLM via SDK OllamaSharp (streaming, temperatura 0.8, TopP 0.7)
- `CreateBlogPosts` — genera post blog `Blog` in IT + traduzioni (EN, FR, ES, JA) per partite `FullTime` senza blog

## Consumer

- [[CreateMatchBlogJob (api)]] — tramite job HF

## Repository usati

- `IMatchRepository`
- [[BlogRepository (api)]]
- `IUnitOfWork`

## Integrazioni usate

- [[OllamaAI (api)]]

## Jobs usati

Nessuno diretto

## Entities coinvolte

- [[Match (api)]]
- [[Blog (api)]]

## Workflow correlati

Non deducibile

## Side effects

- Scrittura DB: `Blog`
- Chiamata HTTP esterna a istanza Ollama

## Nome nel codice

`AiOllamaService` — `src/RugbyRadio/Lib/Services/AiOllamaService.cs`

## Note

Non deducibile dai RAW disponibili.
