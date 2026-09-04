---
title: "SeoMetadataService (web)"
type: frontend-service
layer: frontend
---

# SeoMetadataService (web)

## Sintesi

Servizio frontend Angular per aggiornare metadata SEO runtime nel documento: title, meta description, canonical, Open Graph, Twitter card e structured data JSON-LD.

## Responsabilità

- Aggiorna `document.title` tramite `Title`.
- Aggiunge, aggiorna o rimuove meta tag tramite `Meta`.
- Gestisce canonical link nel `document.head`.
- Inserisce e rimuove script JSON-LD `application/ld+json`.

## Consumer FE

- [[HomePage (web)]]
- [[GChannelPage (web)]]
- [[GMatchPage (web)]]
- [[GTeamPage (web)]]
- [[GChannelsPage (web)]]
- [[GMatchesPage (web)]]
- [[GStatsPage (web)]]

## API chiamate

Non deducibile. Il servizio non effettua chiamate HTTP nel RAW letto.

## DTO o modelli usati

- [[SeoMetadataModel (web)]]
- [[SeoStructuredDataModel (web)]]

## Side effects

- Aggiornamento DOM/head del documento frontend.
- Rimozione canonical quando `canonicalUrl` non è valorizzato.
- Rimozione structured data esistenti prima di inserire nuovi script JSON-LD.

## Implementazione

- Usa `Title` e `Meta` da `@angular/platform-browser`.
- Usa `DOCUMENT` per canonical e structured data.
- Supporta `SeoMetadataModel` per metadata pagine e `SeoStructuredDataModel` per JSON-LD.

## Dettaglio consumer per metadata

| Consumer | Metadata impostati |
|---|---|
| [[HomePage (web)]] | title, description, canonical `/`, image, type website |
| [[GMatchPage (web)]] | title (squadre+score), description, canonical `/g-match/{id}`, JSON-LD `SportsEvent` |
| [[GChannelPage (web)]] | title (nome canale), description, canonical `/g-channel/{id}`, JSON-LD `SportsOrganization` |
| [[GTeamPage (web)]] | title (nome team), description, canonical `/g-team/{id}`, JSON-LD `SportsTeam` |
| [[GMatchesPage (web)]] | title, description, canonical `/g-matches` |
| [[GChannelsPage (web)]] | title, description, canonical `/g-channels` |
| [[GStatsPage (web)]] | title, description, canonical `/g-stats` |

## Note

Fonti: `llm-wiki/raw/frontend/web/service-map-20260519.md`, `llm-wiki/raw/dev/seo-20260519.md`. Il servizio vive in `src/RugbyRadioWeb/src/app/services/seo-metadata.service.ts`.
