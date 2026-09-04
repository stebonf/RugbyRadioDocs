---
title: "Mappatura Audio TTS e Localizzazione (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Audio TTS e Localizzazione (comparison)

## Sintesi

Confronto tra AI-Talker, messaggi multilingua, TTS Audio e modalita Radio Evento, per chiarire come testi, lingua, stile e audio si collegano nella telecronaca.

## Scope

Include telecronaca testuale, messaggi AI, traduzioni, TTS e riproduzione audio lato frontend. Non include UI labels, traduzioni generiche dell'app o streaming server-side non documentato.

## Mappatura

| Area | Pagine collegate | Ruolo |
|---|---|---|
| Stile narrativo | [[AI-Talker (concept)]], [[Telecronaca (concept)]] | Determina stile e lingua percepita della telecronaca. |
| Messaggi AI | [[Sistema Messaggi Telecronaca AI (concept)]], [[SystemMessage (api)]], [[SystemMessageDraft (api)]] | Produce testi offline per tipi evento, lingue e stili. |
| Localizzazione | [[Localizzazione (concept)]], [[OllamaAI (api)]], [[TranslateMatchEventFemaleJob (api)]] | Gestisce traduzione in IT, EN, FR, ES, JA per telecronaca e blog. |
| TTS | [[TTS Audio (concept)]], [[VoiceService (api)]], [[AzureSpeech (api)]] | Sintetizza MP3 per preview o evento usando testi gia disponibili. |
| Riproduzione | [[Riproduzione Audio Telecronaca (workflow)]], [[MatchRadioPlayerService (web)]], [[MatchRadioStorageService (web)]], [[GMatchRadioPage (web)]] | Accoda e riproduce audio evento sul dispositivo. |

## Pattern

- I testi di telecronaca sono generati offline: non avviene AI realtime al click evento.
- La localizzazione ha due pipeline: messaggi telecronaca e blog.
- Il TTS e un layer opzionale sopra testi gia disponibili, non una diretta audio tradizionale.
- La Modalita Radio Evento e frontend-first: coda e preferenze sono gestite lato dispositivo.
- Non tutti gli AI-Talker hanno audio TTS disponibile.

## Gap noti

- Relazione tra lingua AI-Talker e lingua interfaccia frontend non deducibile.
- Prompt AI, modello Ollama e configurazioni Tailoor Talker non deducibili.
- Regole di caching audio oltre al controllo esistenza file non deducibili.
- Supporto background audio, lock screen e Media Session API non validato nella wiki.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`: [[AI-Talker (concept)]], [[TTS Audio (concept)]], [[Localizzazione (concept)]], [[Sistema Messaggi Telecronaca AI (concept)]] e [[Riproduzione Audio Telecronaca (workflow)]]. Nessun RAW letto.
