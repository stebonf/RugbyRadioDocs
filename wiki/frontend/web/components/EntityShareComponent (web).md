---
title: "EntityShareComponent (web)"
type: frontend-component
layer: frontend
---

# EntityShareComponent (web)

## Sintesi

Componente riutilizzabile per la condivisione di contenuti (canali, partite, squadre) tramite copia link. Incluso come tab Share nelle pagine pubbliche e protette.

## Responsabilità

- Fornire interfaccia di condivisione per entita della piattaforma
- Copia del link della pagina corrente negli appunti
- Gestione stato di avvenuta copia

## Parent pages

- [[GChannelPage (web)]]
- [[GMatchPage (web)]]
- [[GTeamPage (web)]]
- [[MatchPage (web)]]

## Child components

Nessuno.

## Servizi FE usati

Nessuno.

## Modelli FE usati

Nessuno.

## Eventi input/output

| Direzione | Nome | Tipo | Descrizione |
|-----------|------|------|-------------|
| Input | shareUrl | string | URL da copiare negli appunti |
| Output | linkCopied | EventEmitter\<void\> | Emesso dopo la copia del link |

## Note

Il componente e incluso come tab "Share" nelle pagine pubbliche GChannelPage, GMatchPage, GTeamPage e nella pagina protetta MatchPage. GChannelPage documenta lo stato UI "Copia link". Dettagli implementativi (template, stili, logica clipboard API) non deducibili dalla wiki.
