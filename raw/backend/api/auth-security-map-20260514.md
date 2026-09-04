# Backend Auth Security Map RAW

## Sintesi

- Data analisi: 2026-05-14
- Project: api
- Root backend analizzata: `src/RugbyRadio/Api/`
- File output: `llm-wiki/raw/backend/api/auth-security-map-20260514.md`
- Configurazioni auth trovate: 4
- Endpoint pubblici trovati: 11
- Endpoint protetti trovati: 44
- Endpoint con accesso non deducibile: 14
- Policy/ruoli trovati: 0
- Controlli applicativi trovati: 5

---

## Configurazione autenticazione/autorizzazione

---

## JwtBearerAuthentication (api)

### Nome wiki suggerito

`JwtBearerAuthentication (api)`

### File sorgente

- `src/RugbyRadio/Lib/Core/Extensions/ServiceCollectionExtensions.cs`
- `src/RugbyRadio/Api/Program.cs`

### Tipo

Authentication — JWT Bearer

### Dettagli verificabili

- Schema di autenticazione: `JwtBearerDefaults.AuthenticationScheme` impostato come schema default per `DefaultAuthenticateScheme`, `DefaultChallengeScheme`, `DefaultScheme`
- Algoritmo firma token: `HmacSha256` (simmetrico)
- `ValidateIssuer`: `true`
- `ValidateAudience`: `true`
- `ValidateIssuerSigningKey`: `true`
- `SaveToken`: `true`
- `RequireHttpsMetadata`: `false`
- Token letto da header `Authorization` (Bearer) oppure da cookie `Authentication` — la logica in `OnMessageReceived` privilegia il cookie `Authentication` sull'header se il cookie è presente; se l'header non è presente usa il cookie
- `app.UseAuthentication()` e `app.UseAuthorization()` registrati in `Program.cs`
- Nessuna policy globale `RequireAuthorization()` visibile: gli endpoint senza `[Authorize]` sono accessibili senza token

### Secret/config reference

- `Security:SecretKey` — chiave simmetrica per firma JWT; valore sensibile presente in `appsettings.json` (non riportato)
- `Security:ValidIssuer` — issuer JWT; valore in `appsettings.json`
- `Security:ValidAudience` — audience JWT; valore in `appsettings.json`
- `Security:ExpirationMinutes` — durata token in minuti; valore: 525600 (circa 1 anno)

### Note di confidenza

Verificato dal codice

---

## SecuritySettings (api)

### Nome wiki suggerito

`SecuritySettings (api)`

### File sorgente

- `src/RugbyRadio/Lib/Settings/SecuritySettings.cs`
- `src/RugbyRadio/Api/Program.cs`

### Tipo

Configurazione security — settings binding

### Dettagli verificabili

- Classe POCO che mappa la sezione `Security` di `appsettings.json`
- Proprietà: `ValidIssuer`, `ValidAudience`, `SecretKey`, `ExpirationMinutes`
- Istanza letta in `Program.cs` tramite `builder.Configuration.GetSection("Security").Get<SecuritySettings>()`
- Passata esplicitamente a `RegisterSecurity(securitySettings)`
- `ArgumentNullException.ThrowIfNull(securitySettings)` presente in `Program.cs`: se la sezione manca, la startup fallisce

### Secret/config reference

- `Security:SecretKey` — chiave di firma JWT; valore sensibile presente in `appsettings.json` in chiaro (non riportato)

### Note di confidenza

Verificato dal codice

---

## CorsPolicy (api)

### Nome wiki suggerito

`CorsPolicy (api)`

### File sorgente

- `src/RugbyRadio/Api/Program.cs`

### Tipo

CORS

### Dettagli verificabili

- Policy configurata: `AllowAllOrigins`
- `AllowAnyOrigin()`, `AllowAnyHeader()`, `AllowAnyMethod()`
- CORS completamente aperto senza restrizioni di origine
- `app.UseCors("AllowAllOrigins")` registrato dopo `app.MapControllers()` — posizione nella pipeline successiva al mapping dei controller

### Secret/config reference

- Nessuno

### Note di confidenza

Verificato dal codice

---

## AuditMiddleware (api)

### Nome wiki suggerito

`AuditMiddleware (api)`

### File sorgente

- `src/RugbyRadio/Lib/Core/Middlewares/AuditMiddleware.cs`
- `src/RugbyRadio/Api/Program.cs`

### Tipo

Middleware — audit logging

### Dettagli verificabili

- Applicato a tutte le richieste HTTP eccetto quelle con metodo HEAD (`UseWhen(context => !HttpMethods.IsHead(...))`)
- Registra: metodo HTTP, path, query string, body request (con sanitizzazione di `Base64Previews`), body response, status code, tempo di risposta, user ID corrente, lingua utente, lingua commentary, nome operazione interno (dal `RouteNameMetadata`)
- Legge lo user ID corrente da `ClaimTypes.NameIdentifier` nel `HttpContext.User` — se non autenticato registra `null`
- Legge header `X-USER-LANGUAGE` e `X-COMMENTARY-LANGUAGE`
- Non blocca le richieste: è un middleware di osservazione, non di autorizzazione
- Salva su `IAuditRepository` — le richieste con metodo OPTIONS o senza `RequestInternalName` sono escluse dal salvataggio
- Le eccezioni durante l'audit sono silenziate (log su file `logs/{date}.log`) per non interrompere la risposta

