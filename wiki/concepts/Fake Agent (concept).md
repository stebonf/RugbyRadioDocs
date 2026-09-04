---
title: "Fake Agent (concept)"
type: concept
layer: concept
---

# Fake Agent (concept)

## Sintesi

Sistema di job Hangfire che genera dati di simulazione (canali, squadre, giocatori, partite, eventi) per popolare la piattaforma con contenuti artificiali. I Fake Agent condividono una classe base `FakeAgent` e sono raggruppati nel namespace `FakeAgents`.

## Componenti coinvolti

- [[FakeLastYearAgentJob (api)]] — simula partite storizzate dell'anno scorso; usa [[UserService (api)]] e [[MatchService (api)]] per creare canali, squadre, giocatori ed eventi; genera testi evento via Tailoor Talker
- [[FakeLeagueAgentJob (api)]] — simula una lega fake leggendo configurazione da [[FakeAgentSetting (api)]]; estende `FakeAgent`; crea dati per canale, squadre, giocatori e partite configurati
- [[FakeFantasyAgentJob (api)]] — stub non funzionale, corpo vuoto, nessuna implementazione
- [[FakeAgentSetting (api)]] — entity di configurazione per lega fake: anno/mese, canale base, squadra principale, lingua, limiti generazione, dati prossima partita

## Relazioni principali

- I job FakeAgent risiedono in `src/RugbyRadio/HF/Jobs/FakeAgents/` e sono eseguiti come Hangfire RecurringJobAdmin; le cron expression non sono deducibili dalla wiki
- La entity [[FakeAgentSetting (api)]] e la repository associata vivono in `src/RugbyRadio/Lib/Repositories/FakeAgentBox/`
- Il DB mapping usa `[Table("FakeAgentSettings")]` in [[AppDbContext (api)]]
- I job condividono il pattern `[AutomaticRetry(Attempts = 0)]` — nessun retry automatico in caso di fallimento
- Entrambi i job funzionali effettuano chiamate HTTP esterne a Tailoor Talker per generazione testi evento
- [[Platform Stats 2026-05-13 (analytic)]] documenta che il dataset piattaforma (230 utenti, 62 canali, 281 partite, 10940 eventi) include contenuti creati sia da utenti reali sia da Fake Agent

## Decisioni architetturali

- I Fake Agent operano offline via Hangfire, non in tempo reale su richiesta utente
- La configurazione della lega simulata e persistita su DB tramite [[FakeAgentSetting (api)]] e letta a runtime da [[FakeLeagueAgentJob (api)]]
- [[FakeLastYearAgentJob (api)]] non usa configurazione DB ma genera dati basati su anno bersaglio
- [[FakeFantasyAgentJob (api)]] e uno stub senza implementazione: contiene solo commenti placeholder

## Rischi

- Cron expression dei job Hangfire non deducibili dalla wiki
- Corpo specifico dei job non letto integralmente; logica dedotta parzialmente dalle descrizioni disponibili
- Impatto dei dati fake sulle metriche di piattaforma non distinguibile nelle statistiche aggregate

## Note

Pagina ponte creata da pagine wiki esistenti: FakeLastYearAgentJob, FakeLeagueAgentJob, FakeFantasyAgentJob, FakeAgentSetting, Platform Stats 2026-05-13 (analytic), UserService, MatchService, AppDbContext. Nessun RAW letto. I dettagli implementativi dei corpi job (FakeAgent base class, Tailoor Talker, logica di generazione) non sono verificabili integralmente dalla wiki.
