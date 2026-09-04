---
title: "IconComponent (web)"
type: frontend-component
layer: frontend
---

# IconComponent (web)

## Sintesi
Componente atomico per la visualizzazione di icone SVG inline. Carica gli SVG da una mappa ICONS interna e li sanitizza tramite DomSanitizer di Angular. Usato trasversalmente in tutta l'app.

## Responsabilità
- Recuperare l'SVG corrispondente al nome fornito dalla mappa ICONS
- Sanitizzare il markup SVG tramite DomSanitizer per la sicurezza XSS
- Renderizzare l'SVG inline con la dimensione configurabile

## Parent pages
Usato in tutti i componenti dell'app (nessun parent limitato).

## Child components
Nessuno.

## Servizi FE usati
Nessuno (usa DomSanitizer di Angular, non un servizio applicativo).

## Modelli FE usati
Nessuno.

## Eventi input/output
| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | name | string | Nome dell'icona da cercare nella mappa ICONS |
| Input | size | number | Dimensione in pixel dell'icona (default: 24) |

## Note
- Nessun output emesso: componente puramente visualizzativo.
- La mappa ICONS è una costante interna che associa nome → markup SVG.
- Se il nome non è presente nella mappa, il componente non renderizza nulla o mostra un fallback.
- La sanitizzazione tramite DomSanitizer è necessaria per rendere sicuro il rendering di HTML/SVG inline.