### Secret/config reference

- Nessuno

### Note di confidenza

Verificato dal codice

---

## Endpoint e attributi auth

---

## AdminV1Controller

### File sorgente

- `src/RugbyRadio/Api/Controllers/AdminV1Controller.cs`

### Autorizzazione controller

- `[Authorize]`: no
- `[AllowAnonymous]`: no
- Ruoli: nessuno
- Policy: nessuna
- Note: protezione custom tramite query parameter `authKey` verificato contro costante interna; nessun meccanismo ASP.NET Core standard

### Endpoint

#### GET /v1/admin/messages/draft

- Metodo C#: `GetDraftMessages`
- Stato accesso: Non deducibile (protezione custom via `authKey`)
- Attributi: nessuno
- Dati utente usati: nessuno (non usa claims o current user)
- Note: la chiave è hardcoded come `const string` nel controller; passata come query parameter in chiaro

#### DELETE /v1/admin/messages/draft/{messageId}

- Metodo C#: `DeleteMessageDrafts`
- Stato accesso: Non deducibile (protezione custom via `authKey`)
- Attributi: nessuno
- Dati utente usati: nessuno
- Note: idem sopra

#### PUT /v1/admin/messages/draft/{messageId}

- Metodo C#: `UpdateMessageDrafts`
- Stato accesso: Non deducibile (protezione custom via `authKey`)
- Attributi: nessuno
- Dati utente usati: nessuno
- Note: idem sopra

#### PUT /v1/admin/messages/draft/{messageId}/verify

- Metodo C#: `ApproveMessageDrafts`
- Stato accesso: Non deducibile (protezione custom via `authKey`)
- Attributi: nessuno
- Dati utente usati: nessuno
- Note: idem sopra

#### GET /v1/admin/messages/statistics

- Metodo C#: `GetMessageStatistics`
- Stato accesso: Non deducibile (protezione custom via `authKey`)
- Attributi: nessuno
- Dati utente usati: nessuno
- Note: idem sopra

---

## AuthV1Controller

### File sorgente

- `src/RugbyRadio/Api/Controllers/AuthV1Controller.cs`

### Autorizzazione controller

- `[Authorize]`: no
- `[AllowAnonymous]`: no
- Ruoli: nessuno
- Policy: nessuna
- Note: controller di autenticazione — nessun attributo di protezione dichiarato. Tutti gli endpoint sono accessibili senza token JWT.

### Endpoint

#### POST /v1/auth/users

- Metodo C#: `Register`
- Stato accesso: Non deducibile (nessun attributo; pubblico per natura)
- Attributi: nessuno
- Dati utente usati: nessuno (crea nuovo utente)
- Note: endpoint di registrazione

#### PUT /v1/auth/users

- Metodo C#: `Activation`
- Stato accesso: Non deducibile
- Attributi: nessuno
- Dati utente usati: token di attivazione via query parameter
- Note: endpoint di attivazione account

#### POST /v1/auth/user/login

- Metodo C#: `Login`
- Stato accesso: Non deducibile
- Attributi: nessuno
- Dati utente usati: `email` e `password` via body
- Note: endpoint di login

#### POST /v1/auth/users/google

- Metodo C#: `GoogleLogin`
- Stato accesso: Non deducibile
- Attributi: nessuno
- Dati utente usati: `token` Google ID (validato da `GoogleJsonWebSignature.ValidateAsync`)
- Note: endpoint di login/registrazione Google OAuth

#### POST /v1/auth/users/forgot

- Metodo C#: `ForgotPassword`
- Stato accesso: Non deducibile
- Attributi: nessuno
- Dati utente usati: `email` via body
- Note: endpoint di recupero password — genera OTP

#### POST /v1/auth/users/password

- Metodo C#: `ChangePassword`
- Stato accesso: Non deducibile
- Attributi: nessuno
- Dati utente usati: `otpCode` e nuova `password` via body
- Note: endpoint di cambio password con OTP

---

## BlogV1Controller

### File sorgente

- `src/RugbyRadio/Api/Controllers/BlogV1Controller.cs`

### Autorizzazione controller

- `[Authorize]`: no
- `[AllowAnonymous]`: sì (su entrambi gli endpoint)

### Endpoint

#### GET /v1/blog

- Metodo C#: `GetBlog`
- Stato accesso: Pubblico
- Attributi: `[AllowAnonymous]`
- Dati utente usati: nessuno

#### GET /v1/blog/matches/{matchId}

- Metodo C#: `GetMatchBlog`
- Stato accesso: Pubblico
- Attributi: `[AllowAnonymous]`
- Dati utente usati: nessuno

---

## ChannelUsersV1Controller

### File sorgente

- `src/RugbyRadio/Api/Controllers/ChannelUsersV1Controller.cs`

### Autorizzazione controller

- `[Authorize]`: no (a livello controller)
- `[AllowAnonymous]`: no
- Note: tutti gli endpoint hanno `[Authorize]` individuale

### Endpoint

#### GET /v1/channels/{channelId}/users

- Metodo C#: `GetUsers`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()` (claim `ClaimTypes.NameIdentifier`)
- Note: verifica ownership canale tramite `_channelService.VerifyAuthAsync`

#### POST /v1/channels/{channelId}/users

- Metodo C#: `AddUser`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership canale

#### DELETE /v1/channels/{channelId}/users/{userId}

