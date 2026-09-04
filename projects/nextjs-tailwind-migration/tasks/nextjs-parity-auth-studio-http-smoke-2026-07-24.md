# Next.js Parity Auth/Studio HTTP Smoke

Data: 2026-07-24

## Contesto

Estensione NXT-T021 dello smoke HTTP ripetibile `src/RugbyRadioWebNext/scripts/smoke-http.mjs`.

La prima versione copriva route pubbliche, redirect legacy principali, asset PWA/TWA e maintenance mode. Questa estensione aggiunge una verifica server-side minimale delle route protette account/studio e dei redirect legacy autenticati, senza richiedere browser, localStorage o token reale.

## Copertura aggiunta

Route protette verificate con status `200`, copy guard `Verifica sessione` e metadata `noindex`:

- `/account`
- `/account/profile`
- `/account/favorites`
- `/account/danger`
- `/studio/channels`
- `/studio/channels/smoke-channel`
- `/studio/matches/smoke-match`

Redirect legacy autenticati verificati con status/location:

- `/user-dashboard` -> `/account`
- `/user-profile` -> `/account/profile`
- `/user-favorites` -> `/account/favorites`
- `/user-danger` -> `/account/danger`
- `/user-channels` -> `/studio/channels`
- `/user-channel/smoke-channel` -> `/studio/channels/smoke-channel`
- `/user-match/smoke-match` -> `/studio/matches/smoke-match`

Lo smoke verifica inoltre `noindex` per `/design-system` e `/_maintenance`.

## Validazione locale

- `node --check scripts\smoke-http.mjs`: passato.
- `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`: compilazione, typecheck e generazione statica completati.
- `node scripts\smoke-http.mjs` con `SMOKE_PORT=3292`: passato su porte 3292/3293.
- `rg -n "TODO|console\.log|any|React\." ...` includendo `scripts/smoke-http.mjs`: nessun match.

## Limiti

- Non valida login reale, localStorage/sessione valida o token scaduto.
- Non esegue idratazione React, click, submit o flussi client-side.
- Non valida payload backend reali per account, canali studio o match studio.
- Non sostituisce QA visuale desktop/mobile o test browser.
