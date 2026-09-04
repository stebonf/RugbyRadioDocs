---
title: "Localizzazione (concept)"
type: concept
layer: concept
---

# Localizzazione (concept)

## Sintesi

Sistema multilingua della piattaforma, che supporta 5 lingue (IT, EN, FR, ES, JA) su due domini di contenuto distinti: messaggi di telecronaca AI e post blog editoriali. Ogni dominio ha una propria pipeline di generazione e traduzione, entrambe basate su [[OllamaAI (api)]] come LLM condiviso.

## Lingue supportate

| Lingua | Telecronaca | Blog | TTS Audio |
|--------|-------------|------|-----------|
| IT | SystemMessage | Blog | AzureSpeech |
| EN | SystemMessage | Blog | AzureSpeech |
| FR | SystemMessage | Blog | AzureSpeech |
| ES | SystemMessage | Blog | AzureSpeech |
| JA | SystemMessage | Blog | AzureSpeech |

## Pipeline 1: Traduzione Messaggi Telecronaca

Il [[Sistema Messaggi Telecronaca AI (concept)]] genera messaggi di sistema per tipi evento partita in 5 lingue x 10 stili AI-Talker = fino a 50 varianti per tipo evento.

- **Generazione**: [[SystemMessageService (api)]] genera testo IT via [[OllamaAI (api)]], poi traduce in EN, FR, ES, JA
- **Qualita**: soglia `verifyValue >= 80` (coerenza testo) e `verifyLanguageValue >= 70` (coerenza lingua) in [[SystemMessageDraft (api)]]
- **Variante femminile**: [[TranslateMatchEventFemaleJob (api)]] traduce `MessageFemale` per batch di 20 messaggi per lingua usando Tailoor Talker
- **Persistenza**: [[SystemMessage (api)]] con campo `Language` (IT, EN, FR, ES, JA), testi `Message` e `MessageFemale`
- **Lookup**: [[SystemMessageRepository (api)]] — `FindByCodeAsync(code, language)` per tipo evento e lingua

## Pipeline 2: Traduzione Blog

Il [[Blog (concept)]] genera post editoriali per partite terminate in 5 lingue.

- **Generazione**: [[AiOllamaService (api)]] genera post IT via [[OllamaAI (api)]], poi traduce in EN, FR, ES, JA
- **Persistenza**: 5 record [[Blog (api)]] per partita (uno per lingua), collegati da `MatchId`
- **Staticizzazione**: [[CreateMatchBlogHtmlJob (api)]] produce HTML statici per ogni lingua con header hreflang (cfr. [[Static Blog SEO Headers (article)]])
- **Pubblicazione**: [[BlogStaticFilePublishingIntegration (api)]] scrive su filesystem

## AI-Talker e Lingue

- 10 [[AI-Talker (concept)]]: ogni talker supporta tutte le 5 lingue
- Lo spettatore sceglie stile e lingua nel [[MatchCommentatorComponent (web)]]
- La preview audio TTS usa frasi hardcoded per lingua/stile in [[VoiceService (api)]]
- Il mapping vocale `GetVoice(language)` in [[VoiceService (api)]] determina la sintesi [[AzureSpeech (api)]] per lingua

## TTS Audio per Lingua

[[VoiceService (api)]] genera file MP3 per evento in tutte le 5 lingue tramite [[AzureSpeech (api)]], con cache su filesystem. La lingua determina la voce di sintesi e lo stile vocale (Arcaico, Influencer, Adolescente, Alieno, ExPlayer, Chef).

## Componenti trasversali

- [[OllamaAI (api)]] — LLM self-hosted condiviso tra le due pipeline
- [[SystemMessageService (api)]] — traduzione messaggi telecronaca
- [[AiOllamaService (api)]] — generazione e traduzione blog
- [[VoiceService (api)]] — sintesi vocale per lingua
- [[AzureSpeech (api)]] — provider TTS esterno

## Decisioni architetturali

- Generazione IT prima, traduzione alle altre 4 lingue in entrambe le pipeline
- AI offline: nessuna chiamata AI realtime, contenuti generati in anticipo da job Hangfire
- Due pipeline separate: telecronaca usa SystemMessageService + Tailoor Talker, blog usa AiOllamaService
- Stessa integrazione [[OllamaAI (api)]] ma servizi consumer distinti
- TTS audio layer opzionale sopra i testi gia tradotti

## Gap noti

- Cron expression dei job di traduzione non deducibili
- Prompt template AI per generazione/traduzione non deducibili
- Ambito contenuti NON localizzati (UI labels, pagine admin, error messages) non documentato
- Relazione tra lingua AI-Talker e lingua interfaccia frontend non deducibile
- La pipeline blog ha un'ambiguità nelle fonti wiki: [[Blog (concept)]] indica EN come lingua primaria generata via Tailoor Talker, mentre [[AiOllamaService (api)]] indica IT come lingua primaria generata via Ollama
