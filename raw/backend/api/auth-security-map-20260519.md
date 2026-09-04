# Backend Auth Security Map RAW

## Metadata

- Data analisi: 2026-05-19
- Ambito: backend/api
- Filtro applicato: soli file modificati dopo il 2026-05-14
- Root analizzata: `src/RugbyRadio`
- Output: `llm-wiki/raw/backend/api/auth-security-map-20260519.md`
- Nota sicurezza: valori segreti e stringhe di connessione non riportati.

## File analizzati

- `src/RugbyRadio/HF/appsettings.json`
- `src/RugbyRadio/HF/Dto/SeoPublicUrl.cs`
- `src/RugbyRadio/HF/Dto/SeoPublicUrlRules.cs`
- `src/RugbyRadio/HF/Helpers/SitemapXmlWriter.cs`
- `src/RugbyRadio/HF/Jobs/Core/BaseCoreJob.cs`
- `src/RugbyRadio/HF/Jobs/CreateMatchBlogHtmlJob.cs`
- `src/RugbyRadio/HF/Jobs/GenerateSeoSitemapJob.cs`
- `src/RugbyRadio/HF/Program.cs`
- `src/RugbyRadio/HF/Services/ISeoUrlInventoryService.cs`
- `src/RugbyRadio/HF/Services/SeoUrlInventoryService.cs`
- `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelRepository.cs`
- `src/RugbyRadio/Lib/Repositories/ChannelBox/IChannelRepository.cs`
- `src/RugbyRadio/Lib/Repositories/MatchBox/IMatchRepository.cs`
- `src/RugbyRadio/Lib/Repositories/MatchBox/MatchRepository.cs`
- `src/RugbyRadio/Lib/Repositories/TeamBox/ITeamRepository.cs`
- `src/RugbyRadio/Lib/Repositories/TeamBox/TeamRepository.cs`
- `src/RugbyRadio/Lib/Settings/SeoSitemapSettings.cs`

## Sintesi risultati

- Configurazioni auth/security trovate: 3
- Endpoint pubblici trovati: 0
- Endpoint protetti trovati: 0
- Policy o ruoli trovati: 0
- Controlli applicativi trovati: 4
- Endpoint sensibili o superfici operative trovate: 1

## Configurazioni autenticazione e autorizzazione

### HFSecuritySettingsReference

- File: `src/RugbyRadio/HF/Program.cs`
- Tipo: configurazione
- Evidenza:
  - `SecuritySettings` viene registrato tramite sezione `Security`.
- Chiavi correlate:
  - `Security.ValidIssuer`
  - `Security.ValidAudience`
  - `Security.SecretKey`
  - `Security.ExpirationMinutes`
- Valori segreti: non riportati.
- Note:
  - Nei file modificati analizzati non risultano chiamate a `AddAuthentication`, `AddAuthorization`, `UseAuthentication` o `UseAuthorization`.

### HFMiddlewareSecuritySurface

- File: `src/RugbyRadio/HF/Program.cs`
- Tipo: middleware
- Evidenza:
  - `UseHttpsRedirection()`
  - `UseStaticFiles()`
  - `UseHangfireDashboard()`
- Note:
  - `UseSwagger()` e `UseSwaggerUI()` sono registrati solo in ambiente development.
  - Non risultano filtri autorizzativi espliciti collegati a `UseHangfireDashboard()` nei file modificati analizzati.

### SensitiveConfigurationReferences

- File: `src/RugbyRadio/HF/appsettings.json`
- Tipo: configurazione sensibile
- Chiavi correlate:
  - `ConnectionStrings.App`
  - `ConnectionStrings.HF`
  - `Security.SecretKey`
  - `Smtp.Username`
  - `Smtp.Password`
  - `Meta.FbAppId`
  - `Meta.FbAppSecret`
  - `Meta.FbAccessToken`
- Valori segreti: non riportati.
- Note:
  - La presenza delle chiavi indica dipendenze da credenziali/configurazioni sensibili.
  - Non e deducibile dai soli file modificati il meccanismo di secret management.

## Endpoint e attributi auth

