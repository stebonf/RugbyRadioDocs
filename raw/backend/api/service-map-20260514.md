# Backend Service Map RAW

## Sintesi

- Data analisi: 2026-05-14
- Project: api
- Root backend analizzata: `src/RugbyRadio/Lib/`
- File output: `llm-wiki/raw/backend/api/service-map-20260514.md`
- Servizi trovati: 14
- Metodi pubblici significativi trovati: 97

---

## Servizi

---

## UserService

### Nome wiki suggerito

`UserService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/UserBox/UserService.cs`
- `src/RugbyRadio/Lib/Repositories/UserBox/IUserService.cs`

### Tipo

Service

### Interfaccia

- `IUserService`

### Responsabilità tecnica

Gestisce il ciclo di vita completo dell'utente: registrazione (email/password e Google OAuth), attivazione account via token, login e generazione token JWT, reset password via OTP, aggiornamento profilo e timezone, salvataggio token notifiche push, cancellazione account con pseudonimizzazione.

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

### Consumer deducibili

- `AuthV1Controller` — login, registrazione, attivazione, OTP
- `UserV1Controller` — profilo, aggiornamento, cancellazione
- `MatchesV1Controller` — timezone
- `CreateTrainingChannelJob` — recupero utenti
- `FakeAgent` (base) — accesso utenti

### Metodi pubblici significativi

#### RegisterNewUserAsync(nickname, email, password, language)

- Input: `nickname` (`string`), `email` (`string`), `password` (`string`), `language` (`string`)
- Output: `Task<User>`
- Dipendenze chiamate: `_userRepository.GetByEmailAsync`, `_userRepository.InsertAsync`, `_unitOfWork.SaveChangesAsync`
- Entità coinvolte: Scrittura: `User`
- Condizioni rilevanti: se email già esistente → lancia `EmailAlreadyExists`; nickname troncato a 20 caratteri; `IsActive = true`, `IsVerified = false`; `ActivationToken = Guid.NewGuid()`
- Side effects: scrittura database
- Errori / casi limite: `EmailAlreadyExists` se email già registrata
- Note di confidenza: Verificato dal codice

#### VerifyUserAsync(token)

- Input: `token` (`string`)
- Output: `Task<User>`
- Dipendenze chiamate: `_userRepository.GetByTokenAsync`, `_userRepository.UpdateAsync`, `_unitOfWork.SaveChangesAsync`
- Entità coinvolte: Lettura/Scrittura: `User`
- Condizioni rilevanti: se utente non trovato o già verificato → lancia `NotAllowed`; imposta `IsVerified = true`
- Side effects: scrittura database
- Errori / casi limite: `NotAllowed` se token non valido
- Note di confidenza: Verificato dal codice

#### GetUserTokenAsync(email, password)

- Input: `email` (`string?`), `password` (`string?`)
- Output: `Task<UserTokenDto>`
- Dipendenze chiamate: `_userRepository.GetByLoginAsync`
- Entità coinvolte: Lettura: `User`
- DTO / Request / Response: `UserTokenDto` con `Id`, `Nickname`, `Language`, `Token` JWT
- Condizioni rilevanti: se email o password vuoti → `InvalidModel`; se utente non trovato → `InvalidCredentials`; token JWT firmato HMAC-SHA256 con scadenza da config
- Side effects: nessuno (token generato in memoria)
- Errori / casi limite: `InvalidModel`, `InvalidCredentials`
- Note di confidenza: Verificato dal codice

#### GetUserTokenAsync(email)

- Input: `email` (`string?`)
- Output: `Task<UserTokenDto>`
- Dipendenze chiamate: `_userRepository.GetByEmailAsync`
- Condizioni rilevanti: variante per login OAuth (senza password)
- Side effects: nessuno
- Note di confidenza: Verificato dal codice

#### GetAvatars()

- Input: nessuno
- Output: `IDictionary<long, string>` — mappa 1..58 → path immagine avatar
- Side effects: nessuno
- Note di confidenza: Verificato dal codice

#### GetProfileAsync(id)

- Input: `id` (`string?`)
- Output: `Task<UserProfileDto>`
- Dipendenze chiamate: `_userRepository.GetByIdAsync`, `_subscriptionRepository.FindChannelSubIncludeByUserIdAsync`, `_channelRepository.CountByUserAsync`
- Entità coinvolte: Lettura: `User`, `Subscription`, conteggio canali
- DTO / Request / Response: `UserProfileDto`
- Side effects: nessuno
- Note di confidenza: Verificato dal codice

#### UpdateAsync(id, model)

- Input: `id` (`string?`), `model` (`UserUpdateDto`)
- Output: `Task`
- Dipendenze chiamate: `_userRepository.UpdateAsync`, `_unitOfWork.SaveChangesAsync`
- Entità coinvolte: Lettura/Scrittura: `User`
- DTO / Request / Response: `UserUpdateDto`
- Condizioni rilevanti: aggiorna solo campi non vuoti nel model
- Side effects: scrittura database
- Note di confidenza: Verificato dal codice

#### UpdateTimezoneAsync(userId, timezone) / AddTimezoneAsync(userId, timezone)

- Input: `userId` (`string`), `timezone` (`string?`)
- Output: `Task`
- Side effects: scrittura database (`User.Timezone`)
- Condizioni rilevanti: `AddTimezoneAsync` skippas se timezone già presente
- Note di confidenza: Verificato dal codice

#### RegisterNewGoogleUserAsync(language, token)

- Input: `language` (`string`), `token` (`string`) — Google ID Token
- Output: `Task<User>`
- Dipendenze chiamate: `GoogleJsonWebSignature.ValidateAsync`, `_userRepository.GetByEmailAsync`, `_userRepository.InsertAsync`, `_unitOfWork.SaveChangesAsync`
- Entità coinvolte: Lettura/Scrittura: `User`
- Condizioni rilevanti: se token non valido → `NotAuthorized`; se utente già esistente → ritorna utente esistente; `Password = "Google"`, `Provider = "Google"`
- Side effects: scrittura database (solo per nuovi utenti)
- Errori / casi limite: `NotAuthorized` se payload Google null
- Note di confidenza: Verificato dal codice

#### SaveNotificationToken(userId, token)

- Input: `userId` (`string`), `token` (`string?`)
- Output: `Task`
- Side effects: scrittura database (`UserToken`)
- Condizioni rilevanti: skip se token già presente in DB
- Note di confidenza: Verificato dal codice

#### ForgotPassword(email)

