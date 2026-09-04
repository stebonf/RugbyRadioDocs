# Backend Integration Map RAW

## Sintesi

- Data analisi: 2026-05-19
- Root backend analizzata: `src/RugbyRadio`
- Filtro applicato: soli file modificati dopo il 2026-05-14
- File output: `llm-wiki/raw/backend/api/integration-map-20260519.md`
- Integrazioni trovate: 5
- Client/adapter trovati: 1
- Webhook trovati: 0
- Configurazioni esterne trovate: 5

## File analizzati

- `src/RugbyRadio/HF/appsettings.json`
- `src/RugbyRadio/HF/Dto/SeoPublicUrl.cs`
- `src/RugbyRadio/HF/Dto/SeoPublicUrlRules.cs`
- `src/RugbyRadio/HF/Helpers/SitemapXmlWriter.cs`
- `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs`
- `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs`
- `src/RugbyRadio/HF/Program.cs`
- `src/RugbyRadio/HF/Services/ISeoUrlInventoryService.cs`
- `src/RugbyRadio/HF/Services/SeoUrlInventoryService.cs`
- `src/RugbyRadio/Lib/Settings/SeoSitemapSettings.cs`

## File modificati esclusi perché non rilevanti per integrazioni esterne

- `src/RugbyRadio/Api/Api.xml` - documentazione XML generata.
- `src/RugbyRadio/HF/Jobs/Core/BaseCoreJob.cs` - infrastruttura job/log.
- `src/RugbyRadio/HF/Templates/post-template.html` - template HTML.
- `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelRepository.cs` - repository database interno.
- `src/RugbyRadio/Lib/Repositories/ChannelBox/IChannelRepository.cs` - interfaccia repository.
- `src/RugbyRadio/Lib/Repositories/MatchBox/IMatchRepository.cs` - interfaccia repository.
- `src/RugbyRadio/Lib/Repositories/MatchBox/MatchRepository.cs` - repository database interno.
- `src/RugbyRadio/Lib/Repositories/TeamBox/ITeamRepository.cs` - interfaccia repository.
- `src/RugbyRadio/Lib/Repositories/TeamBox/TeamRepository.cs` - repository database interno.

## Integrazioni

## BlogStaticFilePublishingIntegration

### Nome wiki suggerito

`BlogStaticFilePublishingIntegration`

### File sorgente

- `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs`
- `src/RugbyRadio/HF/appsettings.json`

### Tipo

Storage/File

### Provider esterno

- Filesystem/cartella pubblica blog configurata da `BlogSettings.OutputPath`

### Classe responsabile

- `CreateMatchBlogHtmlJob`

### Responsabilità tecnica

Genera file HTML statici del blog, landing page, indici paginati e sitemap blog su una directory configurata.

### Configurazioni usate

- `BlogSettings.OutputPath` - cartella di output dei file statici blog.
- `BlogSettings.BlogDomain` - dominio usato per URL canonici blog e sitemap.

### Endpoint / destinazioni esterne

- Metodo: altro
- URL/base URL: `BlogSettings.BlogDomain`
- Scopo tecnico: costruzione URL canonici e sitemap blog.
- Metodo: altro
- URL/base URL: `BlogSettings.OutputPath`
- Scopo tecnico: destinazione filesystem per HTML e sitemap generati.

### Metodi pubblici significativi

#### ExecuteAsync()

- Input:
  - Nessuno
- Output:
  - `Task`
- Payload inviato:
  - HTML statico e XML sitemap generati da template e dati blog/match.
- Payload ricevuto:
  - Nessuno deducibile
- Chiamata esterna:
  - `File.WriteAllTextAsync(...)`
  - `Directory.CreateDirectory(...)`
- Consumer deducibili:
  - Hangfire job
- Retry / timeout / fallback:
  - `[AutomaticRetry(Attempts = 0)]`
  - fallback template a stringa vuota se il file template non esiste.
- Side effects esterni:
  - scrittura file HTML e XML su filesystem configurato.
  - cancellazione file HTML legacy/esistenti prima della riscrittura.
- Errori / casi limite:
  - salta blog senza `MatchId`.
  - salta blog con match non trovato.
  - se template mancante, usa stringa vuota.
- Note di confidenza:
  - Verificato dal codice

## SeoSitemapFilePublishingIntegration

### Nome wiki suggerito

`SeoSitemapFilePublishingIntegration`

### File sorgente

