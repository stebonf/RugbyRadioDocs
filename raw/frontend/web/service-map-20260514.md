# Frontend Service Map RAW

## Sintesi

- Data analisi: 2026-05-14
- Project: web
- Root frontend analizzata: `src/RugbyRadioWeb/src/app/services/`
- File output: `llm-wiki/raw/frontend/web/service-map-20260514.md`
- Servizi frontend trovati: 19
- API client FE trovati: 10 (estendono `BaseService`)
- Metodi pubblici significativi trovati: 93
- Endpoint backend deducibili: 59
- Consumer FE deducibili: da componenti e pagine identificati nel component-map
- Candidati esclusi o incerti: 1 (`AuthInterceptor`)

---

## Configurazioni globali usate dai servizi

- `environment.apiUrl` — base URL API: `https://api-s1-sh.rugbyradiolive.com/v1` (staging); tutte le chiamate HTTP vi sono concatenate.
- `environment.audioUrl` — base URL file audio: `https://storage-sh.rugbyradiolive.com/audio/`.
- `environment.firebaseConfig.vapidKey` — chiave VAPID per Firebase Cloud Messaging (notifiche push).
- `environment.googleClientId` — Client ID Google OAuth.
- `environment.production` — flag produzione; in dev il `LoggingService` stampa su console.

---

## Servizi frontend

---

## BaseService

### Nome nel codice

`BaseService`

### Nome wiki suggerito

`BaseService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/base.service.ts`

### Tipo

Service — base HTTP client astratto

### Responsabilità

Classe base per tutti i servizi che chiamano il backend. Fornisce `doGet`, `doPost`, `doPut`, `doDelete` con logging automatico (`LoggingService.addLog(logCode)`). URL base letta da `environment.apiUrl`. HTTP client Angular iniettato.

### Consumer FE

Esteso da: `UserService`, `MatchService`, `ChannelService`, `ChannelUserService`, `TeamService`, `PlayerService`, `LineupService`, `BlogService`, `StatsService`, `VoiceService`, `BusService`, `ErrorHandlerService`, `LoginCallbackService`, `PlatformService`

### Configurazioni usate

- `environment.apiUrl` — base URL concatenata a ogni endpoint

### Metodi pubblici significativi

#### doGet\<T\>(endpoint, logCode) — protected

- Input: `endpoint` (`string`), `logCode` (`string`)
- Output: `Observable<T>`
- API chiamate: GET `{apiUrl}{endpoint}`
- Side effects: logging via `LoggingService`
- Note di confidenza: Verificato dal codice

#### doPost\<T\>(endpoint, body, logCode) — protected

- Input: `endpoint` (`string`), `body` (`any`), `logCode` (`string`)
- Output: `Observable<T>`
- API chiamate: POST `{apiUrl}{endpoint}`
- Side effects: logging
- Note di confidenza: Verificato dal codice

#### doPut\<T\>(endpoint, body, logCode) — protected

- Input: `endpoint` (`string`), `body` (`any`), `logCode` (`string`)
- Output: `Observable<T>`
- API chiamate: PUT `{apiUrl}{endpoint}`
- Note di confidenza: Verificato dal codice

#### doDelete\<T\>(endpoint, logCode) — protected

- Input: `endpoint` (`string`), `logCode` (`string`)
- Output: `Observable<T>`
- API chiamate: DELETE `{apiUrl}{endpoint}`
- Note di confidenza: Verificato dal codice

---

## UserService

### Nome nel codice

`UserService`

### Nome wiki suggerito

`UserService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/user.service.ts`

### Tipo

Service — autenticazione, profilo utente, stato sessione

### Responsabilità

Gestisce autenticazione (login, registrazione, Google OAuth, logout), sessione JWT in `localStorage`, stato reattivo (`isLoggedIn$`, `userNickname$`, `isSplashVisible$`), preferenze utente (lingua, telecronista, notifiche push), Firebase FCM token, impostazioni partita.

### Consumer FE

- `HeaderComponent`, `EntityBottomNavComponent`, `AuthGuardService`
- `LoginComponent`, `RegistrationComponent`, `ResetPasswordComponent`, `ProfileComponent`
- `MatchCommentatorComponent`, `HomeSplashComponent`, `HomeUserComponent`
- `GBaseUserComponent` (e tutte le pagine che lo estendono)

### Configurazioni usate

- `environment.apiUrl` — base URL API
- `environment.firebaseConfig.vapidKey` — per ottenere token FCM
- `localStorage` keys: `token_id`, `user_id`, `user_nickname`, `user_language`, `commentator_id`, `notification_token`, `notification_check`, `notification_status`, `match_settings_status`, `half_minutes`, `hide_splash`, `hide_tips_get_started`, `use_ai_emoji`

### Metodi pubblici significativi

#### login(email, password)

- Input: `email` (`string`), `password` (`string`)
- Output: `Observable<userTokenDto>`
- API chiamate: POST `/auth/user/login` — `ATH-03`
- DTO: `userLoginDto`, `userTokenDto`
- Side effects: aggiornamento localStorage tramite `setSession` (token, userId, nickname, lingua), aggiornamento `BehaviorSubject` stato login
- Note di confidenza: Verificato dal codice

#### register(email, password, nickname, language)

- Input: `email`, `password`, `nickname`, `language` (`string`)
- Output: `Observable<userTokenDto>`
- API chiamate: POST `/auth/users` — `ATH-01`
- DTO: `userRegisterDto`, `userTokenDto`
- Side effects: `setSession`
- Note di confidenza: Verificato dal codice

#### loginWithGoogle(language, token)

