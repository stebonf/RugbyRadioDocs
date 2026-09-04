# Frontend Component Map RAW

## Sintesi

- Data analisi: 2026-05-19
- Root frontend analizzata: `src/RugbyRadioWeb`
- Filtro applicato: soli file frontend modificati dopo il 2026-05-14
- File output: `llm-wiki/raw/frontend/web/component-map-20260519.md`
- Componenti trovati: 0
- Componenti page-level esclusi: 7
- Input/props trovati: 0
- Output/eventi trovati: 0
- Asset collegati: 0
- Candidati esclusi o incerti: 19

## Criteri usati

- Sono stati considerati solo file frontend modificati dopo il 2026-05-14.
- I componenti dichiarati direttamente in `app.routes.ts` come `component:` sono stati classificati come page-level e quindi esclusi dal censimento componenti riusabili.
- Service, configurazioni, static HTML, sitemap e robots sono stati separati negli esclusi perché non sono componenti UI.
- Non sono stati letti file in `llm-wiki/wiki/` o `llm-wiki/artifacts/`.

## File frontend modificati analizzati

- `src/RugbyRadioWeb/angular.json`
- `src/RugbyRadioWeb/src/app/environments/environment.prod.ts`
- `src/RugbyRadioWeb/src/app/global/g-channel/g-channel.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-channels/g-channels.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-matches/g-matches.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-stats/g-stats.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-team/g-team.component.ts`
- `src/RugbyRadioWeb/src/app/services/seo-metadata.service.ts`
- `src/RugbyRadioWeb/src/app/site/home/home.component.ts`
- `src/RugbyRadioWeb/src/assets/static/ai-talkers.html`
- `src/RugbyRadioWeb/src/assets/static/how-to.html`
- `src/RugbyRadioWeb/src/assets/static/news.html`
- `src/RugbyRadioWeb/src/assets/static/terms.html`
- `src/RugbyRadioWeb/src/assets/static/tutorial.html`
- `src/RugbyRadioWeb/src/assets/static/why.html`
- `src/RugbyRadioWeb/src/index.html`
- `src/RugbyRadioWeb/src/robots.txt`
- `src/RugbyRadioWeb/src/sitemap.xml`

## Componenti frontend

Nessun componente UI non page-level modificato dopo il 2026-05-14 e verificabile nel perimetro analizzato.

## Candidati esclusi o incerti

## GChannelComponent

### Motivo

- Pagina route-level

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-channel/g-channel.component.ts`

### Evidenza

- `app.routes.ts` associa `GChannelComponent` alla route `g-channel/:channelPublicId`.
- Il decorator dichiara `selector: 'app-g-channel'`, `templateUrl: './g-channel.component.html'`, `styleUrl: './g-channel.component.css'`.

## GChannelsComponent

### Motivo

- Pagina route-level

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-channels/g-channels.component.ts`

### Evidenza

- `app.routes.ts` associa `GChannelsComponent` alla route `g-channels`.
- Il decorator dichiara `selector: 'app-g-channels'`, `templateUrl: './g-channels.component.html'`, `styleUrl: './g-channels.component.css'`.

## GMatchComponent

### Motivo

- Pagina route-level

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.ts`

### Evidenza

- `app.routes.ts` associa `GMatchComponent` alla route `g-match/:matchId`.
- Il decorator dichiara `selector: 'app-g-match'`, `templateUrl: './g-match.component.html'`, `styleUrl: './g-match.component.css'`.

## GMatchesComponent

### Motivo

- Pagina route-level

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-matches/g-matches.component.ts`

### Evidenza

- `app.routes.ts` associa `GMatchesComponent` alla route `g-matches`.
- Il decorator dichiara `selector: 'app-g-matches'`, `templateUrl: './g-matches.component.html'`, `styleUrl: './g-matches.component.css'`.

## GStatsComponent

### Motivo

