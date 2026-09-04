---
title: "teamLogoDto (web)"
type: frontend-model
layer: frontend
---

# teamLogoDto (web)

## Sintesi

Dizionario di loghi squadra disponibili per la selezione. Mappa un identificativo numerico all'URL del logo.

## Proprietà

| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| Record<number, string> | dizionario | Mappa ID logo → URL immagine |

## Origine dati

- API: TMS-04 (GET lista loghi disponibili)

## Consumer FE

- [[TeamService (web)]]

## API correlate

- TMS-04: GET lista loghi disponibili

## Note

Usato in TeamEditComponent per la selezione del logo durante creazione/editing squadra. La struttura esatta delle chiavi non e deducibile dal RAW.
