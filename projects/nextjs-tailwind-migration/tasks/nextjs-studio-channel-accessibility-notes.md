# Next.js Studio Channel Accessibility Notes

Data: 2026-07-24

## Contesto

Rifinitura NXT-T017 sulla gestione canali studio dopo la prima migrazione dei workflow canale, squadre, giocatori, partite ed editor. L'obiettivo e ridurre ambiguita nei form operativi e migliorare la parita QA per stati errore/accessibilita senza cambiare contratti backend.

## Modifiche implementate

- La route `/studio/channels/[channelId]` inizializza le tab su `info`, coerente con la prima sezione visibile.
- `SelectField` supporta ora `id`, `aria-describedby`, `aria-invalid` e `required`, come gia fatto per `FormField`.
- Il form info canale usa `aria-labelledby`, `aria-describedby`, `noValidate`, campi `id` espliciti e collegamento dell'errore globale ai controlli principali.
- Le sezioni `teams`, `matches` ed `editors` hanno heading referenziati via `aria-labelledby`.
- I form di creazione squadra, creazione partita, aggiunta editor, salvataggio squadra e gestione giocatore sono nominati con heading nascosti o `aria-label` e usano `noValidate` per mantenere la validazione custom coerente con toast/alert.
- La creazione partita mostra un toast warning quando casa e trasferta mancano o coincidono, invece di limitarsi a impostare uno stato errore generico.
- I picker avatar giocatore usano prefissi id stabili, evitando duplicati fra form di creazione e modifica.

## Impatto funzionale

- Nessun cambio endpoint o DTO.
- Nessuna nuova dependency npm.
- Migliora la leggibilita screen reader dei workflow cronista.
- Rende piu chiaro lo stato invalid per il criterio "create match con squadre diverse".
- Mantiene `TeamsV1Controller` come limite noto: eliminazione team non esposta dal backend.

## Validazione locale

- `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`: compilazione, typecheck e generazione statica completati.
- `node scripts\smoke-http.mjs` da `src/RugbyRadioWebNext` con `SMOKE_PORT=3270`: passato su porte 3270/3271.
- `rg -n "TODO|console\.log|any|React\." ...`: nessun match nei sorgenti Next scansionati.

## Pending

- Validazione browser reale con token cronista e backend.
- Verifica mobile end-to-end di creazione canale, squadra, giocatore, partita ed editor.
- Review visuale delle tab ancora ancorate a sezioni statiche.
