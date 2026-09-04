---
title: "Sistema Messaggi Telecronaca AI (concept)"
type: concept
layer: concept
---

# Sistema Messaggi Telecronaca AI (concept)

## Sintesi

Sistema di gestione dei messaggi di telecronaca generati dall'AI, multilingua, con flusso di bozze e approvazione. Comprende generazione, traduzione, verifica coerenza e pubblicazione dei testi usati per descrivere gli eventi partita.

## Scope

- Generazione AI messaggi per tipi evento partita
- Traduzione automatica in 5 lingue (IT, EN, FR, ES, JA)
- Sistema di bozze (draft) e approvazione con soglie di qualita
- Messaggi in variante maschile e femminile
- Integrazione con TTS Audio per sintesi vocale
- 10 stili telecronista (AI-Talker) per ogni tipo evento

## Componenti coinvolti

### Entita backend

- [[SystemMessage (api)]] — messaggio pubblicato con codice, lingua, testo M/F, versione
- [[SystemMessageDraft (api)]] — bozza in attesa di verifica con percentuali qualita e flag approvazione

### Servizio backend

- [[SystemMessageService (api)]] — generazione, traduzione, verifica e pubblicazione messaggi via AI

### Repository

- [[SystemMessageRepository (api)]] — lookup per codice evento e lingua, ricerca messaggi senza variante femminile

### Job Hangfire

- [[CreateMatchEventJob (api)]] — genera bozze da eventi reali recenti; filtra tipi non generabili; soglia 80% testo, 70% lingua
- [[CreateMatchEventAdminJob (api)]] — completa gruppi incompleti e approva gruppi con 39 draft verificati
- [[TranslateMatchEventFemaleJob (api)]] — completa varianti femminili mancanti

### API

- [[AdminV1Controller (api)]] — accesso diretto a bozze e statistiche messaggi

### AI

- [[OllamaAI (api)]] — LLM self-hosted per generazione e traduzione testi
- Tailoor Talker Helper — HTTP esterno per generazione e verifica messaggi (riferimento tecnico in [[SystemMessageService (api)]])

### Altri servizi

- [[VoiceService (api)]] — lettura messaggi di sistema per generazione audio TTS

### Concetti correlati

- [[Telecronaca (concept)]] — contesto di evento partita che i messaggi descrivono
- [[AI-Talker (concept)]] — personaggio virtuale che usa questi messaggi come voce
- [[Match Event Types (concept)]] — enum `MatchEventType` codificato nei messaggi come `MatchEventType-{N}`
- [[TTS Audio (concept)]] — sintesi vocale che consuma i messaggi pubblicati

## Relazioni principali

- [[CreateMatchEventJob (api)]] recupera eventi reali recenti, filtra tipi (`ErrataCorrige`, `Headset`, segnali arbitro 900–951), genera bozze via Tailoor Talker e salva in [[SystemMessageDraft (api)]] con soglie `verifyValue >= 80` e `verifyLanguageValue >= 70` per `IsVerified = true`
- [[CreateMatchEventAdminJob (api)]] recupera gruppi draft incompleti; se un gruppo ha esattamente 39 draft verificati, chiama `ApproveMessages` e promuove i record in [[SystemMessage (api)]]
- [[SystemMessageService (api)]] orchestra generazione (`AiTalkersCreateOllama`), traduzione (`AiTalkersTranslateOllama`), verifica (`AiTalkerCheckSentences`) e pubblicazione messaggi
- [[VoiceService (api)]] legge [[SystemMessage (api)]] per generare audio TTS tramite [[AzureSpeech (api)]]
- [[TranslateMatchEventFemaleJob (api)]] usa `FindFemaleNotTranslated` su [[SystemMessageRepository (api)]] per completare varianti femminili
- [[AdminV1Controller (api)]] permette gestione manuale bozze e statistiche messaggi
- Ogni messaggio e referenziato da codice `MatchEventType-{N}` dove `{N}` e il valore numerico dell'enum [[Match Event Types (concept)]]

## Decisioni architetturali

- Messaggi generati in anticipo (offline), non in realtime al click evento del cronista
- Flusso a tre stadi: draft (bozza) → verified (verificato) → published (promosso in SystemMessage)
- 5 lingue x 10 stili telecronista = fino a 50 varianti per tipo evento
- Placeholder giocatore (`FlagPlayer`) nei messaggi che includono il nome del giocatore
- Variante maschile e femminile per ogni messaggio
- Limite 10 chiamate AI per esecuzione in [[CreateMatchEventJob (api)]]
- Soglia fissa: 80% coerenza testo, 70% coerenza lingua per approvazione automatica draft

## Rischi

- Cron expression dei job Hangfire non deducibili dalla wiki
- Prompt AI, modello Ollama e configurazione Tailoor Talker non deducibili
- Set completo valori enum `MatchEventType` non deducibile (noti solo gruppi frequenti, tecnici e segnali arbitro)
- Soglie di verifica hardcoded? Non deducibile
- Meccanismo di fallback se la generazione AI fallisce per tutte le lingue: non deducibile

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`. Il sistema messaggi telecronaca AI e documentato in modo frammentato nelle pagine entity, service, repository e job; questa pagina ponte ne ricostruisce il flusso end-to-end. Nessun RAW letto.
