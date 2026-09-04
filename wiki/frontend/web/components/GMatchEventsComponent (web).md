---
title: "GMatchEventsComponent (web)"
type: frontend-component
layer: frontend
---

# GMatchEventsComponent (web)

## Sintesi
Wrapper pubblico degli eventi partita per GMatchPage. Aggrega MatchEventsComponent e MatchCommentatorComponent e gestisce il FAB per l'accesso al pannello telecronista.

## Responsabilità
- Aggregare MatchEventsComponent (feed eventi) e MatchCommentatorComponent (selezione telecronista)
- Offrire nel tab Eventi la scelta rapida tra modalità testo e modalità radio
- Mostrare, in modalità radio, una card di ricezione con stato audio, controlli, evento corrente e reazioni rapide
- Gestire il FAB (Floating Action Button) per aprire il selettore telecronista
- Propagare gli eventi di interazione (login, follow, like, editor) verso GMatchPage
- Propagare matchChange ed eventuali cambi telecronista

## Parent pages
- [[GMatchPage (web)]]

## Child components
- [[MatchEventsComponent (web)]]
- [[MatchCommentatorComponent (web)]]
- [[EntityButtonComponent (web)]]
- [[EntityAlertComponent (web)]]

## Servizi FE usati
- [[MatchRadioPlayerService (web)]]

## Modelli FE usati
- [[matchDto (web)]]
- [[blogDto (web)]]
- [[matchRadioDto (web)]]

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | match | matchDto | Dati completi della partita |
| Input | blog | blogDto | Post blog associato alla partita |
| Input | isUserLoggedIn | boolean | Stato di autenticazione utente |
| Input | isStarted | boolean | La partita è iniziata |
| Input | isFullTime | boolean | La partita è terminata |
| Output | editor | EventEmitter<void> | Emesso quando l'utente richiede accesso editor |
| Output | login | EventEmitter<void> | Emesso quando l'utente deve loggarsi |
| Output | follow | EventEmitter<void> | Emesso quando l'utente segue la partita |
| Output | like | EventEmitter<void> | Emesso quando l'utente mette like |
| Output | commentatorChange | EventEmitter<any> | Emesso al cambio telecronista |
| Output | matchChange | EventEmitter<matchDto> | Emesso dopo aggiornamenti alla partita |

## Note
- Componente orchestratore: coordina feed eventi, selettore AI-Talker e player radio lato frontend.
- La modalità radio usa MatchRadioPlayerService e risolve il testo dell'evento corrente da `match.events` tramite `currentItem.eventId`.
- Le reazioni rapide della card radio usano lo stesso endpoint delle reazioni evento del feed.
- Il FAB è visibile solo se la partita è in corso o terminata.
- Il tab `Ascolta` cambia solo vista e non avvia automaticamente l'audio; il tab `Leggi` non spegne la radio. Nel tab `Ascolta` non vengono renderizzati feed testuale e accordion `Opzioni partita`.
