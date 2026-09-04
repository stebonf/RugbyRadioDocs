---
title: "teamMinDto (web)"
type: frontend-model
layer: frontend
---

# teamMinDto (web)

## Sintesi

Versione minima del DTO squadra per liste e riferimenti. Contiene solo identificativo, canale di appartenenza e nome.

## Proprietà

| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | string | Identificatore univoco della squadra |
| channelId | string | ID del canale di appartenenza |
| name | string | Nome della squadra |
| logoUrl | string | URL del logo della squadra |

## Origine dati

- API: TMS-01 (GET lista squadre del canale)

## Consumer FE

- [[TeamService (web)]]
- [[MatchCardListComponent (web)]]
- MatchCardSmallComponent (web)

## API correlate

- TMS-01: GET lista squadre del canale

## Note

Usato per elenchi sintetici dove non serve il dettaglio completo della squadra. `logoUrl` può essere vuoto se non è stato selezionato un logo.
