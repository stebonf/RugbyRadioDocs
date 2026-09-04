---
id: POST-T004
title: Create Agent Social Post
status: open
agent: agent-project-task-executor
priority: P1
created: "2026-08-02"
---

# Create Agent Social Post

## Goal

Creare un agente operativo che usa la skill social e produce bozze.

## Output

`company/agents/agent-social-post.md`

## Dependencies

- POST-T003

## Acceptance Criteria

- L'agente accetta social id, topic/source e tono opzionale.
- L'agente produce e salva una bozza.
- La dashboard legge input, output e risk dell'agente.

## Recommended Verification

Ricaricare la dashboard e verificare che l'agente sia disponibile.

## AI-Ready Prompt

Crea `agent-social-post` con input `social-id`, `topic`, `source-path` opzionale e output bozza Markdown.
