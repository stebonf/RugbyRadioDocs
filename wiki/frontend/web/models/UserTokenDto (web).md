---
title: "userTokenDto (web)"
type: frontend-model
layer: frontend
---

# userTokenDto (web)

## Sintesi
DTO di risposta post-login o post-registrazione contenente il token JWT e i dati base dell'utente. Viene persistito in localStorage da UserService per mantenere la sessione.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| id | string | Identificatore univoco dell'utente |
| nickname | string | Nickname pubblico dell'utente |
| token | string | Token JWT per le chiamate API autenticate |
| language | string | Lingua preferita dell'utente (codice ISO) |

## Origine dati
- API: ATH-01 (POST login), ATH-03 (POST registrazione), ATH-04 (POST login social), ATH-06 (POST refresh token)

## Consumer FE
- UserService (web) — persiste e legge da localStorage
- [[LoginPage (web)]]
- [[RegistrationPage (web)]]

## API correlate
- ATH-01: POST login con email/password
- ATH-03: POST registrazione nuovo utente
- ATH-04: POST login tramite provider social (Google, Apple, ecc.)
- ATH-06: POST refresh del token JWT

## Note
- Il token viene salvato in localStorage con chiave dedicata da UserService.
- Alla lettura da localStorage, UserService popola lo stato utente dell'intera app.
- Il campo `language` viene usato per impostare la lingua dell'app al momento del login.
