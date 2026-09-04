---
title: "ChannelUserService (web)"
type: frontend-service
layer: frontend
---

# ChannelUserService (web)

## Sintesi

API client per la gestione dei co-editor di un canale. Permette di aggiungere, elencare e rimuovere utenti con ruolo di editor su un canale.

## Responsabilità

- Recupero della lista dei co-editor di un canale
- Aggiunta di nuovi co-editor
- Rimozione di co-editor esistenti

## Consumer FE

- [[ChannelPage (web)]] (sub-componente Editors)

## API chiamate

- [[ChannelUsersV1Controller (api)]]

## DTO o modelli usati

- channelUserDto (web)
- channelUserAddDto (web)

## Side effects

- Chiamate HTTP verso le API backend

## Note

Utilizzato esclusivamente nella sezione di gestione editor della pagina canale. Separato da ChannelService per mantenere la separazione delle responsabilità.

