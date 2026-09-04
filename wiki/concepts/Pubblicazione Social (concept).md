---
title: "Pubblicazione Social (concept)"
type: concept
layer: concept
---

# Pubblicazione Social (concept)

## Sintesi

Pipeline backend che pubblica su Facebook i contenuti delle partite terminate. Genera immagine con tabellino visuale via Tailoor Painter, compone il post con ImageSharp e lo pubblica sulla pagina Facebook della piattaforma tramite Facebook Graph API. Fa parte della fase 4 di [[Pipeline Contenuti (concept)]].

## Scope

La pubblicazione social copre la generazione dell'immagine partita, il compositing del tabellino visuale, la pubblicazione su Facebook e l'aggiornamento del flag `IsFacebookPosted` sull'entita [[Blog (api)]]. Non copre la condivisione via URL client-side (gestita da [[SocialShareUrlIntegration (api)]] e [[EntityShareComponent (web)]]) ne la pubblicazione su Instagram (gestita da job separati [[CreateMatchImageInstagramJob (api)]] e [[CreateChannelImageInstagramJob (api)]]).

## Componenti coinvolti

- [[FacebookJob (api)]] — job Hangfire che orchestra generazione immagine, compositing e pubblicazione
- [[FacebookService (api)]] — client Facebook Graph API con metodi PostAsync, GetAccessTokenAsync, GetPagesAsync
- [[FacebookGraphAPI (api)]] — integrazione HTTP verso `/{pageId}/photos` form-encoded
- [[HttpClientService (api)]] — client HTTP generico (RestSharp) usato da FacebookService
- [[Blog (api)]] — entita con flag `IsFacebookPosted` aggiornato dal job
- [[Blog (concept)]] — contesto blog della piattaforma
- [[Match (api)]] — partita sorgente per tabellino visuale
- [[Ciclo di Vita Partita (concept)]] — FullTime come trigger della pubblicazione
- [[Pipeline Contenuti (concept)]] — pipeline genitore in cui la pubblicazione e fase 4
- [[Generazione Immagini (concept)]] — generazione immagini contestuale
- [[MatchStatusChanged]] — evento che attiva FacebookJob al raggiungimento di FullTime
- [[Partita (concept)]] — concetto di dominio partita
- [[Pubblicazione Blog Statico (workflow)]] — flusso di pubblicazione blog correlato
- [[SocialShareUrlIntegration (api)]] — link social negli HTML statici
- [[EntityShareComponent (web)]] — condivisione link lato frontend
- [[Rugby Radio Live (architecture)]] — architettura piattaforma
- [[Cronista (actor)]] — produttore del contenuto sorgente
- [[Spettatore (actor)]] — fruitore del contenuto pubblicato

## Relazioni principali

- Al raggiungimento di `FullTime` ([[MatchStatusChanged]]), [[FacebookJob (api)]] viene eseguito da Hangfire RecurringJobAdmin.
- [[FacebookJob (api)]] genera un'immagine partita via Tailoor Painter e compone il tabellino visuale (squadre, punteggio) con ImageSharp.
- [[FacebookService (api)]] pubblica il post con immagine su Facebook tramite POST `/{pageId}/photos` form-encoded con `access_token`, `message` e `url`.
- Dopo la pubblicazione, il flag `IsFacebookPosted` su [[Blog (api)]] viene aggiornato per evitare doppie pubblicazioni.
- Il flusso e separato dalla generazione immagini partita ([[CreateMatchImageJob (api)]] e [[RepairMatchImageJob (api)]]) perche il job Facebook compone un'immagine autonoma con tabellino visuale invece di usare la copertina standard.
- [[SocialShareUrlIntegration (api)]] opera su un piano diverso: inserisce URL di condivisione (WhatsApp, X/Twitter, Facebook) negli HTML statici del blog, senza interagire con le API di pubblicazione.
- [[EntityShareComponent (web)]] offre condivisione client-side via copia link negli appunti, senza interazione server.

## Decisioni architetturali

- La pubblicazione social e asincrona e offline (job Hangfire), non in tempo reale sulla richiesta di cambio stato.
- [[FacebookJob (api)]] non ha retry automatico (`[AutomaticRetry(Attempts = 0)]`): un fallimento di pubblicazione non viene ritentato.
- L'immagine per Facebook e generata separatamente dalle immagini copertina partita; il job compone un tabellino visuale dedicato invece di riutilizzare la WebP 1200x630 di [[CreateMatchImageJob (api)]].
- Il flag `IsFacebookPosted` su [[Blog (api)]] funge da guardia per evitare pubblicazioni duplicate.
- La configurazione Meta (FbAppId, FbAppSecret, FbAccessToken) non risiede in `appsettings.json` principale ma e gestita separatamente.

## Rischi

- Frequenza cron di [[FacebookJob (api)]] non deducibile dalla wiki.
- Nessun retry automatico: un errore di pubblicazione (rete, token scaduto, immagine nulla) non viene recuperato automaticamente.
- Se `IsFacebookPosted` non viene aggiornato correttamente, lo stesso post potrebbe essere pubblicato piu volte.
- Il refresh del token long-lived (via `ShouldRefreshToken`) potrebbe fallire e causare errori di autenticazione.
- La pubblicazione Instagram ([[CreateMatchImageInstagramJob (api)]] e [[CreateChannelImageInstagramJob (api)]]) contiene side effect `WritePost` non completamente deducibili, potenzialmente sovrapponibili al flusso Facebook.

## Note

Pagina creata da pagine wiki esistenti: FacebookJob, FacebookService, FacebookGraphAPI, HttpClientService, Blog, Blog (concept), Match, Ciclo di Vita Partita, Pipeline Contenuti, Generazione Immagini, MatchStatusChanged, Partita, Pubblicazione Blog Statico, SocialShareUrlIntegration, EntityShareComponent, Rugby Radio Live (architecture), Cronista, Spettatore. Nessun RAW letto.