- Metodo C#: `AddUser` (overload — naming nel codice da verificare)
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership canale

---

## ChannelsV1Controller

### File sorgente

- `src/RugbyRadio/Api/Controllers/ChannelsV1Controller.cs`

### Autorizzazione controller

- `[Authorize]`: no (a livello controller)
- `[AllowAnonymous]`: no (a livello controller)
- Note: attributi misti per endpoint

### Endpoint

#### GET /v1/channels

- Metodo C#: `GetChannels`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### GET /v1/channels/{channelId}

- Metodo C#: `GetChannelById`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership canale

#### POST /v1/channels

- Metodo C#: `AddChannel`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### PUT /v1/channels/{channelId}

- Metodo C#: `UpdateChannel`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership canale

#### PUT /v1/channels/{channelId}/layout

- Metodo C#: `UpdateChannelLayout`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership canale

#### PUT /v1/channels/{channelId}/subscription

- Metodo C#: `ManageChannelSubscription`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### GET /v1/channels/favorites

- Metodo C#: `FindFavorites`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### GET /v1/channels/public/{publicId}

- Metodo C#: `GetByPublicId`
- Stato accesso: Pubblico
- Attributi: `[AllowAnonymous]`
- Dati utente usati: `userId` da `GetCurrentUserIdIfLogged()` — opzionale, `null` se non autenticato

#### GET /v1/channels/public/search

- Metodo C#: `FindChannels`
- Stato accesso: Pubblico
- Attributi: `[AllowAnonymous]`
- Dati utente usati: nessuno

---

## MatchEventsV1Controllers

### File sorgente

- `src/RugbyRadio/Api/Controllers/MatchEventsV1Controllers.cs`

### Autorizzazione controller

- `[Authorize]`: no (a livello controller)
- `[AllowAnonymous]`: no

### Endpoint

#### POST /v1/matches/{matchId}/events

- Metodo C#: `AddEvent`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership tramite `_matchService.VerifyAuthAsync`

#### DELETE /v1/matches/{matchId}/events/{eventId}

- Metodo C#: `DeleteEvent`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership tramite `_matchService.VerifyAuthAsync`

---

## MatchLineupsV1Controller

### File sorgente

- `src/RugbyRadio/Api/Controllers/MatchLineupsV1Controller.cs`

### Autorizzazione controller

- `[Authorize]`: no (a livello controller)
- `[AllowAnonymous]`: no

### Endpoint

#### PUT /v1/channels/{channelId}/matches/{matchId}/lineups/{lineupId}

- Metodo C#: `UpdatePlayerLineup`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership canale, partita e lineup tramite `_matchService.VerifyAuthAsync`

#### POST /v1/channels/{channelId}/matches/{matchId}/lineups/{lineupId}

- Metodo C#: `AddPlayerLineup`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership

#### DELETE /v1/channels/{channelId}/matches/{matchId}/lineups/{lineupId}

- Metodo C#: `RemovePlayerLineup`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership

---

## MatchesV1Controller

### File sorgente

- `src/RugbyRadio/Api/Controllers/MatchesV1Controller.cs`

### Autorizzazione controller

- `[Authorize]`: no (a livello controller)
- `[AllowAnonymous]`: no (a livello controller)
- Note: attributi misti per endpoint

### Endpoint

#### GET /v1/channels/{channelId}/matches

- Metodo C#: `GetMatchesByChannel`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership canale

#### GET /v1/matches/{matchId}

- Metodo C#: `GetMatchById`
- Stato accesso: Pubblico
- Attributi: `[AllowAnonymous]`
- Dati utente usati: `userId` da `GetCurrentUserIdIfLogged()` — opzionale

#### POST /v1/channels/{channelId}/matches

- Metodo C#: `AddMatch`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership canale

#### PUT /v1/matches/{matchId}/stats

- Metodo C#: `UpdateMatchStats`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership tramite matchId

#### POST /v1/matches/{matchId}/reactions

- Metodo C#: `AddReaction`
- Stato accesso: Non deducibile
- Attributi: nessuno
- Dati utente usati: `userId` da `GetCurrentUserIdIfLogged()` — opzionale
- Note: nessun `[Authorize]` né `[AllowAnonymous]`; accetta utenti anonimi e autenticati

#### POST /v1/matches/{matchId}/comments

- Metodo C#: `AddComment`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### DELETE /v1/matches/{matchId}/comments/{commentId}

- Metodo C#: `DeleteComment`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership tramite matchId

#### PUT /v1/matches/{matchId}/status

- Metodo C#: `UpdateStatus`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership

#### PUT /v1/channels/{channelId}/matches/{matchId}

- Metodo C#: `UpdateMatch`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership canale

#### GET /v1/channels/{channelId}/matches/search

- Metodo C#: `SearchByChannel`
- Stato accesso: Pubblico
- Attributi: `[AllowAnonymous]`
- Dati utente usati: nessuno

#### GET /v1/matches/public/search

- Metodo C#: `FindChannels`
- Stato accesso: Pubblico
- Attributi: `[AllowAnonymous]`
- Dati utente usati: nessuno

#### POST /v1/matches/{matchId}/players/{lineupPlayerId}/rate

- Metodo C#: `SaveRates`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### PUT /v1/matches/{matchId}/like

- Metodo C#: `SaveLike`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### GET /v1/matches/ongoing