- Input: `language` (`string`), `token` (`string`) — Google ID token
- Output: `Observable<userTokenDto>`
- API chiamate: POST `/auth/users/google` — `ATH-04`
- DTO: `userGoogleRegisterDto`, `userTokenDto`
- Side effects: `setSession`
- Note di confidenza: Verificato dal codice

#### forgotPassword(email)

- Input: `email` (`string`)
- Output: `Observable<void>`
- API chiamate: POST `/auth/users/forgot` — `ATH-05`
- Note di confidenza: Verificato dal codice

#### changePassword(otpcode, newPassword)

- Input: `otpcode` (`string`), `newPassword` (`string`)
- Output: `Observable<userTokenDto>`
- API chiamate: POST `/auth/users/password` — `ATH-06`
- DTO: `userChangePasswordDto`, `userTokenDto`
- Side effects: `setSession`
- Note di confidenza: Verificato dal codice

#### getAvatars()

- Output: `Observable<userAvatarsDto>`
- API chiamate: GET `/user/avatars` — `USR-01`
- Note di confidenza: Verificato dal codice

#### getProfile()

- Output: `Observable<userProfileDto>`
- API chiamate: GET `/user` — `USR-02`
- Note di confidenza: Verificato dal codice

#### update(model)

- Input: `model` (`userUpdateDto`)
- Output: `Observable<void>`
- API chiamate: PUT `/user` — `USR-03`
- Side effects: chiamata HTTP
- Note di confidenza: Verificato dal codice

#### updateTimezone(timezone)

- Input: `timezone` (`string`)
- Output: `Observable<void>`
- API chiamate: PUT `/user/timezone` — `USR-04`
- Note di confidenza: Verificato dal codice

#### sendFeedback(rating, message)

- Input: `rating` (`number`), `message` (`string`)
- Output: `Observable<void>`
- API chiamate: POST `/user/feedback` — `USR-07`
- Note di confidenza: Verificato dal codice

#### deleteUser()

- Output: `Observable<void>`
- API chiamate: DELETE `/user` — `USR-06`
- Side effects: chiamata HTTP (cancellazione account)
- Note di confidenza: Verificato dal codice

#### logout()

- Output: `void`
- Side effects: rimozione chiavi localStorage (token, userId, nickname, notificationToken, hideSplash, hideTipsGetStarted), pulizia sessionStorage, aggiornamento `BehaviorSubject` stato login a `false`
- Note di confidenza: Verificato dal codice

#### setCommentatorId(id)

- Input: `id` (`string`)
- Side effects: localStorage `commentator_id`; se loggato chiama `update(model)` con `commentaryLanguage`
- Note di confidenza: Verificato dal codice

#### setUserLanguage(language)

- Input: `language` (`string`)
- Side effects: localStorage `user_language`; aggiornamento `TranslateService`; se loggato chiama `update(model)` con `language`
- Note di confidenza: Verificato dal codice

#### requestNotificationPermission()

- Output: `Promise<boolean>`
- Side effects: richiesta permesso notifica browser; localStorage `notification_status`; se concesso: recupero token FCM e `saveNotificationToken` (PUT `/user/notification` — `USR-05`)
- Note di confidenza: Verificato dal codice

#### refreshTokenNotification()

- Side effects: controlla se notifiche abilitate; se token FCM non aggiornato oggi, lo rinnova (una volta per giorno, via `notification_check` in localStorage)
- Note di confidenza: Verificato dal codice

#### getUserId() / getToken() / getUserLanguage() / getCommentatorId()

- Output: `string | null`
- Side effects: lettura localStorage; nessuna chiamata HTTP
- Note di confidenza: Verificato dal codice

#### isSplashVisible() / setSplashHidden() / isTipsGetStartedVisible() / setTipsGetStartedHidden()

- Side effects: localStorage `hide_splash`, `hide_tips_get_started`; aggiornamento `isSplashVisibleSubject`
- Note di confidenza: Verificato dal codice

#### getHalfMinutes() / setHalfMinutes(minutes) / getUseAiEmoji() / setUseAiEmoji(value) / getMatchSettingsStatus() / setMatchSettingsStatus(status)

- Side effects: lettura/scrittura localStorage; nessuna chiamata HTTP
- Note di confidenza: Verificato dal codice

---

## MatchService

### Nome nel codice

`MatchService`

### Nome wiki suggerito

`MatchService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/match.service.ts`

### Tipo

ApiClient — partite

### Responsabilità

API client completo per la gestione delle partite. Copre CRUD partite, eventi, reazioni, commenti, like, follow, voti giocatori, notifiche, ricerca pubblica, partite in corso, formazione, partita di training.

### Consumer FE

- `MatchEventsComponent`, `MatchLineupComponent`, `MatchCreateComponent`
- `GMatchComponent`, `GMatchesComponent`, `GChannelComponent`, `GTeamComponent`
- `HomeLastMatchesComponent`, `HomeNextMatchesComponent`, `HomeOngoingMatchesComponent`, `HomeUserComponent`
- `MatchComponent` (editor), vari componenti canale

### Metodi pubblici significativi

#### getMatches(channelId)

- Input: `channelId` (`string`)
- Output: `Observable<matchChannelDto[]>`
- API chiamate: GET `/channels/{channelId}/matches` — `MTC-01` — `MatchesV1Controller.GetMatchesByChannel`
- Note di confidenza: Verificato dal codice

#### getMatch(matchId)

- Input: `matchId` (`string`)
- Output: `Observable<matchDto>`
- API chiamate: GET `/matches/{matchId}` — `MTC-02` — `MatchesV1Controller.GetMatchById`
- Note di confidenza: Verificato dal codice

#### addMatch(channelId, match)

- Input: `channelId` (`string`), `match` (`matchAddDto`)
- Output: `Observable<matchDto>`
- API chiamate: POST `/channels/{channelId}/matches` — `MTC-03`
- Note di confidenza: Verificato dal codice

