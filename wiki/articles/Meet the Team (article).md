---
title: "Meet the Team (article)"
type: article
layer: articles
---

# Meet the Team (article)

## Sintesi
Hub editoriale pubblico che sostituisce la pagina statica `ai-talkers.html` con una pagina Team dedicata a founder, AI-Talkers, identita del prodotto e contenuti indicizzabili.

## Scope
La pagina index pubblica usa URL canonico `/team`; le pagine dettaglio dei membri usano naming `/team-{slug}.html`. La prima release include founder e AI-Talkers gia presenti nella pagina statica attuale: Vox, Nitro, Beat Breaker, Orfeo, Zoe, Maul, Zorblax, Elixir, Bulldog, El Mangiapolenta, Trasteverino, Newsly e Brushy.

## Componenti coinvolti
- [[AI-Talker (concept)]]
- [[TTS Audio (concept)]]
- [[Telecronaca (concept)]]
- [[Static Blog SEO Headers (article)]]
- [[Public Sitemap (article)]]
- [[Monetizzazione (monetization)]]
- [[Google Analytics Traffic 2026-01 2026-06 (analytic)]]

## Relazioni principali
- La pagina Team spiega che gli AI-Talkers non sostituiscono il cronista, ma trasformano eventi partita in commenti con stile e persona.
- I link pubblici devono indirizzare verso matches, channels, tutorial, how-to e blog.
- La pagina `ai-talkers.html` non deve restare esperienza pubblica separata.
- Founder e AI-Talkers hanno pagine statiche dettaglio con bio, media, esempi editoriali e link correlati.

## Decisioni architetturali
La feature resta nel perimetro frontend/static content: non introduce nuove API, persistenza, job AI o logica realtime. L'implementazione architetturale e descritta in [[Meet the Team Static Pages (architecture)]].

## Rischi
- Placeholder founder da sostituire prima del rilascio produzione.
- Esempi di commentary editoriali da mantenere coerenti con il tono del singolo AI-Talker.
- `/ai-talkers` viene rimosso senza alias o redirect, quindi i link interni devono essere aggiornati.

## Note
Fonti: `llm-wiki/raw/analysis/analisi-funzionale-meet-team.md`, `llm-wiki/raw/analysis/architettura-meet-team.md`.
