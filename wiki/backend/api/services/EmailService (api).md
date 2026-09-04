---
title: "EmailService (api)"
type: backend-service
layer: backend
---

# EmailService (api)

## Sintesi

Invia email transazionali via SMTP Aruba (MailKit, SSL porta 465). Gestisce OTP per reset password e email generica per feedback utente. Persiste ogni invio nella tabella `Email` con stato `Sent` o `Failed`.

## Responsabilità

- `SendOptCode` — email OTP reset password; persiste `Email` con esito
- `SendEmail` — email generica; nessuna persistenza DB; eccezione propagata al chiamante

## Consumer

- [[UserService (api)]] — OTP reset password
- [[UserV1Controller (api)]] — feedback utente

## Repository usati

- `IEmailRepository`
- `IUnitOfWork`

## Integrazioni usate

- [[SmtpEmail (api)]] — provider SMTP Aruba

## Jobs usati

Nessuno diretto (iniettato in `CreateMatchEventJob` ma utilizzo non verificato)

## Entities coinvolte

- [[Email (api)]]

## Workflow correlati

Non deducibile

## Side effects

- Invio email SMTP
- Scrittura DB: `Email` (solo in `SendOptCode`)

## Nome nel codice

`EmailService` — `src/RugbyRadio/Lib/Repositories/EmailBox/EmailService.cs`

## Note

Non deducibile dai RAW disponibili.
