---
title: "SitemapXmlWriter (api)"
type: backend-service
layer: backend
---

# SitemapXmlWriter (api)

## Sintesi

Helper backend per generazione XML sitemap e sitemap index. Usato da [[GenerateSeoSitemapJob (api)]] per produrre output XML strutturato e validato.

## Responsabilità

- Genera `urlset` XML per URL pubbliche
- Genera `sitemapindex` XML
- Chunking a 50.000 URL per file sitemap
- `lastmod` in formato ISO
- `priority` limitata
- `changefreq` lowercase
- Emissione solo per URL canoniche e indicizzabili
- Escaping XML gestito da API XML

## Consumer

- [[GenerateSeoSitemapJob (api)]]

## Repository usati

Nessuno. Servizio helper senza accesso a repository.

## Integrazioni usate

Nessuna integrazione esterna diretta.

## Jobs usati

- [[GenerateSeoSitemapJob (api)]] — consumer principale

## Entities coinvolte

Nessuna entity coinvolta. Opera su URL inventory prodotto da [[SeoUrlInventoryService (api)]].

## Workflow correlati

- [[Pubblicazione Blog Statico (workflow)]]

## Side effects

- Scrittura di file XML sitemap su filesystem
- Generazione chunk multipli oltre 50.000 URL

## Note

Fonte: `llm-wiki/raw/dev/seo-20260519.md` (TASK-015). Implementato in `src/RugbyRadio/HF/Helpers/SitemapXmlWriter.cs` usando LINQ to XML.