- Input: `email` (`string`)
- Output: `Task`
- Dipendenze chiamate: `_userRepository.GetByEmailAsync`, `_userOtpCodeRepository.InsertAsync`, `_unitOfWork.SaveChangesAsync`, `_emailService.SendOptCode`
- Entità coinvolte: Lettura: `User`; Scrittura: `UserOtpCode`
- Condizioni rilevanti: se utente non trovato → `InvalidEmail`; OTP = `Random().Next(100000, 999999)`, scadenza 1 ora
- Side effects: scrittura database; invio email OTP
- Errori / casi limite: `InvalidEmail`
- Note di confidenza: Verificato dal codice

#### ChangePassword(otpCode, newPassword)

- Input: `otpCode` (`string`), `newPassword` (`string`)
- Output: `Task<UserTokenDto>`
- Dipendenze chiamate: `_userOtpCodeRepository.GetByOtpCode`, `_userOtpCodeRepository.UpdateAsync`, `_userRepository.UpdateAsync`, `_unitOfWork.SaveChangesAsync`, `GetUserTokenAsync`
- Entità coinvolte: Lettura/Scrittura: `UserOtpCode`, `User`
- Condizioni rilevanti: verifica OTP non scaduto e non già usato; imposta `IsUsed = true`; aggiorna password; genera nuovo token
- Side effects: scrittura database
- Errori / casi limite: `NotFound` se OTP non valido/scaduto/già usato
- Note di confidenza: Verificato dal codice

#### DeleteUser(userId)

- Input: `userId` (`string`)
- Output: `Task`
- Dipendenze chiamate: `_userRepository.UpdateAsync`, `_unitOfWork.SaveChangesAsync`
- Entità coinvolte: Scrittura: `User`
- Condizioni rilevanti: pseudonimizzazione: email → `{id}@deleted.rrl`, nickname randomizzato, `IsActive = false`, `Provider = null`
- Side effects: scrittura database (pseudonimizzazione)
- Note di confidenza: Verificato dal codice

---

## ChannelService

### Nome wiki suggerito

`ChannelService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/ChannelBox/ChannelService.cs`
- `src/RugbyRadio/Lib/Repositories/ChannelBox/IChannelService.cs`

### Tipo

Service

### Interfaccia

- `IChannelService`

### Responsabilità tecnica

Gestisce il ciclo di vita dei canali: creazione, aggiornamento, ricerca pubblica, gestione co-owner, gestione iscrizioni, composizione DTO pubblici con classifica, statistiche e tabella squadre.

### Dipendenze iniettate

- `IUnitOfWork`
- `IChannelRepository`
- `IMatchRepository`
- `ISubscriptionRepository`
- `IMatchLikeRepository`
- `IChannelUserRepository`
- `IUserRepository`
- `ITeamRepository`

### Consumer deducibili

- `ChannelsV1Controller`
- `ChannelUsersV1Controller`
- `MatchesV1Controller`
- `RugbyRadioLiveService`

### Metodi pubblici significativi

#### CreateChannelAsync(userId, model)

- Input: `userId` (`string`), `model` (`ChannelAddDto`)
- Output: `Task<Channel>`
- Dipendenze chiamate: `_channelRepository.GetByPublicIdIncludeAsync`, `_channelRepository.InsertAsync`, `_unitOfWork.SaveChangesAsync`
- Entità coinvolte: Scrittura: `Channel`
- DTO / Request / Response: `ChannelAddDto`
- Condizioni rilevanti: genera `PublicId` univoco (8 char da GUID) con retry fino alla collisione; assegna immagine WebP dalla pool `ChannelImageNewUrl` se disponibile
- Side effects: scrittura database; eventuale spostamento file immagine su filesystem
- Note di confidenza: Verificato dal codice

#### GetOrCreateChannelAsync(userId, model)

- Input: `userId` (`string`), `model` (`MatchQuickItemAddDto`)
- Output: `Task<Channel>`
- Dipendenze chiamate: `_channelRepository.GetByIdAsync`, `CreateChannelAsync`
- Condizioni rilevanti: se `model.Id` valorizzato → recupera canale esistente verificando ownership; altrimenti crea nuovo canale
- Errori / casi limite: `NotAuthorized` se canale non appartiene all'utente
- Note di confidenza: Verificato dal codice

#### GetPublicChannelAsync(publicId, userId)

- Input: `publicId` (`string`), `userId` (`string?`)
- Output: `Task<ChannelPublicDto>`
- Dipendenze chiamate: `_channelRepository.GetByPublicIdIncludeAsync`, `_subscriptionRepository.GetChannelSubAsync`, `_matchLikeRepository.GetChannelLikesCountAsync`, `_matchRepository.CountByChannelAsync`, `_matchRepository.FindByChannelByIdIncludeAsync`, `_teamRepository.FindByChannelAsync`
- DTO / Request / Response: `ChannelPublicDto` con owner, statistiche like, follow, squadre con conteggio partite, tabella classifica, data ultima/prossima partita
- Condizioni rilevanti: calcola tabella classifiche (played, won, drawn, lost, pointsFor, pointsAgainst) per ogni squadra escludendo partite `Scheduled`
- Errori / casi limite: `NotFound` se canale non trovato
- Note di confidenza: Verificato dal codice

#### FindChannelsAsync(userId)

- Input: `userId` (`string`)
- Output: `Task<IList<Channel>>`
- Dipendenze chiamate: `_channelRepository.FindByUserAsync`
- Condizioni rilevanti: include co-owner
- Note di confidenza: Verificato dal codice

#### FindChannelsAsync(model)

- Input: `model` (`ChannelSearchDto`)
- Output: `Task<PageDto<ChannelPublicDto>>`
- Dipendenze chiamate: `_channelRepository.FindByFilterAsync`
- Side effects: nessuno
- Note di confidenza: Verificato dal codice

#### GetChannelByIdAsync(channelId)

- Input: `channelId` (`string`)
- Output: `Task<ChannelDto?>`
- Dipendenze chiamate: `_channelRepository.GetByIdAsync`, `_matchRepository.CountByChannelAsync`
- DTO / Request / Response: `ChannelDto`
- Note di confidenza: Verificato dal codice

#### VerifyAuthAsync(userId, channelId)

- Input: `userId` (`string`), `channelId` (`string`)
- Output: `Task`
- Dipendenze chiamate: `_channelRepository.GetByIdAsync`
- Condizioni rilevanti: verifica che `channel.UserId == userId` o che `channel.Owners` contenga `userId`; altrimenti `NotAuthorized`
- Errori / casi limite: `NotAuthorized`
- Note di confidenza: Verificato dal codice

#### UpdateChannelAsync(channelId, model) / UpdateChannelLayoutAsync(channelId, model)

