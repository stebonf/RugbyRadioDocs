---
title: "AI-Talker (concept)"
type: concept
layer: concept
---

# AI-Talker (concept)

## Sintesi
Personaggio virtuale che determina stile e lingua delle frasi di telecronaca generate per gli eventi.

## Scope
Gli spettatori possono scegliere un AI-Talker diverso; la stessa partita puo essere raccontata con stili diversi.

## Componenti coinvolti
- [[Telecronaca (concept)]]
- [[Spettatore (actor)]]
- [[Cronista (actor)]]

## Relazioni principali
- Usa testi di sistema generati offline
- E collegato agli eventi partita
- Influenza stile e lingua della telecronaca mostrata
- Puo abilitare o meno audio TTS tramite [[TTS Audio (concept)]]

## Decisioni architetturali
Nessuna chiamata AI realtime al click evento; le frasi sono gia pronte e salvate nel database.

## Rischi
Non deducibile dai RAW.

## Note
AI-Talker e anche elemento di branding del prodotto.

Non tutti gli AI-Talker hanno audio TTS disponibile: Rapper, Telecronista, Milanese e Romano risultano privi di voce audio nei RAW TTS.
