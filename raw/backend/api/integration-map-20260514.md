# Backend Integration Map RAW

## Sintesi

- Data analisi: 2026-05-14
- Project: api
- Root backend analizzata: `src/RugbyRadio/`
- File output: `llm-wiki/raw/backend/api/integration-map-20260514.md`
- Integrazioni trovate: 6
- Client/adapter trovati: 2
- Webhook trovati: 0
- Configurazioni esterne trovate: 5

---

## Integrazioni

---

## AzureSpeech (api)

### Nome wiki suggerito

`AzureSpeech (api)`

### File sorgente

- `src/RugbyRadio/Lib/Services/VoiceService.cs`

### Tipo

AI/LLM — Text-to-Speech

### Provider esterno

Microsoft Azure Cognitive Services — Speech SDK

### Classe responsabile

- `VoiceService`

### Responsabilità tecnica

Genera file audio MP3 da testo tramite Azure Text-to-Speech. Supporta più lingue e stili vocali (personaggi: Arcaico, Influencer, Adolescente, Alieno, ExPlayer, Chef). I file generati vengono salvati su filesystem locale in `D:\Web\RugbyRadioStorage\audio\`. Il file viene generato solo se non esiste già (cache su file system).

### Configurazioni usate

- `subscriptionKey` — chiave di sottoscrizione Azure Speech; **valore sensibile hardcoded nel codice** (non riportato)
- `region` — regione Azure; valore hardcoded: `swedencentral`
- Path storage locale: `D:\Web\RugbyRadioStorage\audio\` — hardcoded nel codice

### Endpoint / destinazioni esterne

- Metodo: SDK (non HTTP diretto)
- URL/base URL: gestito internamente dall'SDK `Microsoft.CognitiveServices.Speech`; regione `swedencentral`
- Scopo tecnico: sintesi vocale da testo a MP3

### Metodi pubblici significativi

#### GetAudioAsync(language, sentence)

- Input: `language` (`string`), `sentence` (`string`)
- Output: `Task<string?>` — path del file MP3 generato o `null`
- Payload inviato: testo sintetizzato (stringa); nome voce selezionata tramite `GetVoice(language)`
- Payload ricevuto: `byte[]` audio MP3
- Chiamata esterna: `SpeechSynthesizer.SpeakTextAsync(text)` dell'SDK Azure
- Consumer deducibili: `VoicesV1Controller.GetAudio`
- Retry / timeout / fallback: nessuno deducibile; se la sintesi fallisce ritorna `null`
- Side effects esterni: scrittura file MP3 su filesystem locale
- Errori / casi limite: ritorna `null` se la lingua non è supportata o se la sintesi fallisce; nessun re-raise visibile
- Note di confidenza: Verificato dal codice

#### GetAudioEventAsync(language, eventId)

- Input: `language` (`string`), `eventId` (`string`)
- Output: `Task<string?>` — path del file MP3 o `null`
- Payload inviato: testo del messaggio di sistema localizzato per l'evento; eventualmente testo arricchito con descrizione giocatore
- Payload ricevuto: `byte[]` audio MP3
- Chiamata esterna: `SpeechSynthesizer.SpeakTextAsync(text)` dell'SDK Azure (tramite `WriteFileAsync`)
- Consumer deducibili: `VoicesV1Controller.GetEventAudio`
- Retry / timeout / fallback: nessuno deducibile
- Side effects esterni: scrittura file MP3 su filesystem locale
- Errori / casi limite: ritorna `null` se evento non trovato, messaggio non trovato o sintesi fallita
- Note di confidenza: Verificato dal codice

---

## FirebaseFCM (api)

### Nome wiki suggerito

`FirebaseFCM (api)`

### File sorgente

- `src/RugbyRadio/Api/Program.cs` (inizializzazione)
- `src/RugbyRadio/Lib/Repositories/MatchBox/MatchService.cs` (invio notifiche)

### Tipo

Cloud — Push Notification

### Provider esterno

Google Firebase Cloud Messaging (FCM) — SDK `FirebaseAdmin`

### Classe responsabile

- `MatchService` (invio notifiche)
- `Program.cs` (inizializzazione `FirebaseApp`)

### Responsabilità tecnica

Invia notifiche push agli utenti che seguono una partita. L'inizializzazione avviene in `Program.cs` tramite `FirebaseApp.Create` con credenziali da file `FirebaseKey.json`. L'invio avviene in `MatchService.SendNotifications` iterando sui token FCM degli utenti iscritti alla partita. I token non validi vengono eliminati dal database.

### Configurazioni usate

- `FirebaseKey.json` — file credenziali Google Service Account; **valore sensibile**, path: `src/RugbyRadio/Api/FirebaseKey.json`

### Endpoint / destinazioni esterne

- Metodo: SDK (`FirebaseMessaging.DefaultInstance.SendAsync`)
- URL/base URL: gestita internamente dall'SDK Firebase Admin
- Scopo tecnico: invio notifiche push FCM a singoli device token

### Metodi pubblici significativi

#### SendNotifications(matchId) — in MatchService

- Input: `matchId` (`string`)
- Output: `Task<bool>`
- Payload inviato: `Message` FCM con `Notification` (title, body), `Data` (`matchId`, `eventId`), `Token` (device token), `WebpushConfig` con `WebpushNotification` (title, body, action `open-match`)
- Payload ricevuto: nessuno (fire-and-forget)
- Chiamata esterna: `FirebaseMessaging.DefaultInstance.SendAsync(msg)`
- Consumer deducibili: `MatchesV1Controller.SendNotification` (POST /v1/matches/{matchId}/notification)
- Retry / timeout / fallback: nessun retry esplicito; `FirebaseMessagingException` con `ErrorCode.InvalidArgument` → eliminazione token dal DB; altri errori ignorati silenziosamente (catch generico)
- Side effects esterni: invio notifica push FCM; eliminazione token non validi dal DB
- Errori / casi limite: `FirebaseMessagingException` gestita per token non validi; eccezioni generiche ignorate
- Note di confidenza: Verificato dal codice

---

## GoogleOAuth (api)

### Nome wiki suggerito

`GoogleOAuth (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/UserBox/UserService.cs`

### Tipo

HTTP API — OAuth / Identity

### Provider esterno

Google Identity — libreria `Google.Apis.Auth` (`GoogleJsonWebSignature`)

### Classe responsabile

- `UserService`

### Responsabilità tecnica

Valida i Google ID Token ricevuti dall'app mobile/web durante il login con Google. Usa `GoogleJsonWebSignature.ValidateAsync` con audience limitata al `ClientId` configurato. Se la validazione ha successo, recupera o crea l'utente corrispondente.

### Configurazioni usate

- `Providers:Google:ClientId` — Client ID dell'app Google; valore in `appsettings.json` (non riportato)

### Endpoint / destinazioni esterne

- Metodo: SDK (verifica JWT locale + chiamata Google per validazione)
- URL/base URL: gestita internamente dalla libreria `Google.Apis.Auth`
- Scopo tecnico: validazione Google ID Token; estrazione payload (email, nome, subject)

### Metodi pubblici significativi

#### RegisterNewGoogleUserAsync(language, token)

- Input: `language` (`string`), `token` (`string`) — Google ID Token
- Output: `Task<User>` — utente esistente o nuovo creato
- Payload inviato: token Google + `ClientId` come audience
- Payload ricevuto: `GoogleJsonWebSignature.Payload` con `Email`, `Name`, `Subject`
- Chiamata esterna: `GoogleJsonWebSignature.ValidateAsync(token, settings)`
- Consumer deducibili: `AuthV1Controller.GoogleLogin` (POST /v1/auth/users/google)
- Retry / timeout / fallback: nessuno deducibile; se payload `null` lancia `NotAuthorized`
- Side effects esterni: nessuno diretto (la creazione utente è operazione interna DB)
- Errori / casi limite: `NotAuthorized` se token non valido o payload null
- Note di confidenza: Verificato dal codice

---

## SmtpEmail (api)

### Nome wiki suggerito

`SmtpEmail (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/EmailBox/EmailService.cs`
- `src/RugbyRadio/Lib/Settings/SmtpSettings.cs`

### Tipo

Email — SMTP

### Provider esterno

Aruba SMTP — libreria `MailKit`

### Classe responsabile

- `EmailService`

### Responsabilità tecnica

Invia email transazionali tramite server SMTP Aruba su porta 465 con SSL. Supporta due casi d'uso: invio OTP per reset password (`SendOptCode`) e invio email generica (`SendEmail`). Ogni invio viene registrato nella tabella `Emails` con stato `Sent` o `Failed`.

### Configurazioni usate

- `Smtp:Host` — hostname SMTP; valore in `appsettings.json`: `smtps.aruba.it`
- `Smtp:Port` — porta SMTP; valore in `appsettings.json`: `465`
- `Smtp:Username` — username SMTP; valore in `appsettings.json` (non riportato)
- `Smtp:Password` — password SMTP; **valore sensibile presente in `appsettings.json`** (non riportato)
- Mittente fisso hardcoded: `support@rugbyradiolive.com`

### Endpoint / destinazioni esterne

- Metodo: SMTP (SSL, `SslOnConnect`)
- URL/base URL: `smtps.aruba.it:465`
- Scopo tecnico: invio email transazionale (OTP reset password, feedback utente)

### Metodi pubblici significativi

#### SendOptCode(userId, email, otpCode)

- Input: `userId` (`string`), `email` (`string`), `otpCode` (`string`)
- Output: `Task`
- Payload inviato: email plain text con corpo fisso in inglese contenente il codice OTP e la scadenza (1 ora); subject: `"Password Reset Request"`; destinatario: `email`
- Payload ricevuto: nessuno
- Chiamata esterna: `MailKit.Net.Smtp.SmtpClient.SendAsync`
- Consumer deducibili: `UserService.ForgotPassword`
- Retry / timeout / fallback: nessun retry; `catch(Exception)` imposta `Email.Status = Failed`; email comunque persistita in DB
- Side effects esterni: invio email SMTP; scrittura record `Email` in DB con esito
- Errori / casi limite: eccezione SMTP catturata silenziosamente; record `Email` salvato con status `Failed`
- Note di confidenza: Verificato dal codice

#### SendEmail(email, subject, body)

- Input: `email` (`string`), `subject` (`string`), `body` (`string`)
- Output: `Task`
- Payload inviato: email plain text con subject e body parametrici; mittente: `support@rugbyradiolive.com`
- Payload ricevuto: nessuno
- Chiamata esterna: `MailKit.Net.Smtp.SmtpClient.SendAsync`
- Consumer deducibili: `UserV1Controller.FeedbackUser` (POST /v1/user/feedback)
- Retry / timeout / fallback: nessuno deducibile; nessun catch visibile in questo metodo — eccezione propagata al chiamante
- Side effects esterni: invio email SMTP (nessuna persistenza in DB per questo metodo)
- Errori / casi limite: eccezione SMTP non gestita, propagata al chiamante
- Note di confidenza: Verificato dal codice

---

## FacebookGraphAPI (api)

### Nome wiki suggerito

`FacebookGraphAPI (api)`

### File sorgente

- `src/RugbyRadio/Lib/Services/FacebookService.cs`
- `src/RugbyRadio/Lib/Settings/MetaSettings.cs`
- `src/RugbyRadio/Lib/Dto/Facebook/` (DTO)

### Tipo

Social — HTTP API (Facebook Graph API)

### Provider esterno

Meta / Facebook — Graph API

### Classe responsabile

- `FacebookService`
- `HttpClientService` (client HTTP di base, usa RestSharp)

### Responsabilità tecnica

Client per la Facebook Graph API. Gestisce: scambio token (short-lived → long-lived), recupero info utente, verifica token, recupero pagine Facebook dell'utente, pubblicazione post con immagine su pagina Facebook, revoca permessi. Usata per la funzionalità di pubblicazione blog post su Facebook.

### Configurazioni usate

- `Meta:FbAppId` — App ID Facebook; valore da `appsettings` o configurazione (non visibile in `appsettings.json` principale)
- `Meta:FbAppSecret` — App Secret Facebook; **valore sensibile** (non riportato)
- `Meta:FbApiUrl` — URL base Graph API; valore da configurazione
- `Meta:FbAccessTokenRefreshThreshold` — soglia di refresh token in secondi
- `Meta:FbAccessToken` — access token frontend; **valore potenzialmente sensibile**

### Endpoint / destinazioni esterne

- GET `{FbApiUrl}/oauth/access_token?client_id=...&client_secret=...&fb_exchange_token=...&grant_type=fb_exchange_token` — scambio token
- GET `{FbApiUrl}/me?fields=id,name,email,picture&access_token=...` — info utente
- GET `{FbApiUrl}/debug_token?input_token=...&access_token=...` — verifica token
- GET `{FbApiUrl}/me/accounts?fields=id,name,access_token&access_token=...` — recupero pagine
- DELETE `{FbApiUrl}/me/permissions?access_token=...` — revoca permessi
- POST `{FbApiUrl}/{pageId}/photos?access_token=...` — pubblicazione post con immagine (form-encoded)

### Metodi pubblici significativi

#### GetAccessTokenAsync(shortLivedToken)

- Input: `shortLivedToken` (`string`)
- Output: `Task<FacebookTokenResponseDto?>`
- Chiamata esterna: GET `{FbApiUrl}/oauth/access_token`
- Consumer deducibili: Non deducibile dai controller API letti
- Side effects esterni: nessuno
- Note di confidenza: Verificato dal codice

#### GetUserInfoAsync(accessToken)

- Input: `accessToken` (`string`)
- Output: `Task<FacebookUserResponseDto?>`
- Chiamata esterna: GET `{FbApiUrl}/me?fields=id,name,email,picture`
- Consumer deducibili: Non deducibile dai controller API letti
- Side effects esterni: nessuno
- Note di confidenza: Verificato dal codice

#### GetPagesAsync(accessToken)

- Input: `accessToken` (`string`)
- Output: `Task<FacebookAccountsResponseDto?>`
- Chiamata esterna: GET `{FbApiUrl}/me/accounts`
- Consumer deducibili: Non deducibile dai controller API letti
- Side effects esterni: nessuno
- Note di confidenza: Verificato dal codice

#### PostAsync(pageId, pageAccessToken, imageUrl, postMessage)

- Input: `pageId` (`string`), `pageAccessToken` (`string`), `imageUrl` (`string`), `postMessage` (`string`)
- Output: `Task`
- Payload inviato: form-encoded con `access_token`, `message`, `url` (URL immagine)
- Payload ricevuto: `FacebookPostResponseDto`
- Chiamata esterna: POST `{FbApiUrl}/{pageId}/photos` form-encoded
- Consumer deducibili: Non deducibile dai controller API letti (probabile uso in job HF)
- Side effects esterni: pubblicazione post con immagine su pagina Facebook
- Note di confidenza: Verificato dal codice

#### RevokePermissionsAsync(accessToken)

- Input: `accessToken` (`string`)
- Output: `Task<bool>`
- Chiamata esterna: DELETE `{FbApiUrl}/me/permissions`
- Side effects esterni: revoca permessi OAuth Facebook
- Note di confidenza: Verificato dal codice

#### ShouldRefreshToken(expiresAt)

- Input: `expiresAt` (`DateTime?`)
- Output: `bool`
- Chiamata esterna: nessuna
- Note di confidenza: Verificato dal codice

---

## OllamaAI (api)

### Nome wiki suggerito

`OllamaAI (api)`

### File sorgente

- `src/RugbyRadio/Lib/Services/AiOllamaService.cs`
- `src/RugbyRadio/Lib/Repositories/SystemMessageBox/SystemMessageService.cs`
- `src/RugbyRadio/Lib/Services/AiSettings.cs`

### Tipo

AI/LLM

### Provider esterno

Ollama — SDK `OllamaSharp` — istanza self-hosted (URI configurabile)

### Classe responsabile

- `AiOllamaService`
- `SystemMessageService`

### Responsabilità tecnica

Due utilizzi principali dell'istanza Ollama:

1. `AiOllamaService`: genera post del blog per partite terminate (`CreateBlogPosts`) in più lingue. Costruisce un tabellino testuale della partita e lo passa come contesto al modello LLM per generare titolo e corpo del post.

2. `SystemMessageService`: genera e traduce i messaggi di sistema (`AiTalkersCreateOllama`, `AiTalkersTranslateOllama`, `AiTalkersTranslateOllamaLanguage`) usati per la telecronaca automatica degli eventi.

La configurazione è caricata da un file JSON esterno (`Db/Ai-Talkers.json`) referenziato tramite la connection string `AiTalkers`.

### Configurazioni usate

- `ConnectionStrings:AiTalkers` — path del file JSON di configurazione AI; valore in `appsettings.json`: `Db\Ai-Talkers.json`
- `AiSettings.OllamaUri` — URI dell'istanza Ollama; letto dal file JSON
- `AiSettings.ChatModels` — lista modelli LLM da usare; letti dal file JSON
- `AiSettings.CheckModel` — modello per verifica; letto dal file JSON
- `AiSettings.AiReporters` — prompt per reporter per lingua; letti dal file JSON
- `AiSettings.Embeddings` — embedding contestuali; letti dal file JSON

### Endpoint / destinazioni esterne

- Metodo: SDK (`OllamaApiClient`, `Chat.SendAsync`)
- URL/base URL: `AiSettings.OllamaUri` (da configurazione JSON)
- Scopo tecnico: generazione testo (blog post, messaggi telecronaca) tramite modello LLM locale

### Metodi pubblici significativi

#### CallAi(ollamaUri, systemPrompt, question, model, history?, embeddings?)

- Input: `ollamaUri` (`string`), `systemPrompt` (`string?`), `question` (`string`), `model` (`string`), `history` (`IList<string>?`), `embeddings` (`IList<string>?`)
- Output: `Task<string>` — risposta testuale del modello
- Payload inviato: system prompt (con eventuali embedding concatenati), domanda, history messaggi; parametri: `Seed` random, `Temperature = 0.8`, `TopP = 0.7`
- Payload ricevuto: stream di token testuali concatenati in stringa
- Chiamata esterna: `OllamaApiClient.Chat.SendAsync(question)` in streaming
- Consumer deducibili: `AiOllamaService.CreateBlogPost`, `SystemMessageService` (vari metodi)
- Retry / timeout / fallback: nessuno deducibile
- Side effects esterni: nessuno diretto (la scrittura blog avviene nel chiamante)
- Note di confidenza: Verificato dal codice

#### CreateBlogPosts()

- Input: nessuno
- Output: `Task`
- Payload inviato: tabellino testuale della partita (squadre, punteggi, eventi, giocatori, timeline)
- Payload ricevuto: risposta LLM con `<title>...</title>` + body
- Chiamata esterna: `CallAi(...)` con URI Ollama
- Consumer deducibili: job HF (non deducibile dai controller API)
- Side effects esterni: creazione post `Blog` in DB per ogni partita terminata, per ogni lingua configurata
- Note di confidenza: Verificato dal codice

---

## Client/Adapter

---

## HttpClientService (api)

### Nome wiki suggerito

`HttpClientService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Services/HttpClientService.cs`
- `src/RugbyRadio/Lib/Services/Interfaces/IHttpClientService.cs`

### Tipo

HTTP API — client generico

### Provider esterno

Non specifico — wrapper generico su `RestSharp`

### Classe responsabile

- `HttpClientService`

### Responsabilità tecnica

Client HTTP generico basato su `RestSharp`. Astrae le chiamate HTTP (GET, POST, PUT, PATCH, DELETE) verso endpoint esterni arbitrari. Supporta autenticazione Bearer JWT e header custom. Supporta sia body JSON che form-encoded. Deserializza automaticamente la risposta in tipo generico `T` tramite `Newtonsoft.Json`.

### Configurazioni usate

- Nessuna configurazione propria; l'URL è passato dal chiamante.

### Metodi pubblici significativi

- `DoGetAsync<T>(apiUrl, bearerToken?, headers?)` — GET, risposta deserializzata in `T`
- `DoPostAsync<T>(apiUrl, body, bearerToken?, headers?)` — POST JSON
- `DoPostFormEncodedAsync<T>(apiUrl, bearerToken?, parameters?, headers?)` — POST form-encoded
- `DoPutAsync<T>(apiUrl, body, bearerToken?, headers?)` — PUT JSON
- `DoPatchAsync<T>(apiUrl, body, bearerToken?, headers?)` — PATCH JSON
- `DoDeleteAsync<T>(apiUrl, body, bearerToken?, headers?)` — DELETE

- Consumer deducibili: `FacebookService`
- Retry / timeout / fallback: nessuno esplicito deducibile
- Note di confidenza: Verificato dal codice

---

## Webhook

Nessun webhook inbound o outbound individuato nel codice analizzato.

---

## Configurazioni e secret reference

---

## Security JWT

- File sorgente/config: `src/RugbyRadio/Api/appsettings.json`
- Chiave: `Security:SecretKey`
- Uso deducibile: chiave simmetrica per firma e validazione token JWT (HmacSha256)
- Valore sensibile presente nel codice: sì, in `appsettings.json` in chiaro
- Nota: non riportato il valore

---

## SMTP Aruba

- File sorgente/config: `src/RugbyRadio/Api/appsettings.json`
- Chiave: `Smtp:Password`
- Uso deducibile: credenziale per autenticazione server SMTP Aruba su `smtps.aruba.it:465`
- Valore sensibile presente nel codice: sì, in `appsettings.json` in chiaro
- Nota: non riportato il valore

---

## Google OAuth ClientId

- File sorgente/config: `src/RugbyRadio/Api/appsettings.json`
- Chiave: `Providers:Google:ClientId`
- Uso deducibile: audience per validazione Google ID Token con `GoogleJsonWebSignature.ValidateAsync`
- Valore sensibile presente nel codice: sì, Client ID presente in `appsettings.json` (non riportato)
- Nota: il Client ID non è un segreto critico ma è un identificativo dell'app

---

## Azure Speech Subscription Key

- File sorgente/config: `src/RugbyRadio/Lib/Services/VoiceService.cs`
- Chiave: `subscriptionKey` (hardcoded nel metodo `AzureTextToSpeechAsync`)
- Uso deducibile: chiave di sottoscrizione per Azure Cognitive Services Text-to-Speech, regione `swedencentral`
- Valore sensibile presente nel codice: sì, **API key hardcoded nel codice sorgente** (non riportato)
- Nota: non riportato il valore; la chiave dovrebbe essere spostata in configurazione

---

## Firebase Credentials

- File sorgente/config: `src/RugbyRadio/Api/FirebaseKey.json`
- Chiave: file JSON credenziali Google Service Account
- Uso deducibile: autenticazione `FirebaseApp` per Firebase Cloud Messaging
- Valore sensibile presente nel codice: sì, file con credenziali service account (non analizzato il contenuto)

---

## Meta / Facebook

- File sorgente/config: configurazione sezione `Meta` (non presente in `appsettings.json` principale letto)
- Chiavi: `Meta:FbAppId`, `Meta:FbAppSecret`, `Meta:FbApiUrl`, `Meta:FbAccessTokenRefreshThreshold`, `Meta:FbAccessToken`
- Uso deducibile: autenticazione e chiamate Facebook Graph API
- Valore sensibile presente nel codice: `FbAppSecret` e `FbAccessToken` sono sensibili; non riportati i valori
- Nota: il file `appsettings.json` principale non contiene la sezione `Meta`; probabile configurazione in `appsettings.Development.json` o variabili d'ambiente

---

## OpenTelemetry OTLP

- File sorgente/config: `src/RugbyRadio/Api/appsettings.json`
- Chiave: `OTEL_EXPORTER_OTLP_ENDPOINT`
- Uso deducibile: endpoint OTLP per export trace e metriche OpenTelemetry
- Valore sensibile presente nel codice: no; valore in `appsettings.json`: `http://localhost:4317` (endpoint locale)
- Nota: librerie OpenTelemetry importate in `Program.cs` ma la configurazione di tracing/metrics specifica non è stata letta in dettaglio

---

## Note finali

- Limiti dell'analisi: il file `Db/Ai-Talkers.json` non è stato letto (contiene configurazioni Ollama e prompt AI); i controller e job del progetto `HF` (Hangfire) non sono stati analizzati in dettaglio — `FacebookService` e `AiOllamaService` sono probabilmente utilizzati da lì; `SystemMessageService` è stato letto solo parzialmente.
- Elementi esclusi: OpenTelemetry (non è un'integrazione applicativa ma osservabilità infrastrutturale); Serilog (logging locale, non integrazione esterna).
- Elementi non deducibili: configurazione completa di OpenTelemetry (tracing/metrics specifici); configurazione `Meta` (sezione non trovata in `appsettings.json` principale); consumer diretti di `FacebookService` (probabilmente in job HF non analizzati); URI Ollama effettivo (nel file JSON non letto).
- Secret hardcoded rilevati: `AzureTextToSpeechAsync` in `VoiceService.cs` contiene una chiave di sottoscrizione Azure hardcoded — da spostare in configurazione.
- Wiki non modificata: confermato.
