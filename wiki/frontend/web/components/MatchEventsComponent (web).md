---
title: "MatchEventsComponent (web)"
type: frontend-component
layer: frontend
---

# MatchEventsComponent (web)

## Sintesi
Feed eventi della telecronaca di una partita. Supporta la visualizzazione, l'aggiunta e l'eliminazione di eventi (in edit mode), le reazioni emoji, i commenti e la lettura audio TTS tramite VoiceService.

## Responsabilità
- Visualizzare il feed cronologico degli eventi partita
- In edit mode: permettere l'aggiunta e l'eliminazione di eventi tramite MatchService
- Gestire le reazioni emoji agli eventi (evento [[ReactionAdded]])
- Leggere ad alta voce gli eventi tramite VoiceService (TTS)
- Tracciare le interazioni tramite AnalyticsService
- Visualizzare banner pubblicitari tramite EntityAdsComponent

## Parent pages
- [[GMatchEventsComponent (web)]]

## Child components
- [[EntityAdsComponent (web)]]
- [[EntityAlertComponent (web)]]
- [[EntityButtonComponent (web)]]

## Servizi FE usati
- [[MatchService (web)]]
- [[UserService (web)]]
- [[VoiceService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati
- [[matchDto (web)]]
- [[matchEventDto (web)]]

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | match | matchDto | Dati completi della partita |
| Input | blog | blogDto | Post blog associato alla partita |
| Input | isEditMode | boolean | Abilita le funzionalità di editing |
| Output | matchChange | EventEmitter<matchDto> | Emesso quando la partita viene aggiornata |

## Note
- In edit mode viene mostrata la toolbar per l'aggiunta di nuovi eventi.
- L'audio TTS è opzionale e dipende dalla configurazione del telecronista selezionato in MatchCommentatorComponent.
- Gli ads vengono inseriti nel feed con frequenza configurabile.
- Il pulsante audio evento e mostrato solo quando [[UserService (web)]] indica disponibilita audio per il commentator corrente.
