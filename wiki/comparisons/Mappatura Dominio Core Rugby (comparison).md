---
title: "Mappatura Dominio Core Rugby (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Dominio Core Rugby (comparison)

## Sintesi

Confronto tra i concetti centrali del dominio rugby documentati nella wiki: canale, squadra, partita, formazione, co-proprieta e ciclo di vita partita.

## Scope

Include solo concetti, workflow, pagine e componenti gia formalizzati nella wiki. Non include regole sportive generali non documentate.

## Mappatura

| Concetto | Ruolo nel dominio | Relazioni principali |
|---|---|---|
| [[Radio Canale (concept)]] | Contenitore pubblico di partite, gestito da cronisti. | Contiene [[Partita (concept)]], e gestito tramite [[Gestione Canale (workflow)]], puo essere seguito dagli spettatori. |
| [[Squadra (concept)]] | Entita sportiva associata a un canale. | Appartiene a [[Radio Canale (concept)]], partecipa a [[Partita (concept)]], contiene [[Player (api)]]. |
| [[Partita (concept)]] | Incontro tra due squadre con eventi di telecronaca. | Appartiene a un canale, coinvolge due squadre, genera eventi, contenuti e interazioni. |
| [[Ciclo di Vita Partita (concept)]] | Stato operativo della partita. | Stati Scheduled, InProgress, Halftime e FullTime determinano visibilita e automazioni. |
| [[Co-proprietà (concept)]] | Modello owner/co-owner del canale. | Regola autorizzazioni su canali, squadre, giocatori, partite e formazioni. |

## Pattern

- Il canale e il confine di ownership: squadre, partite e co-editor dipendono dal canale.
- La partita e il centro del flusso runtime: collega squadre, eventi, spettatori, interazioni e contenuti post-partita.
- La squadra e riutilizzabile tra piu partite dello stesso canale.
- Il ciclo di vita della partita determina quando la partita diventa pubblica e quando partono le automazioni post-FullTime.
- La co-proprieta consente a co-owner di gestire squadre e partite, ma non giocatori o co-editor secondo le pagine wiki.

## Workflow collegati

- [[Gestione Canale (workflow)]] — crea e aggiorna canali, layout, co-editor e dati collegati.
- [[Cronista Telecronaca (workflow)]] — usa canale, squadre, partita, formazione ed eventi.
- [[Spettatore Partita (workflow)]] — consuma partita pubblica, eventi, commenti, reazioni e voti.

## Gap noti

- Regole complete di campionato/classifica non deducibili.
- Vincoli di validazione per squadra, giocatore e partita non completamente deducibili.
- Dettaglio completo di conflitti tra owner e co-owner non deducibile.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`: [[Radio Canale (concept)]], [[Squadra (concept)]], [[Partita (concept)]], [[Ciclo di Vita Partita (concept)]], [[Co-proprietà (concept)]] e workflow collegati. Nessun RAW letto.
