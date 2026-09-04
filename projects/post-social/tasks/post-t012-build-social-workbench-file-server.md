---
id: POST-T012
title: Build Social Workbench File Server
status: open
agent: agent-project-task-executor
priority: P0
created: "2026-08-03"
---

# Build Social Workbench File Server

## Status

open

## Goal

Creare il server locale file-only necessario al Social Workbench per leggere e salvare configurazioni social e bozze su filesystem.

## Context

Una pagina HTML/JS/CSS statica non puo garantire salvataggio affidabile su filesystem in tutti i browser. Serve un piccolo server locale o endpoint equivalente, con perimetro molto stretto e nessuna capacita di esecuzione Codex.

## Output

Server locale o modulo equivalente per:

- servire `src/RugbyRadioSocial/web`;
- leggere social config da `src/RugbyRadioSocial/config/socials`;
- salvare social config;
- leggere bozze/post da `src/RugbyRadioSocial/raw/posts`;
- salvare bozze/post;
- aggiornare stati.

## Dependencies

- POST-T011

## Acceptance Criteria

- Gli endpoint sono file-only e allowlistati sulle cartelle social del progetto.
- Non esistono endpoint per lanciare agenti, queue, processi o comandi shell.
- Il server rifiuta path traversal e scritture fuori dal perimetro.
- Gli errori di salvataggio sono restituiti in JSON leggibile dalla UI.

## Recommended Verification

Eseguire `node --check` sul server e testare almeno una lettura API e una richiesta non valida che deve essere rifiutata.

## AI-Ready Prompt

Implementa un piccolo server locale file-only per il Social Workbench di `post-social`, con endpoint allowlistati per social config e bozze/post. Non aggiungere esecuzione Codex o shell.