- Nessun controller, minimal endpoint o mapping API modificato dopo il 2026-05-14 e rilevato nel perimetro analizzato.
- Nessun attributo `[Authorize]`, `[AllowAnonymous]`, policy o ruolo trovato nei file modificati analizzati.

## Servizi auth/security

- Nessun servizio auth dedicato trovato nei file modificati analizzati.
- `SeoUrlInventoryService` non espone controlli auth. Contiene regole di inclusione/esclusione SEO per URL pubblici, non classificabili come autorizzazione applicativa.

## Controlli ownership/accesso applicativo

### ChannelRepository.CountByUserAsync

- File: `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelRepository.cs`
- Metodo: `CountByUserAsync(string userId)`
- Ambito: Channel/User
- Dove avviene: Repository
- Regola:
  - Conta canali non cancellati dove `Channel.UserId` corrisponde a `userId` oppure dove `Owners` contiene `userId`.
- Effetto se la regola non corrisponde:
  - Il canale non contribuisce al conteggio.
- Note:
  - Controllo applicativo di ownership/co-ownership deducibile dalla query.

### ChannelRepository.FindByUserAsync

- File: `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelRepository.cs`
- Metodo: `FindByUserAsync(string userId)`
- Ambito: Channel/User
- Dove avviene: Repository
- Regola:
  - Recupera canali non cancellati dove `Channel.UserId` corrisponde a `userId` oppure dove `Owners` contiene `userId`.
- Effetto se la regola non corrisponde:
  - Il canale non viene incluso nei risultati.
- Note:
  - Controllo applicativo di ownership/co-ownership deducibile dalla query.

### MatchRepository.FindOnGoingIncludeByUserIdAsync

- File: `src/RugbyRadio/Lib/Repositories/MatchBox/MatchRepository.cs`
- Metodo: `FindOnGoingIncludeByUserIdAsync(string userId)`
- Ambito: Match/User
- Dove avviene: Repository
- Regola:
  - Recupera partite in corso, halftime o scheduled associate a un canale del proprietario `userId`.
  - Recupera anche partite associate a canali dove `Owners` contiene `userId`.
- Effetto se la regola non corrisponde:
  - La partita non viene inclusa nei risultati.
- Note:
  - Controllo applicativo di ownership/co-ownership deducibile dalla query.

### MatchRepository.FindTrainingByUserIdAsync

- File: `src/RugbyRadio/Lib/Repositories/MatchBox/MatchRepository.cs`
- Metodo: `FindTrainingByUserIdAsync(string userId)`
- Ambito: Match/User
- Dove avviene: Repository
- Regola:
  - Recupera partite di allenamento dove `Channel.UserId` corrisponde a `userId` e `Channel.IsTestChannel` e `true`.
- Effetto se la regola non corrisponde:
  - La partita non viene inclusa nei risultati.
- Note:
  - Controllo applicativo di ownership deducibile dalla query.

## Endpoint sensibili o superfici operative

### HangfireDashboard

- File: `src/RugbyRadio/HF/Program.cs`
- Tipo: dashboard operativa
- Evidenza:
  - `UseHangfireDashboard()`
- Protezione visibile:
  - Non deducibile dai soli file modificati analizzati.
- Note:
  - Non classificato come endpoint pubblico o protetto per assenza di attributi endpoint/API e perimetro limitato ai file modificati.

## Dati non deducibili

- Non e deducibile dai soli file modificati se l'autenticazione principale sia registrata in file non modificati dopo il 2026-05-14.
- Non e deducibile dai soli file modificati se `HangfireDashboard` sia protetta da filtri esterni, reverse proxy, ambiente o configurazione non presente nei file analizzati.
- Non e deducibile dai soli file modificati la mappa completa di endpoint pubblici/protetti dell'applicazione.
- Non sono stati letti o consolidati controller e servizi non modificati dopo il 2026-05-14.
- I valori di secret, token, password e connection string non sono riportati nel documento.

## Conferma per ingest successivo

- Il documento contiene solo evidenze dai file modificati dopo il 2026-05-14.
- Il documento non contiene path assoluti.
- Il documento non modifica la wiki.
- Il documento puo essere ingerito successivamente come RAW backend auth/security.
