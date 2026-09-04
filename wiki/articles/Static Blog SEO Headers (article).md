---
title: "Static Blog SEO Headers (article)"
type: article
layer: articles
---

# Static Blog SEO Headers (article)

## Sintesi
Descrive gli header SEO delle pagine HTML statiche del blog generate da un job Hangfire.

## Scope
Pagine statiche:
- root blog `index.html`
- indice lingua `{language}/index.html`
- pagina partita `{language}/{matchId}.html`

## Componenti coinvolti
- [[CreateMatchBlogHtmlJob (api)]]
- [[Blog (api)]]
- [[BlogV1Controller (api)]]

## Relazioni principali
- Il blog statico usa canonical URL.
- Il blog statico usa alternate hreflang per `en`, `it`, `fr`, `es`, `ja` e `x-default`.
- Le pagine partita includono metadati Open Graph e Twitter card.
- Le pagine partita hanno `og:type` article.
- Workflow correlato: [[Pubblicazione Blog Statico (workflow)]].

## Decisioni architetturali
Gli header SEO sono prodotti dal job che genera le pagine HTML statiche.

## Rischi
Non deducibile dai RAW.

## Note
Fonte: `Header Pagine Blog.md`.