- Input: `channelId` (`string`), `model` (`ChannelUpdateDto` | `ChannelLayoutUpdateDto`)
- Output: `Task<Channel>`
- Side effects: scrittura database
- Note di confidenza: Verificato dal codice

#### ManageSubscription(publicId, userId)

- Input: `publicId` (`string`), `userId` (`string`)
- Output: `Task`
- Dipendenze chiamate: `_channelRepository.GetByPublicIdAsync`, `_subscriptionRepository.GetChannelSubAsync`, `_subscriptionRepository.InsertAsync` | `DeleteAsync`, `_unitOfWork.SaveChangesAsync`
- Condizioni rilevanti: toggle — se non iscritto crea `Subscription`; se già iscritto elimina
- Side effects: scrittura database
- Errori / casi limite: `NotFound` se canale non trovato
- Note di confidenza: Verificato dal codice

#### FindFavorites(userId)

- Input: `userId` (`string`)
- Output: `Task<IList<Channel>?>`
- Dipendenze chiamate: `_subscriptionRepository.FindChannelSubIncludeByUserIdAsync`
- Note di confidenza: Verificato dal codice

#### FindUsersAsync(channelId)

- Input: `channelId` (`string`)
- Output: `Task<IList<ChannelUserDto>>`
- Dipendenze chiamate: `_channelUserRepository.FindUsersAsync`
- Note di confidenza: Verificato dal codice

#### AddUserAsync(channelId, email)

- Input: `channelId` (`string`), `email` (`string`)
- Output: `Task<ChannelUserDto>`
- Dipendenze chiamate: `_userRepository.GetByEmailAsync`, `_channelUserRepository.InsertAsync`, `_unitOfWork.SaveChangesAsync`, `_channelUserRepository.GetUserAsync`
- Condizioni rilevanti: se utente non trovato per email → `InvalidEmail`
- Side effects: scrittura database
- Note di confidenza: Verificato dal codice

#### DeleteUserAsync(channelId, userId)

- Input: `channelId` (`string`), `userId` (`string`)
- Output: `Task`
- Side effects: scrittura database (cancellazione `ChannelUser`)
- Note di confidenza: Verificato dal codice

---

## MatchService

### Nome wiki suggerito

`MatchService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/MatchBox/MatchService.cs`
- `src/RugbyRadio/Lib/Repositories/MatchBox/IMatchService.cs`

### Tipo

Service

### Interfaccia

- `IMatchService`

### Responsabilità tecnica

Servizio centrale della piattaforma. Gestisce l'intero ciclo di vita delle partite: creazione, aggiornamento, stato, eventi, formazioni, reazioni, commenti, like, votazioni, notifiche push Firebase, follow/unfollow, ricerca pubblica, calcolo tabellini e compositing immagini con overlay visuale.

### Dipendenze iniettate

- `IUnitOfWork`
- `IMatchRepository`
- `IMatchEventRepository`
- `ILineupPlayerRepository`
- `ILineupPlayerRateRepository`
- `IChannelRepository`
- `ITeamRepository`
- `IPlayerRepository`
- `ICommentRepository`
- `IEventReactionRepository`
- `IMatchLikeRepository`
- `ISubscriptionRepository`
- `IUserTokenRepository`
- `ISystemMessageRepository`

### Consumer deducibili

- `MatchesV1Controller`
- `MatchEventsV1Controllers`
- `MatchLineupsV1Controller`
- `RugbyRadioLiveService`
- `CreateMatchBlogJob`
- `CreateMatchBlogHtmlJob`
- `FakeAgent`

### Metodi pubblici significativi

#### VerifyAuthAsync(userId, channelId?, matchId?, teamId?, lineupPlayerId?, playerId?)

- Input: `userId` (`string`), parametri opzionali per ogni livello gerarchico
- Output: `Task`
- Condizioni rilevanti: verifica gerarchica canale → partita → squadra → formazione → giocatore; partita archiviata → `NotAuthorized`; usa `channel.IsOwner(userId)` per owner + co-owner
- Errori / casi limite: `NotAuthorized` a ogni livello
- Note di confidenza: Verificato dal codice

#### GetMatchAsync(matchId, language, userId)

- Input: `matchId` (`string`), `language` (`string`), `userId` (`string?`)
- Output: `Task<MatchDto>`
- Dipendenze chiamate: `_matchRepository.GetByIdIncludeAsync`, `_systemMessageRepository.FindByLanguageAsync`, `_lineupPlayerRateRepository.*`, `_eventReactionRepository.*`, `_matchLikeRepository.*`
- DTO / Request / Response: `MatchDto` — DTO ricco con eventi, formazioni, commenti, reazioni, like, voti giocatori, messaggi telecronaca localizzati
- Note di confidenza: Parzialmente dedotto (metodo molto lungo)

#### AddMatchAsync(channelId, model)

- Input: `channelId` (`string`), `model` (`MatchAddDto`)
- Output: `Task<Match>`
- Dipendenze chiamate: `_matchRepository.InsertAsync`, `_unitOfWork.SaveChangesAsync`
- Entità coinvolte: Scrittura: `Match`
- DTO / Request / Response: `MatchAddDto`
- Condizioni rilevanti: stato iniziale `Scheduled`, minuto `1`, `HalfMinutes = 40`, score `0`
- Side effects: scrittura database
- Note di confidenza: Verificato dal codice

#### AddEventAsync(matchId, userId, model)

- Input: `matchId` (`string`), `userId` (`string`), `model` (`MatchEventAddDto`)
- Output: `Task<MatchEvent>`
- Dipendenze chiamate: `_matchRepository.GetByIdAsync`, `_matchEventRepository.InsertAsync`, `_matchRepository.UpdateAsync`, `_unitOfWork.SaveChangesAsync`; per `FullTime` → `FinalizeMatchImageAsync`
- Entità coinvolte: Lettura/Scrittura: `Match`, `MatchEvent`
- Condizioni rilevanti: `Kickoff` → stato `InProgress`; `FullTime` → stato `FullTime` + finalizzazione immagine; aggiorna `Match.Minute`, `HomeScore`/`AwayScore`, possesso, zone in base al tipo evento
- Side effects: scrittura database; compositing immagine su filesystem per `FullTime`
- Note di confidenza: Verificato dal codice

#### UpdateMatchStatsAsync(matchId, userId, model)

- Input: `matchId` (`string`), `userId` (`string`), `model` (`MatchStatsUpdateDto`)
- Output: `Task`
- Side effects: scrittura database
- Note di confidenza: Parzialmente dedotto

#### AddReactionAsync(eventId, userId, reactionType)

