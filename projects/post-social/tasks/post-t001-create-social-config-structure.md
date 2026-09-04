---
id: POST-T001
title: Create Social Config Structure
status: done
agent: agent-project-task-executor
priority: P0
created: "2026-08-02"
---

# Create Social Config Structure

## Status

done

## Goal

Creare cartelle e template per configurare social e prompt.

## Context

Usare `projects/post-social/architecture/arch-post-social.md` e `projects/post-social/analysis/functional-post-social.md`.

## Output

`src/RugbyRadioSocial/config/socials/*.md`

## Likely Files Or Components

- `src/RugbyRadioSocial/config/socials/instagram.md`
- `src/RugbyRadioSocial/config/socials/linkedin.md`

## Dependencies

None.

## Acceptance Criteria

- Esistono configurazioni iniziali per Instagram e LinkedIn.
- Ogni configurazione contiene frontmatter, prompt, format rules, hashtag rules, media rules e API notes.

## Recommended Verification

Aprire i file e verificare frontmatter e sezioni.

## Validation Notes

- Created `src/RugbyRadioSocial/config/socials/instagram.md`.
- Created `src/RugbyRadioSocial/config/socials/linkedin.md`.
- Verified both files contain frontmatter, Prompt, Format Rules, Hashtag Rules, Media Rules and API Notes.

## AI-Ready Prompt

Crea configurazioni social Markdown per Instagram e LinkedIn sotto `src/RugbyRadioSocial/config/socials`, usando l'architettura post-social.
