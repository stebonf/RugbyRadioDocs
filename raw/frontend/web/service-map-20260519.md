# Frontend Service Map RAW

## Sintesi

- Data analisi: 2026-05-19
- Root frontend analizzata: `src/RugbyRadioWeb`
- Filtro applicato: soli file frontend modificati dopo il 2026-05-14
- File output: `llm-wiki/raw/frontend/web/service-map-20260519.md`
- servizi frontend trovati: 1
- API client FE trovati: 0
- Metodi pubblici significativi trovati: 2
- Endpoint backend deducibili: 0
- Consumer FE deducibili: 7
- Candidati esclusi o incerti: 18

## Criteri usati

- Sono stati inclusi solo service class modificati dopo il 2026-05-14.
- Consumer FE deducibili: solo pagine/componenti con import o injection diretta di `SeoMetadataService`.
- Endpoint backend dichiarati solo se supportati da chiamate HTTP nel service modificato.
- Non sono stati letti file in `llm-wiki/wiki/` o `llm-wiki/artifacts/`.

## File frontend modificati analizzati

- `src/RugbyRadioWeb/src/app/services/seo-metadata.service.ts`
- `src/RugbyRadioWeb/src/app/environments/environment.prod.ts`
- `src/RugbyRadioWeb/src/app/global/g-channel/g-channel.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-channels/g-channels.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-matches/g-matches.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-stats/g-stats.component.ts`
- `src/RugbyRadioWeb/src/app/global/g-team/g-team.component.ts`
- `src/RugbyRadioWeb/src/app/site/home/home.component.ts`

## Servizi frontend

## SeoMetadataService

### Nome nel codice

`SeoMetadataService`

### Nome wiki suggerito

`SeoMetadataService`

### File sorgente

- `src/RugbyRadioWeb/src/app/services/seo-metadata.service.ts`

### Tipo

Service

### Responsabilita

Aggiorna metadata SEO nel documento frontend: title, meta description, canonical link, Open Graph, Twitter card e structured data JSON-LD.

### Consumer FE

- `HomeComponent` - evidenza: injection e `seoMetadataService.update(...)`.
- `GChannelComponent` - evidenza: injection e `seoMetadataService.update(...)`.
- `GMatchComponent` - evidenza: injection e `seoMetadataService.update(...)`.
- `GTeamComponent` - evidenza: injection e `seoMetadataService.update(...)`.
- `GChannelsComponent` - evidenza: injection e `seoMetadataService.update(...)`.
- `GMatchesComponent` - evidenza: injection e `seoMetadataService.update(...)`.
- `GStatsComponent` - evidenza: injection e `seoMetadataService.update(...)`.

### Configurazioni usate

- `DOCUMENT` - token Angular usato per accedere a `document.head`, canonical link e script JSON-LD.
- `Title` - servizio Angular per aggiornare il titolo pagina.
- `Meta` - servizio Angular per leggere, aggiungere e aggiornare meta tag.

### Metodi pubblici significativi

#### update(metadata)

- Input:
  - `metadata` (`SeoMetadata`)
- Output:
  - `void`
- API chiamate:
  - Metodo HTTP: non deducibile
  - Path/URL: `Non deducibile`
  - API wiki suggerita: `Non deducibile`
- DTO o modelli usati:
  - `SeoMetadata`
  - `SeoStructuredData`
- Side effects:
  - aggiornamento stato FE/DOM
  - modifica `document.title`
  - creazione/aggiornamento/rimozione meta tag
  - creazione/aggiornamento/rimozione canonical link
  - creazione/rimozione script JSON-LD
- Errori / casi limite:
  - `title` viene normalizzato con `trim()`.
  - se `canonicalUrl` non e valorizzato, canonical esistente viene rimosso.
  - se `structuredData` non e valorizzato, gli script structured data esistenti vengono rimossi.
  - se `imageUrl` non e valorizzato, `twitterCard` usa fallback `summary`.
- Note di confidenza:
  - Verificato dal codice

#### clearStructuredData()

- Input:
  - Nessuno
- Output:
  - `void`