- Input: `eventId` (`string`), `userId` (`string?`), `reactionType` (`string?`)
- Output: `Task`
- Dipendenze chiamate: `_eventReactionRepository.InsertAsync`, `_unitOfWork.SaveChangesAsync`
- Entità coinvolte: Scrittura: `EventReaction`
- Side effects: scrittura database
- Note di confidenza: Verificato dal codice

#### AddCommentAsync(matchId, eventId, userId, message)

- Input: `matchId` (`string`), `eventId` (`string`), `userId` (`string`), `message` (`string?`)
- Output: `Task`
- Entità coinvolte: Scrittura: `Comment`
- Side effects: scrittura database
- Note di confidenza: Verificato dal codice

#### DeleteCommentAsync(commentId)

- Input: `commentId` (`string`)
- Output: `Task`
- Condizioni rilevanti: soft-delete (`IsDeleted = true`)
- Side effects: scrittura database
- Note di confidenza: Verificato dal codice

#### UpdateMatchStatusAsync(matchId, status)

- Input: `matchId` (`string`), `status` (`MatchStatus`)
- Output: `Task`
- Entità coinvolte: Scrittura: `Match.Status`
- Errori / casi limite: `NotFound` se partita non trovata
- Side effects: scrittura database
- Note di confidenza: Verificato dal codice

#### UpdateMatchAsync(channelId, matchId, model)

- Input: `channelId` (`string`), `matchId` (`string`), `model` (`MatchAddDto`)
- Output: `Task`
- Side effects: scrittura database
- Note di confidenza: Parzialmente dedotto

#### FindMatchesByChannelAsync(channelId, language)

- Input: `channelId` (`string`), `language` (`string`)
- Output: `Task<IList<MatchChannelDto>>`
- Dipendenze chiamate: `_matchRepository.FindByChannelByIdIncludeAsync`, `_systemMessageRepository.FindByLanguageAsync`
- Note di confidenza: Verificato dal codice

#### FindPublicMatchesAsync(channelId, model, language) / FindPublicMatchesAsync(model, language) / FindTeamMatchesAsync(teamId, model, language)

- Output: `Task<PageDto<MatchMinDto>>`
- Side effects: nessuno
- Note di confidenza: Verificato dal codice

#### SavePlayerRate(userId, matchId, lineupPlayerId)

- Input: `userId` (`string`), `matchId` (`string`), `lineupPlayerId` (`string`)
- Output: `Task`
- Dipendenze chiamate: `_lineupPlayerRateRepository.FindByMatchIdIncludeAsync`, `_lineupPlayerRateRepository.DeleteAsync` | `InsertAsync`, `_unitOfWork.SaveChangesAsync`
- Condizioni rilevanti: toggle voto; se già votato → rimuove; se non votato ma già 3 voti totali → early return; max 3 voti per utente per partita
- Side effects: scrittura database
- Note di confidenza: Verificato dal codice

#### AddLikeAsync(matchId, userId)

- Input: `matchId` (`string`), `userId` (`string`)
- Output: `Task`
- Entità coinvolte: Scrittura: `MatchLike`
- Side effects: scrittura database
- Note di confidenza: Verificato dal codice

#### AddPlayerRoleAsync(lineupId, model)

- Input: `lineupId` (`string`), `model` (`LineupPlayerAddDto`)
- Output: `Task`
- Dipendenze chiamate: `_lineupPlayerRepository.GetByIdAsync`, `_playerRepository.InsertAsync`, `_lineupPlayerRepository.UpdateAsync`, `_unitOfWork.SaveChangesAsync`
- Condizioni rilevanti: crea nuovo `Player` e lo assegna alla formazione; avatar da numero maglia
- Entità coinvolte: Scrittura: `Player`, `LineupPlayer`
- Errori / casi limite: `NotFound` se lineup non trovata
- Note di confidenza: Verificato dal codice

#### UpdatePlayerRoleAsync(lineupPlayerId, playerId)

- Input: `lineupPlayerId` (`string`), `playerId` (`string`)
- Output: `Task`
- Side effects: scrittura database (`LineupPlayer.PlayerId`)
- Errori / casi limite: `NotFound` se lineup non trovata
- Note di confidenza: Verificato dal codice

#### RemovePlayerRoleAsync(lineupId)

- Input: `lineupId` (`string`)
- Output: `Task`
- Condizioni rilevanti: imposta `PlayerId = null` sulla formazione
- Side effects: scrittura database
- Note di confidenza: Parzialmente dedotto

#### FindMatchOnGoingAsync(userId, language)

- Input: `userId` (`string`), `language` (`string`)
- Output: `Task<IList<MatchMinDto>>`
- Dipendenze chiamate: `_matchRepository.FindOnGoingIncludeByUserIdAsync`
- Note di confidenza: Verificato dal codice

#### SendNotifications(matchId)

- Input: `matchId` (`string`)
- Output: `Task<bool>`
- Dipendenze chiamate: `_subscriptionRepository.FindMatchSubIncludeByMatchIdAsync`, `_systemMessageRepository.FindByLanguageAsync`, `_matchEventRepository.GetLastEventAsync`, `FirebaseMessaging.DefaultInstance.SendAsync`, `_userTokenRepository.DeleteAsync`, `_unitOfWork.SaveChangesAsync`
- Entità coinvolte: Lettura: `Subscription`, `User`, `UserToken`, `MatchEvent`, `SystemMessage`; Scrittura: eliminazione `UserToken` invalidi
- Condizioni rilevanti: per ogni subscriber recupera l'ultimo evento e il messaggio localizzato nella lingua dell'utente; costruisce payload `WebpushConfig` con azione `open-match`
- Side effects: invio notifiche push Firebase FCM; eliminazione token non validi dal DB
- Errori / casi limite: `FirebaseMessagingException` con `InvalidArgument` → elimina token; altri errori ignorati
- Note di confidenza: Verificato dal codice

#### FollowAsync(matchId, userId)

- Input: `matchId` (`string`), `userId` (`string`)
- Output: `Task<bool>`
- Dipendenze chiamate: `_subscriptionRepository.GetMatchSubAsync`, `_subscriptionRepository.DeleteAsync` | `InsertAsync`, `_unitOfWork.SaveChangesAsync`
- Condizioni rilevanti: toggle iscrizione partita
- Side effects: scrittura database
- Note di confidenza: Parzialmente dedotto

#### DeleteEventAsync(matchId, eventId)

- Input: `matchId` (`string`), `eventId` (`string`)
- Output: `Task`
- Side effects: scrittura database (cancellazione evento + eventuale ricalcolo punteggio)
- Note di confidenza: Parzialmente dedotto

#### GetScoreboardAsync(matchId) / GetScoreboardAsync(match)