#### updateStats(matchId, matchStats)

- Input: `matchId` (`string`), `matchStats` (`matchStatsDto`)
- Output: `Observable<matchDto>`
- API chiamate: PUT `/matches/{matchId}/stats` — `MTC-04`
- Note di confidenza: Verificato dal codice

#### addEvent(matchId, event)

- Input: `matchId` (`string`), `event` (`matchEventAddDto`)
- Output: `Observable<matchDto>`
- API chiamate: POST `/matches/{matchId}/events` — `EVT-03`
- Note di confidenza: Verificato dal codice

#### deleteEvent(matchId, eventId)

- Input: `matchId` (`string`), `eventId` (`string`)
- Output: `Observable<matchDto>`
- API chiamate: DELETE `/matches/{matchId}/events/{eventId}` — `EVT-04`
- Note di confidenza: Verificato dal codice

#### addReaction(matchId, eventId, reactionType)

- Input: `matchId`, `eventId`, `reactionType` (`string`)
- Output: `Observable<matchDto>`
- API chiamate: POST `/matches/{matchId}/reactions` — `MTC-05`
- DTO: `matchReactionAddDto`
- Note di confidenza: Verificato dal codice

#### addComment(matchId, eventId, message)

- Input: `matchId`, `eventId`, `message` (`string`)
- Output: `Observable<matchDto>`
- API chiamate: POST `/matches/{matchId}/comments` — `MTC-06`
- DTO: `matchCommentAddDto`
- Note di confidenza: Verificato dal codice

#### deleteComment(matchId, commentId)

- Output: `Observable<matchDto>`
- API chiamate: DELETE `/matches/{matchId}/comments/{commentId}` — `MTC-07`
- Note di confidenza: Verificato dal codice

#### updateStatus(matchId, status)

- Input: `matchId` (`string`), `status` (`number`)
- Output: `Observable<matchDto>`
- API chiamate: PUT `/matches/{matchId}/status` — `MTC-08`
- DTO: `matchStatusUpdateDto`
- Note di confidenza: Verificato dal codice

#### updateMatch(channelId, matchId, match)

- Output: `Observable<matchDto>`
- API chiamate: PUT `/channels/{channelId}/matches/{matchId}` — `MTC-09`
- Note di confidenza: Verificato dal codice

#### findMatchesByChannel(channelId, page?)

- Output: `Observable<pageDto<matchMinDto>>`
- API chiamate: GET `/channels/{channelId}/matches/search?page={page}&pageSize=20` — `MTC-10`
- Note di confidenza: Verificato dal codice

#### findMatches(search?, page?, status?)

- Output: `Observable<pageDto<matchMinDto>>`
- API chiamate: GET `/matches/public/search?textToSearch={search}&page={page}&pageSize=20[&status={status}]` — `MTC-11`
- Note di confidenza: Verificato dal codice

#### ratePlayer(matchId, lineupPlayerId)

- Output: `Observable<matchDto>`
- API chiamate: POST `/matches/{matchId}/players/{lineupPlayerId}/rate` — `MTC-12`
- Note di confidenza: Verificato dal codice

#### likeMatch(matchId)

- Output: `Observable<matchDto>`
- API chiamate: PUT `/matches/{matchId}/like` — `MTC-13`
- Note di confidenza: Verificato dal codice

#### getOnGoingMatches()

- Output: `Observable<matchMinDto[]>`
- API chiamate: GET `/matches/ongoing` — `MTC-14`
- Note di confidenza: Verificato dal codice

#### manageFollow(matchId)

- Output: `Observable<boolean>`
- API chiamate: PUT `/matches/{matchId}/follow` — `MTC-15`
- Note di confidenza: Verificato dal codice

#### sendNotification(matchId)

- Output: `Observable<boolean>`
- API chiamate: POST `/matches/{matchId}/notification` — `MTC-16`
- Note di confidenza: Verificato dal codice

#### addQuickMatch(match)

- Input: `match` (`matchQuickAddDto`)
- Output: `Observable<matchMinDto>`
- API chiamate: POST `/matches` — `MTC-17`
- Note di confidenza: Verificato dal codice

#### findMatchesByTeam(teamId, page?)

- Output: `Observable<pageDto<matchMinDto>>`
- API chiamate: GET `/teams/{teamId}/matches/search?page={page}&pageSize=20` — `MTC-18`
- Note di confidenza: Verificato dal codice

#### getTrainingMatch()

- Output: `Observable<matchChannelDto>`
- API chiamate: GET `/channels/matches/training` — `MTC-19`
- Note di confidenza: Verificato dal codice

---

## ChannelService

### Nome nel codice

`ChannelService`

### Nome wiki suggerito

`ChannelService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/channel.service.ts`

### Tipo

ApiClient — canali

### Responsabilità

API client per CRUD canali (utente e pubblici), gestione iscrizioni, ricerca pubblica.

### Consumer FE

- `GChannelComponent`, `GChannelsComponent`
- `HomeLastChannelsComponent`, `HomeUserComponent`
- `ChannelComponent` (editor), `ChannelsComponent`

### Metodi pubblici significativi

#### getChannels()

- Output: `Observable<channelDto[]>`
- API chiamate: GET `/channels` — `CHL-01` — `ChannelsV1Controller.GetChannels`
- Note di confidenza: Verificato dal codice

#### getChannel(channelId)

- Output: `Observable<channelDto>`
- API chiamate: GET `/channels/{channelId}` — `CHL-02`
- Note di confidenza: Verificato dal codice

#### addChannel(channel)

