---
title: "SeoMetadataModel (web)"
type: frontend-model
layer: frontend
---

# SeoMetadataModel (web)

## Sintesi

Interface frontend usata da [[SeoMetadataService (web)]] per descrivere metadata SEO e social della pagina corrente.

## Proprietà

- `title` (`string`) - obbligatoria; titolo pagina.
- `description` (`string`) - opzionale; meta description e descrizione social.
- `canonicalUrl` (`string`) - opzionale; URL canonical.
- `imageUrl` (`string`) - opzionale; immagine Open Graph/Twitter.
- `type` (`string`) - opzionale; tipo Open Graph, fallback `website`.
- `siteName` (`string`) - opzionale; site name, fallback `Rugby Radio Live`.
- `locale` (`string`) - opzionale; locale Open Graph.
- `twitterCard` (`'summary' | 'summary_large_image'`) - opzionale; tipo Twitter card.
- `structuredData` (`SeoStructuredData | SeoStructuredData[]`) - opzionale; JSON-LD.

## Origine dati

Componente o pagina frontend.

## Consumer FE

- [[SeoMetadataService (web)]]
- [[HomePage (web)]]
- [[GChannelPage (web)]]
- [[GMatchPage (web)]]
- [[GTeamPage (web)]]
- [[GChannelsPage (web)]]
- [[GMatchesPage (web)]]
- [[GStatsPage (web)]]

## API correlate

Non deducibile.

## Note

Fonte: `llm-wiki/raw/frontend/web/model-map-20260519.md`.