- Input: `matchId` (`string`) | `match` (`Match`)
- Output: `Task<MatchScoreboard>`
- Dipendenze chiamate: `_matchRepository.GetByIdIncludeAsync`
- DTO / Request / Response: `MatchScoreboard`
- Note di confidenza: Parzialmente dedotto

#### AddMatchImageAsync(match)

- Input: `match` (`Match`)
- Output: `Task<Match>`
- Condizioni rilevanti: prende prima immagine dalla pool `MatchImageNewUrl`, la sposta in `MatchImageUrl` con nome = `match.Id`
- Side effects: spostamento file su filesystem; scrittura database (`Match.ImageUrl`)
- Note di confidenza: Verificato dal codice

#### GetTrainingMatchAsync(userId)

- Input: `userId` (`string`)
- Output: `Task<Match?>`
- Dipendenze chiamate: `_matchRepository.FindTrainingByUserIdAsync`
- Note di confidenza: Parzialmente dedotto

---

## TeamService

### Nome wiki suggerito

`TeamService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/TeamBox/TeamService.cs`
- `src/RugbyRadio/Lib/Repositories/TeamBox/ITeamService.cs`

### Tipo

Service

### Interfaccia

- `ITeamService`

### Responsabilità tecnica

Gestisce il ciclo di vita delle squadre: creazione, aggiornamento, ricerca per canale, verifica ownership, recupero loghi disponibili.

### Dipendenze iniettate

- `IUnitOfWork`
- `ITeamRepository`
- `IChannelRepository`

### Consumer deducibili

- `TeamsV1Controller`
- `MatchLineupsV1Controller`
- `RugbyRadioLiveService`
- `FakeAgent`

### Metodi pubblici significativi

#### VerifyAuthAsync(userId, channelId, teamId?)

- Input: `userId` (`string`), `channelId` (`string`), `teamId` (`string?`)
- Output: `Task`
- Condizioni rilevanti: carica canale; se `teamId` fornito verifica `team.ChannelId == channelId` e `channel.IsOwner(userId)`, altrimenti solo `IsOwner`
- Errori / casi limite: `NotFound` se canale non trovato; `NotAuthorized` se non owner
- Note di confidenza: Verificato dal codice

#### CreateTeamAsync(channelId, model)

- Input: `channelId` (`string`), `model` (`TeamAddDto`)
- Output: `Task<Team>`
- Entità coinvolte: Scrittura: `Team`
- DTO / Request / Response: `TeamAddDto`
- Side effects: scrittura database
- Note di confidenza: Verificato dal codice

#### GetChannelTeamsAsync(channelId)

- Input: `channelId` (`string`)
- Output: `Task<IList<TeamChannelDto>>`
- DTO / Request / Response: `TeamChannelDto`
- Side effects: nessuno
- Note di confidenza: Parzialmente dedotto

#### GetLogos()

- Input: nessuno
- Output: `IDictionary<long, string>` — mappa logo disponibili
- Side effects: nessuno
- Note di confidenza: Verificato dal codice

#### UpdateTeamAsync(teamId, model)

- Input: `teamId` (`string`), `model` (`TeamUpdateDto`)
- Output: `Task<Team>`
- Side effects: scrittura database
- Note di confidenza: Parzialmente dedotto

#### FindUserTeamsAsync(userId)

- Input: `userId` (`string`)
- Output: `Task<IList<Team>>`
- Side effects: nessuno
- Note di confidenza: Parzialmente dedotto

#### GetOrCreateTeamAsync(channelId, model)

- Input: `channelId` (`string`), `model` (`MatchQuickItemAddDto`)
- Output: `Task<Team>`
- Condizioni rilevanti: se `model.Id` valorizzato → recupera squadra esistente; altrimenti crea nuova
- Side effects: scrittura database (solo se creazione)
- Note di confidenza: Parzialmente dedotto

#### GetTeamAsync(teamId)

- Input: `teamId` (`string`)
- Output: `Task<TeamPublicDto?>`
- DTO / Request / Response: `TeamPublicDto`
- Side effects: nessuno
- Note di confidenza: Parzialmente dedotto

---

## PlayerService

### Nome wiki suggerito

`PlayerService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/PlayerBox/PlayerService.cs`
- `src/RugbyRadio/Lib/Repositories/PlayerBox/IPlayerService.cs`

### Tipo

Service

### Interfaccia

- `IPlayerService`

### Responsabilità tecnica

Gestisce il ciclo di vita dei giocatori: verifica ownership (solo owner primario), creazione, aggiornamento, eliminazione, ricerca per squadra.

### Dipendenze iniettate

- `IUnitOfWork`
- `IPlayerRepository`
- `ITeamRepository`
- `IChannelRepository`

### Consumer deducibili

- `PlayersV1Controller`
- `FakeAgent`

### Metodi pubblici significativi

#### VerifyAuthAsync(userId, channelId, teamId, playerId?)

- Input: `userId` (`string`), `channelId` (`string`), `teamId` (`string`), `playerId` (`string?`)
- Output: `Task`
- Condizioni rilevanti: verifica `channel.UserId == userId` (solo owner primario, **non** co-owner); verifica `team.ChannelId == channelId`; se `playerId` fornito verifica `player.TeamId == teamId`
- Errori / casi limite: `NotAuthorized`
- Note di confidenza: Verificato dal codice

#### CreatePlayerAsync(teamId, model)

- Input: `teamId` (`string`), `model` (`PlayerSaveDto`)
- Output: `Task<Player>`
- Entità coinvolte: Scrittura: `Player`
- DTO / Request / Response: `PlayerSaveDto`
- Condizioni rilevanti: avatar = `/images/avatars/players/{defaultNumber}.png` se non fornito
- Side effects: scrittura database
- Note di confidenza: Verificato dal codice

#### UpdatePlayerAsync(teamId, playerId, model)

- Input: `teamId` (`string`), `playerId` (`string`), `model` (`PlayerSaveDto`)
- Output: `Task<Player>`
- Side effects: scrittura database
- Note di confidenza: Parzialmente dedotto

#### DeletePlayerAsync(playerId)

- Input: `playerId` (`string`)
- Output: `Task`
- Side effects: scrittura database (cancellazione)
- Note di confidenza: Parzialmente dedotto

#### FindPlayersAsync(teamId)

- Input: `teamId` (`string`)
- Output: `Task<IList<Player>>`
- Side effects: nessuno
- Note di confidenza: Parzialmente dedotto

---

## LineupPlayerService

### Nome wiki suggerito

`LineupPlayerService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/LineupPlayerBox/LineupPlayerService.cs`
- `src/RugbyRadio/Lib/Repositories/LineupPlayerBox/ILineupPlayerService.cs`

