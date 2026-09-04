---
title: "MatchRadioStorageService (web)"
type: frontend-service
layer: frontend
---

# MatchRadioStorageService (web)

## Sintesi

Servizio frontend che isola la persistenza locale della Modalita Radio Evento.

## Responsabilità

- Serializzare/deserializzare stato radio in `localStorage`
- Usare namespace per match: `rrl_radio_v1:{matchId}:...`
- Salvare preferenze radio, ultimi 5 item di coda e ultimo evento ascoltato
- Memorizzare la data dell'ultimo item persistito
- Ripulire lo stato locale dopo 10 giorni dall'ultimo item persistito
- Degradare senza eccezioni se localStorage non e disponibile, corrotto o pieno

## Consumer FE

- [[MatchRadioPlayerService (web)]]

## API chiamate

Nessuna.

## DTO o modelli usati

- [[matchRadioDto (web)]]

## Side effects

- Lettura e scrittura di `localStorage`
- Cleanup dello stato radio obsoleto dopo 10 giorni dall'ultimo item persistito

## Data locale

- `preferences`
- `queue`
- `last_event`
- `state`

## Decisioni

- Nessun dato sensibile o audio binario viene salvato
- La coda persistita e limitata agli ultimi 5 item per match
- La persistenza e solo dispositivo e non richiede login

## Note

Le chiavi locali usano il namespace `rrl_radio_v1:{matchId}:...`. Se `localStorage` non e disponibile, corrotto o pieno, la radio degrada senza bloccare la riproduzione runtime.
