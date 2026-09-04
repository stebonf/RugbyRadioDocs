# Backend Service Map RAW

## Sintesi

- Data analisi: 2026-05-19
- Root backend analizzata: `src/RugbyRadio`
- Filtro applicato: soli file modificati dopo il 2026-05-14
- File output: `llm-wiki/raw/backend/api/service-map-20260519.md`
- Servizi trovati: 1
- Metodi pubblici significativi trovati: 7

## File analizzati

- `src/RugbyRadio/HF/Services/ISeoUrlInventoryService.cs`
- `src/RugbyRadio/HF/Services/SeoUrlInventoryService.cs`
- `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs`
- `src/RugbyRadio/HF/Dto/SeoPublicUrl.cs`
- `src/RugbyRadio/HF/Dto/SeoPublicUrlRules.cs`
- `src/RugbyRadio/HF/Program.cs`

## File modificati esclusi perché non service layer

- `src/RugbyRadio/Api/Api.xml` - documentazione XML generata.
- `src/RugbyRadio/HF/appsettings.json` - configurazione applicativa.
- `src/RugbyRadio/HF/Helpers/SitemapXmlWriter.cs` - helper/writer XML.
- `src/RugbyRadio/HF/Jobs/Core/BaseCoreJob.cs` - base job Hangfire.
- `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs` - job backend.
- `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs` - letto come consumer, non classificato come service.
- `src/RugbyRadio/HF/Templates/post-template.html` - template HTML.
- `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelRepository.cs` - repository dati.
- `src/RugbyRadio/Lib/Repositories/ChannelBox/IChannelRepository.cs` - interfaccia repository.
- `src/RugbyRadio/Lib/Repositories/MatchBox/IMatchRepository.cs` - interfaccia repository.
- `src/RugbyRadio/Lib/Repositories/MatchBox/MatchRepository.cs` - repository dati.
- `src/RugbyRadio/Lib/Repositories/TeamBox/ITeamRepository.cs` - interfaccia repository.
- `src/RugbyRadio/Lib/Repositories/TeamBox/TeamRepository.cs` - repository dati.
- `src/RugbyRadio/Lib/Settings/SeoSitemapSettings.cs` - settings.

## Servizi

## SeoUrlInventoryService

### Nome wiki suggerito

`SeoUrlInventoryService`

### File sorgente

- `src/RugbyRadio/HF/Services/SeoUrlInventoryService.cs`
- `src/RugbyRadio/HF/Services/ISeoUrlInventoryService.cs`

### Tipo

Service

### Interfaccia

- `ISeoUrlInventoryService`

### Responsabilità tecnica

Costruisce candidati URL pubblici canonici per generazione sitemap SEO leggendo repository applicativi e configurazione blog, senza persistere righe di inventory.

### Dipendenze iniettate

- `IMatchRepository`
- `IChannelRepository`
- `ITeamRepository`
- `IBlogRepository`
- `IOptions<BlogSettings>`

### Consumer deducibili

- `GenerateSeoSitemapJob`

### Metodi pubblici significativi

#### GetStaticUrls(DateTimeOffset lastMod)

- Input:
  - `lastMod` (`DateTimeOffset`)
- Output:
  - `IReadOnlyList<SeoPublicUrl>`
- Dipendenze chiamate:
  - `SeoPublicUrlRules.StaticIndexablePaths`
  - `SeoPublicUrlRules.ToCanonicalLoc(...)`
- Entità coinvolte:
  - Non deducibile
- DTO / Request / Response:
  - `SeoPublicUrl`
- Condizioni rilevanti:
  - route `/` viene classificata come `SeoPublicUrlType.Home`.
  - le altre route statiche vengono classificate come `SeoPublicUrlType.StaticPage`.
  - priority candidate pari a `1.0` per home e `StaticPriority` per le altre route.
  - change frequency `Daily` per home e `Weekly` per le altre route.
- Side effects:
  - nessuno deducibile
- Errori / casi limite:
  - non deducibile
- Note di confidenza:
  - Verificato dal codice

#### GetMatchUrlsAsync()

- Input:
  - Nessuno
- Output:
  - `Task<IReadOnlyList<SeoPublicUrl>>`
- Dipendenze chiamate:
  - `IMatchRepository.FindSeoCandidatesAsync()`
  - `SeoPublicUrlRules.IsPotentiallyIndexableMatch(...)`
  - `SeoPublicUrlRules.ToCanonicalLoc(...)`
- Entità coinvolte:
  - Lettura: `Match`
  - Lettura: `Blog`
  - Lettura: `Channel`
- DTO / Request / Response:
  - `SeoPublicUrl`
- Condizioni rilevanti:
  - include solo URL con `ShouldIncludeInSitemap`.
  - un match e indexable solo se full time, con home team, away team, almeno 10 eventi, blog statico associato e non appartenente a canale test.
  - se non indexable, viene valorizzata una reason interna prima del filtro finale.
- Side effects:
  - nessuno deducibile
- Errori / casi limite:
  - `ExclusionReason` può indicare match non full time, team mancanti, eventi insufficienti, blog statico mancante, canale test o policy non soddisfatta.
- Note di confidenza:
  - Verificato dal codice

#### GetChannelUrlsAsync()

- Input:
  - Nessuno
