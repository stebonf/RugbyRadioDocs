---
title: "Esperienza Spettatore Partita (article)"
type: article
layer: concept
---

# Esperienza Spettatore Partita (article)

## Sintesi

L'esperienza spettatore consente di seguire partite pubbliche, leggere eventi, interagire con commenti, reazioni, voti e ascoltare audio TTS quando disponibile.

## Scope

Questa pagina collega il workflow spettatore alle pagine pubbliche, ai dati partita e al sottoflusso audio.

## Componenti coinvolti

- [[Spettatore Partita (workflow)]]
- [[Spettatore (actor)]]
- [[GMatchPage (web)]]
- [[GMatchesPage (web)]]
- [[GChannelPage (web)]]
- [[GTeamPage (web)]]
- [[MatchEventsComponent (web)]]
- [[MatchCommentatorComponent (web)]]
- [[MatchesV1Controller (api)]]
- [[BlogV1Controller (api)]]
- [[VoicesV1Controller (api)]]
- [[Riproduzione Audio Telecronaca (workflow)]]

## Relazioni principali

- Lo spettatore apre un link pubblico alla partita o naviga da liste pubbliche.
- [[GMatchPage (web)]] e il fulcro dell'esperienza partita pubblica.
- [[MatchesV1Controller (api)]] fornisce dati partita.
- [[BlogV1Controller (api)]] collega eventuali contenuti blog.
- [[VoicesV1Controller (api)]] abilita audio TTS quando disponibile.

## Note

Articolo creato usando solo pagine wiki esistenti. Vincoli esatti su commenti, rating, follow e polling non sono completamente deducibili.