- `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs`
- `src/RugbyRadio/HF/Helpers/SitemapXmlWriter.cs`
- `src/RugbyRadio/Lib/Settings/SeoSitemapSettings.cs`
- `src/RugbyRadio/HF/appsettings.json`
- `src/RugbyRadio/HF/Program.cs`

### Tipo

Storage/File

### Provider esterno

- Filesystem/cartella pubblica sitemap configurata da `SeoSitemap.OutputPath`

### Classe responsabile

- `GenerateSeoSitemapJob`
- `SitemapXmlWriter`

### Responsabilità tecnica

Genera sitemap XML pubbliche e sitemap index per URL statici, match, canali, squadre e riferimento sitemap blog.

### Configurazioni usate

- `SeoSitemap.OutputPath` - cartella di output delle sitemap pubbliche.
- `SeoSitemap.StaticFilesPath` - cartella usata per derivare `lastmod` degli URL statici.

### Endpoint / destinazioni esterne

- Metodo: altro
- URL/base URL: `SeoSitemap.OutputPath`
- Scopo tecnico: destinazione filesystem per sitemap XML.
- Metodo: altro
- URL/base URL: `SeoSitemap.StaticFilesPath`
- Scopo tecnico: origine filesystem per calcolo `lastmod`.

### Metodi pubblici significativi

#### ExecuteAsync()

- Input:
  - Nessuno
- Output:
  - `Task`
- Payload inviato:
  - XML sitemap generato da `SeoPublicUrl` e `SeoSitemapReference`.
- Payload ricevuto:
  - Nessuno deducibile
- Chiamata esterna:
  - `Directory.CreateDirectory(outputPath)`
  - `File.WriteAllTextAsync(tempPath, xml, ...)`
  - `File.Replace(...)`
  - `File.Move(...)`
- Consumer deducibili:
  - Hangfire job
- Retry / timeout / fallback:
  - `[AutomaticRetry(Attempts = 0)]`
  - `[DisableConcurrentExecution(timeoutInSeconds: 3600)]`
  - fallback `File.Move(..., overwrite: true)` quando `File.Replace` fallisce per `IOException`, `UnauthorizedAccessException` o `PlatformNotSupportedException`.
  - fallback `lastmod` a data generazione se i file statici non sono disponibili.
- Side effects esterni:
  - scrittura sitemap XML su filesystem configurato.
  - sostituzione atomica o overwrite dei file sitemap target.
- Errori / casi limite:
  - lancia `InvalidOperationException` se `SeoSitemap:OutputPath` non e valorizzato.
  - valida XML con `XDocument.Parse(xml)` prima della scrittura.
  - cancella file temporaneo nel blocco `finally`.
- Note di confidenza:
  - Verificato dal codice

## BlogSitemapReferenceIntegration

### Nome wiki suggerito

`BlogSitemapReferenceIntegration`

### File sorgente

- `src/RugbyRadio/HF/Dto/SeoPublicUrlRules.cs`
- `src/RugbyRadio/HF/Services/ISeoUrlInventoryService.cs`
- `src/RugbyRadio/HF/Services/SeoUrlInventoryService.cs`
- `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs`
- `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs`

### Tipo

Altro

### Provider esterno

- Blog pubblico Rugby Radio Live

### Classe responsabile

- `SeoUrlInventoryService`
- `CreateMatchBlogHtmlJob`

### Responsabilità tecnica

Produce riferimenti sitemap verso il blog pubblico e genera sitemap index blog per lingue supportate.

### Configurazioni usate

- `BlogSettings.BlogDomain` - dominio blog per URL root e sitemap.
- `SeoPublicUrlRules.BlogSitemapLoc` - URL fallback della sitemap blog.

### Endpoint / destinazioni esterne

- Metodo: altro
- URL/base URL: `https://blog.rugbyradiolive.com/sitemap.xml`
- Scopo tecnico: riferimento esterno inserito nel sitemap index.
- Metodo: altro
- URL/base URL: `BlogSettings.BlogDomain`
- Scopo tecnico: costruzione URL blog root e sitemap per lingua.

### Metodi pubblici significativi

#### GetBlogSitemapReferenceAsync()

- Input:
  - Nessuno
- Output:
  - `Task<SeoSitemapReference>`
- Payload inviato:
  - Nessuno deducibile
- Payload ricevuto:
  - Nessuno deducibile