- Output:
  - `Task<IReadOnlyList<SeoPublicUrl>>`
- Dipendenze chiamate:
  - `IChannelRepository.FindSeoCandidatesAsync()`
  - `SeoPublicUrlRules.ToCanonicalLoc(...)`
- Entità coinvolte:
  - Lettura: `Channel`
  - Lettura: `Match`
- DTO / Request / Response:
  - `SeoPublicUrl`
- Condizioni rilevanti:
  - include solo canali con `PublicId` non vuoto.
  - URL generato su path `/g-channel/{PublicId}`.
  - `lastmod` usa ultimo aggiornamento match del canale se presente, altrimenti timestamp canale.
- Side effects:
  - nessuno deducibile
- Errori / casi limite:
  - se non ci sono match validi, `lastmod` ricade su `channel.Ts`.
- Note di confidenza:
  - Verificato dal codice

#### GetTeamUrlsAsync()

- Input:
  - Nessuno
- Output:
  - `Task<IReadOnlyList<SeoPublicUrl>>`
- Dipendenze chiamate:
  - `ITeamRepository.FindSeoCandidatesAsync()`
  - `SeoPublicUrlRules.ToCanonicalLoc(...)`
- Entità coinvolte:
  - Lettura: `Team`
- DTO / Request / Response:
  - `SeoPublicUrl`
- Condizioni rilevanti:
  - include solo team con `Id` non vuoto.
  - URL generato su path `/g-team/{Id}`.
  - `lastmod` usa `team.Ts`.
- Side effects:
  - nessuno deducibile
- Errori / casi limite:
  - non deducibile
- Note di confidenza:
  - Verificato dal codice

#### GetBlogUrlsAsync()

- Input:
  - Nessuno
- Output:
  - `Task<IReadOnlyList<SeoPublicUrl>>`
- Dipendenze chiamate:
  - `IBlogRepository.FindLatestStaticAsync(1)`
  - `BlogSettings.BlogDomain`
- Entità coinvolte:
  - Lettura: `Blog`
- DTO / Request / Response:
  - `SeoPublicUrl`
- Condizioni rilevanti:
  - se blog root non e valorizzato, ritorna lista vuota.
  - se presente, produce un URL candidato per `blog-root`.
  - `lastmod` usa `latestStaticBlog.Ts` se esiste.
- Side effects:
  - nessuno deducibile
- Errori / casi limite:
  - ritorna lista vuota se `BlogSettings.BlogDomain` non produce root valida.
  - `LastMod` null se non esiste blog statico.
- Note di confidenza:
  - Verificato dal codice

#### GetBlogSitemapReferenceAsync()

- Input:
  - Nessuno
- Output:
  - `Task<SeoSitemapReference>`
- Dipendenze chiamate:
  - `IBlogRepository.FindLatestStaticAsync(1)`
  - `BlogSettings.BlogDomain`
  - `SeoPublicUrlRules.BlogSitemapLoc`
- Entità coinvolte:
  - Lettura: `Blog`
- DTO / Request / Response:
  - `SeoSitemapReference`
- Condizioni rilevanti:
  - se il blog root configurato e vuoto, usa fallback `SeoPublicUrlRules.BlogSitemapLoc`.
  - altrimenti costruisce `{blogRoot}sitemap.xml`.
  - `lastmod` usa `latestStaticBlog.Ts` se esiste.
- Side effects:
  - nessuno deducibile
- Errori / casi limite:
  - `LastMod` null se non esiste blog statico.
- Note di confidenza:
  - Verificato dal codice

#### GetAllUrlsAsync(DateTimeOffset staticLastMod)

- Input:
  - `staticLastMod` (`DateTimeOffset`)
- Output:
  - `Task<IReadOnlyList<SeoPublicUrl>>`
- Dipendenze chiamate:
  - `GetStaticUrls(staticLastMod)`
  - `GetMatchUrlsAsync()`
  - `GetChannelUrlsAsync()`
  - `GetTeamUrlsAsync()`
  - `GetBlogUrlsAsync()`
- Entità coinvolte:
  - Lettura: `Match`
  - Lettura: `Channel`
  - Lettura: `Team`
  - Lettura: `Blog`
- DTO / Request / Response:
  - `SeoPublicUrl`
- Condizioni rilevanti:
  - aggrega URL statici, match, canali, squadre e blog in una singola lista.
- Side effects:
  - nessuno deducibile
- Errori / casi limite:
  - eredita eventuali ritorni vuoti o null logic dai metodi chiamati.
- Note di confidenza:
  - Verificato dal codice

## Note finali

- Limiti dell'analisi:
  - Il filtro richiesto limita la mappa ai soli file modificati dopo il 2026-05-14.
  - Altri service presenti nel repository ma non modificati nel periodo non sono stati censiti.
  - Repository chiamati dal service sono indicati solo come dipendenze, non analizzati in dettaglio.
- Elementi esclusi:
  - job backend.
  - repository dati.
  - DTO puri.
  - settings.
  - helper/writer XML.
  - template HTML.
- Elementi non deducibili:
  - consumer ulteriori non modificati nel periodo.
  - side effects indiretti interni ai repository.
  - validazioni complete dei dati repository.
  - schedulazione del job consumer.
- Conferma:
  - Nessun file in `llm-wiki/wiki/` e stato creato o modificato.