- Metodo C#: `GetOnGoingMatch`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### PUT /v1/matches/{matchId}/follow

- Metodo C#: `ManageFollow`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### POST /v1/matches/{matchId}/notification

- Metodo C#: `SendNotification`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: nessuno (non usa current user esplicitamente nel controller)

#### POST /v1/matches

- Metodo C#: `AddMatchQuick`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### GET /v1/teams/{teamId}/matches/search

- Metodo C#: `GetMatchesByTeam`
- Stato accesso: Pubblico
- Attributi: `[AllowAnonymous]`
- Dati utente usati: nessuno

#### GET /v1/channels/matches/training

- Metodo C#: `GetTrainingMatchByCurrentUser`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

---

## PlayersV1Controller

### File sorgente

- `src/RugbyRadio/Api/Controllers/PlayersV1Controller.cs`

### Autorizzazione controller

- `[Authorize]`: no (a livello controller)
- `[AllowAnonymous]`: no

### Endpoint

#### GET /v1/channels/{channelId}/teams/{teamId}/players

- Metodo C#: `GetPlayers`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: nessuno (non verifica ownership per la lettura)
- Note: non chiama `VerifyAuthAsync` per GET

#### POST /v1/channels/{channelId}/teams/{teamId}/players

- Metodo C#: `AddPlayer`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership tramite `_playerService.VerifyAuthAsync`

#### PUT /v1/channels/{channelId}/teams/{teamId}/players/{playerId}

- Metodo C#: `UpdatePlayer`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership

#### DELETE /v1/channels/{channelId}/teams/{teamId}/players/{playerId}

- Metodo C#: `DeletePlayer`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership

---

## StatsV1Controller

### File sorgente

- `src/RugbyRadio/Api/Controllers/StatsV1Controller.cs`

### Autorizzazione controller

