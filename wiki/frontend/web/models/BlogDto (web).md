---
title: "blogDto (web)"
type: frontend-model
layer: frontend
---

# blogDto (web)

## Sintesi
DTO di risposta per il post blog associato a una partita. Contiene titolo, corpo del post e un riferimento ridotto alla partita per il contesto.

## Proprietà
| Proprietà | Tipo | Descrizione |
|-----------|------|-------------|
| title | string | Titolo del post blog |
| body | string | Corpo del post blog (HTML o markdown) |
| match | matchBlogDto | Dati ridotti della partita associata al blog |

## Origine dati
- API: BLOG-01 (GET post blog per partita), BLOG-02 (GET lista post blog)

## Consumer FE
- [[GMatchPage (web)]]
- [[MatchPage (web)]]
- [[MatchEventsComponent (web)]]

## API correlate
- BLOG-01: GET post blog associato a una partita specifica
- BLOG-02: GET lista post blog

## Note
- `matchBlogDto` è una versione ulteriormente ridotta di matchDto contenente solo i dati necessari per contestualizzare il blog post.
- Il campo `body` potrebbe contenere HTML o markdown in base alla configurazione dell'API.
- Il blog è opzionale: non tutte le partite hanno un post blog associato.
