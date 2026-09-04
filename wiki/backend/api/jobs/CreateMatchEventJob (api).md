---
title: "CreateMatchEventJob (api)"
type: backend-job
layer: backend
---

# CreateMatchEventJob (api)

## Sintesi

Genera messaggi di telecronaca AI per i tipi di evento più frequenti nell'ultimo periodo. Calcola la media di occorrenze per tipo evento, genera draft in 5 lingue e 10 stili telecronista, verifica coerenza (soglia 80% testo, 70% lingua) prima del salvataggio.

## Trigger

Hangfire RecurringJobAdmin — cron non deducibile dal codice (configurato a runtime dalla dashboard `/hangfire`)

## Responsabilità

- Recupera eventi reali degli ultimi N giorni
- Filtra tipi `ErrataCorrige`, `Headset` e segnali arbitro (900–951)
- Genera messaggi draft via `TailoorTalkerHelper` (HTTP esterno)
- Verifica: `verifyValue >= 80 && verifyLanguageValue >= 70` → `IsVerified = true`
- Limite 10 chiamate AI per esecuzione

## Services usati

- [[SystemMessageService (api)]]

## Entities coinvolte

- [[MatchEvent (api)]] — lettura
- [[SystemMessage (api)]] — lettura
- [[SystemMessageDraft (api)]] — scrittura

## Side effects

- Scrittura DB: `SystemMessageDraft`
- Chiamata HTTP esterna a Tailoor Talker

## Failure points

- Risposta AI vuota o HTML malformato → skip
- Placeholder giocatore mancante → skip
- Prompt mancante → `IsMissingPrompt = true`, skip
- `[AutomaticRetry(Attempts = 0)]` — nessun retry

## Nome nel codice

`CreateMatchEventJob` — `src/RugbyRadio/HF/Jobs/CreateMatchEventJob.cs`