- Pagina route-level

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-stats/g-stats.component.ts`

### Evidenza

- `app.routes.ts` associa `GStatsComponent` alla route `g-stats`.
- Il decorator dichiara `selector: 'app-g-stats'`, `templateUrl: './g-stats.component.html'`, `styleUrl: './g-stats.component.css'`.

## GTeamComponent

### Motivo

- Pagina route-level

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-team/g-team.component.ts`

### Evidenza

- `app.routes.ts` associa `GTeamComponent` alla route `g-team/:teamId`.
- Il decorator dichiara `selector: 'app-g-team'`, `templateUrl: './g-team.component.html'`, `styleUrl: './g-team.component.css'`.

## HomeComponent

### Motivo

- Pagina route-level

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home.component.ts`

### Evidenza

- `app.routes.ts` associa `HomeComponent` alla route vuota `''`.
- `app.routes.ts` associa `HomeComponent` anche alla route `user-dashboard` con `canActivate: [AuthGuardService]`.
- Il decorator dichiara `selector: 'app-home'`, `templateUrl: './home.component.html'`, `styleUrl: './home.component.css'`.

## SeoMetadataService

### Motivo

- Service layer frontend
- Non componente UI

### File sorgente

- `src/RugbyRadioWeb/src/app/services/seo-metadata.service.ts`

## AngularJson

### Motivo

- Configurazione build Angular
- Non componente UI

### File sorgente

- `src/RugbyRadioWeb/angular.json`

## EnvironmentProd

### Motivo

- Configurazione environment frontend
- Non componente UI

### File sorgente

- `src/RugbyRadioWeb/src/app/environments/environment.prod.ts`

## StaticPageAiTalkers

### Motivo

- Static HTML asset
- Non componente Angular

### File sorgente

- `src/RugbyRadioWeb/src/assets/static/ai-talkers.html`

## StaticPageHowTo

### Motivo

- Static HTML asset
- Non componente Angular

### File sorgente

- `src/RugbyRadioWeb/src/assets/static/how-to.html`

## StaticPageNews

### Motivo

- Static HTML asset
- Non componente Angular

### File sorgente

- `src/RugbyRadioWeb/src/assets/static/news.html`

## StaticPageTerms

### Motivo

- Static HTML asset
- Non componente Angular

### File sorgente

- `src/RugbyRadioWeb/src/assets/static/terms.html`

## StaticPageTutorial

### Motivo

- Static HTML asset
- Non componente Angular

### File sorgente

- `src/RugbyRadioWeb/src/assets/static/tutorial.html`

## StaticPageWhy

### Motivo

- Static HTML asset
- Non componente Angular

### File sorgente

- `src/RugbyRadioWeb/src/assets/static/why.html`

## IndexHtml

### Motivo

- Entry HTML applicativa
- Non componente Angular

### File sorgente

- `src/RugbyRadioWeb/src/index.html`

## RobotsTxt

### Motivo

- File SEO/statico
- Non componente UI

### File sorgente

- `src/RugbyRadioWeb/src/robots.txt`

## SitemapXml

### Motivo

- File SEO/statico
- Non componente UI

### File sorgente

- `src/RugbyRadioWeb/src/sitemap.xml`

## Note finali

- Limiti dell'analisi:
  - L'analisi e limitata ai soli file modificati dopo il 2026-05-14.
  - I componenti child importati dalle page-level modificate non sono stati censiti se il loro file sorgente non risulta modificato nel periodo.
  - Template e stili collegati alle page-level escluse non sono stati analizzati in dettaglio perché il prompt esclude pagine route-level.
- Elementi non deducibili:
  - Eventuali cambiamenti indiretti su componenti child non modificati.
  - Input/output di componenti non modificati ma importati dalle page-level.
  - Asset usati dai componenti non page-level fuori dal filtro temporale.
- Possibili approfondimenti:
  - Eseguire helper senza filtro temporale per censire tutti i componenti UI riusabili.
- Conferma:
  - Nessun file in `llm-wiki/wiki/` e stato creato o modificato.
