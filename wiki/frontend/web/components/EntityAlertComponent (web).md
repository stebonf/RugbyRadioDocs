---
title: "EntityAlertComponent (web)"
type: frontend-component
layer: frontend
---

# EntityAlertComponent (web)

## Sintesi
Banner informativo o di errore con supporto al dismiss persistente tramite localStorage. Supporta varianti di tipo, stile e layout configurabili con icona opzionale.

## Responsabilità
- Visualizzare banner informativi, di avviso o di errore
- Permettere il dismiss dell'alert con persistenza in localStorage tramite ID
- Adattare aspetto visivo in base a type, variant e layout
- Mostrare icona opzionale tramite IconComponent

## Parent pages
Usato in tutte le pagine con stati di errore o informativi.

## Child components
- [[IconComponent (web)]]

## Servizi FE usati
Nessuno (accesso diretto a localStorage).

## Modelli FE usati
Nessuno.

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | id | string | Identificatore univoco per la persistenza dismiss in localStorage |
| Input | type | string | Tipo alert: `info`, `warning`, `error`, `success` |
| Input | variant | string | Variante visiva dell'alert |
| Input | layout | string | Layout del banner: `inline`, `full` |
| Input | icon | string | Nome icona opzionale |

## Note
- Il dismiss viene salvato in localStorage con chiave derivata dall'`id`: una volta chiuso, l'alert non viene più mostrato alla stessa sessione/browser.
- Nessun output emesso verso il parent.