- Input: `channel` (`channelAddDto`)
- Output: `Observable<channelDto>`
- API chiamate: POST `/channels` — `CHL-03`
- Note di confidenza: Verificato dal codice

#### updateChannel(channelId, channel)

- Input: `channelId` (`string`), `channel` (`channelUpdateDto`)
- Output: `Observable<channelDto>`
- API chiamate: PUT `/channels/{channelId}` — `CHL-04`
- Note di confidenza: Verificato dal codice

#### updateLayout(channelId, layout)

- Input: `channelId` (`string`), `layout` (`channelLayoutUpdateDto`)
- Output: `Observable<channelDto>`
- API chiamate: PUT `/channels/{channelId}/layout` — `CHL-05`
- Note di confidenza: Verificato dal codice

#### manageSubscription(channelId)

- Input: `channelId` (`string`)
- Output: `Observable<void>`
- API chiamate: PUT `/channels/{channelId}/subscription` — `CHL-06`
- Note di confidenza: Verificato dal codice

#### getFavorites()

- Output: `Observable<channelDto[]>`
- API chiamate: GET `/channels/favorites` — `CHL-07`
- Note di confidenza: Verificato dal codice

#### getPublicChannel(publicId)

- Input: `publicId` (`string`)
- Output: `Observable<channelPublicDto>`
- API chiamate: GET `/channels/public/{publicId}` — `CHL-10`
- Note di confidenza: Verificato dal codice

#### findChannels(search?, page?)

- Output: `Observable<pageDto<channelPublicDto>>`
- API chiamate: GET `/channels/public/search?textToSearch={search}&page={page}&pageSize=20` — `CHL-11`
- Note di confidenza: Verificato dal codice

---

## ChannelUserService

### Nome nel codice

`ChannelUserService`

### Nome wiki suggerito

`ChannelUserService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/channel-user.service.ts`

### Tipo

ApiClient — co-editor canale

### Responsabilità

API client per gestione co-editor (co-owner) di un canale.

### Consumer FE

- `ChannelComponent` / `channel-editors` (area utente)

### Metodi pubblici significativi

#### getUsers(channelId)

- Output: `Observable<channelUserDto[]>`
- API chiamate: GET `/channels/{channelId}/users` — `CHL-USR-01`
- Note di confidenza: Verificato dal codice

#### addUser(channelId, email)

- Input: `channelId` (`string`), `email` (`string`)
- Output: `Observable<any>`
- API chiamate: POST `/channels/{channelId}/users` — `CHL-USR-02`
- DTO: `channelUserAddDto`
- Note di confidenza: Verificato dal codice

#### deleteUser(channelId, userId)

- Input: `channelId` (`string`), `userId` (`string`)
- Output: `Observable<any>`
- API chiamate: DELETE `/channels/{channelId}/users/{userId}` — `CHL-USR-03`
- Note di confidenza: Verificato dal codice

---

## TeamService

### Nome nel codice

`TeamService`

### Nome wiki suggerito

`TeamService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/team.service.ts`

### Tipo

ApiClient — squadre

### Responsabilità

API client per CRUD squadre di un canale, recupero loghi disponibili, squadre pubbliche.

### Consumer FE

- `GTeamComponent`, `ChannelComponent`, `HomeUserComponent`

### Metodi pubblici significativi

#### getTeams(channelId)

- Output: `Observable<teamChannelDto[]>`
- API chiamate: GET `/channels/{channelId}/teams` — `TMS-01`
- Note di confidenza: Verificato dal codice

#### getLogos()

- Output: `Observable<teamLogoDto>`
- API chiamate: GET `/teams/logos` — `TMS-02`
- Note di confidenza: Verificato dal codice

#### addTeam(channelId, model)

- Input: `channelId` (`string`), `model` (`teamAddDto`)
- Output: `Observable<teamChannelDto>`
- API chiamate: POST `/channels/{channelId}/teams` — `TMS-03`
- Note di confidenza: Verificato dal codice

#### updateTeam(channelId, teamId, model)

- Input: `channelId` (`string`), `teamId` (`string`), `model` (`teamUpdateDto`)
- Output: `Observable<teamChannelDto>`
- API chiamate: PUT `/channels/{channelId}/teams/{teamId}` — `TMS-04`
- Note di confidenza: Verificato dal codice

#### getUserTeams()

- Output: `Observable<teamMinDto[]>`
- API chiamate: GET `/teams` — `TMS-05`
- Note di confidenza: Verificato dal codice

#### getTeam(teamId)

- Input: `teamId` (`string`)
- Output: `Observable<teamPublicDto>`
- API chiamate: GET `/teams/{teamId}` — `TMS-06`
- Note di confidenza: Verificato dal codice

---

## PlayerService

### Nome nel codice

`PlayerService`

### Nome wiki suggerito

`PlayerService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/player.service.ts`

### Tipo

ApiClient — giocatori

### Responsabilità

API client per CRUD giocatori di una squadra.

### Consumer FE

- Componenti nell'area editor canale/match

### Metodi pubblici significativi

#### getPlayers(channelId, teamId)

- Output: `Observable<playerDto[]>`
- API chiamate: GET `/channels/{channelId}/teams/{teamId}/players` — `PYR-01`
- Note di confidenza: Verificato dal codice

#### addPlayer(channelId, teamId, model)

- Input: `channelId`, `teamId` (`string`), `model` (`playerSaveDto`)
- Output: `Observable<playerDto>`
- API chiamate: POST `/channels/{channelId}/teams/{teamId}/players` — `PYR-03`
- Note di confidenza: Verificato dal codice

#### updatePlayer(channelId, teamId, playerId, model)

- Output: `Observable<playerDto>`
- API chiamate: PUT `/channels/{channelId}/teams/{teamId}/players/{playerId}` — `PYR-04`
- Note di confidenza: Verificato dal codice

