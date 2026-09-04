---
title: "TTS Audio (concept)"
type: concept
layer: concept
---

# TTS Audio (concept)

## Sintesi
Layer opzionale di sintesi vocale sopra la telecronaca testuale di Rugby Radio Live.

## Scope
Il TTS genera o riusa file MP3 per preview voce e audio evento. Non trasforma il prodotto in una diretta audio tradizionale: lo spettatore continua a seguire eventi testuali, punteggio e telecronaca generata.

## Componenti coinvolti
- [[Telecronaca (concept)]]
- [[AI-Talker (concept)]]
- [[GMatchEventsComponent (web)]]
- [[GMatchRadioPage (web)]]
- [[MatchCommentatorComponent (web)]]
- [[MatchEventsComponent (web)]]
- [[MatchRadioPlayerService (web)]]
- [[MatchRadioStorageService (web)]]
- [[VoiceService (web)]]
- [[VoiceService (api)]]
- [[VoicesV1Controller (api)]]
- [[AzureSpeech (api)]]
- [[Riproduzione Audio Telecronaca (workflow)]]

## Relazioni principali
- Lo spettatore seleziona un AI-Talker nel frontend.
- Il frontend usa [[VoiceService (web)]] per richiedere preview audio o audio evento.
- La Modalita Radio Evento usa [[MatchRadioPlayerService (web)]] per accodare e riprodurre automaticamente gli audio evento.
- Il backend usa [[VoiceService (api)]] e [[AzureSpeech (api)]] per generare MP3.
- Il controller restituisce un path relativo `text/plain`, poi il frontend costruisce l'URL finale con `environment.audioUrl`.

## Riproduzione lato frontend
Nel FE pubblico la riproduzione audio passa dal wrapper [[GMatchEventsComponent (web)]], che aggrega il feed eventi e il selettore telecronista:

- [[GMatchEventsComponent (web)]] mostra il FAB per aprire [[MatchCommentatorComponent (web)]] quando la partita e in corso o terminata.
- In [[MatchCommentatorComponent (web)]] lo spettatore sceglie stile e lingua dell'AI-Talker; se il talker ha un codice voce valorizzato, il componente abilita la preview audio.
- Per la preview, [[MatchCommentatorComponent (web)]] chiama [[VoiceService (web)]] passando lingua e frase `presentation`.
- Nel feed eventi, [[MatchEventsComponent (web)]] mostra il pulsante audio evento solo quando [[UserService (web)]] indica disponibilita audio per il commentator corrente.
- Per un evento partita, il click manuale viene delegato a [[MatchRadioPlayerService (web)]], che chiama [[VoiceService (web)]] passando lingua ed `eventId`.
- La Modalita Radio Evento accoda eventi in ordine cronologico, riproduce un solo audio alla volta e persiste sul dispositivo preferenze, ultimi 5 item di coda e ultimo evento ascoltato.
- [[VoiceService (web)]] invia la richiesta HTTP a [[VoicesV1Controller (api)]] con `responseType: 'text'`.
- [[VoicesV1Controller (api)]] restituisce il path relativo del file MP3 generato o gia presente; non restituisce uno stream audio.
- Il componente FE consumer combina il path ricevuto con `environment.audioUrl` e usa l'URL finale per avviare la riproduzione audio.

## Decisioni architetturali
Le frasi AI della telecronaca sono generate offline e salvate in database; al click evento non avviene una chiamata AI realtime. Il TTS sintetizza audio a partire da frasi gia disponibili o da messaggi di sistema collegati agli eventi.

La Modalita Radio Evento e frontend-first: non introduce nuove API, nuove tabelle, stream server-side o persistenza backend della coda.

## Rischi
- Sintesi o file audio possono non essere disponibili.
- Non risultano retry o fallback applicativi.
- Subscription key Azure Speech, regione e path storage risultano hardcoded nel codice.
- Non tutti gli AI-Talker hanno audio TTS disponibile.

## Note
Evidenza da `llm-wiki/raw/docs/rrl-tts.md`.
