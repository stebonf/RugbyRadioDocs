---
title: "teamAddDto (web)"
type: frontend-model
layer: frontend
---

# teamAddDto (web)

## Sintesi

DTO di richiesta per la creazione di una squadra tramite TeamEditComponent. Contiene nome, soprannome opzionale e URL logo.

## Proprietà

| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| name | string | Nome della squadra (required, max 20) |
| nickname | string? | Soprannome/abbreviazione (optional, max 20) |
| logoUrl | string? | URL del logo selezionato |

## Origine dati

Costruito lato FE da TeamEditComponent.

## Consumer FE

- [[TeamService (web)]]

## API correlate

- TMS-02: POST creazione nuova squadra

## Note

`teamUpdateDto` ha la stessa struttura per l'aggiornamento squadra.