#### deletePlayer(channelId, teamId, playerId)

- Output: `Observable<playerDto>`
- API chiamate: DELETE `/channels/{channelId}/teams/{teamId}/players/{playerId}` — `PYR-05`
- Note di confidenza: Verificato dal codice

---

## LineupService

### Nome nel codice

`LineupService`

### Nome wiki suggerito

`LineupService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/lineup.service.ts`

### Tipo

ApiClient — formazioni partita

### Responsabilità

API client per gestione formazioni: aggiornamento ruolo, aggiunta giocatore inline, rimozione.

### Consumer FE

- `MatchLineupComponent`

### Metodi pubblici significativi

#### updateLineup(channelId?, matchId?, lineupId?, playerId?)

- Input: tutti opzionali (`string`)
- Output: `Observable<matchDto>`
- API chiamate: PUT `/channels/{channelId}/matches/{matchId}/lineups/{lineupId}` — `LNP-04`
- DTO: `lineupPlayerEditDto`
- Note di confidenza: Verificato dal codice

#### addLineup(channelId?, matchId?, lineupId?, name?, nickname?)

- Output: `Observable<matchDto>`
- API chiamate: POST `/channels/{channelId}/matches/{matchId}/lineups/{lineupId}` — `LNP-05`
- DTO: `lineupPlayerAddDto`
- Note di confidenza: Verificato dal codice

#### removeLineup(channelId?, matchId?, lineupId?)

- Output: `Observable<matchDto>`
- API chiamate: DELETE `/channels/{channelId}/matches/{matchId}/lineups/{lineupId}` — `LNP-06`
- Note di confidenza: Verificato dal codice

---

## BlogService

### Nome nel codice

`BlogService`

### Nome wiki suggerito

`BlogService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/blog.service.ts`

### Tipo

ApiClient — blog

### Responsabilità

API client per lettura post blog (lista paginata e singolo post per partita).

### Consumer FE

- `GMatchComponent`

### Metodi pubblici significativi

#### getBlogs(page)

- Input: `page` (`number`)
- Output: `Observable<pageDto<blogDto>>`
- API chiamate: GET `/blog?page={page}` — `BLOG-01` — `BlogV1Controller.GetBlog`
- Note di confidenza: Verificato dal codice

#### getMatchBlog(matchId)

- Input: `matchId` (`string`)
- Output: `Observable<blogDto>`
- API chiamate: GET `/blog/matches/{matchId}` — `BLOG-02` — `BlogV1Controller.GetMatchBlog`
- Note di confidenza: Verificato dal codice

---

## StatsService

### Nome nel codice

`StatsService`

### Nome wiki suggerito

`StatsService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/stats.service.ts`

### Tipo

ApiClient — statistiche piattaforma

### Responsabilità

API client per recupero statistiche globali della piattaforma.

### Consumer FE

- `GStatsComponent`

### Metodi pubblici significativi

#### getStats()

- Output: `Observable<statsDto>`
- API chiamate: GET `/stats/` — `STS-01` — `StatsV1Controller.GetStats`
- Note di confidenza: Verificato dal codice

---

## VoiceService

### Nome nel codice

`VoiceService`

### Nome wiki suggerito

`VoiceService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/voice.service.ts`

### Tipo

ApiClient — audio/TTS

### Responsabilità

API client per recupero file audio di telecronaca. La risposta è `text` (path del file audio sul server), non JSON. Chiama endpoint backend che generano MP3 via Azure TTS.

### Consumer FE

- `MatchCommentatorComponent`, `MatchEventsComponent`

### Metodi pubblici significativi

#### getVoice(language, sentence)

- Input: `language` (`string`), `sentence` (`string`) — ID stile telecronista
- Output: `Observable<string>` — path file audio
- API chiamate: GET `/voices?language={language}&sentence={sentence}` — `VOICE-01` — `VoicesV1Controller.GetAudio`
- Side effects: chiamata HTTP con `responseType: 'text'`
- Note di confidenza: Verificato dal codice

#### getVoiceEvent(language, eventId)

- Input: `language` (`string`), `eventId` (`string`)
- Output: `Observable<string>` — path file audio
- API chiamate: GET `/voices/events?language={language}&eventId={eventId}` — `VOICE-02` — `VoicesV1Controller.GetEventAudio`
- Side effects: chiamata HTTP con `responseType: 'text'`
- Note di confidenza: Verificato dal codice

---

## BusService

### Nome nel codice

`BusService`

### Nome wiki suggerito

`BusService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/bus.service.ts`

### Tipo

Service — event bus / stato globale UI

### Responsabilità

Event bus reattivo per comunicazione tra componenti non correlati gerarchicamente. Gestisce visibilità menu lingua header, titolo header, pulsante back, apertura drawer "Crea partita rapida" (`isQuickMatchOpen$`). Tutti gli stati sono `BehaviorSubject`.

### Consumer FE

- `HeaderComponent` — osserva `isHeaderLanguageVisible$`, `headerPageTitle$`, `isHeaderBackVisible$`
- `EntityBottomNavComponent` — chiama `setQuickMatchOpen(true)`
- `AppComponent` — osserva `isQuickMatchOpen$` per aprire `MatchCreateComponent`
- `HomeSplashComponent`, `GFeedbackComponent`

### Metodi pubblici significativi

#### setHeaderLanguageVisible(value) / setHeaderPageTitle(value) / setHeaderBackVisible(value)

- Side effects: aggiornamento `BehaviorSubject` corrispondente
- Note di confidenza: Verificato dal codice

#### setQuickMatchOpen(value)

