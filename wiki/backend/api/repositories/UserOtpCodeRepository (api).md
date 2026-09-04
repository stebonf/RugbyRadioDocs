---
title: "UserOtpCodeRepository (api)"
type: backend-repository
layer: backend
---

# UserOtpCodeRepository (api)

## Sintesi

Repository per la persistenza dei codici OTP temporanei usati nel reset password.

## Responsabilità

- Gestire la persistenza di [[UserOtpCode (api)]].
- Supportare il reset password e la verifica OTP in [[UserService (api)]].

## Entities gestite

- [[UserOtpCode (api)]]

## Query rilevanti

Non deducibile dalla wiki attuale.

## Consumer

- [[UserService (api)]]

## Nome nel codice

`UserOtpCodeRepository` / `IUserOtpCodeRepository`

## Note

Pagina creata da riferimenti gia presenti nella wiki; dettagli implementativi non deducibili dalla wiki attuale.
