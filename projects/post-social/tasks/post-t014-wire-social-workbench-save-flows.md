---
id: POST-T014
title: Wire Social Workbench Save Flows
status: open
agent: agent-project-task-executor
priority: P1
created: "2026-08-03"
---

# Wire Social Workbench Save Flows

## Status

open

## Goal

Collegare la UI Social Workbench agli endpoint file-only e verificare che ogni modifica venga salvata su filesystem.

## Context

Il requisito centrale della nuova idea e che tutto cio che viene creato o modificato dalla pagina sia persistito su file. Questo task valida il flusso end-to-end.

## Output

Flussi funzionanti per:

- creare social;
- modificare prompt/regole social;
- attivare/disattivare social;
- creare o aggiornare bozze/post;
- aggiornare stato bozza/post.

## Dependencies

- POST-T012
- POST-T013

## Acceptance Criteria

- Ogni azione UI rilevante produce una modifica file verificabile.
- La UI mostra feedback chiaro per salvataggio riuscito o fallito.
- I file salvati restano compatibili con il contratto di POST-T011.
- Un tentativo di scrittura fuori perimetro viene rifiutato dal server.
- Non viene invocato Codex, non viene creata queue e non parte pubblicazione social.

## Recommended Verification

Eseguire smoke test manuale creando un social di prova e una bozza di prova, poi verificare i file generati. Eseguire `node --check` sui file JS.

## AI-Ready Prompt

Collega la UI Social Workbench agli endpoint file-only e verifica che social, prompt e bozze vengano salvati su filesystem, senza Codex, queue o pubblicazione automatica.
