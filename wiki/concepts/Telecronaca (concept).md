---
title: "Telecronaca (concept)"
type: concept
layer: concept
---

# Telecronaca (concept)

## Sintesi
Insieme degli eventi cliccati da un cronista durante una partita.

## Scope
Ogni evento viene trasformato in frase di telecronaca tramite AI-Talker e mostrato agli spettatori collegati.

## Componenti coinvolti
- [[Cronista (actor)]]
- [[Spettatore (actor)]]
- [[AI-Talker (concept)]]
- [[Partita (concept)]]

## Relazioni principali
- La telecronaca appartiene a una partita
- La telecronaca e creata dal cronista
- La telecronaca e consumata dagli spettatori
- La telecronaca puo essere ascoltata tramite [[TTS Audio (concept)]] quando l'AI-Talker selezionato supporta audio

## Decisioni architetturali
Le frasi AI sono generate in anticipo e salvate nel database; non c'e chiamata AI realtime sul click evento.

## Rischi
Non deducibile dai RAW.

## Note
Evidenza da `RugbyRadioLive.md`.

Il TTS e un layer opzionale sopra la telecronaca testuale, documentato in `llm-wiki/raw/docs/rrl-tts.md`.

