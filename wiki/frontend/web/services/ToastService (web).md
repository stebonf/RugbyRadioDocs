---
title: "ToastService (web)"
type: frontend-service
layer: frontend
---

# ToastService (web)

## Sintesi

Gestisce la visualizzazione delle notifiche toast nell'interfaccia utente. Supporta quattro livelli di severità con auto-dismiss automatico dopo 4000ms.

## Responsabilità

- Accodamento di notifiche toast di tipo success, info, warning ed error
- Auto-dismiss delle notifiche dopo 4000ms
- Esposizione della coda toast tramite BehaviorSubject

## Consumer FE

- [[EntityToastComponent (web)]]
- Tutti i componenti e le pagine che necessitano di mostrare notifiche all'utente

## API chiamate

- Nessuna

## DTO o modelli usati

- [[Toast (web)]]

## Side effects

- Aggiornamento del BehaviorSubject della coda toast
- Scheduling del timer di auto-dismiss (4000ms)

## Note

Il modello `Toast` include almeno il messaggio, il tipo (success/info/warning/error) e un identificatore univoco. `EntityToastComponent` si iscrive al BehaviorSubject e renderizza visivamente le notifiche.
