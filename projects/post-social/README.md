# Post Social

## Status

`planned`

## Goal

Creare un agente locale che aiuti a generare post social per Rugby Radio Live, partendo da Instagram e LinkedIn e lasciando spazio ad altri canali futuri.

## Scope

- Idea iniziale da inbox.
- Idea `20260803070301-web-page` integrata come Social Workbench file-based.
- Output operativi, configurazioni, bozze e web app sotto `src/RugbyRadioSocial`.
- Analisi funzionale.
- Analisi architetturale.
- Task di implementazione.

## Key Artifacts

- `analysis/functional-post-social.md`
- `architecture/arch-post-social.md`
- `tasks/tasklist-post-social.md`
- `tasks/taskboard-post-social.md`
- `../../src/RugbyRadioSocial/README.md`
- `../../src/RugbyRadioSocial/config/socials/instagram.md`
- `../../src/RugbyRadioSocial/config/socials/linkedin.md`
- futuro `../../src/RugbyRadioSocial/web/` per la pagina operativa social file-based.

## Source Idea

- `company/inbox/20260802194951-post-social.md`

## Closeout

Non ancora generato.

## Ideas

### Web Page

- id: `20260803070301-web-page`
- status: `integrated`
- created: `2026-08-03`
- queue: `queue-20260803070301-xtd81l`

Aggiungiamo una pagina Web html, js, css per permettermi di navigare tra i social, aggiungerli, attivarli, disattivarli, configurare i prompt, vedere i post creati, etc. Usare lo stile utilizzato per la pagina AI-Company (./company/web). La pagina non deve permettere il lancio di agenti o interagire con codex, deve lavorare solo sui file dei social, è quindi necessario che tutto ciò che viene creato sia salvato su file system.

Integration note: l'idea e stata incorporata come requisito di Social Workbench locale. La pagina deve gestire configurazioni social, prompt e bozze/post salvati su file sotto `src/RugbyRadioSocial`, con stile coerente a `company/web`, senza pulsanti di lancio agenti, senza chiamate Codex e senza pubblicazione automatica.