- Chiamata esterna:
  - Nessuna chiamata HTTP; costruzione riferimento URL.
- Consumer deducibili:
  - `GenerateSeoSitemapJob`
- Retry / timeout / fallback:
  - fallback a `SeoPublicUrlRules.BlogSitemapLoc` se `BlogSettings.BlogDomain` non e valorizzato.
- Side effects esterni:
  - nessuno deducibile; il riferimento viene scritto nel sitemap index da job separato.
- Errori / casi limite:
  - `LastMod` null se non esiste blog statico deducibile.
- Note di confidenza:
  - Verificato dal codice

## SocialShareUrlIntegration

### Nome wiki suggerito

`SocialShareUrlIntegration`

### File sorgente

- `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs`

### Tipo

Social

### Provider esterno

- WhatsApp
- X/Twitter
- Facebook
- Instagram
- YouTube

### Classe responsabile

- `CreateMatchBlogHtmlJob`

### Responsabilità tecnica

Inserisce URL social e link di condivisione nei file HTML statici generati per il blog.

### Configurazioni usate

- Nessuna configurazione deducibile per questi URL hardcoded.

### Endpoint / destinazioni esterne

- Metodo: altro
- URL/base URL: `https://wa.me/`
- Scopo tecnico: link condivisione WhatsApp.
- Metodo: altro
- URL/base URL: `https://x.com/intent/tweet`
- Scopo tecnico: link condivisione X/Twitter.
- Metodo: altro
- URL/base URL: `https://www.facebook.com/sharer/sharer.php`
- Scopo tecnico: link condivisione Facebook.
- Metodo: altro
- URL/base URL: `https://www.instagram.com/rugbyradiolive`
- Scopo tecnico: link social inserito in HTML.
- Metodo: altro
- URL/base URL: `https://www.youtube.com/channel/UCeXPMRPHLjWAQC4coPmqlAg`
- Scopo tecnico: link social inserito in HTML.

### Metodi pubblici significativi

#### ExecuteAsync()

- Input:
  - Nessuno
- Output:
  - `Task`
- Payload inviato:
  - Nessuno deducibile
- Payload ricevuto:
  - Nessuno deducibile
- Chiamata esterna:
  - Nessuna chiamata HTTP; gli URL sono inseriti nei file HTML generati.
- Consumer deducibili:
  - Hangfire job
- Retry / timeout / fallback:
  - `[AutomaticRetry(Attempts = 0)]`
- Side effects esterni:
  - scrittura HTML contenente link social esterni.
- Errori / casi limite:
  - Non deducibile
- Note di confidenza:
  - Verificato dal codice

## PublicMediaUrlReferenceIntegration

### Nome wiki suggerito

`PublicMediaUrlReferenceIntegration`

### File sorgente

- `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs`

### Tipo

Storage/File

### Provider esterno

- `storage-sh.rugbyradiolive.com`

### Classe responsabile

- `CreateMatchBlogHtmlJob`

### Responsabilità tecnica

Inserisce URL assoluti a immagini pubbliche nei file HTML statici del blog.

### Configurazioni usate

- Nessuna configurazione deducibile; host hardcoded nel job.

### Endpoint / destinazioni esterne

- Metodo: altro
- URL/base URL: `https://storage-sh.rugbyradiolive.com`
- Scopo tecnico: riferimento immagini cover e loghi team nei file HTML generati.

### Metodi pubblici significativi

#### ExecuteAsync()

- Input:
  - Nessuno
- Output:
  - `Task`
- Payload inviato:
  - Nessuno deducibile
- Payload ricevuto:
  - Nessuno deducibile
- Chiamata esterna:
  - Nessuna chiamata HTTP; gli URL media vengono scritti dentro HTML.
- Consumer deducibili:
  - Hangfire job
- Retry / timeout / fallback:
  - `[AutomaticRetry(Attempts = 0)]`
- Side effects esterni:
  - scrittura HTML contenente riferimenti a media esterni.
- Errori / casi limite:
  - Non deducibile
- Note di confidenza:
  - Verificato dal codice

## Webhook

Nessun webhook inbound o outbound deducibile dai file modificati dopo il 2026-05-14.

## Configurazioni e secret reference

## BlogSettings

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `BlogSettings.OutputPath`
- Uso deducibile: cartella output HTML e sitemap blog statiche.
- Valore sensibile presente nel codice: no
- Nota: valore non riportato perché path locale di deployment.

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `BlogSettings.BlogDomain`
- Uso deducibile: dominio canonico blog e sitemap blog.
- Valore sensibile presente nel codice: no

