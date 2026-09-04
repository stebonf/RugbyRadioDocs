---
title: "teamUpdateDto (web)"
type: frontend-model
layer: frontend
---

# teamUpdateDto (web)

## Sintesi

DTO di richiesta per l'aggiornamento di una squadra esistente tramite TeamEditComponent. Stessa struttura di teamAddDto.

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

- TMS-03: PUT aggiornamento squadra esistente

## Note

Stessa struttura di `teamAddDto`. Inviato con metodo PUT per aggiornare una squadra esistente identificata da `teamId`.
