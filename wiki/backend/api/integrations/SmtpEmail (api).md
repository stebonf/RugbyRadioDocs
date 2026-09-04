---
title: "SmtpEmail (api)"
type: backend-integration
layer: backend
---

# SmtpEmail (api)

## Sintesi

Integrazione SMTP con Aruba via MailKit (SSL, porta 465). Usata per invio email transazionali: OTP reset password e feedback utente. Ogni invio viene registrato nella tabella `Email`.

## Provider esterno

Aruba SMTP — libreria MailKit

## Responsabilità

- Invio email OTP reset password (`SendOptCode`) — persiste record `Email` con esito
- Invio email generica (`SendEmail`) — nessuna persistenza DB; eccezione propagata al chiamante

## Services consumer

- [[EmailService (api)]]

## Payload rilevanti

- Mittente fisso: `support@rugbyradiolive.com`
- OTP: subject `"Password Reset Request"`, corpo plain text in inglese
- Porta SSL: 465

## Retry/fallback

`SendOptCode`: catch → `Email.Status = Failed`, record salvato comunque. `SendEmail`: nessun catch, eccezione propagata.

## Side effects

- Invio email SMTP
- Scrittura `Email` in DB (solo `SendOptCode`)

## Configurazioni

- `Smtp:Host` — `smtps.aruba.it`
- `Smtp:Port` — `465`
- `Smtp:Username`, `Smtp:Password` — in `appsettings.json` (sensibili)

## Classe responsabile

`EmailService` — `src/RugbyRadio/Lib/Repositories/EmailBox/EmailService.cs`