## SeoSitemap

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `SeoSitemap.OutputPath`
- Uso deducibile: cartella output sitemap principale.
- Valore sensibile presente nel codice: no
- Nota: valore non riportato perché path locale di deployment.

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `SeoSitemap.StaticFilesPath`
- Uso deducibile: cartella input per calcolo `lastmod` dei file statici.
- Valore sensibile presente nel codice: no
- Nota: valore non riportato perché path locale di deployment.

## Smtp

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `Smtp.Host`
- Uso deducibile: server SMTP configurato.
- Valore sensibile presente nel codice: no

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `Smtp.Username`
- Uso deducibile: username SMTP.
- Valore sensibile presente nel codice: si, username non riportato.

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `Smtp.Password`
- Uso deducibile: password SMTP.
- Valore sensibile presente nel codice: si, password non riportata.

- Nota:
  - Nei file modificati analizzati la sezione `Smtp` viene registrata in `Program.cs`, ma non e presente codice SMTP modificato nel periodo.

## MetaFacebook

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `Meta.FbApiUrl`
- Uso deducibile: base URL API Facebook configurata.
- Valore sensibile presente nel codice: no

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `Meta.FbAppId`
- Uso deducibile: ID app Facebook.
- Valore sensibile presente nel codice: si, valore non riportato.

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `Meta.FbAppSecret`
- Uso deducibile: secret app Facebook.
- Valore sensibile presente nel codice: si, secret non riportato.

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `Meta.FbAccessToken`
- Uso deducibile: access token Facebook.
- Valore sensibile presente nel codice: si/non deducibile se valorizzato; valore non riportato.

- Nota:
  - Nei file modificati analizzati la sezione `Meta` viene registrata in `Program.cs`, ma non e presente codice client Facebook modificato nel periodo.

## ConnectionStrings

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `ConnectionStrings.ApiUrl`
- Uso deducibile: URL API interno/esterno configurato.
- Valore sensibile presente nel codice: no

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `ConnectionStrings.App`
- Uso deducibile: connessione database applicativo.
- Valore sensibile presente nel codice: si, connection string con credenziali non riportata.

- File sorgente/config: `src/RugbyRadio/HF/appsettings.json`
- Chiave: `ConnectionStrings.HF`
- Uso deducibile: connessione database Hangfire.
- Valore sensibile presente nel codice: si, connection string con credenziali non riportata.

## DTO/payload esterni rilevati

## SeoPublicUrl

- File sorgente: `src/RugbyRadio/HF/Dto/SeoPublicUrl.cs`
- Uso: candidato URL pubblico per generazione sitemap.
- Campi principali:
  - `Loc`
  - `Type`
  - `LastMod`
  - `IsIndexable`
  - `CanonicalLoc`
  - `Source`
  - `PriorityCandidate`
  - `ChangeFrequency`
  - `SourceId`
  - `ExclusionReason`
- Note:
  - Il commento sorgente dichiara che non e una entity database.

## SeoSitemapReference

- File sorgente: `src/RugbyRadio/HF/Helpers/SitemapXmlWriter.cs`
- Uso: riferimento sitemap inserito in sitemap index.
- Campi principali:
  - `Loc`
  - `LastMod`

## Note finali

- Limiti dell'analisi:
  - Il filtro richiesto limita la mappa ai soli file modificati dopo il 2026-05-14.
  - I client Facebook, SMTP, HTTP, AI/LLM e altri client presenti in file non modificati non sono stati analizzati in dettaglio.
  - Le integrazioni social/media rilevate nei file modificati sono riferimenti URL scritti in HTML, non chiamate runtime HTTP server-side.
- Elementi esclusi:
  - Controller interni.
  - Repository database interni.
  - Service layer non modificato nel periodo.
  - Job non modificati nel periodo.
- Elementi non deducibili:
  - Disponibilita effettiva delle destinazioni filesystem.
  - Permessi runtime sulle cartelle di output.
  - Policy operative di pubblicazione/deploy dei file generati.
  - Timeout/retry di eventuali client esterni non modificati.
  - Uso effettivo delle configurazioni SMTP e Facebook nei file non modificati.
- Conferma:
  - Nessun valore segreto e stato copiato.
  - Nessun file in `llm-wiki/wiki/` e stato creato o modificato.
