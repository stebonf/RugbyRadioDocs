---
title: "teamChannelDto (web)"
type: frontend-model
layer: frontend
---

# teamChannelDto (web)

## Sintesi

DTO squadra contestualizzato a un canale. Estende i dati base con la lista dei giocatori e il conteggio partite giocate.

## Proprietà

| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | string | Identificatore univoco della squadra |
| name | string | Nome della squadra |
| logoUrl | string | URL del logo della squadra |
| nickname | string | Soprannome/abbreviazione della squadra |
| players | playerDto[] | Lista dei giocatori della squadra |
| matchesPlayed | number? | Conteggio partite giocate |

## Origine dati

- API: TMS-01 (GET lista squadre del canale con dettaglio)

## Consumer FE

- [[TeamService (web)]]

## API correlate

- TMS-01: GET lista squadre del canale

## Note

Usato nella ChannelTeamsComponent per la gestione squadre in contesto canale. `matchesPlayed` e opzionale e puo non essere presente in tutte le risposte.
