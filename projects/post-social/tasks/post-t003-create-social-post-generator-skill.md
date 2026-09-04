---
id: POST-T003
title: Create Social Post Generator Skill
status: open
agent: agent-project-task-executor
priority: P0
created: "2026-08-02"
---

# Create Social Post Generator Skill

## Goal

Creare una skill riusabile per generare post leggendo configurazione e storico.

## Output

`company/skills/social-post-generator/SKILL.md`

## Dependencies

- POST-T001
- POST-T002

## Acceptance Criteria

- La skill obbliga a leggere storico e configurazione social prima di generare.
- La skill produce bozze locali.
- La skill vieta pubblicazione automatica in Fase 1.

## Recommended Verification

Review della skill e prova su un tema fittizio.

## AI-Ready Prompt

Crea la skill `company/skills/social-post-generator` per generare bozze social RRL con storico anti-ripetizione.