- Input: `value` (`boolean`)
- Side effects: aggiornamento `isQuickMatchOpenSubject` — trigger apertura drawer `MatchCreate`
- Note di confidenza: Verificato dal codice

---

## ToastService

### Nome nel codice

`ToastService`

### Nome wiki suggerito

`ToastService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/toast.service.ts`

### Tipo

Service — notifiche toast

### Responsabilità

Gestisce la coda di notifiche toast. Auto-dismiss dopo 4000ms. Espone `toasts$` Observable consumato da `EntityToastComponent`.

### Consumer FE

- `EntityToastComponent` — osserva `toasts$`
- Tutti i componenti/pagine che iniettano `ToastService` per mostrare notifiche

### Metodi pubblici significativi

#### success(text) / info(text) / warning(text) / error(text)

- Input: `text` (`string`)
- Side effects: aggiunta toast alla lista; auto-dismiss dopo 4000ms

#### dismiss(id)

- Input: `id` (`number`)
- Side effects: rimozione toast dalla lista

---

## AnalyticsService

### Nome nel codice

`AnalyticsService`

### Nome wiki suggerito

`AnalyticsService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/analytics.service.ts`

### Tipo

Service — tracking Firebase Analytics

### Responsabilità

Wrapper per `AngularFireAnalytics`. Espone `track` per eventi custom e `trackPageView`. Iniettato con `optional: true` (non blocca se Firebase non è configurato). Filtra parametri `undefined`.

### Consumer FE

- Quasi tutte le pagine e componenti principali

### Configurazioni usate

- `environment.firebaseConfig.measurementId` — ID Google Analytics (configurato in `firebase.config.ts`)

### Metodi pubblici significativi

#### track(eventName, params?)

- Input: `eventName` (`string`), `params` (`Record<string, string|number|boolean|null|undefined>`)
- Side effects: `AngularFireAnalytics.logEvent`
- Note di confidenza: Verificato dal codice

#### trackPageView(pagePath, pageTitle?)

- Input: `pagePath` (`string`), `pageTitle` (`string?`)
- Side effects: chiama `track('page_view', {...})`
- Note di confidenza: Verificato dal codice

---

## LoggingService

### Nome nel codice

`LoggingService`

### Nome wiki suggerito

`LoggingService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/logging.service.ts`

### Tipo

Service — logging applicativo

### Responsabilità

Logging a `sessionStorage` con rolling buffer di 100 entry. In non-production stampa su `console.log` con colori per namespace. Usato da `BaseService` e da ogni componente/servizio per tracciare navigazione e operazioni.

### Consumer FE

- `BaseService` e tutti i servizi derivati
- La maggior parte dei componenti

### Metodi pubblici significativi

#### addLog(message)

- Input: `message` (`string`)
- Side effects: scrittura `sessionStorage['logs']`; `console.log` in dev

#### getLogs()

- Output: `{ message, timestamp }[]`
- Side effects: lettura `sessionStorage`

#### clearLogs()

- Side effects: rimozione `sessionStorage['logs']`

---

## ErrorHandlerService

### Nome nel codice

`ErrorHandlerService`

### Nome wiki suggerito

`ErrorHandlerService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/errorhandler.service.ts`

### Tipo

Service — gestione errori applicativa

### Responsabilità

Persistenza dell'ultimo errore in `localStorage`. Logging tramite `LoggingService`.

### Consumer FE

- `MatchEventsComponent`, `MatchLineupComponent`, `MatchCreateComponent`
- Pagine globali (`GMatchComponent`, `GChannelComponent`, ecc.)

### Metodi pubblici significativi

#### save(error)

- Input: `error` (`any`)
- Side effects: scrittura `localStorage['last_error']`; logging

#### getLastError()

- Output: `string | null`
- Side effects: lettura `localStorage`

---

## LoginCallbackService

### Nome nel codice

`LoginCallbackService`

### Nome wiki suggerito

`LoginCallbackService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/logincallback.service.ts`

### Tipo

Service — redirect post-login

### Responsabilità

Gestisce redirect post-login: salva l'URL di destinazione in `localStorage` prima del redirect al login; dopo il login reindirizza all'URL salvato (o a un default).

### Consumer FE

- `AuthGuardService`, `GChannelComponent`, `LoginComponent`

### Metodi pubblici significativi

#### goToLogin(callbackUrl)

- Input: `callbackUrl` (`string`)
- Side effects: `localStorage['login_callback'] = callbackUrl`; naviga a `/user-login`

#### goToCallback(defaultUrl)

- Input: `defaultUrl` (`string`)
- Side effects: legge e rimuove `localStorage['login_callback']`; naviga all'URL salvato o al default

#### clear()

- Side effects: rimozione `localStorage['login_callback']`

---

## PlatformService

### Nome nel codice

`PlatformService`

### Nome wiki suggerito

`PlatformService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/platform.service.ts`

### Tipo

Service — rilevamento piattaforma

### Responsabilità

Rileva al costruttore se l'app è eseguita in modalità TWA (Trusted Web Activity) e se il dispositivo è mobile. Espone `isTwa` e `isMobile` come proprietà boolean.

### Consumer FE

- `HeaderComponent`

### Metodi pubblici significativi

Nessun metodo pubblico (solo proprietà `isTwa` e `isMobile` calcolate al costruttore).

- `isTwa` — `window.matchMedia('(display-mode: standalone)').matches || navigator.userAgent.includes('TWA')`
- `isMobile` — `userAgent` match `/android|iPhone|iPad|iPod/i`

### Note di confidenza

Verificato dal codice

---

## AuthGuardService

### Nome nel codice

`AuthGuardService`

### Nome wiki suggerito