- API chiamate:
  - Metodo HTTP: non deducibile
  - Path/URL: `Non deducibile`
  - API wiki suggerita: `Non deducibile`
- DTO o modelli usati:
  - Nessuno deducibile
- Side effects:
  - aggiornamento stato FE/DOM
  - rimozione script `script[data-rrl-seo="structured-data"]`
- Errori / casi limite:
  - Se non esistono script structured data, non viene rimosso nulla.
- Note di confidenza:
  - Verificato dal codice

## Endpoint backend rilevati

Nessun endpoint backend deducibile dal service frontend modificato dopo il 2026-05-14.

## Configurazioni endpoint rilevate ma non usate dal service modificato

## EnvironmentProd

### Motivo

- Configurazione environment frontend modificata nel periodo.
- Non e usata direttamente da `SeoMetadataService`.
- Non viene classificata come endpoint backend chiamato dal service censito.

### File sorgente

- `src/RugbyRadioWeb/src/app/environments/environment.prod.ts`

### Configurazioni visibili

- `apiUrl` - base URL API frontend production, non usato dal service censito.
- `audioUrl` - base URL storage audio, non usato dal service censito.
- `storageUrl` - base URL storage, non usato dal service censito.
- `googleClientId` - configurazione Google, valore non riportato.
- `firebaseConfig` - configurazione Firebase, valori non riportati.

## Candidati esclusi o incerti

## AngularJson

### Motivo

- Configurazione build, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/angular.json`

## GChannelComponent

### Motivo

- Componente/pagina, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-channel/g-channel.component.ts`

## GChannelsComponent

### Motivo

- Componente/pagina, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-channels/g-channels.component.ts`

## GMatchComponent

### Motivo

- Componente/pagina, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-match/g-match.component.ts`

## GMatchesComponent

### Motivo

- Componente/pagina, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-matches/g-matches.component.ts`

## GStatsComponent

### Motivo

- Componente/pagina, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-stats/g-stats.component.ts`

## GTeamComponent

### Motivo

- Componente/pagina, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/app/global/g-team/g-team.component.ts`

## HomeComponent

### Motivo

- Componente/pagina, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/app/site/home/home.component.ts`

## StaticAiTalkers

### Motivo

- Static HTML asset, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/assets/static/ai-talkers.html`

## StaticHowTo

### Motivo

- Static HTML asset, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/assets/static/how-to.html`

## StaticNews

### Motivo

- Static HTML asset, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/assets/static/news.html`

## StaticTerms

### Motivo

- Static HTML asset, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/assets/static/terms.html`

## StaticTutorial

### Motivo

- Static HTML asset, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/assets/static/tutorial.html`

## StaticWhy

### Motivo

- Static HTML asset, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/assets/static/why.html`

## IndexHtml

### Motivo

- Entrypoint HTML applicativo, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/index.html`

## RobotsTxt

### Motivo

- File statico SEO, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/robots.txt`

## SitemapXml

### Motivo

- File statico SEO, non servizio FE.

### File sorgente

- `src/RugbyRadioWeb/src/sitemap.xml`

## SeoMetadataTypes

### Motivo

- Model/type alias associati al service, non servizio autonomo.

### File sorgente

- `src/RugbyRadioWeb/src/app/services/seo-metadata.service.ts`

## Note finali

- Limiti dell'analisi:
  - L'analisi e limitata ai soli file modificati dopo il 2026-05-14.
  - Gli altri service frontend usati dalle pagine modificate non sono stati censiti se non modificati nel periodo.
  - `environment.prod.ts` contiene configurazioni endpoint, ma non e usato direttamente dal service censito.
- Elementi non deducibili:
  - Endpoint backend effettivi degli altri service FE non modificati.
  - Consumer fuori filtro temporale non cercati in profondita.
  - Eventuali side effects indiretti di componenti consumer.
- Possibili approfondimenti:
  - Eseguire helper senza filtro temporale per mappa completa dei service FE e relativi endpoint backend.
- Conferma:
  - Nessun file in `llm-wiki/wiki/` e stato creato o modificato.
