---
title: "Generazione Immagini (concept)"
type: concept
layer: concept
---

# Generazione Immagini (concept)

## Sintesi

Pipeline di generazione automatica di immagini per partite e canali, basata su job Hangfire e integrazione con Tailoor Painter AI. Le immagini sono usate come copertina di partite e canali, convertite per Instagram e arricchite con tabellino visuale.

## Componenti coinvolti

- [[CreateMatchImageJob (api)]] — generazione WebP partite (1200x630, qualita 75, lossy)
- [[CreateMatchImageInstagramJob (api)]] — conversione WebP → JPG (1080x1350) per Instagram partite
- [[CreateChannelImageJob (api)]] — generazione WebP canali
- [[CreateChannelImageInstagramJob (api)]] — conversione WebP → JPG per Instagram canali
- [[RepairMatchImageJob (api)]] — assegnazione immagini a partite senza copertina e compositing tabellino
- [[FacebookJob (api)]] — generazione immagine e compositing per pubblicazione Facebook
- [[MatchService (api)]] — compositing immagine partita con tabellino visuale (squadre, punteggio)

## Relazioni principali

- Le immagini partita sono generate in formato WebP (1200x630, qualita 75, lossy) e salvate in `D:\Web\RugbyRadioStorage\Matches-New\`
- Le immagini canale seguono lo stesso pattern con output in `ChannelImageNewUrl`
- La conversione Instagram produce JPG (1080x1350, qualita 90) con skip se file gia presente o se contiene `-original` nel nome
- [[RepairMatchImageJob (api)]] seleziona un'immagine casuale dal pool per partite senza copertina, la copia come `-original`, compone il tabellino visuale (ImageSharp + SixLabors.Fonts) e aggiorna [[Match (api)]]`.`ImageUrl
- Il limite di 10.000 immagini per cartella ferma la generazione per sicurezza
- [[CreateMatchImageJob (api)]] e [[CreateChannelImageJob (api)]] usano Painter ID hardcoded `5382e0a5-700c-4e6b-ba85-e0d842806200`
- I prompt AI sono differenziati per contesto: `Prompts/Painters/Match/` per partite, `Prompts/Painters/Channel/` per canali
- [[Partita (concept)]] e [[Radio Canale (concept)]] citano la generazione automatica di immagini di copertina tramite AI

## Decisioni architetturali

- Generazione offline via job Hangfire RecurringJobAdmin, non in tempo reale
- Nessuna dipendenza DB per le immagini di pool (solo filesystem + aggiornamento `ImageUrl` su entita)
- I job Instagram contengono metodo `WritePost` per pubblicazione social (side effect non completamente deducibile)
- [[FacebookJob (api)]] genera immagine autonoma e compone tabellino separatamente dal flusso immagini partita

## Rischi

- Cron expression dei job Hangfire non deducibili dalla wiki
- Side effects `WritePost` in job Instagram non completamente deducibili
- Dettaglio compositing immagine in [[MatchService (api)]] (~2000 righe) non verificato integralmente

## Note

Pagina creata da pagine wiki esistenti: CreateMatchImageJob, CreateMatchImageInstagramJob, CreateChannelImageJob, CreateChannelImageInstagramJob, RepairMatchImageJob, FacebookJob, MatchService, Partita (concept), Radio Canale (concept). Nessun RAW letto. Painter ID hardcoded documentato come segnalazione.
