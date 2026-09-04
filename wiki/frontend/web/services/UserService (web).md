---
title: "UserService (web)"
type: frontend-service
layer: frontend
---

# UserService (web)

## Sintesi

Gestisce autenticazione, sessione JWT su localStorage, stato reattivo dell'utente corrente e preferenze. Integra Firebase FCM per la ricezione di notifiche push.

## Responsabilità

- Esecuzione login, logout e refresh token JWT
- Persistenza e lettura del token in localStorage
- Esposizione di stream reattivi: `isLoggedIn$`, `userNickname$`, `isSplashVisible$`
- Recupero e aggiornamento del profilo utente
- Registrazione del token Firebase FCM per le notifiche push
- Persistenza lingua e AI-Talker/commentator selezionato per la telecronaca
- Verifica disponibilita audio TTS per il commentator corrente

## Consumer FE

- [[LoginPage (web)]]
- [[RegistrationPage (web)]]
- [[ResetPasswordPage (web)]]
- [[ProfilePage (web)]]
- HeaderComponent (web)
- [[EntityBottomNavComponent (web)]]
- [[AuthGuardService (web)]]

## API chiamate

- [[AuthV1Controller (api)]]
- [[UserV1Controller (api)]]

## DTO o modelli usati

- userLoginDto (web)
- [[userTokenDto (web)]]
- [[userProfileDto (web)]]
- userUpdateDto (web)

## Side effects

- Lettura e scrittura su localStorage (token JWT, dati profilo)
- Lettura e scrittura su localStorage di `user_language` e `commentator_id`
- Registrazione del token Firebase FCM
- Aggiornamento dei BehaviorSubject `isLoggedIn$`, `userNickname$`, `isSplashVisible$`

## Note

Il token JWT viene memorizzato in localStorage e riletto all'avvio dell'applicazione per ripristinare la sessione. I BehaviorSubject permettono a qualsiasi componente di reagire in modo reattivo ai cambiamenti di stato dell'utente.

Per il TTS, il servizio ritorna audio disponibile solo per base language e per i talker Arcaico, Influencer, Adolescente, Chef, Alieno ed ExPlayer nelle lingue supportate. Talker come Rapper, Telecronista, Milanese e Romano risultano privi di audio TTS.

