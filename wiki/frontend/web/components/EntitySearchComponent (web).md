---
title: "EntitySearchComponent (web)"
type: frontend-component
layer: frontend
---

# EntitySearchComponent (web)

## Sintesi
Campo di ricerca con label, placeholder, pulsante di ricerca e pulsante clear. Gestisce la digitazione e l'invio della query di ricerca verso il componente parent.

## Responsabilità
- Visualizzare un campo di input per la ricerca con label e placeholder
- Emettere valueChange ad ogni modifica del testo
- Emettere search alla pressione del pulsante di ricerca o invio
- Emettere clear alla pressione del pulsante di reset

## Parent pages
- [[GMatchesPage (web)]]
- [[GChannelsPage (web)]]

## Child components
- [[EntityButtonComponent (web)]]
- EntityFieldComponent (web)

## Servizi FE usati
Nessuno.

## Modelli FE usati
Nessuno.

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | value | string | Valore corrente del campo di ricerca |
| Input | label | string | Label del campo |
| Input | placeholder | string | Placeholder del campo di input |
| Output | valueChange | EventEmitter<string> | Emesso ad ogni modifica del valore |
| Output | search | EventEmitter<string> | Emesso alla conferma della ricerca |
| Output | clear | EventEmitter<void> | Emesso alla pulizia del campo |

## Note
- Delegato a EntityFieldComponent per il rendering dell'input.
- EntityButtonComponent gestisce i pulsanti di ricerca e clear.
