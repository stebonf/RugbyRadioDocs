---
title: "Mappatura Integrazioni Esterne (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Integrazioni Esterne (comparison)

## Sintesi

Mappa le integrazioni esterne e pseudo-esterne documentate nella wiki, distinguendo provider runtime, provider AI/TTS, servizi social, email, analytics e pubblicazione su filesystem. L'obiettivo e evidenziare consumer, side effect e retry/fallback dove gia documentati.

## Scope

Include solo integrazioni gia presenti come pagine wiki o collegate da servizi, job e concept esistenti.

## Integrazioni runtime

| Integrazione | Provider | Consumer principali | Side effect | Retry/fallback |
|---|---|---|---|---|
| [[FirebaseFCM (api)]] | Firebase Cloud Messaging | [[MatchService (api)]], [[UserService (api)]], [[UserToken (api)]] | Invio notifiche push e pulizia token invalidi | Non deducibile oltre alla rimozione token non validi |
| [[SmtpEmail (api)]] | Aruba SMTP via MailKit | [[EmailService (api)]], [[UserService (api)]], [[UserV1Controller (api)]] | Invio OTP e feedback, scrittura `Email` per OTP | `SendOptCode` registra fallimento; `SendEmail` propaga eccezione |
| [[GoogleOAuth (api)]] | Google Identity | [[UserService (api)]], [[AuthV1Controller (api)]] | Validazione Google ID Token per login/registrazione | Non deducibile |
| [[FacebookGraphAPI (api)]] | Meta/Facebook Graph API | [[FacebookService (api)]], [[FacebookJob (api)]] | Exchange token, lettura pagine, pubblicazione foto, revoke | Non deducibile |

## Integrazioni AI, audio e contenuti

| Integrazione | Provider | Consumer principali | Output |
|---|---|---|---|
| [[OllamaAI (api)]] | Ollama via OllamaSharp | [[AiOllamaService (api)]], [[SystemMessageService (api)]] | Blog, messaggi telecronaca, traduzioni e contenuti AI |
| [[AzureSpeech (api)]] | Azure Cognitive Services TTS | [[VoiceService (api)]], [[TTS Audio (concept)]] | File MP3 per riproduzione audio telecronaca |
| [[BlogStaticFilePublishingIntegration (api)]] | Filesystem pubblico | [[CreateMatchBlogHtmlJob (api)]] | HTML statico, landing, indici e sitemap blog |
| [[SeoSitemapFilePublishingIntegration (api)]] | Filesystem pubblico | [[GenerateSeoSitemapJob (api)]] | Sitemap XML e sitemap index |

## Integrazioni di riferimento pubblico

| Integrazione | Provider | Consumer principali | Nota |
|---|---|---|---|
| [[SocialShareUrlIntegration (api)]] | WhatsApp, X/Twitter, Facebook, Instagram, YouTube | [[CreateMatchBlogHtmlJob (api)]] | Inserisce URL social negli HTML statici, senza chiamate HTTP runtime documentate. |
| [[PublicMediaUrlReferenceIntegration (api)]] | `storage-sh.rugbyradiolive.com` | [[CreateMatchBlogHtmlJob (api)]] | Inserisce riferimenti assoluti a immagini e loghi pubblici. |
| [[AnalyticsService (web)]] | Firebase Analytics / Google Analytics | Pagine frontend principali | Invio eventi tramite SDK frontend, opzionale se Firebase non e configurato. |

## Pattern ricorrenti

- Le integrazioni con provider esterni sono incapsulate in servizi o job specifici, poi richiamate dai workflow applicativi.
- Le integrazioni filesystem sono trattate come side effect di job Hangfire, non come API pubbliche.
- Le integrazioni social server-side documentate sono concentrate su pubblicazione Facebook e generazione di link social statici.
- Le credenziali sensibili risultano citate nelle pagine di configurazione o integrazione, ma la wiki non descrive una strategia completa di secret management.

## Gap noti

- Le policy di retry complete non sono deducibili per molte integrazioni.
- Non e sempre deducibile quali chiamate siano sincrone, asincrone o schedulate oltre al job consumer documentato.
- Non sono deducibili SLA, limiti provider, rate limiting o osservabilita specifica per integrazione.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`. Non sono state lette fonti RAW.
