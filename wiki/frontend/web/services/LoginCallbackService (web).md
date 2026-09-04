---
title: "LoginCallbackService (web)"
type: frontend-service
layer: frontend
---

# LoginCallbackService (web)

## Sintesi

Gestisce il meccanismo di redirect post-login. Prima di reindirizzare l'utente alla pagina di login, salva l'URL di ritorno in localStorage in modo da poterlo ripristinare dopo l'autenticazione.

## Responsabilità

- Salvataggio dell'URL corrente in localStorage prima del redirect a login
- Recupero dell'URL di ritorno dopo il completamento del login
- Navigazione verso l'URL di ritorno tramite il Router Angular

## Consumer FE

- [[AuthGuardService (web)]]
- [[GChannelPage (web)]]
- [[LoginPage (web)]]

## API chiamate

- Nessuna

## DTO o modelli usati

- Nessuno

## Side effects

- Lettura e scrittura su localStorage (chiave URL di ritorno)
- Navigazione tramite Angular Router

## Note

Implementa il pattern "redirect to intended URL" standard per le applicazioni SPA. L'URL di ritorno viene rimosso da localStorage dopo il redirect avvenuto con successo per evitare redirect indesiderati alle sessioni successive.
