---
id: POST-T011
title: Define Social Workbench File Contract
status: open
agent: agent-project-task-executor
priority: P0
created: "2026-08-03"
---

# Define Social Workbench File Contract

## Status

open

## Goal

Definire il contratto file che la pagina Social Workbench deve leggere e scrivere per social, prompt e bozze.

## Context

La nuova idea `20260803070301-web-page` richiede una pagina HTML/JS/CSS per navigare social, aggiungerli, attivarli/disattivarli, configurare prompt e vedere post creati. La pagina non deve lanciare agenti o interagire con Codex; deve salvare tutto su filesystem.

## Output

Documento o README operativo che descrive:

- formato configurazioni social;
- formato bozze/post;
- stati ammessi;
- mapping tra campi UI e sezioni Markdown;
- cartelle allowlist per lettura/scrittura.

## Dependencies

- POST-T001
- POST-T002

## Acceptance Criteria

- Il contratto copre social config, prompt, regole, stato active/inactive e post draft/ready/published/failed/dropped.
- Il contratto indica cartelle e naming convention sotto `projects/post-social`.
- Il contratto chiarisce che la UI non puo lanciare agenti, queue o Codex.
- Il contratto e sufficiente per implementare una API file-only senza endpoint generici di scrittura.

## Recommended Verification

Review manuale del documento confrontandolo con `analysis/functional-post-social.md` e `architecture/arch-post-social.md`.

## AI-Ready Prompt

Definisci il contratto file per il Social Workbench di `post-social`, includendo configurazioni social, prompt, bozze/post, stati e cartelle allowlist. Non progettare alcuna interazione con Codex.
