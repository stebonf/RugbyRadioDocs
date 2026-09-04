---
title: "EntityButtonComponent (web)"
type: frontend-component
layer: frontend
---

# EntityButtonComponent (web)

## Sintesi
Widget pulsante atomico riutilizzabile. Supporta tre varianti di forma (pill, panel, close) e tre varianti di stile (primary, secondary, ghost). Usato trasversalmente in tutta l'app come mattone base dell'UI.

## Responsabilità
- Renderizzare un pulsante con variante di forma e stile configurabile
- Mostrare un'icona opzionale tramite IconComponent
- Gestire lo stato disabled
- Emettere l'evento clicked al click

## Parent pages
Usato in tutti i componenti e pagine dell'app (nessun parent specifico limitato).

## Child components
- [[IconComponent (web)]]

## Servizi FE usati
Nessuno.

## Modelli FE usati
Nessuno.

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | variant | string | Forma del bottone: `pill`, `panel`, `close` |
| Input | color | string | Stile cromatico: `primary`, `secondary`, `ghost` |
| Input | label | string | Testo del bottone |
| Input | icon | string | Nome icona da passare a IconComponent |
| Input | disabled | boolean | Disabilita il bottone |
| Input | type | string | Attributo HTML type (`button`, `submit`, ecc.) |
| Output | clicked | EventEmitter<void> | Emesso al click sul bottone |

## Note
- Componente atomico: non dipende da altri componenti tranne IconComponent.
- La variante `close` viene tipicamente usata per chiudere modal/drawer.
