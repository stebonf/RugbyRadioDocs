---
type: decision-record
created: 2026-07-23T21:38:00+02:00
source: tasklist-nextjs-tailwind-migration
topic: "Auth e sessione RugbyRadioWebNext"
---

# Auth e sessione RugbyRadioWebNext

## Decisione

La fase 1 mantiene sessione e token in `localStorage`, in continuita con Angular. Il server renderizza shell e contenuti pubblici; le aree protette verificano la sessione lato client prima di chiamare API con token.

## Regole implementative

- Chiavi legacy preservate: `token_id`, `user_id`, `user_nickname`, `user_language`, `commentator_id`, `login_callback`.
- Header API preservati:
  - `Authorization: Bearer <token>` solo verso API RRL quando token presente.
  - `X-USER-LANGUAGE`.
  - `X-COMMENTARY-LANGUAGE`.
- Route protette fase 1:
  - render shell non sensibile;
  - client guard controlla token;
  - se token assente, salva callback e naviga a `/login`.
- Login riuscito salva sessione in localStorage e torna alla callback o ad area default.

## Rischi accettati in fase 1

- Token accessibile a JavaScript come nell'app Angular.
- SSR non puo autenticare veramente l'utente senza cookie httpOnly.
- La protezione effettiva dei dati resta lato backend.

## Evoluzione consigliata

Valutare cookie httpOnly e BFF/proxy auth in una fase successiva, dopo parita funzionale e stabilizzazione Cloudflare.
