# Next.js Auth Accessibility Notes

Data: 2026-07-24

## Contesto

Rifinitura di NXT-T015 dopo il cablaggio iniziale di login, registrazione, reset password e Google Sign-In. L'obiettivo e ridurre ambiguita runtime prima della validazione browser completa, mantenendo la parita con la strategia Angular/i18n gia migrata.

## Modifiche implementate

- `FormField` accetta ora `id`, `aria-describedby` e `aria-invalid`, cosi i form auth possono collegare gli errori inline ai campi interessati senza duplicare markup input.
- Login, registrazione e richiesta reset password usano heading reali con `aria-labelledby`, `noValidate` e alert collegati tramite `aria-describedby`.
- Lo step OTP/reset password e ora una `section` nominata, con heading reale e alert errore collegato.
- Google Sign-In riceve la copy dal catalogo auth invece di usare messaggi hardcoded italiani per token mancante, indisponibilita del provider ed errore login.
- La lingua scelta in registrazione viene sincronizzata subito con localStorage e cookie `user_language` tramite `setUserLanguage`, oltre al riallineamento post-token gia presente.
- Il messaggio "codice inviato a" dello step reset e stato spostato in `ResetPasswordCopy` con fallback typed.

## Impatto funzionale

- Nessuna nuova dependency npm.
- Nessun cambio endpoint o payload API.
- Migliora la compatibilita screen reader e rende i messaggi auth coerenti con il caricamento server-aware dei cataloghi.
- La registrazione aggiorna la lingua lato client prima del completamento sessione, riducendo mismatch tra select, cookie SSR e successiva navigazione.

## Validazione locale

- `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`: compilazione, typecheck e generazione statica completati.
- `node scripts\smoke-http.mjs` da `src/RugbyRadioWebNext` con `SMOKE_PORT=3250`: passato su porte 3250/3251.
- `rg -n "TODO|console\.log|any|React\." ...`: nessun match nei sorgenti Next scansionati.

## Pending

- Validazione browser reale di login/register/reset con backend e credenziali.
- Verifica Google Identity Services con client id reale e callback runtime.
- Test screen reader/manuale completo su flusso OTP e messaggi errore.