### Tipo

Service

### Interfaccia

- `ILineupPlayerService`

### Responsabilità tecnica

Crea la formazione di default per una partita: genera 23 slot `LineupPlayer` (ruoli 1..23) assegnando i giocatori della squadra per numero di maglia di default.

### Dipendenze iniettate

- `IUnitOfWork`
- `ILineupPlayerRepository`
- `IPlayerRepository`

### Consumer deducibili

- `MatchesV1Controller`
- `RugbyRadioLiveService`

### Metodi pubblici significativi

#### CreateLineup(matchId, teamId)

- Input: `matchId` (`string`), `teamId` (`string`)
- Output: `Task<IList<LineupPlayer>>`
- Dipendenze chiamate: `_playerRepository.FindByTeamAsync`, `_lineupPlayerRepository.InsertRangeAsync`, `_unitOfWork.SaveChangesAsync`
- Entità coinvolte: Lettura: `Player`; Scrittura: `LineupPlayer` (23 record)
- Condizioni rilevanti: per i ruoli 1..23 cerca il giocatore con `DefaultNumber == i`; se non trovato → `PlayerId = null`
- Side effects: scrittura database (batch insert)
- Note di confidenza: Verificato dal codice

---

## BlogService

### Nome wiki suggerito

`BlogService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/BlogBox/BlogService.cs`
- `src/RugbyRadio/Lib/Repositories/BlogBox/IBlogService.cs`

### Tipo

Service

### Interfaccia

- `IBlogService`

### Responsabilità tecnica

Espone le query del blog verso i controller: lista paginata con dettaglio partita e squadre, post singolo per partita e lingua.

### Dipendenze iniettate

- `IBlogRepository`

### Consumer deducibili

- `BlogV1Controller`

### Metodi pubblici significativi

#### FindAsync(page, pageSize, language)

- Input: `page` (`int`), `pageSize` (`int`), `language` (`string`)
- Output: `Task<PageDto<BlogDto>>`
- Dipendenze chiamate: `_blogRepository.FindIncludeAsync`
- DTO / Request / Response: `PageDto<BlogDto>` con `BlogMatchDto`, `BlogTeamDto`
- Side effects: nessuno
- Note di confidenza: Verificato dal codice

#### GetByMatchIdAsync(matchId, language)

- Input: `matchId` (`string`), `language` (`string`)
- Output: `Task<BlogDto?>`
- Dipendenze chiamate: `_blogRepository.GetByMatchIdAsync`
- Condizioni rilevanti: ritorna `null` se blog non trovato
- Side effects: nessuno
- Note di confidenza: Verificato dal codice

---

## EmailService

### Nome wiki suggerito

`EmailService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/EmailBox/EmailService.cs`
- `src/RugbyRadio/Lib/Repositories/EmailBox/IEmailService.cs`

### Tipo

Service

### Interfaccia

- `IEmailService`

### Responsabilità tecnica

Invia email transazionali via SMTP Aruba (MailKit, SSL, porta 465). Gestisce OTP per reset password e email generiche. Persiste ogni invio in tabella `Email` con stato `Sent` o `Failed`.

### Dipendenze iniettate

- `IEmailRepository`
- `IUnitOfWork`
- `IOptions<SmtpSettings>`

### Consumer deducibili

- `UserService` — OTP reset password
- `UserV1Controller` — feedback utente
- `CreateMatchEventJob` — iniettato ma utilizzo non verificato nel body del job

### Metodi pubblici significativi

#### SendOptCode(userId, email, otpCode)

- Input: `userId` (`string`), `email` (`string`), `otpCode` (`string`)
- Output: `Task`
- Dipendenze chiamate: SMTP `SmtpClient.ConnectAsync`, `AuthenticateAsync`, `SendAsync`; `_emailRepository.InsertAsync`, `_unitOfWork.SaveChangesAsync`
- Condizioni rilevanti: corpo email fisso in inglese con codice OTP e scadenza 1 ora; mittente: `support@rugbyradiolive.com`
- Side effects: invio email SMTP; scrittura database `Email`
- Errori / casi limite: eccezione SMTP catturata → `Email.Status = Failed`; record salvato comunque
- Note di confidenza: Verificato dal codice

#### SendEmail(email, subject, body)

- Input: `email` (`string`), `subject` (`string`), `body` (`string`)
- Output: `Task`
- Side effects: invio email SMTP (nessuna persistenza DB in questo metodo)
- Errori / casi limite: eccezione SMTP non gestita → propagata al chiamante
- Note di confidenza: Verificato dal codice

---

## VoiceService

### Nome wiki suggerito

`VoiceService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Services/VoiceService.cs`
- `src/RugbyRadio/Lib/Services/Interfaces/IVoiceService.cs`

### Tipo

Service

### Interfaccia

- `IVoiceService`

### Responsabilità tecnica

Genera file audio MP3 via Azure Cognitive Services Text-to-Speech (SDK `Microsoft.CognitiveServices.Speech`). Supporta più lingue e stili vocali (personaggi: Arcaico, Influencer, Adolescente, Alieno, ExPlayer, Chef). File salvati su filesystem locale con cache: il file viene generato solo se non esiste già.

### Dipendenze iniettate

- `IMatchEventRepository`
- `ISystemMessageRepository`
- `IMatchService`

### Consumer deducibili

- `VoicesV1Controller`

### Metodi pubblici significativi

#### GetAudioAsync(language, sentence)

- Input: `language` (`string`), `sentence` (`string`)
- Output: `Task<string?>` — path file MP3
- Dipendenze chiamate: `SpeechSynthesizer.SpeakTextAsync` (Azure SDK)
- Condizioni rilevanti: se file già esiste → ritorna path direttamente; testo fisso per ogni `language` di tipo talker (Arcaico, Influencer, ecc.); se lingua non supportata → `null`
- Side effects: generazione e scrittura file MP3 su filesystem
- Errori / casi limite: ritorna `null` se lingua non supportata o sintesi fallisce
- Note di confidenza: Verificato dal codice

#### GetAudioEventAsync(language, eventId)

- Input: `language` (`string`), `eventId` (`string`)
- Output: `Task<string?>` — path file MP3
- Dipendenze chiamate: `_matchEventRepository.GetByIdAsync`, `_systemMessageRepository.GetByCodeAsync`, `_matchService.GetMatchAsync`, Azure TTS SDK
- Condizioni rilevanti: se file esiste → ritorna path; se `FlagPlayer` → usa testo arricchito con descrizione giocatore dall'evento
- Side effects: generazione e scrittura file MP3 su filesystem
- Errori / casi limite: ritorna `null` se evento/messaggio non trovato o sintesi fallisce
- Note di confidenza: Verificato dal codice

