---
title: "AppDbContext (api)"
type: data-schema
layer: data
---

# AppDbContext (api)

## Sintesi

DbContext principale dell'applicazione (Entity Framework Core). Espone tutti i `DbSet<T>` per le entity persistenti. Configura conversioni enum, compressione dei campi audit e mapping personalizzato in `OnModelCreating`.

## Struttura dati

DbSet esposti:

- `DbSet<User> Users`
- `DbSet<Channel> Channels`
- `DbSet<ChannelUser>` — mappato via navigation (non DbSet diretto esplicito)
- `DbSet<Team> Teams`
- `DbSet<Player> Players`
- `DbSet<Match> Matches`
- `DbSet<MatchEvent> MatchEvents` (tabella `Events`)
- `DbSet<LineupPlayer> LineupPlayers`
- `DbSet<Comment> Comments`
- `DbSet<EventReaction> EventReactions`
- `DbSet<Subscription> Subscriptions`
- `DbSet<LineupPlayerRate> LineupPlayerRates`
- `DbSet<MatchLike> MatchLikes`
- `DbSet<UserToken> UserTokens`
- `DbSet<Blog> Blog`
- `DbSet<UserOtpCode> UserOptCodes` (nota: typo `Opt` invece di `Otp`)
- `DbSet<Email> Emails`
- `DbSet<SystemMessage> SystemMessages`
- `DbSet<SystemMessageDraft> SystemMessageDrafts`
- `DbSet<Audit>` — configurata in `OnModelCreating`
- `DbSet<FakeAgentSetting> FakeAgentSettings`

Conversioni enum configurate in `OnModelCreating`:

- `Match.Status` (`MatchStatus`) → `HasConversion<int>()`
- `MatchEvent.Type` (`MatchEventType`) → `HasConversion<int>()`
- `MatchEvent.Territory` (`TerritoryType`) → `HasConversion<int>()`
- `Email.Status` (`EmailStatus`) → `HasConversion<int>()`

Campi `Audit.RequestSerialized` e `Audit.ResponseSerialized` compressi con `DbConfiguratorHelper.Zip/Unzip`.

## Entità correlate

- [[User (api)]], [[Channel (api)]], [[ChannelUser (api)]], [[Team (api)]], [[Player (api)]], [[Match (api)]], [[MatchEvent (api)]], [[LineupPlayer (api)]], [[Comment (api)]], [[EventReaction (api)]], [[Subscription (api)]], [[LineupPlayerRate (api)]], [[MatchLike (api)]], [[UserToken (api)]], [[Blog (api)]], [[UserOtpCode (api)]], [[Email (api)]], [[SystemMessage (api)]], [[SystemMessageDraft (api)]], [[Audit (api)]], [[FakeAgentSetting (api)]]

## Eventi correlati

Non deducibili

## Note

Connection string `App` per DB applicativo. Connection string `HF` separata per DB Hangfire.

## Nome nel codice

`AppDbContext` — `src/RugbyRadio/Lib/Core/AppDbContext.cs`
