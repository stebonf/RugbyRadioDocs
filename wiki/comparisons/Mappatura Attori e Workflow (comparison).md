---
title: "Mappatura Attori e Workflow (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Attori e Workflow (comparison)

## Sintesi

Confronto tra attori business e workflow documentati nella wiki, con lo scopo di chiarire quali percorsi sono guidati da utenti finali, cronisti, amministratori o job tecnici.

## Scope

Include gli attori canonici e i workflow presenti in `wiki/workflows/`. Non include funzionalita non formalizzate come workflow, ne sottoflussi descritti solo dentro pagine tecniche.

## Mappatura

### Workflow per attore

| Attore | Workflow principali | Ruolo nel prodotto |
|---|---|---|
| [[Cronista (actor)]] | [[Autenticazione Utente (workflow)]], [[Gestione Canale (workflow)]], [[Cronista Telecronaca (workflow)]] | Crea canali, gestisce partite e inserisce eventi di telecronaca. |
| [[Spettatore (actor)]] | [[Spettatore Partita (workflow)]], [[Riproduzione Audio Telecronaca (workflow)]], [[Autenticazione Utente (workflow)]] | Segue partite pubbliche, ascolta contenuti audio e interagisce quando autenticato. |
| [[Amministratore (actor)]] | [[Operazioni Amministrative (workflow)]], [[Backup USB (workflow)]] | Supervisiona manutenzione, job, messaggi di sistema, backup e superfici operative. |

### Workflow tecnici senza attore diretto

| Workflow | Driver principale | Note |
|---|---|---|
| [[Pubblicazione Blog Statico (workflow)]] | Job Hangfire | Workflow tecnico di generazione contenuti blog, staticizzazione HTML, sitemap e header SEO. |

## Pattern

- [[Rugby Radio Live (product)]] definisce [[Cronista (actor)]] e [[Spettatore (actor)]] come attori principali del prodotto.
- [[Cronista (actor)]] opera nel lato autenticato/editoriale: canali, partite, formazioni ed eventi.
- [[Spettatore (actor)]] puo fruire contenuti pubblici anche senza account, ma alcune interazioni richiedono [[Autenticazione Utente (workflow)]].
- [[Amministratore (actor)]] e separato dagli attori prodotto: opera su superfici di manutenzione, audit, backup e gestione messaggi.
- [[Pubblicazione Blog Statico (workflow)]] e un workflow tecnico asincrono: non ha attore business deducibile nella pagina workflow.

## Relazioni con concept

- [[Telecronaca (concept)]] e [[Partita (concept)]] collegano [[Cronista Telecronaca (workflow)]] e [[Spettatore Partita (workflow)]].
- [[Radio Canale (concept)]] e [[Co-proprietà (concept)]] chiariscono il contesto di [[Gestione Canale (workflow)]].
- [[TTS Audio (concept)]] e [[AI-Talker (concept)]] supportano [[Riproduzione Audio Telecronaca (workflow)]].
- [[Operativita Backend (concept)]] supporta [[Operazioni Amministrative (workflow)]] e [[Backup USB (workflow)]].
- [[Blog (concept)]], [[Pipeline Contenuti (concept)]] e [[Superficie SEO Pubblica (concept)]] supportano [[Pubblicazione Blog Statico (workflow)]].

## Gap noti

- Non tutti i workflow hanno analytics tracking deducibile.
- [[Pubblicazione Blog Statico (workflow)]] non dichiara un attore business.
- Trigger end-to-end amministrativi tra dashboard, maintenance page e job non sono completamente deducibili.
- La wiki non documenta una matrice completa di permessi per ogni azione utente oltre alle pagine dedicate a sicurezza e co-proprieta.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`: attori, workflow, prodotto e concept collegati. Nessun RAW letto.
