---
title: "userProfileDto (web)"
type: frontend-model
layer: frontend
---

# userProfileDto (web)

## Sintesi
DTO di risposta per il profilo utente completo. Include dati personali, preferenze, stato di verifica account, canali posseduti e canali seguiti.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| email | string | Indirizzo email dell'utente |
| nickname | string | Nickname pubblico dell'utente |
| avatarUrl | string | URL avatar dell'utente |
| language | string | Lingua preferita (codice ISO) |
| timezone | string | Fuso orario preferito |
| isVerified | boolean | Account verificato via email |
| channels | channelDto[] | Canali posseduti dall'utente |
| followChannels | channelPublicMinDto[] | Canali seguiti dall'utente |

## Origine dati
- API: USR-02 (GET profilo utente autenticato)

## Consumer FE
- [[ProfilePage (web)]]
- HomeUserComponent (web)
- BaseUserComponent

## API correlate
- USR-02: GET profilo utente completo

## Note
- Questo DTO è disponibile solo per l'utente autenticato (richiede JWT).
- `channels` include i canali di cui l'utente è owner/editor.
- `followChannels` usa `channelPublicMinDto` (versione ulteriormente ridotta di channelPublicDto).
