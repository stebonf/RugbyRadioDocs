---
title: "MatchHeaderComponent (web)"
type: frontend-component
layer: frontend
---

# MatchHeaderComponent (web)

## Sintesi
Header visuale della partita. Mostra punteggio, squadre, stato della partita (in corso, intervallo, terminata), immagine di sfondo e gradiente cromatico derivato dai colori del canale.

## Responsabilità
- Visualizzare il punteggio home/away e i nomi delle squadre
- Mostrare lo stato della partita (in corso, intervallo, terminata)
- Applicare gradiente di colore basato sul canale della partita
- Gestire il skeleton loading durante il caricamento
- Tracciare errori tramite LoggingService

## Parent pages
- [[GMatchPage (web)]]
- [[MatchPage (web)]]

## Child components
Nessuno.

## Servizi FE usati
- [[LoggingService (web)]]

## Modelli FE usati
- [[matchDto (web)]]

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | match | matchDto | Dati completi della partita |
| Input | isLoading | boolean | Attiva skeleton loading |
| Input | isStarted | boolean | La partita è iniziata |
| Input | isHalfTime | boolean | La partita è all'intervallo |
| Input | isFullTime | boolean | La partita è terminata |
| Input | isEditor | boolean | L'utente è editor della partita |

## Note
- Il gradiente cromatico viene derivato da `match.channel.headerBgColor` e `match.channel.headerFtColor`.
- Gli stati isStarted, isHalfTime, isFullTime derivano dal campo `match.status` ma vengono passati già calcolati dal parent per semplicità.
