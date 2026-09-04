---
title: "Match Event Types (concept)"
type: concept
layer: concept
---

# Match Event Types (concept)

## Sintesi

L'enumerazione `MatchEventType` definisce i tipi di evento di telecronaca che un [[Cronista (actor)]] puo registrare durante una partita. Ogni tipo evento ha un codice numerico (stored as `int` nel DB), un'icona corrispondente nel frontend e un messaggio di telecronaca opzionale generato dall'AI.

## Scope

I tipi evento coprono azioni di gioco (Try, Scrum, Conversion, ecc.), eventi tecnici (ErrataCorrige, Headset) e segnali arbitro (codici 900–951). Il tipo evento determina l'icona, il comportamento visivo nel feed e, per i tipi filtrabili, la generazione di bozze AI multilingua.

## Componenti coinvolti

- [[MatchEvent (api)]] — proprieta `Type` (`MatchEventType`)
- [[MatchEventCreated]] — payload `MatchEventAddDto` con tipo evento
- [[matchEventDto (web)]] — campo `type` (`matchEventType`)
- [[matchEventAddDto (web)]] — campo `type` (`matchEventType`)
- [[SystemMessage (api)]] — codice `MatchEventType-{N}`
- [[CreateMatchEventJob (api)]] — filtro tipi per generazione AI
- [[CreateMatchEventAdminJob (api)]] — generazione messaggi per tipo
- [[Platform Stats 2026-05-13 (analytic)]] — frequenza tipi evento
- [[Telecronaca (concept)]]
- [[Partita (concept)]]

## Relazioni principali

- Ogni [[MatchEvent (api)]] ha un `Type` di tipo `MatchEventType` (enum stored as int in `Events` table)
- I messaggi di telecronaca localizzati sono referenziati da [[SystemMessage (api)]] via codice `MatchEventType-{N}` dove `{N}` e il valore numerico dell'enum
- Il frontend mappa ogni `matchEventType` a un'icona e a un comportamento visivo nel feed di [[MatchEventsComponent (web)]] e [[GMatchEventsComponent (web)]]
- [[CreateMatchEventJob (api)]] filtra i tipi `ErrataCorrige`, `Headset` e segnali arbitro (900–951) per la generazione AI di bozze telecronaca
- [[CreateMatchEventAdminJob (api)]] genera messaggi per tutti i `MatchEventType` mancanti

## Tipi noti

Dalla wiki sono identificabili i seguenti gruppi:

**Eventi di gioco frequenti** (fonte: [[Platform Stats 2026-05-13 (analytic)]]):
- Try
- Scrum
- Conversion
- ConversionFailed
- Touche
- Kick
- ForwardPass

**Eventi tecnici** (fonte: [[CreateMatchEventJob (api)]]):
- ErrataCorrige — eventi correttivi, esclusi da generazione AI
- Headset — eventi microfono/cuffia, esclusi da generazione AI

**Segnali arbitro** (fonte: [[CreateMatchEventJob (api)]]):
- Codici 900–951 — esclusi da generazione AI

La descrizione `matchEventType` nel frontend come "gol, ammonizione, espulsione, ecc." e probabilmente un naming generico non allineato al dominio rugby.

## Note

- I valori numerici esatti dell'enum `MatchEventType` non sono documentati nella wiki; il riferimento `SystemMessage.Code` formato `MatchEventType-{N}` suggerisce codici come `MatchEventType-300` per Conversion o simili
- La `TypeVersion` su [[MatchEvent (api)]] indica una versione del messaggio associata al tipo evento
- Il set completo dei valori enum non e deducibile dalla wiki
- Le regole di validazione (tipi consentiti per minuto, squadra, zona campo) non sono deducibili
- La conversione `MatchEventType` → `int` e configurata in [[AppDbContext (api)]] via `HasConversion<int>()` in `OnModelCreating`
