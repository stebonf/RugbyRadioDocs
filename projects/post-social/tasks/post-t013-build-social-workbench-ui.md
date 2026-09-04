---
id: POST-T013
title: Build Social Workbench UI
status: open
agent: agent-project-task-executor
priority: P1
created: "2026-08-03"
---

# Build Social Workbench UI

## Status

open

## Goal

Creare la pagina web HTML, JS e CSS per gestire social, prompt e bozze/post con stile coerente alla dashboard AI-Company.

## Context

La UI deve ispirarsi a `company/web`: sidebar, card operative, filtri, editor compatti e stati chiari. Deve restare focalizzata sui file social e non mostrare azioni Codex.

## Output

- `src/RugbyRadioSocial/web/index.html`
- `src/RugbyRadioSocial/web/app.js`
- `src/RugbyRadioSocial/web/styles.css`

## Dependencies

- POST-T011
- POST-T012

## Acceptance Criteria

- La pagina mostra lista social e stato active/inactive.
- La pagina consente aggiunta social.
- La pagina consente attivazione/disattivazione social.
- La pagina consente modifica prompt e regole.
- La pagina mostra bozze/post filtrabili per social e stato.
- La pagina non contiene pulsanti o flussi per agenti, Codex, queue o pubblicazione automatica.
- Lo stile e coerente con `company/web` senza copiare funzionalita non pertinenti.

## Recommended Verification

Aprire la pagina dal server locale, controllare layout desktop/mobile essenziale e verificare una lettura dati mocked o reale.

## AI-Ready Prompt

Costruisci la UI HTML/JS/CSS del Social Workbench sotto `src/RugbyRadioSocial/web`, usando lo stile di `company/web` e limitandoti a social config e bozze/post file-based.
