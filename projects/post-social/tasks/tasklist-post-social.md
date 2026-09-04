---
type: task-plan
status: open
created: 2026-08-02T21:54:17+02:00
topic: "Post Social"
project: "post-social"
slug: "post-social"
input: "projects/post-social/analysis/functional-post-social.md; projects/post-social/architecture/arch-post-social.md"
---

# Task Plan: Post Social

## Summary

Piano per passare dall'idea `post-social` a un agente locale capace di generare post social RRL, salvare storico e preparare future pubblicazioni automatiche.

## Input Used

- `projects/post-social/analysis/functional-post-social.md`
- `projects/post-social/architecture/arch-post-social.md`
- `company/inbox/20260802194951-post-social.md`

## Operational Goal

Realizzare prima un flusso manuale affidabile per generare post Instagram e LinkedIn, poi estendere a media, publishing API e schedulazione.

## Blocking Decisions

Nessuna per la Fase 1.

## Assumptions

- Fase 1 usa solo file locali.
- Pubblicazione automatica e schedulazione arrivano dopo validazione del valore.
- Le API social richiedono setup esterno e approvazioni.

## Milestones

- M1 - Fondazione locale
- M1b - Social Workbench file-based
- M2 - Generazione manuale
- M3 - Media prompt e storico
- M4 - Publishing API discovery
- M5 - Pubblicazione assistita
- M6 - Schedulazione

## Prioritized Backlog

### POST-T001 - Create Social Config Structure

- Priority: P0
- Milestone: M1
- Type: project-docs/config
- Effort: Small
- Risk: Low
- Parallelizable: No
- Description: Creare cartelle e template per configurare social e prompt.
- Input: architettura post-social.
- Output: `src/RugbyRadioSocial/config/socials/*.md`.
- Likely Files Or Components: `src/RugbyRadioSocial/config/socials/instagram.md`, `linkedin.md`.
- Dependencies: none.
- Acceptance Criteria: esistono configurazioni iniziali per Instagram e LinkedIn con prompt, format rules, hashtag rules e API notes.
- Recommended Verification: aprire i file e verificare frontmatter e sezioni.
- AI-Ready Prompt: "Crea configurazioni social Markdown per Instagram e LinkedIn sotto src/RugbyRadioSocial/config/socials, usando l'architettura post-social."

### POST-T002 - Define Draft Storage Format

- Priority: P0
- Milestone: M1
- Type: project-docs/storage
- Effort: Small
- Risk: Low
- Parallelizable: Yes
- Description: Definire il formato dei file bozza e dello storico locale.
- Input: analisi funzionale e architettura.
- Output: template bozza e cartelle storico.
- Likely Files Or Components: `src/RugbyRadioSocial/raw/posts/README.md`, `src/RugbyRadioSocial/raw/media-prompts/README.md`.
- Dependencies: POST-T001.
- Acceptance Criteria: il formato contiene social, status, source, fingerprint, testo, hashtag, CTA, media prompt.
- Recommended Verification: review manuale del template.
- AI-Ready Prompt: "Definisci il formato Markdown delle bozze social e crea README operativi per src/RugbyRadioSocial/raw/posts e src/RugbyRadioSocial/raw/media-prompts."

### POST-T003 - Create Social Post Generator Skill

- Priority: P0
- Milestone: M2
- Type: company-skill
- Effort: Medium
- Risk: Medium
- Parallelizable: No
- Description: Creare una skill riusabile per generare post leggendo config e storico.
- Input: POST-T001, POST-T002.
- Output: `company/skills/social-post-generator/SKILL.md`.
- Likely Files Or Components: `company/skills/social-post-generator/SKILL.md`.
- Dependencies: POST-T001, POST-T002.
- Acceptance Criteria: la skill obbliga a leggere storico, applicare prompt social, salvare bozza e non pubblicare in Fase 1.
- Recommended Verification: review della skill e prova su un tema fittizio.
- AI-Ready Prompt: "Crea la skill company/skills/social-post-generator per generare bozze social RRL con storico anti-ripetizione."

### POST-T011 - Define Social Workbench File Contract

- Priority: P0
- Milestone: M1b
- Type: architecture/file-contract
- Effort: Small
- Risk: Medium
- Parallelizable: No
- Description: Definire il contratto file per configurazioni social, prompt e bozze/post usati dalla pagina Social Workbench.
- Input: idea `20260803070301-web-page`, analisi funzionale e architettura.
- Output: documento o README operativo del contratto file.
- Likely Files Or Components: `src/RugbyRadioSocial/config/socials`, `src/RugbyRadioSocial/raw/posts`, `src/RugbyRadioSocial/raw/media-prompts`.
- Dependencies: POST-T001, POST-T002.
- Acceptance Criteria: stati, frontmatter, sezioni Markdown, naming convention e cartelle allowlist sono definiti.
- Recommended Verification: review manuale con analisi e architettura.
- AI-Ready Prompt: "Definisci il contratto file per il Social Workbench di post-social, senza interazione con Codex."

