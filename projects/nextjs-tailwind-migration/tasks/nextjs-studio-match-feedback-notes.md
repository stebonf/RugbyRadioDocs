# Next.js Studio Match Feedback Notes

Data: 2026-07-24

## Contesto

Rifinitura NXT-T018 sulla pagina match cronista dopo la prima migrazione dei workflow eventi, formazioni, statistiche, audio, notifiche e blog. L'obiettivo e rendere piu affidabili feedback operativi, ancore di navigazione e accessibilita dei form principali prima della validazione con backend reale.

## Modifiche implementate

- Corretta l'ancora delle tab: `#lineup` ora punta alla sezione Formazioni, mentre il feed eventi usa `#event-feed`; la tab Eventi resta su `#events`, il form di creazione evento.
- Update dati partita valida canale e squadre diverse prima di chiamare API, con toast warning/danger dedicati.
- Toast di update partita corretti: non parlano piu di giocatori/formazioni quando viene salvata data/ora/squadre.
- Update stato partita mostra toast success, warning su stato non valido ed errore API dedicato.
- Update statistiche live mostra toast coerenti con possesso/territorio/nota, invece di messaggi di assegnazione formazione.
- Add lineup inline valida slot e nome/nickname prima della chiamata API e restituisce toast success/error dedicati.
- Assign lineup player valida `Player ID`, segnala warning se vuoto e usa toast success/error specifici.
- Remove lineup segnala errore quando il match non contiene un canale valido.
- Score, dati partita, nuovo evento, feed eventi, formazioni e statistiche live hanno heading/ARIA piu espliciti; i form principali usano `noValidate`, id stabili, `required` dove utile e label/aria-label dedicate.
- I form di assegnazione slot in `LineupList` hanno `aria-label`, `noValidate` e id campo `Player ID` specifico per lineup.

## Impatto funzionale

- Nessun cambio endpoint o DTO.
- Nessuna nuova dependency npm.
- Migliora la parita QA per tab/ancore `events`, `lineup`, `stats`, `blog`.
- Riduce ambiguita operativa durante il workflow live cronista, dove messaggi sbagliati possono confondere salvataggi diversi.

## Validazione locale

- `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`: compilazione, typecheck e generazione statica completati.
- `node scripts\smoke-http.mjs` da `src/RugbyRadioWebNext` con `SMOKE_PORT=3280`: passato su porte 3280/3281.
- `rg -n "TODO|console\.log|any|React\." ...`: nessun match nei sorgenti Next scansionati.

## Pending

- Validazione browser reale con token cronista e backend.
- Verifica mobile end-to-end di evento, lineup, statistiche, audio TTS, notifiche e blog.
- Verifica runtime dei payload reali restituiti da `MatchService`, `LineupService`, `VoiceService` e `BlogService`.