- `[Authorize]`: no
- `[AllowAnonymous]`: sì (sull'endpoint)

### Endpoint

#### GET /v1/stats

- Metodo C#: `GetStats`
- Stato accesso: Pubblico
- Attributi: `[AllowAnonymous]`
- Dati utente usati: nessuno

---

## TeamsV1Controller

### File sorgente

- `src/RugbyRadio/Api/Controllers/TeamsV1Controller.cs`

### Autorizzazione controller

- `[Authorize]`: no (a livello controller)
- `[AllowAnonymous]`: no

### Endpoint

#### GET /v1/channels/{channelId}/teams

- Metodo C#: `GetTeams`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership canale

#### GET /v1/teams/logos

- Metodo C#: `GetLogos`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: nessuno (dato statico)

#### POST /v1/channels/{channelId}/teams

- Metodo C#: `AddTeam`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership canale

#### PUT /v1/channels/{channelId}/teams/{teamId}

- Metodo C#: `UpdateTeam`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`
- Note: verifica ownership canale

#### GET /v1/teams

- Metodo C#: `GetTeams`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### GET /v1/teams/{teamId}

- Metodo C#: `GetTeam`
- Stato accesso: Pubblico
- Attributi: `[AllowAnonymous]`
- Dati utente usati: nessuno

---

## UserV1Controller

### File sorgente

- `src/RugbyRadio/Api/Controllers/UserV1Controller.cs`

### Autorizzazione controller

- `[Authorize]`: no (a livello controller)
- `[AllowAnonymous]`: no (a livello controller)

### Endpoint

#### GET /v1/user/avatars

- Metodo C#: `GetAvatars`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: nessuno (dato statico)

#### GET /v1/user

- Metodo C#: `GetProfile`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### PUT /v1/user

- Metodo C#: `UpdateUser`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### PUT /v1/user/timezone

- Metodo C#: `UpdateUser` (overload)
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### PUT /v1/user/notification

- Metodo C#: `NotificationToken`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### DELETE /v1/user

- Metodo C#: `DeleteUser`
- Stato accesso: Protetto
- Attributi: `[Authorize]`
- Dati utente usati: `userId` da `GetCurrentUserId()`

#### POST /v1/user/feedback

- Metodo C#: `FeedbackUser`
- Stato accesso: Pubblico
- Attributi: `[AllowAnonymous]`
- Dati utente usati: nessuno

---

## VoicesV1Controller

### File sorgente

- `src/RugbyRadio/Api/Controllers/VoicesV1Controller.cs`

### Autorizzazione controller

- `[Authorize]`: no
- `[AllowAnonymous]`: no

### Endpoint

#### GET /v1/voices

- Metodo C#: `GetAudio`
- Stato accesso: Non deducibile
- Attributi: nessuno
- Dati utente usati: nessuno

#### GET /v1/voices/events

- Metodo C#: `GetEventAudio`
- Stato accesso: Non deducibile
- Attributi: nessuno
- Dati utente usati: nessuno

---

## Servizi auth/security

---

## UserService (api)

### Nome wiki suggerito

`UserService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/UserBox/UserService.cs`

### Responsabilità tecnica

Gestione completa del ciclo di vita dell'utente: registrazione, attivazione, login (email+password e Google OAuth), generazione token JWT, OTP per reset password, aggiornamento profilo, cancellazione account, salvataggio token notifiche push.

### Dipendenze iniettate

- `IUnitOfWork`
- `IUserRepository`
- `IChannelRepository`
- `IUserTokenRepository`
- `IUserOtpCodeRepository`
- `ISubscriptionRepository`
- `IEmailService`
- `IOptions<SecuritySettings>`
- `IOptions<ProvidersSettings>`

### Metodi pubblici significativi

#### RegisterNewUserAsync(nickname, email, password, language)

- Input: `nickname` (`string`), `email` (`string`), `password` (`string`), `language` (`string`)
- Output: `Task<User>`
- Area sicurezza: registrazione
- Controlli visibili:
  - verifica email già esistente (`GetByEmailAsync`); se esiste lancia `EmailAlreadyExists`
  - nickname troncato a 20 caratteri
  - password salvata in chiaro (non deducibile hashing dal codice del service)
  - `IsActive = true`, `IsVerified = false` al momento della registrazione
  - `ActivationToken` generato come `Guid.NewGuid().ToString()`
- Entity coinvolte: Scrittura: `User`
- Side effects: nessun invio email visibile in questo metodo (ATH-01 non invia email di verifica — verificato)
- Errori/casi limite: `EmailAlreadyExists` se email già registrata
- Note di confidenza: Verificato dal codice

---

#### VerifyUserAsync(token)

- Input: `token` (`string`)
- Output: `Task<User>`
- Area sicurezza: attivazione account
- Controlli visibili:
  - cerca utente per `ActivationToken`
  - se utente non trovato o già verificato: lancia `NotAllowed`
  - imposta `IsVerified = true`
- Entity coinvolte: Lettura/Scrittura: `User`
- Side effects: nessuno deducibile
- Errori/casi limite: `NotAllowed` se token non valido o utente già attivato
- Note di confidenza: Verificato dal codice

---

#### GetUserTokenAsync(email, password)

- Input: `email` (`string?`), `password` (`string?`)
- Output: `Task<UserTokenDto>`
- Area sicurezza: login, generazione token JWT
- Controlli visibili:
  - validazione email e password non nulle/vuote
  - lookup utente per email+password (`GetByLoginAsync`) — modalità di confronto password non deducibile dal solo service
  - se utente non trovato: lancia `InvalidCredentials`
- Entity coinvolte: Lettura: `User`
- Side effects: creazione token JWT (in memoria, non persistito)
- Errori/casi limite: `InvalidModel`, `InvalidCredentials`
- Note di confidenza: Verificato dal codice

---

#### GetUserTokenAsync(email)

- Input: `email` (`string?`)
- Output: `Task<UserTokenDto>`
- Area sicurezza: login via provider OAuth, generazione token JWT
- Controlli visibili:
  - lookup utente per email
  - se non trovato: lancia `InvalidCredentials`
- Entity coinvolte: Lettura: `User`
- Side effects: creazione token JWT (in memoria)
- Errori/casi limite: `InvalidModel`, `InvalidCredentials`
- Note di confidenza: Verificato dal codice

---

#### GetUserTokenInternalAsync(user) — privato

- Input: `User`
- Output: `UserTokenDto`
- Area sicurezza: generazione token JWT
- Dettagli token generato:
  - Claim `Jti`: `Guid.NewGuid()`
  - Claim `NameIdentifier`: `user.Id`
  - Claim `Name`: `user.Nickname`
  - Claim `Email`: `user.Email`
  - Scadenza: `DateTime.UtcNow + ExpirationMinutes` (da config — 525600 min ≈ 1 anno)
  - Firma: `HmacSha256` con `SecuritySettings.SecretKey`
  - Issuer e Audience da `SecuritySettings`
- Side effects: nessuno (token non persistito)
- Note di confidenza: Verificato dal codice

---

#### RegisterNewGoogleUserAsync(language, token)

- Input: `language` (`string`), `token` (`string`) — Google ID token
- Output: `Task<User>`
- Area sicurezza: login/registrazione Google OAuth
- Controlli visibili:
  - valida il token Google con `GoogleJsonWebSignature.ValidateAsync(token, settings)`
  - `settings.Audience` = `ProvidersSettings.Google.ClientId`
  - se `payload == null`: lancia `NotAuthorized`
  - se utente esiste già per email: restituisce l'utente esistente senza crearne uno nuovo
  - password impostata a stringa letterale `"Google"` per utenti OAuth
- Entity coinvolte: Lettura/Scrittura: `User`
- Side effects: nessuno deducibile
- Errori/casi limite: `NotAuthorized` se token Google non valido
- Note di confidenza: Verificato dal codice

---

#### ForgotPassword(email)

- Input: `email` (`string`)
- Output: `Task`
- Area sicurezza: reset password — generazione OTP
- Controlli visibili:
  - lookup utente per email; se non trovato: lancia `InvalidEmail`
  - genera codice OTP numerico a 6 cifre (`Random().Next(100000, 999999)`)
  - scadenza OTP: 1 ora da `DateTime.UtcNow`
  - `IsUsed = false` al momento della creazione
- Entity coinvolte: Lettura: `User`; Scrittura: `UserOtpCode`
- Side effects: salvataggio OTP; invio email tramite `IEmailService.SendOptCode`
- Errori/casi limite: `InvalidEmail` se utente non trovato
- Note di confidenza: Verificato dal codice

---

#### ChangePassword(otpCode, newPassword)

- Input: `otpCode` (`string`), `newPassword` (`string`)
- Output: `Task<UserTokenDto>`
- Area sicurezza: reset password con OTP
- Controlli visibili:
  - lookup OTP per codice numerico
  - verifica: OTP non nullo, non scaduto (`Expiration >= DateTime.UtcNow`), non già usato (`IsUsed == false`)
  - se controllo fallisce: lancia `NotFound`
  - imposta `IsUsed = true` prima di aggiornare la password
  - aggiorna password utente (in chiaro — hashing non deducibile)
  - genera nuovo token JWT
- Entity coinvolte: Lettura/Scrittura: `User`, `UserOtpCode`
- Side effects: aggiornamento OTP come usato; aggiornamento password; generazione token JWT
- Errori/casi limite: `NotFound` se OTP non valido, scaduto o già usato; `NotFound` se utente non trovato
- Note di confidenza: Verificato dal codice

---

#### DeleteUser(userId)

- Input: `userId` (`string`)
- Output: `Task`
- Area sicurezza: cancellazione account
- Controlli visibili:
  - lookup utente per ID; se non trovato: lancia `NotAuthorized`
  - pseudonimizzazione: email sostituita con `{userId}@deleted.rrl`; nickname randomizzato; `IsActive = false`; `ProviderUserId = null`; `Provider = null`
  - `IsDeleted = false` (comportamento: impostato a false al momento della cancellazione — da verificare se è il valore atteso)
- Entity coinvolte: Lettura/Scrittura: `User`
- Side effects: pseudonimizzazione dati utente
- Errori/casi limite: `NotAuthorized` se utente non trovato
- Note di confidenza: Verificato dal codice

---

## ChannelService — VerifyAuthAsync (api)

### Nome wiki suggerito

`ChannelService.VerifyAuthAsync (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelService.cs`

### Responsabilità tecnica

Verifica che l'utente corrente sia owner o co-owner del canale prima di operazioni privilegiate.

### Metodi pubblici significativi

#### VerifyAuthAsync(userId, channelId)

- Input: `userId` (`string`), `channelId` (`string`)
- Output: `Task`
- Area sicurezza: ownership canale
- Controlli visibili:
  - carica il canale per ID
  - se `channel.UserId == userId`: passa
  - se `channel.Owners` contiene un owner con `UserId == userId`: passa
  - altrimenti: lancia `NotAuthorized`
- Effetto se fallisce: `RugbyRadioValidationException` → `BadRequest` via `RugbyRadioExceptionFilter`
- Note di confidenza: Verificato dal codice

---

## MatchService — VerifyAuthAsync (api)

### Nome wiki suggerito

`MatchService.VerifyAuthAsync (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/MatchBox/MatchService.cs`

### Responsabilità tecnica

Verifica gerarchica dei permessi di accesso a partita, canale, squadra, formazione e giocatore.

### Metodi pubblici significativi

#### VerifyAuthAsync(userId, channelId?, matchId?, teamId?, lineupPlayerId?, playerId?)

- Input: tutti i parametri opzionali tranne `userId`
- Output: `Task`
- Area sicurezza: ownership multi-livello (canale → partita → squadra → formazione → giocatore)
- Controlli visibili:
  - se `channelId` e `matchId` entrambi nulli: lancia `NotAuthorized`
  - se solo `matchId` fornito: carica la partita e ne ricava `ChannelId`
  - verifica `channel.IsOwner(userId)` — metodo su entity `Channel` che controlla sia `UserId` che `Owners`
  - se `matchId` fornito: verifica `match.ChannelId == channelId` e che la partita non sia archiviata (`IsArchived != true`)
  - se `teamId` fornito: verifica `team.ChannelId == channelId`
  - se `lineupPlayerId` fornito: verifica `lineupPlayer.MatchId == matchId`
  - se `playerId` fornito: verifica `player.TeamId == teamId`
- Effetto se fallisce: `RugbyRadioValidationException` → `BadRequest`
- Note di confidenza: Verificato dal codice

---

## TeamService — VerifyAuthAsync (api)

### Nome wiki suggerito

`TeamService.VerifyAuthAsync (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/TeamBox/TeamService.cs`

### Responsabilità tecnica

Verifica ownership del canale e appartenenza della squadra al canale.

### Metodi pubblici significativi

#### VerifyAuthAsync(userId, channelId, teamId?)

- Input: `userId` (`string`), `channelId` (`string`), `teamId` (`string?`)
- Output: `Task`
- Area sicurezza: ownership canale + squadra
- Controlli visibili:
  - carica canale; se non trovato: lancia `NotFound`
  - se `teamId` fornito: verifica `team.ChannelId == channelId` e `channel.IsOwner(userId)`
  - se solo `channelId`: verifica `channel.IsOwner(userId)`
- Effetto se fallisce: `RugbyRadioValidationException` → `BadRequest`
- Note di confidenza: Verificato dal codice

---

## PlayerService — VerifyAuthAsync (api)

### Nome wiki suggerito

`PlayerService.VerifyAuthAsync (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/PlayerBox/PlayerService.cs`

### Responsabilità tecnica

Verifica ownership del canale e appartenenza della squadra e del giocatore.

### Metodi pubblici significativi

#### VerifyAuthAsync(userId, channelId, teamId, playerId?)

- Input: `userId` (`string`), `channelId` (`string`), `teamId` (`string`), `playerId` (`string?`)
- Output: `Task`
- Area sicurezza: ownership canale + squadra + giocatore
- Controlli visibili:
  - carica canale; se `channel == null || channel.UserId != userId`: lancia `NotAuthorized`
  - carica squadra; se `team == null || team.ChannelId != channelId`: lancia `NotAuthorized`
  - se `playerId` fornito: verifica `player.TeamId == teamId`
- Note: usa `channel.UserId != userId` direttamente invece di `IsOwner` — i co-owner non sono considerati in questo controllo (diverso da `ChannelService` e `MatchService`)
- Effetto se fallisce: `RugbyRadioValidationException` → `BadRequest`
- Note di confidenza: Verificato dal codice

---

## BaseController — GetCurrentUserId / GetCurrentUserIdIfLogged (api)

### Nome wiki suggerito

`BaseController.UserContext (api)`

### File sorgente

- `src/RugbyRadio/Api/Controllers/Core/BaseController.cs`

### Responsabilità tecnica

Estrazione del user ID corrente dai claims JWT nelle action dei controller.

### Metodi pubblici significativi

#### GetCurrentUserId()

- Output: `string`
- Area sicurezza: lettura user context
- Controlli visibili:
  - verifica `HttpContext?.User != null`
  - verifica presenza claim `ClaimTypes.NameIdentifier`
  - verifica valore non nullo/vuoto
  - se uno qualsiasi fallisce: lancia `NotAuthorized`
- Effetto se fallisce: `RugbyRadioValidationException` → `BadRequest`
- Note di confidenza: Verificato dal codice

#### GetCurrentUserIdIfLogged()

- Output: `string?` (nullable)
- Area sicurezza: lettura user context opzionale
- Controlli visibili:
  - restituisce `null` se non autenticato — non lancia eccezioni
- Note di confidenza: Verificato dal codice

---

## RugbyRadioExceptionFilter (api)

### Nome wiki suggerito

`RugbyRadioExceptionFilter (api)`

### File sorgente

- `src/RugbyRadio/Lib/Core/Filters/RugbyRadioExceptionFilter.cs`

### Responsabilità tecnica

Gestione centralizzata delle eccezioni: converte `RugbyRadioValidationException` in `BadRequest 400` con messaggio localizzato; converte eccezioni generiche in `BadRequest 400` con stack trace (visibile in risposta).

### Dipendenze iniettate

- `IHttpContextAccessor`
- `ISystemMessageRepository`
- `ILogger<RugbyRadioExceptionFilter>`

### Note di confidenza

Verificato dal codice

---

## Controlli ownership / accesso applicativo

---

## Channel.IsOwner

### File sorgente

- `src/RugbyRadio/Lib/Repositories/ChannelBox/Channel.cs`

### Ambito

Channel

### Dove avviene

Entity (metodo sull'entity `Channel`)

### Regola verificabile

Restituisce `true` se `channel.UserId == userId` (case-insensitive) oppure se `channel.Owners` contiene un elemento con `UserId == userId` (case-insensitive). Usato da `ChannelService.VerifyAuthAsync` e `MatchService.VerifyAuthAsync`.

### Effetto se fallisce

Propagato al chiamante — il chiamante lancia `NotAuthorized`

---

## ChannelService.VerifyAuthAsync — Controllo ownership canale

### File sorgente

- `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelService.cs`

### Ambito

Channel

### Dove avviene

Service

### Regola verificabile

Owner primario (`channel.UserId`) o co-owner (`channel.Owners`) possono operare sul canale. Il controllo avviene prima di ogni operazione di scrittura/lettura privilegiata sul canale.

### Effetto se fallisce

`RugbyRadioValidationException` → `BadRequest 400`

---

## MatchService.VerifyAuthAsync — Controllo gerarchico match/channel/team/lineup

### File sorgente

- `src/RugbyRadio/Lib/Repositories/MatchBox/MatchService.cs`

### Ambito

Channel, Match, Team

### Dove avviene

Service

### Regola verificabile

Verifica catena di appartenenza: l'utente deve essere owner del canale; la partita deve appartenere al canale; la partita non deve essere archiviata; la squadra deve appartenere al canale; la formazione deve appartenere alla partita.

### Effetto se fallisce

`RugbyRadioValidationException` → `BadRequest 400`

---

## TeamService.VerifyAuthAsync — Controllo ownership canale/squadra

### File sorgente

- `src/RugbyRadio/Lib/Repositories/TeamBox/TeamService.cs`

### Ambito

Channel, Team

### Dove avviene

Service

### Regola verificabile

Owner del canale (tramite `IsOwner`) può operare sulle squadre del canale. La squadra deve appartenere al canale.

### Effetto se fallisce

`RugbyRadioValidationException` → `BadRequest 400`

---

## PlayerService.VerifyAuthAsync — Controllo ownership canale/squadra/giocatore

### File sorgente

- `src/RugbyRadio/Lib/Repositories/PlayerBox/PlayerService.cs`

### Ambito

Channel, Team

### Dove avviene

Service

### Regola verificabile

Solo owner primario del canale (`channel.UserId == userId`, senza considerare i co-owner) può gestire i giocatori. Differisce da `ChannelService` e `MatchService` che usano `IsOwner` (che include i co-owner).

### Effetto se fallisce

`RugbyRadioValidationException` → `BadRequest 400`

---

## AdminV1Controller.CheckAuthKey — Protezione endpoint admin

### File sorgente

- `src/RugbyRadio/Api/Controllers/AdminV1Controller.cs`

### Ambito

Admin

### Dove avviene

Controller

### Regola verificabile

Confronto `string.Equals(authKey, AuthKey)` con chiave hardcoded come `const string` nel controller. Ricevuta via query parameter in chiaro. Nessun meccanismo ASP.NET Core standard (JWT, [Authorize], policy).

### Effetto se fallisce

`UnauthorizedAccessException` — non gestita da `RugbyRadioExceptionFilter` come `RugbyRadioValidationException`; gestita come eccezione generica → `BadRequest 400` con stack trace visibile.

---

## Endpoint sensibili

---

## POST /v1/auth/users — Registrazione

### File sorgente

- `src/RugbyRadio/Api/Controllers/AuthV1Controller.cs`

### Perché sensibile

- creazione account utente
- password ricevuta in chiaro nel body

### Protezione visibile

Nessuna (nessun `[Authorize]`, nessun rate limiting visibile nel codice)

---

## POST /v1/auth/user/login — Login

### File sorgente

- `src/RugbyRadio/Api/Controllers/AuthV1Controller.cs`

### Perché sensibile

- autenticazione/token
- credenziali ricevute nel body

### Protezione visibile

Nessuna (nessun rate limiting visibile)

---

## POST /v1/auth/users/google — Login Google

### File sorgente

- `src/RugbyRadio/Api/Controllers/AuthV1Controller.cs`

### Perché sensibile

- autenticazione/token via OAuth
- token Google validato tramite `GoogleJsonWebSignature.ValidateAsync`

### Protezione visibile

Validazione token Google tramite libreria ufficiale; `ClientId` referenziato da `ProvidersSettings`

---

## POST /v1/auth/users/forgot — Forgot Password

### File sorgente

- `src/RugbyRadio/Api/Controllers/AuthV1Controller.cs`

### Perché sensibile

- flusso di reset credenziali
- genera e invia OTP via email

### Protezione visibile

Nessuna (nessun rate limiting visibile)

---

## POST /v1/auth/users/password — Change Password

### File sorgente

- `src/RugbyRadio/Api/Controllers/AuthV1Controller.cs`

### Perché sensibile

- modifica credenziali utente
- nuova password ricevuta in chiaro nel body

### Protezione visibile

Verifica OTP (scadenza 1 ora, flag `IsUsed`); OTP numerico a 6 cifre

---

## DELETE /v1/user — Cancellazione account

### File sorgente

- `src/RugbyRadio/Api/Controllers/UserV1Controller.cs`

### Perché sensibile

- operazione distruttiva su dati personali (pseudonimizzazione)

### Protezione visibile

`[Authorize]` + `GetCurrentUserId()`: solo l'utente autenticato può cancellare se stesso

---

## GET /v1/admin/messages/draft e /statistics — Endpoint Admin

### File sorgente

- `src/RugbyRadio/Api/Controllers/AdminV1Controller.cs`

### Perché sensibile

- operazione admin (lettura/modifica messaggi di sistema)
- DELETE su messaggi, PUT per approvazione

### Protezione visibile

Chiave API hardcoded come `const string` nel controller, passata come query parameter in chiaro; nessun meccanismo ASP.NET Core standard

---

## POST /v1/matches/{matchId}/notification — Invio notifiche

### File sorgente

- `src/RugbyRadio/Api/Controllers/MatchesV1Controller.cs`

### Perché sensibile

- attiva invio notifiche push a utenti che seguono la partita
- integrazione esterna

### Protezione visibile

`[Authorize]` — ma non verifica ownership tramite `VerifyAuthAsync`; qualsiasi utente autenticato può chiamarlo

---

## GET /v1/voices — Generazione audio TTS

### File sorgente

- `src/RugbyRadio/Api/Controllers/VoicesV1Controller.cs`

### Perché sensibile

- integrazione esterna (Google Text-to-Speech deducibile da `google-text-to-speech.json`)
- nessun controllo accesso visibile

### Protezione visibile

Nessuna (nessun `[Authorize]` né `[AllowAnonymous]`)

---

## Note finali

- Limiti dell'analisi: la modalità di salvataggio delle password non è deducibile dal solo `UserService` (non è visibile hashing nel codice letto — possibile che avvenga nel repository o tramite EF Core); il codice dei test non è stato analizzato; il progetto `HF` non è stato analizzato in dettaglio.
- Elementi esclusi: repository e entity non direttamente collegati ad auth/security; `HF/Program.cs` (usa `SecuritySettings` ma ruolo non analizzato); frontend.
- Elementi non deducibili: hashing password (non visibile nel service); rate limiting (non presente nel codice analizzato); refresh token (non presente nel codice analizzato — token JWT a scadenza lunga senza refresh); revoca token (non presente nel codice analizzato — token non persistiti).
- Header identificati: `X-USER-LANGUAGE`, `X-COMMENTARY-LANGUAGE` (letti da `HeaderHelper`; non legati alla sicurezza).
- Cookie identificato: `Authentication` — usato in alternativa all'header `Authorization` per il trasporto del JWT (letto in `OnMessageReceived` di `JwtBearerEvents`).
- Segreti sensibili rilevati nel codice sorgente: `appsettings.json` contiene `Security:SecretKey` (chiave JWT), `Smtp:Password` (credenziali SMTP), `ConnectionStrings:App` (credenziali DB) — tutti in chiaro. Non riportati i valori.
- Wiki non modificata: confermato.
