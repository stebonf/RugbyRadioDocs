---
title: "StatsCardViewModel (web)"
type: frontend-model
layer: frontend
---

# StatsCardViewModel (web)

## Sintesi

View model locale per card statistiche mostrate nella pagina statistiche pubbliche.

## Proprietà

- `labelKey` (`string`) - obbligatoria; chiave i18n della label.
- `icon` (`string`) - obbligatoria; nome icona visualizzata.
- `value` (`number`) - obbligatoria; valore numerico visualizzato.

## Origine dati

Stato locale derivato da [[statsDto (web)]].

## Consumer FE

- [[GStatsPage (web)]]

## API correlate

Non deducibile.

## Note

Fonte: `llm-wiki/raw/frontend/web/model-map-20260519.md`.
