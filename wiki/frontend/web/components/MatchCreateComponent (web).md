---
title: "MatchCreateComponent (web)"
type: frontend-component
layer: frontend
---

# MatchCreateComponent (web)

## Sintesi
Drawer full-screen wizard per la creazione rapida di una partita in tre step: selezione canale, selezione squadre e riepilogo/conferma. Blocca lo scroll del body quando aperto.

## Responsabilità
- Guidare l'utente attraverso i 3 step di creazione partita
- Bloccare lo scroll del body quando il drawer è visibile
- Inviare la richiesta di creazione tramite MatchService
- Emettere closeModal, matchCreated e dataRefreshNeeded al termine del flusso

## Parent pages
- AppComponent
- HomeUserComponent (web)

## Child components
- [[EntityButtonComponent (web)]]
- EntityFieldComponent (web)

## Servizi FE usati
- [[MatchService (web)]]

## Modelli FE usati
- [[matchQuickAddDto (web)]]
- [[channelDto (web)]]
- teamMinDto (web)

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | channels | channelDto[] | Lista canali disponibili per la selezione |
| Input | teams | teamMinDto[] | Lista squadre disponibili per la selezione |
| Input | isVisible | boolean | Controlla la visibilità del drawer |
| Output | closeModal | EventEmitter<void> | Emesso alla chiusura del drawer |
| Output | matchCreated | EventEmitter<matchDto> | Emesso dopo la creazione della partita |
| Output | dataRefreshNeeded | EventEmitter<void> | Emesso quando i dati parent devono essere ricaricati |

## Note
- Step 1: selezione canale dalla lista `channels`.
- Step 2: selezione squadra home e away dalla lista `teams`.
- Step 3: riepilogo e conferma creazione tramite MatchService con `matchQuickAddDto`.
- Il blocco scroll body viene rimosso all'emit di closeModal.
