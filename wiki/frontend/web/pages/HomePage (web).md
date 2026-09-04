---
title: "HomePage (web)"
type: frontend-page
layer: frontend
---

# HomePage (web)

## Sintesi

Home page e dashboard utente. Pubblica: splash onboarding, marketing, caroselli partite/canali. Utente loggato: profilo, statistiche, partite in corso.

## Route

`/` (pubblica), `/user-dashboard` (AuthGuardService)

## Responsabilità

Gestisce due contesti distinti: per utenti anonimi mostra splash onboarding, contenuti marketing e caroselli di partite/canali; per utenti autenticati mostra profilo, statistiche personali e partite in corso.

## Componenti usati

- HomeSplashComponent (web)
- HomeLogoComponent (web)
- HomeNextMatchesComponent (web)
- HomeLastMatchesComponent (web)
- HomeLastChannelsComponent (web)
- HomeOngoingMatchesComponent (web)
- HomeUserComponent (web)
- [[EntityAdsComponent (web)]]

## Servizi FE usati

- [[UserService (web)]]
- [[PlatformService (web)]]
- [[BusService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- [[userTokenDto (web)]]

## API dipendenti

- [[ChannelsV1Controller (api)]]
- [[MatchesV1Controller (api)]]

## Workflow correlati

Non deducibile

## Stati UI

- Splash visible/hidden
- Utente loggato/anonimo
- isTwa
- isMobile

## Note

La route `/user-dashboard` è protetta da AuthGuardService; la route `/` è pubblica e adatta a TWA e mobile.

