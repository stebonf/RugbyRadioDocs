---
title: "MatchCommentatorComponent (web)"
type: frontend-component
layer: frontend
---

# MatchCommentatorComponent (web)

## Sintesi
Selettore AI-Talker/telecronista con stili e lingue disponibili. Permette la preview audio del telecronista selezionato quando il relativo codice voce e valorizzato. Visualizzato come drawer animato.

## Responsabilità
- Presentare la griglia di 10 stili telecronista × 5 lingue selezionabili
- Riprodurre una preview audio tramite VoiceService usando la frase `presentation`
- Animare l'apertura/chiusura del drawer
- Emettere commentatorChanged al cambio di selezione
- Tracciare le interazioni tramite LoggingService

## Parent pages
- [[GMatchEventsComponent (web)]]

## Child components
- [[EntityButtonComponent (web)]]
- [[IconComponent (web)]]

## Servizi FE usati
- [[UserService (web)]]
- [[VoiceService (web)]]
- [[LoggingService (web)]]

## Modelli FE usati
Nessuno (stili e lingue sono definiti internamente come costanti).

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Output | commentatorChanged | EventEmitter<any> | Emesso con il telecronista selezionato (stile + lingua) |

## Note
- Gli stili telecronista e le lingue disponibili sono costanti interne al componente.
- La preview audio viene riprodotta tramite VoiceService e `environment.audioUrl`.
- Il drawer utilizza animazioni CSS per l'apertura/chiusura.
- L'accesso ad alcuni stili potrebbe essere riservato agli utenti autenticati (verificato tramite UserService).
- Alcuni talker hanno `voice` vuota e quindi non espongono preview audio.
