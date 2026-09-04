---
title: "EntityToastComponent (web)"
type: frontend-component
layer: frontend
---

# EntityToastComponent (web)

## Sintesi
Sistema di notifiche toast globale. Osserva il flusso `ToastService.toasts$` e visualizza le notifiche attive in overlay. Montato una sola volta in AppComponent.

## Responsabilità
- Sottoscriversi a ToastService.toasts$ e visualizzare i toast attivi
- Renderizzare icona e testo per ogni toast in base al tipo
- Rimuovere automaticamente i toast dopo il timeout

## Parent pages
- AppComponent

## Child components
- [[IconComponent (web)]]

## Servizi FE usati
- [[ToastService (web)]]

## Modelli FE usati
- [[Toast (web)]]

## Eventi input/output
Nessun input. Nessun output diretto (il sistema è interamente reattivo via Observable).

## Note
- Il componente non riceve input dall'esterno: i toast sono gestiti esclusivamente tramite ToastService.
- Posizionato in overlay fisso, solitamente in basso o in alto alla viewport.