---

## FacebookService

### Nome wiki suggerito

`FacebookService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Services/FacebookService.cs`
- `src/RugbyRadio/Lib/Services/Interfaces/IFacebookService.cs`

### Tipo

Service

### Interfaccia

- `IFacebookService`

### Responsabilità tecnica

Client per la Facebook Graph API. Gestisce scambio e verifica token OAuth, recupero info utente, recupero pagine, pubblicazione post con immagine su pagina Facebook, revoca permessi.

### Dipendenze iniettate

- `IHttpClientService`
- `IOptions<MetaSettings>`

### Consumer deducibili

- `FacebookJob`

### Metodi pubblici significativi

#### GetAccessTokenAsync(shortLivedToken)

- Input: `shortLivedToken` (`string`)
- Output: `Task<FacebookTokenResponseDto?>`
- Dipendenze chiamate: `_httpClientService.DoGetAsync` — GET `{FbApiUrl}/oauth/access_token`
- DTO / Request / Response: `FacebookTokenResponseDto`
- Side effects: chiamata HTTP esterna
- Note di confidenza: Verificato dal codice

#### GetUserInfoAsync(accessToken)

- Input: `accessToken` (`string`)
- Output: `Task<FacebookUserResponseDto?>`
- Side effects: chiamata HTTP esterna
- Note di confidenza: Verificato dal codice

#### GetAccessTokenDetailsAsync(accessToken)

- Input: `accessToken` (`string`)
- Output: `Task<FacebookAccessTokenDetailsDto?>`
- Side effects: chiamata HTTP esterna
- Note di confidenza: Verificato dal codice

#### GetPagesAsync(accessToken)

- Input: `accessToken` (`string`)
- Output: `Task<FacebookAccountsResponseDto?>`
- Side effects: chiamata HTTP esterna
- Note di confidenza: Verificato dal codice

#### RevokePermissionsAsync(accessToken)

- Input: `accessToken` (`string`)
- Output: `Task<bool>`
- Dipendenze chiamate: `_httpClientService.DoDeleteAsync` — DELETE `{FbApiUrl}/me/permissions`
- Side effects: chiamata HTTP esterna (revoca permessi OAuth)
- Note di confidenza: Verificato dal codice

#### PostAsync(pageId, pageAccessToken, imageUrl, postMessage)

- Input: `pageId` (`string`), `pageAccessToken` (`string`), `imageUrl` (`string`), `postMessage` (`string`)
- Output: `Task`
- Dipendenze chiamate: `_httpClientService.DoPostFormEncodedAsync` — POST `{FbApiUrl}/{pageId}/photos` form-encoded
- DTO / Request / Response: `FacebookPostResponseDto`
- Side effects: pubblicazione post con immagine su pagina Facebook
- Note di confidenza: Verificato dal codice

#### ShouldRefreshToken(expiresAt)

- Input: `expiresAt` (`DateTime?`)
- Output: `bool`
- Condizioni rilevanti: `expiresAt <= DateTime.UtcNow.AddDays(threshold)`
- Side effects: nessuno
- Note di confidenza: Verificato dal codice

---

## AiOllamaService

### Nome wiki suggerito

`AiOllamaService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Services/AiOllamaService.cs`
- `src/RugbyRadio/Lib/Services/Interfaces/IAiOllamaService.cs`

### Tipo

Service

### Interfaccia

- `IAiOllamaService`

### Responsabilità tecnica

Client per istanza Ollama (LLM locale). Genera post blog per partite terminate in più lingue, leggendo configurazione da file JSON esterno (`Db/Ai-Talkers.json`). Costruisce tabellino testuale della partita come contesto per il modello.

### Dipendenze iniettate

- `IConfiguration`
- `IMatchService`
- `IMatchRepository`
- `IBlogRepository`
- `IUnitOfWork`

### Consumer deducibili

- `CreateMatchBlogJob` (HF) — non verificato nei controller API

### Metodi pubblici significativi

#### GetSettings()

- Input: nessuno
- Output: `Task<AiSettings>`
- Side effects: nessuno
- Note di confidenza: Verificato dal codice

#### CallAi(ollamaUri, systemPrompt, question, model, history?, embeddings?)

- Input: `ollamaUri` (`string`), `systemPrompt` (`string?`), `question` (`string`), `model` (`string`), `history` (`IList<string>?`), `embeddings` (`IList<string>?`)
- Output: `Task<string>` — risposta testuale del modello
- Dipendenze chiamate: `OllamaApiClient` (SDK OllamaSharp) — streaming risposta
- Condizioni rilevanti: temperature 0.8, TopP 0.7, seed random; embedding concatenati al system prompt
- Side effects: chiamata HTTP esterna a istanza Ollama
- Errori / casi limite: ritorna stringa vuota se `question` vuota
- Note di confidenza: Verificato dal codice

#### CreateBlogPosts()

- Input: nessuno
- Output: `Task`
- Dipendenze chiamate: `_matchRepository.FindByFilterIncludeAsync`, `_blogRepository.GetByMatchIdAsync`, `_blogRepository.InsertAsync`, `_unitOfWork.SaveChangesAsync`, `CallAi`
- Entità coinvolte: Lettura: `Match`, `Blog`; Scrittura: `Blog`
- Condizioni rilevanti: processa partite `FullTime` in pagine da 10; genera prima IT, poi traduce nelle altre lingue; skip se post esiste già
- Side effects: scrittura database (`Blog`); chiamata HTTP esterna a Ollama
- Note di confidenza: Verificato dal codice

---

## SystemMessageService

### Nome wiki suggerito

`SystemMessageService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Repositories/SystemMessageBox/SystemMessageService.cs`
- `src/RugbyRadio/Lib/Repositories/SystemMessageBox/ISystemMessageService.cs`

### Tipo

Service

### Interfaccia

- `ISystemMessageService`

### Responsabilità tecnica

Crea e gestisce i messaggi di sistema per la telecronaca tramite Ollama AI. Genera messaggi in italiano per ogni tipo di evento partita, li traduce nelle altre lingue (EN, FR, ES, JA) e nei vari stili di talker. Verifica coerenza del testo e lingua. Pubblica i messaggi verificati in `SystemMessage`.

### Dipendenze iniettate

- `IConfiguration`
- `ISystemMessageRepository`
- `ISystemMessageDraftRepository`
- `IUnitOfWork`

### Consumer deducibili

- Job HF (`CreateMatchEventJob`, `CreateMatchEventAdminJob`) — tramite `ISystemMessageService` o direttamente

