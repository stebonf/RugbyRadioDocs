---
title: "BusService (web)"
type: frontend-service
layer: frontend
---

# BusService (web)

## Sintesi

Event bus reattivo per la comunicazione tra componenti non direttamente collegati. Espone BehaviorSubject per lo stato condiviso dell'header e dell'interfaccia globale.

## Responsabilità

- Gestione dello stato condiviso tramite BehaviorSubject per:
  - `headerLanguageVisible`: visibilità del selettore lingua nell'header
  - `headerPageTitle`: titolo corrente della pagina nell'header
  - `headerBackVisible`: visibilità del pulsante back nell'header
  - `quickMatchOpen`: stato di apertura del pannello quick match

## Consumer FE

- HeaderComponent (web)
- [[EntityBottomNavComponent (web)]]
- AppComponent

## API chiamate

- Nessuna

## DTO o modelli usati

- Nessuno

## Side effects

- Aggiornamento dei BehaviorSubject alla navigazione tra pagine e all'interazione con i componenti

## Note

Alternativa leggera a una soluzione di state management completa (es. NgRx) per la gestione dello stato UI globale. I componenti si iscrivono agli stream e reagiscono ai cambiamenti senza accoppiamento diretto.

