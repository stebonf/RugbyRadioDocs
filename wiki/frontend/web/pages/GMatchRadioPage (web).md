---
title: "GMatchRadioPage (web)"
type: frontend-page
layer: frontend
---

# GMatchRadioPage (web)

## Sintesi

Pagina pubblica dedicata alla Modalita Radio Evento. Permette allo spettatore di aprire direttamente una vista essenziale di ascolto per una partita.

## Route

`/g-radio/:matchId` — Parametri: `matchId` — Pubblica

## Responsabilità

- Caricare la partita tramite [[MatchService (web)]]
- Configurare [[MatchRadioPlayerService (web)]] con source view `g_radio`
- Mostrare squadre, punteggio, minuto, stato partita e controlli Play/Pause/Stop
- Offrire l'opzione "ascolta dall'inizio"
- Offrire ritorno alla pagina partita `/g-match/:matchId`

## Componenti usati

- [[EntityButtonComponent (web)]]
- [[IconComponent (web)]]

## Servizi FE usati

- [[MatchService (web)]]
- [[UserService (web)]]
- [[MatchRadioPlayerService (web)]]

## Modelli FE usati

- [[matchDto (web)]]
- [[matchRadioDto (web)]]

## API dipendenti

- [[MatchesV1Controller (api)]]
- [[VoicesV1Controller (api)]]

## Workflow correlati

- [[Riproduzione Audio Telecronaca (workflow)]]

## Stati UI

- Loading match
- Radio idle
- Loading audio
- Playing
- Paused
- Waiting for events
- Error recoverable
- Ended

## Note

La pagina riusa il player radio frontend e non introduce streaming audio o nuove API. Il RAW di chiusura progetto conferma la route pubblica `/g-radio/:matchId` come vista essenziale dedicata, mentre la card integrata in [[GMatchPage (web)]] resta il punto principale del journey partita.
