---
title: "MatchRepository (api)"
type: backend-repository
layer: backend
---

# MatchRepository (api)

## Sintesi

Repository più complesso della piattaforma. Gestisce la persistenza delle partite con numerosi filtri, include multipli (team, eventi, formazioni, blog) e query aggregate. Usato anche dai job per ricerca partite da processare.

## Responsabilità

- CRUD partita con include `HomeTeam`, `AwayTeam`, `Channel`, `Events`, `LineupPlayers`, `Blogs`
- Ricerca partite per canale, data, stato, presenza blog, immagine
- Conteggio partite per canale
- `FindWithoutBlogAsync` — partite FullTime con meno di N post blog
- `FindByFilterIncludeAsync` — ricerca paginata con filtri multipli

## Entities gestite

- [[Match (api)]]

## Query rilevanti

- `GetByIdIncludeAsync(matchId)` — include tutte le navigazioni
- `FindByChannelByIdIncludeAsync(channelId)` — partite canale con include
- `FindByDateAsync(from, to)` — partite per finestra temporale
- `FindWithoutBlogAsync(maxBlogs)` — partite FullTime candidate per blog
- `FindAllAsync()` — tutte le partite (usato da job)

## Consumer

- [[MatchService (api)]]
- [[CreateMatchBlogJob (api)]]
- [[CreateMatchBlogHtmlJob (api)]]
- [[RepairMatchImageJob (api)]]
- [[AiOllamaService (api)]]

## Nome nel codice

`MatchRepository` — `src/RugbyRadio/Lib/Repositories/MatchBox/MatchRepository.cs`

## Note

Non deducibile
