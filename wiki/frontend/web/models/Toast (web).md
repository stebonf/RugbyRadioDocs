---
title: "Toast (web)"
type: frontend-model
layer: frontend
---

# Toast (web)

## Sintesi
View model per una notifica toast temporanea. Gestito da ToastService e visualizzato da EntityToastComponent. Rappresenta un singolo messaggio di feedback UI.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | number | Identificatore univoco del toast (usato per rimuoverlo dalla lista attiva) |
| type | ToastType | Tipo di notifica: `success`, `error`, `warning`, `info` |
| text | string | Testo del messaggio da visualizzare |

## Origine dati
Creato lato FE da ToastService. Non proviene dall'API.

## Consumer FE
- ToastService (web) — crea e gestisce i toast nell'Observable `toasts$`
- EntityToastComponent (web) — visualizza i toast attivi

## API correlate
Nessuna. Modello puramente frontend.

## Note
- `ToastType` è un enum che determina il colore e l'icona del toast in EntityToastComponent.
- L'`id` è tipicamente un timestamp o un contatore autoincrementante generato da ToastService.
- I toast vengono rimossi automaticamente dopo un timeout configurato in ToastService.
- Il pattern di utilizzo è: qualsiasi servizio o componente inietta ToastService e chiama `ToastService.show(type, text)`.