### POST-T012 - Build Social Workbench File Server

- Priority: P0
- Milestone: M1b
- Type: local-web/file-api
- Effort: Medium
- Risk: Medium
- Parallelizable: No
- Description: Implementare server locale file-only per leggere e salvare configurazioni social e bozze/post.
- Input: POST-T011.
- Output: server o endpoint equivalenti per `src/RugbyRadioSocial/web`.
- Likely Files Or Components: `src/RugbyRadioSocial/web/server.js`.
- Dependencies: POST-T011.
- Acceptance Criteria: endpoint allowlistati, nessuna esecuzione Codex/shell, path traversal rifiutato.
- Recommended Verification: `node --check` e test API di lettura/scrittura valida e richiesta non valida.
- AI-Ready Prompt: "Implementa il server file-only del Social Workbench con endpoint allowlistati e nessuna esecuzione Codex."

### POST-T013 - Build Social Workbench UI

- Priority: P1
- Milestone: M1b
- Type: local-web/ui
- Effort: Medium
- Risk: Medium
- Parallelizable: Yes
- Description: Creare pagina HTML/JS/CSS per navigare social, aggiungerli, attivarli/disattivarli, configurare prompt e vedere bozze/post.
- Input: POST-T011, POST-T012, stile `company/web`.
- Output: `src/RugbyRadioSocial/web/index.html`, `app.js`, `styles.css`.
- Likely Files Or Components: `src/RugbyRadioSocial/web`.
- Dependencies: POST-T011, POST-T012.
- Acceptance Criteria: UI operativa coerente con `company/web`, senza azioni agent/Codex/queue.
- Recommended Verification: apertura pagina e smoke test layout/interazioni principali.
- AI-Ready Prompt: "Costruisci la UI HTML/JS/CSS del Social Workbench usando lo stile di company/web e limitandoti ai file social."

### POST-T014 - Wire Social Workbench Save Flows

- Priority: P1
- Milestone: M1b
- Type: local-web/integration
- Effort: Medium
- Risk: Medium
- Parallelizable: No
- Description: Collegare UI e server file-only verificando persistenza su filesystem.
- Input: POST-T012, POST-T013.
- Output: flussi create/update social, prompt e bozze/post salvati su file.
- Likely Files Or Components: `src/RugbyRadioSocial/web/app.js`, `src/RugbyRadioSocial/web/server.js`, file sotto `src/RugbyRadioSocial/config/socials` e `src/RugbyRadioSocial/raw/posts`.
- Dependencies: POST-T012, POST-T013.
- Acceptance Criteria: ogni modifica UI produce file verificabile; scritture fuori perimetro rifiutate; nessun Codex/queue/pubblicazione.
- Recommended Verification: smoke test manuale con social e bozza di prova, piu `node --check`.
- AI-Ready Prompt: "Collega la UI Social Workbench agli endpoint file-only e verifica i salvataggi su filesystem."

### POST-T004 - Create Agent Social Post

- Priority: P1
- Milestone: M2
- Type: company-agent
- Effort: Medium
- Risk: Medium
- Parallelizable: No
- Description: Creare un agente operativo che usa la skill e produce bozze.
- Input: POST-T003.
- Output: `company/agents/agent-social-post.md`.
- Likely Files Or Components: `company/agents/agent-social-post.md`.
- Dependencies: POST-T003.
- Acceptance Criteria: l'agente accetta social, topic/source, optional tone; produce e salva bozza.
- Recommended Verification: dashboard legge l'agente con input/output corretti.
- AI-Ready Prompt: "Crea agent-social-post con input social-id, topic, source-path opzionale e output bozza Markdown."

### POST-T005 - Generate First Manual Drafts

- Priority: P1
- Milestone: M2
- Type: content-validation
- Effort: Small
- Risk: Low
- Parallelizable: Yes
- Description: Generare una prima bozza Instagram e una LinkedIn per validare tono e formato.
- Input: agent-social-post.
- Output: bozze in `src/RugbyRadioSocial/raw/posts`.
- Likely Files Or Components: raw posts.
- Dependencies: POST-T004.
- Acceptance Criteria: due bozze salvate, diverse tra loro e coerenti con i canali.
- Recommended Verification: review umana dei contenuti.
- AI-Ready Prompt: "Usa agent-social-post per generare una bozza Instagram e una LinkedIn su Rugby Radio Live."

### POST-T006 - Add Anti-Repetition Check

- Priority: P1
- Milestone: M3
- Type: workflow-hardening
- Effort: Medium
- Risk: Medium
- Parallelizable: Yes
- Description: Rafforzare regole di controllo storico e fingerprint semantico.
- Input: prime bozze.
- Output: istruzioni aggiornate in skill/agent.
- Likely Files Or Components: `company/skills/social-post-generator/SKILL.md`, `company/agents/agent-social-post.md`.
- Dependencies: POST-T005.
- Acceptance Criteria: la generazione deve citare storico letto e spiegare come evita ripetizioni.
- Recommended Verification: generare secondo post sullo stesso tema e confrontare output.
- AI-Ready Prompt: "Aggiorna skill e agente per includere controllo anti-ripetizione basato su storico e tags."