### Metodi pubblici significativi

#### AiTalkersCreateOllama(language)

- Input: `language` (`string`)
- Output: `Task`
- Dipendenze chiamate: Ollama via `TailoorTalkerHelper` (HTTP esterno), `_systemMessageDraftRepository.InsertAsync`, `_unitOfWork.SaveChangesAsync`
- Side effects: scrittura database (`SystemMessageDraft`); chiamata HTTP esterna
- Note di confidenza: Parzialmente dedotto

#### AiTalkersTranslateOllama(languageSource) / AiTalkersTranslateOllamaLanguage()

- Input: `languageSource` (`string`)
- Output: `Task`
- Side effects: scrittura database (`SystemMessageDraft`); chiamata HTTP esterna
- Note di confidenza: Parzialmente dedotto

#### AiTalkerCheckSentences(sentence1, sentence2, token) / AiTalkerCheckMessage(sourceMessage, targetMessage, token)

- Output: `Task<CheckSentencesAnswer?>` | `Task<(bool, string)>`
- Side effects: chiamata HTTP esterna (verifica qualità via AI)
- Note di confidenza: Parzialmente dedotto

#### AiTalkerProcessMessages(token)

- Input: `token` (`string`)
- Output: `Task`
- Side effects: scrittura database; chiamata HTTP esterna
- Note di confidenza: Parzialmente dedotto

#### AddCommonMessageAsync() e AddMatchEvent*Async()

- Vari metodi per aggiungere messaggi di sistema per specifici `MatchEventType`
- Side effects: scrittura database (`SystemMessage`)
- Note di confidenza: Parzialmente dedotto (metodi letti solo per firma)

---

## HttpClientService

### Nome wiki suggerito

`HttpClientService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Services/HttpClientService.cs`
- `src/RugbyRadio/Lib/Services/Interfaces/IHttpClientService.cs`

### Tipo

Client

### Interfaccia

- `IHttpClientService`

### Responsabilità tecnica

Client HTTP generico basato su RestSharp. Astrae tutte le chiamate HTTP verso endpoint esterni (GET, POST, PUT, PATCH, DELETE). Supporta autenticazione Bearer JWT, header custom e body sia JSON che form-encoded. Deserializza automaticamente la risposta tramite Newtonsoft.Json.

### Dipendenze iniettate

Nessuna

### Consumer deducibili

- `FacebookService`

### Metodi pubblici significativi

#### DoGetAsync\<T\>(apiUrl, bearerToken?, headers?)

- Input: `apiUrl` (`string`), `bearerToken` (`string?`), `headers` (`Dictionary<string, string>?`)
- Output: `Task<T?>`
- Side effects: chiamata HTTP esterna
- Note di confidenza: Verificato dal codice

#### DoPostAsync\<T\>(apiUrl, body, bearerToken?, headers?) / DoPostFormEncodedAsync\<T\> / DoPutAsync\<T\> / DoPatchAsync\<T\> / DoDeleteAsync\<T\>

- Output: `Task<T?>`
- Side effects: chiamata HTTP esterna
- Note di confidenza: Verificato dal codice

---

## RugbyRadioLiveService

### Nome wiki suggerito

`RugbyRadioLiveService (api)`

### File sorgente

- `src/RugbyRadio/Lib/Services/RugbyRadioLiveService.cs`
- `src/RugbyRadio/Lib/Services/Interfaces/IRugbyRadioLiveService.cs`

### Tipo

Service

### Interfaccia

- `IRugbyRadioLiveService`

### Responsabilità tecnica

Orchestratore di alto livello per la creazione rapida di canale + squadre + partita + formazioni in un'unica operazione wizard. Usato sia alla registrazione utente che per job di simulazione e manutenzione.

### Dipendenze iniettate

- `IChannelRepository`
- `IChannelService`
- `ITeamService`
- `IMatchService`
- `ILineupPlayerService`
- `IUnitOfWork`

### Consumer deducibili

- `AuthV1Controller` — registrazione utente (email e Google)
- `MatchesV1Controller` — creazione partita rapida (MTC-17)
- `CreateTrainingChannelJob`

### Metodi pubblici significativi

#### WizardFastAddChannelAsync(userId, model, isTestChannel?)

- Input: `userId` (`string`), `model` (`MatchQuickAddDto`), `isTestChannel` (`bool?`)
- Output: `Task<Match>`
- Dipendenze chiamate: `_channelRepository.FindByUserAsync`, `_channelService.GetOrCreateChannelAsync`, `_channelRepository.UpdateAsync`, `_teamService.GetOrCreateTeamAsync` (×2), `_matchService.AddMatchAsync`, `_lineupPlayerService.CreateLineup` (×2), `_matchService.AddMatchImageAsync`, `_unitOfWork.SaveChangesAsync`
- Entità coinvolte: Scrittura: `Channel`, `Team` (×2), `Match`, `LineupPlayer` (46 record)
- DTO / Request / Response: `MatchQuickAddDto`, `MatchAddDto`
- Condizioni rilevanti: se `isTestChannel = true` → verifica se l'utente ha già un canale test: se sì ritorna `new Match()` senza creare nulla; imposta `channel.IsTestChannel = true`
- Side effects: scrittura database multipla; eventuale spostamento file immagine su filesystem (via `AddMatchImageAsync`)
- Errori / casi limite: `ArgumentNullException` se `model.Channel`, `model.HomeTeam` o `model.AwayTeam` sono null
- Note di confidenza: Verificato dal codice

---

## Note finali

- Limiti dell'analisi: `MatchService` è il servizio più esteso (~2000 righe); i metodi `UpdateMatchAsync`, `UpdateMatchStatsAsync`, `DeleteEventAsync`, `FollowAsync`, `RemovePlayerRoleAsync`, `GetTrainingMatchAsync`, `GetScoreboardAsync` sono stati verificati solo per firma dall'interfaccia o parzialmente; `SystemMessageService` contiene numerosi metodi `AddMatchEvent*Async` letti solo per firma; `TeamService.GetChannelTeamsAsync` non letto nel dettaglio.
- Elementi esclusi: `Repository<T>` (repository base, non service); validator; entity; DTO puri; `BaseCoreJob`, `CreateMatchEventCoreJob`, `FakeAgent` (classi base job, non service).
- Elementi non deducibili: dettaglio completo di `MatchService.GetMatchAsync` (metodo molto lungo con logica di mapping DTO complessa); dettaglio completo di `SystemMessageService` (molti metodi interni AI); consumer di `AiOllamaService` e `SystemMessageService` dai controller API (usati nei job HF, non nei controller API analizzati).
- Wiki non modificata: confermato.
