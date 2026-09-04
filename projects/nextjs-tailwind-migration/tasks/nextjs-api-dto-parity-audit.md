---
type: task-evidence
created: 2026-07-24T12:30:12+02:00
source: tasklist-nextjs-tailwind-migration
topic: "Audit parita API/DTO Next.js"
slug: nextjs-api-dto-parity-audit
tasks:
  - NXT-T007
---

# Audit parita API/DTO Next.js

## Scopo

Verificare la copertura del layer `src/RugbyRadioWebNext/lib/api` rispetto ai service Angular in `src/RugbyRadioWeb/src/app/services`, con focus su endpoint, DTO di ritorno e campi necessari alle route Next migrate.

## Service Angular verificati

| Service Angular | Endpoint/funzioni principali | Stato Next |
|---|---|---|
| `ChannelService` | `CHL-01..07`, `CHL-10`, `CHL-11` | Coperti in `lib/api/channels.ts` e `lib/api/public-data.ts`. |
| `MatchService` | `MTC-01..19`, `EVT-03`, `EVT-04` | Coperti in `lib/api/matches.ts`, `lib/api/public-data.ts` e `lib/api/lineups.ts`. |
| `TeamService` | `TMS-01..06` | Coperti in `lib/api/teams.ts` e `lib/api/public-data.ts`. |
| `PlayerService` | `PYR-01`, `PYR-03..05` | Coperti in `lib/api/players.ts`. |
| `LineupService` | `LNP-04..06` | Coperti in `lib/api/lineups.ts`. |
| `BlogService` | `BLOG-01`, `BLOG-02` | Coperti in `lib/api/blog.ts`. |
| `StatsService` | `STS-01` | Coperto in `lib/api/stats.ts`. |
| `VoiceService` | `VOICE-01`, `VOICE-02` | Coperti in `lib/api/voice.ts`. |
| `UserService` | `ATH-01`, `ATH-03..06`, `USR-01..07`, `USR-05` | Coperti in `lib/api/user.ts` e helper notifiche client. |

## Correzioni DTO applicate

- Aggiunto `ChannelPublicMinDto` con `idFull`, `headerBgColor` e `headerFtColor`, allineato al `channelPublicMinDto` Angular usato nel `matchDto` completo.
- Esteso `ChannelMinDto` con `owner?: UserMinDto`, allineato al DTO Angular usato nei match minimi pubblici.
- Aggiunto `MatchChannelDto`, allineato a `matchChannelDto` Angular per `/channels/{channelId}/matches` e `/channels/matches/training`.
- Aggiunti `MatchScoreboardDto`, `MatchScoreboardItemDto` e `MatchScoreboardTimelineItemDto`, allineati ai DTO Angular `matchScoreboardDto`.
- Aggiunti `comments?: MatchCommentDto[]` e `scoreboard?: MatchScoreboardDto` a `MatchDto`.
- Aggiornato `MatchDto` con `channel?: ChannelPublicMinDto | ChannelMinDto`, usando `Omit<MatchMinDto, "channel">` per distinguere correttamente match completo e match minimo.
- Aggiornate le firme `getChannelMatches()` e `getTrainingMatch()` in `lib/api/matches.ts` per restituire `MatchChannelDto`.
- Aggiornati i consumatori `ChannelManagementPanel` e `AccountDashboardPanel` per usare `MatchChannelDto` dove il backend restituisce liste/training match.
- La route `/matches/[matchId]` ora ricava il link canale SEO da `publicId` o da `idFull`, compatibile sia con payload minimi sia con il DTO Angular completo.

## Validazione

- `.\node_modules\.bin\next.cmd build` da `src/RugbyRadioWebNext`: passata, 47 pagine generate.
- `node scripts\smoke-http.mjs` con `SMOKE_PORT=3180`: passato, route/redirect/PWA/maintenance validati su porte 3180/3181.
- Scan statico `rg "TODO|console\.log|any|React\."` su `app`, `components`, `lib`, `types`, `middleware.ts` e service worker: nessun match.

## Residui

- L'audit statico conferma copertura endpoint e DTO principali, ma non sostituisce test con backend reale.
- Le risposte effettive Cloudflare/backend devono ancora validare payload deep di match, scoreboard, notifiche push e workflow autenticati.