### POST-T007 - Validate API Feasibility For Initial Socials

- Priority: P1
- Milestone: M4
- Type: research
- Effort: Medium
- Risk: Medium
- Parallelizable: Yes
- Description: Validare tecnicamente LinkedIn e Instagram API con requisiti account, permessi, review e limiti.
- Input: official docs.
- Output: research note.
- Likely Files Or Components: `projects/post-social/research/api-feasibility-instagram-linkedin.md`.
- Dependencies: POST-T005.
- Acceptance Criteria: la nota indica prerequisiti, endpoint, limiti, credenziali e decisione go/no-go.
- Recommended Verification: link a fonti ufficiali aggiornate.
- AI-Ready Prompt: "Produci una nota di fattibilita API per Instagram e LinkedIn usando fonti ufficiali."

### POST-T008 - Evaluate Google Flow Automation

- Priority: P2
- Milestone: M4
- Type: research
- Effort: Medium
- Risk: Medium
- Parallelizable: Yes
- Description: Verificare se Google Flow e automatizzabile o se conviene usare prompt media manuali/API alternative.
- Input: Google Flow docs.
- Output: research note.
- Likely Files Or Components: `projects/post-social/research/google-flow-automation.md`.
- Dependencies: none.
- Acceptance Criteria: la nota distingue Flow manuale, API disponibili, limiti account/crediti e raccomandazione.
- Recommended Verification: fonti ufficiali.
- AI-Ready Prompt: "Verifica Google Flow come integrazione per media social e proponi fallback tecnici."

### POST-T009 - Design Publishing Adapter

- Priority: P2
- Milestone: M5
- Type: architecture-update
- Effort: Medium
- Risk: High
- Parallelizable: No
- Description: Progettare adapter publishing per social abilitati.
- Input: POST-T007.
- Output: architettura aggiornata o decisione tecnica.
- Likely Files Or Components: `projects/post-social/architecture/arch-publishing-adapters.md`.
- Dependencies: POST-T007.
- Acceptance Criteria: contratti, secret handling, conferma utente, logging e failure mode definiti.
- Recommended Verification: review architetturale.
- AI-Ready Prompt: "Disegna gli adapter di pubblicazione social per i canali approvati nella research."

### POST-T010 - Plan Scheduling

- Priority: P3
- Milestone: M6
- Type: planning
- Effort: Medium
- Risk: Medium
- Parallelizable: Yes
- Description: Definire calendario editoriale e meccanismo di schedulazione.
- Input: validazione flusso manuale.
- Output: piano schedulazione.
- Likely Files Or Components: `projects/post-social/architecture/arch-social-scheduling.md`.
- Dependencies: POST-T005.
- Acceptance Criteria: frequenze, finestre, conferma umana e stop conditions documentate.
- Recommended Verification: review del calendario con utente.
- AI-Ready Prompt: "Definisci una proposta di schedulazione editoriale per post-social."

## Recommended Sequence

1. POST-T001
2. POST-T002
3. POST-T011
4. POST-T012
5. POST-T013
6. POST-T014
7. POST-T003
8. POST-T004
9. POST-T005
10. POST-T006
11. POST-T007 and POST-T008
12. POST-T009
13. POST-T010

## Parallelizable Work

- POST-T002 dopo POST-T001.
- POST-T013 dopo POST-T011 e POST-T012.
- POST-T007 e POST-T008 dopo le prime bozze.
- POST-T010 puo iniziare come bozza dopo validazione contenuti.

## Manual Or Non-Delegable Tasks

- Approvare tono editoriale.
- Creare app developer e OAuth sui social.
- Decidere pubblicazione automatica o sempre confermata.
- Valutare account Google Flow e costi/crediti.

## Definition Of Done

- Instagram e LinkedIn configurati.
- Agente locale creato e visibile in dashboard.
- Due bozze reali generate e archiviate.
- Storico anti-ripetizione operativo.
- Ricerca API iniziale completata.
- Decisione su media generation registrata.

## Risks And Mitigations

- API social bloccanti: mantenere Fase 1 manuale.
- Bassa qualita contenuti: iterare prompt per social.
- Ripetizione: storico obbligatorio e fingerprint.
- Segreti: non salvarli nel repository.

## Missing Data And Questions

- Tono definitivo LinkedIn.
- Tipi sorgente principali: match, blog, roadmap, analytics, news.
- Cartella definitiva per archivio operativo se diventa riusabile oltre questo progetto.

## Notes For Execution

Partire dal valore editoriale. Non spendere tempo su OAuth prima di avere bozze utili.