`AuthGuardService (web)`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/auth-guard.service.ts`

### Tipo

Service — route guard Angular

### Responsabilità

Implementa `CanActivate`. Blocca la navigazione verso route protette se l'utente non è autenticato. Osserva `UserService.isLoggedIn$`.

### Consumer FE

- `app.routes.ts` — applicato a route `/user-dashboard`, `/user-profile`, `/user-channels`, `/user-channel/:id`, `/user-match/:id`, `/user-danger`, `/user-favorites`

### Metodi pubblici significativi

#### canActivate(route, state)

- Output: `boolean` (sincrono — valore corrente di `isLoggedIn`)
- Side effects: nessuno deducibile (non reindirizza automaticamente a login — il redirect è gestito a livello di routing o da `LoginCallbackService`)
- Note di confidenza: Verificato dal codice

---

## Endpoint backend rilevati

---

## GET /v1/channels — CHL-01

### Chiamato da

- `ChannelService.getChannels()`

### Metodo e path

- GET `/channels`

### API backend suggerita

- `ChannelsV1Controller.GetChannels`

---

## GET /v1/channels/{channelId} — CHL-02

### Chiamato da

- `ChannelService.getChannel(channelId)`

### Metodo e path

- GET `/channels/{channelId}`

### API backend suggerita

- `ChannelsV1Controller.GetChannelById`

---

## POST /v1/channels — CHL-03

### Chiamato da

- `ChannelService.addChannel(channel)`

### Metodo e path

- POST `/channels`

### API backend suggerita

- `ChannelsV1Controller.AddChannel`

---

## PUT /v1/channels/{channelId} — CHL-04

### Chiamato da

- `ChannelService.updateChannel(channelId, channel)`

### Metodo e path

- PUT `/channels/{channelId}`

### API backend suggerita

- `ChannelsV1Controller.UpdateChannel`

---

## PUT /v1/channels/{channelId}/layout — CHL-05

### Chiamato da

- `ChannelService.updateLayout(channelId, layout)`

### Metodo e path

- PUT `/channels/{channelId}/layout`

### API backend suggerita

- `ChannelsV1Controller.UpdateChannelLayout`

---

## PUT /v1/channels/{channelId}/subscription — CHL-06

### Chiamato da

- `ChannelService.manageSubscription(channelId)`

### Metodo e path

- PUT `/channels/{channelId}/subscription`

### API backend suggerita

- `ChannelsV1Controller.ManageChannelSubscription`

---

## GET /v1/channels/favorites — CHL-07

### Chiamato da

- `ChannelService.getFavorites()`

### Metodo e path

- GET `/channels/favorites`

### API backend suggerita

- `ChannelsV1Controller.FindFavorites`

---

## GET /v1/channels/public/{publicId} — CHL-10

### Chiamato da

- `ChannelService.getPublicChannel(publicId)`

### Metodo e path

- GET `/channels/public/{publicId}`

### API backend suggerita

- `ChannelsV1Controller.GetByPublicId`

---

## GET /v1/channels/public/search — CHL-11

### Chiamato da

- `ChannelService.findChannels(search, page)`

### Metodo e path

- GET `/channels/public/search?textToSearch={search}&page={page}&pageSize=20`

### API backend suggerita

- `ChannelsV1Controller.FindChannels`

---

## GET /v1/channels/{channelId}/users — CHL-USR-01

### Chiamato da

- `ChannelUserService.getUsers(channelId)`

### Metodo e path

- GET `/channels/{channelId}/users`

### API backend suggerita

- `ChannelUsersV1Controller.GetUsers`

---

## POST /v1/channels/{channelId}/users — CHL-USR-02

### Chiamato da

- `ChannelUserService.addUser(channelId, email)`

### Metodo e path

- POST `/channels/{channelId}/users`

### API backend suggerita

- `ChannelUsersV1Controller.AddUser`

---

## DELETE /v1/channels/{channelId}/users/{userId} — CHL-USR-03

### Chiamato da

- `ChannelUserService.deleteUser(channelId, userId)`

### Metodo e path

- DELETE `/channels/{channelId}/users/{userId}`

### API backend suggerita

- `ChannelUsersV1Controller.DeleteUser`

---

## GET /v1/channels/{channelId}/matches — MTC-01

### Chiamato da

- `MatchService.getMatches(channelId)`

### Metodo e path

- GET `/channels/{channelId}/matches`

### API backend suggerita

- `MatchesV1Controller.GetMatchesByChannel`

---

## GET /v1/matches/{matchId} — MTC-02

### Chiamato da

- `MatchService.getMatch(matchId)`

### API backend suggerita

- `MatchesV1Controller.GetMatchById`

---

## POST /v1/channels/{channelId}/matches — MTC-03

### Chiamato da

- `MatchService.addMatch(channelId, match)`

### API backend suggerita

- `MatchesV1Controller.AddMatch`

---

## PUT /v1/matches/{matchId}/stats — MTC-04

### Chiamato da

- `MatchService.updateStats(matchId, matchStats)`

### API backend suggerita

- `MatchesV1Controller.UpdateMatchStats`

---

## POST /v1/matches/{matchId}/events — EVT-03

### Chiamato da

- `MatchService.addEvent(matchId, event)`

### API backend suggerita

- `MatchEventsV1Controllers.AddEvent`

---

## DELETE /v1/matches/{matchId}/events/{eventId} — EVT-04

### Chiamato da

- `MatchService.deleteEvent(matchId, eventId)`

### API backend suggerita

- `MatchEventsV1Controllers.DeleteEvent`

---

## POST /v1/matches/{matchId}/reactions — MTC-05

### Chiamato da

- `MatchService.addReaction(matchId, eventId, reactionType)`

### API backend suggerita

- `MatchesV1Controller.AddReaction`

---

## POST /v1/matches/{matchId}/comments — MTC-06

### Chiamato da

- `MatchService.addComment(matchId, eventId, message)`

### API backend suggerita

- `MatchesV1Controller.AddComment`

---

## DELETE /v1/matches/{matchId}/comments/{commentId} — MTC-07

### Chiamato da

- `MatchService.deleteComment(matchId, commentId)`

### API backend suggerita

- `MatchesV1Controller.DeleteComment`

---

## PUT /v1/matches/{matchId}/status — MTC-08

### Chiamato da

- `MatchService.updateStatus(matchId, status)`

### API backend suggerita

- `MatchesV1Controller.UpdateStatus`

---

## PUT /v1/channels/{channelId}/matches/{matchId} — MTC-09

### Chiamato da

- `MatchService.updateMatch(channelId, matchId, match)`

### API backend suggerita

- `MatchesV1Controller.UpdateMatch`

---

## GET /v1/channels/{channelId}/matches/search — MTC-10

### Chiamato da

- `MatchService.findMatchesByChannel(channelId, page)`

### API backend suggerita

- `MatchesV1Controller.SearchByChannel`

---

## GET /v1/matches/public/search — MTC-11

### Chiamato da

- `MatchService.findMatches(search, page, status)`

### API backend suggerita

- `MatchesV1Controller.FindChannels`

---

## POST /v1/matches/{matchId}/players/{lineupPlayerId}/rate — MTC-12

### Chiamato da

- `MatchService.ratePlayer(matchId, lineupPlayerId)`

### API backend suggerita

- `MatchesV1Controller.SaveRates`

---

## PUT /v1/matches/{matchId}/like — MTC-13

### Chiamato da

- `MatchService.likeMatch(matchId)`

### API backend suggerita

- `MatchesV1Controller.SaveLike`

---

## GET /v1/matches/ongoing — MTC-14

### Chiamato da

- `MatchService.getOnGoingMatches()`

### API backend suggerita

- `MatchesV1Controller.GetOnGoingMatch`

---

## PUT /v1/matches/{matchId}/follow — MTC-15

### Chiamato da

- `MatchService.manageFollow(matchId)`

### API backend suggerita

- `MatchesV1Controller.ManageFollow`

---

## POST /v1/matches/{matchId}/notification — MTC-16

### Chiamato da

- `MatchService.sendNotification(matchId)`

### API backend suggerita

- `MatchesV1Controller.SendNotification`

---

## POST /v1/matches — MTC-17

### Chiamato da

- `MatchService.addQuickMatch(match)`

### API backend suggerita

- `MatchesV1Controller.AddMatchQuick`

---

## GET /v1/teams/{teamId}/matches/search — MTC-18

### Chiamato da

- `MatchService.findMatchesByTeam(teamId, page)`

### API backend suggerita

- `MatchesV1Controller.GetMatchesByTeam`

---

## GET /v1/channels/matches/training — MTC-19

### Chiamato da

- `MatchService.getTrainingMatch()`

### API backend suggerita

- `MatchesV1Controller.GetTrainingMatchByCurrentUser`

---

## GET/POST/PUT/DELETE /v1/channels/{channelId}/teams/{teamId}/players — PYR-01/03/04/05

### Chiamato da

- `PlayerService.getPlayers`, `addPlayer`, `updatePlayer`, `deletePlayer`

### API backend suggerita

- `PlayersV1Controller`

---

## GET/POST/PUT /v1/channels/{channelId}/matches/{matchId}/lineups/{lineupId} — LNP-04/05/06

### Chiamato da

- `LineupService.updateLineup`, `addLineup`, `removeLineup`

### API backend suggerita

- `MatchLineupsV1Controller`

---

## GET /v1/blog e GET /v1/blog/matches/{matchId} — BLOG-01/02

### Chiamato da

- `BlogService.getBlogs`, `getMatchBlog`

### API backend suggerita

- `BlogV1Controller`

---

## GET /v1/stats/ — STS-01

### Chiamato da

- `StatsService.getStats()`

### API backend suggerita

- `StatsV1Controller.GetStats`

---

## GET /v1/voices e GET /v1/voices/events — VOICE-01/02

### Chiamato da

- `VoiceService.getVoice`, `getVoiceEvent`

### API backend suggerita

- `VoicesV1Controller`

---

## Auth endpoints — ATH-01/03/04/05/06 e USR-01/02/03/04/05/06/07

### Chiamato da

- `UserService.*`

### API backend suggerita

- `AuthV1Controller`, `UserV1Controller`

---

## Candidati esclusi o incerti

---

## AuthInterceptor

### Motivo

Interceptor HTTP Angular, non un service applicativo. Aggiunge automaticamente `Authorization: Bearer {token}`, `X-USER-LANGUAGE`, `X-COMMENTARY-LANGUAGE` a ogni richiesta verso `environment.apiUrl`. Non ha metodi pubblici invocati da componenti.

### File sorgente

- `src/RugbyRadioWeb/src/app/interceptors/auth.interceptor.ts`

---

## Note finali

- Limiti dell'analisi: i consumer dettagliati di ogni servizio non sono stati verificati in modo esaustivo (solo quelli più evidenti dal component-map precedente); la configurazione Firebase (`firebase.config.ts`) non è stata letta.
- Elementi non deducibili: URL di produzione (`environment.prod.ts` non letto); comportamento esatto del `canActivate` in caso di utente non autenticato (non redirige automaticamente, comportamento dipendente da configurazione router non analizzata nel dettaglio).
- Possibili approfondimenti: lettura `app.config.ts` per verifica configurazione interceptor; analisi `firebase.config.ts` per setup Firebase; analisi componenti `user/match/*` e `user/channel/*` per consumer aggiuntivi.
- Wiki non modificata: confermato.
