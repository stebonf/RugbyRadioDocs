---
type: architecture-design
created: 2026-08-02T21:54:17+02:00
topic: "Post Social"
project: "post-social"
slug: "post-social"
functional_input: "projects/post-social/analysis/functional-post-social.md"
---

# Architecture Design: Post Social

## Summary

L'architettura proposta introduce un agente locale file-based per generare, archiviare e in futuro pubblicare contenuti social RRL, affiancato da un Social Workbench web locale per gestire configurazioni, prompt e bozze salvate su file. La prima fase evita integrazioni esterne obbligatorie: produce bozze copiabili, salva storico locale, prepara prompt media e offre una UI operativa senza lancio agenti. Le integrazioni API e la schedulazione arrivano dopo, tramite adapter isolati.

## Functional Input

- `projects/post-social/analysis/functional-post-social.md`
- `projects/post-social/README.md` idea `20260803070301-web-page`
- `company/inbox/20260802194951-post-social.md`

## Scope

- Struttura progetto e configurazione social.
- Archivio locale bozze/storico.
- Social Workbench locale HTML/JS/CSS con stile ispirato a `company/web`.
- API o adapter file-only necessari per salvare configurazioni e bozze su filesystem.
- Agente di generazione on demand.
- Adapter futuri per pubblicazione.
- Guardrail anti-ripetizione.
- Preparazione alla generazione media.

## Out Of Scope

- Implementazione immediata di OAuth social.
- Pubblicazione automatica senza conferma.
- Integrazione diretta non verificata con Google Flow.
- Modifiche backend RRL in MVP.
- Lancio agenti, queue Codex, runner Codex o pubblicazione social dalla pagina Workbench.

## Sources Reviewed

- `wiki/concepts/Pubblicazione Social (concept).md`
- `wiki/articles/Pubblicazione Social Post Partita (article).md`
- `wiki/backend/api/jobs/FacebookJob (api).md`
- Official docs for LinkedIn, Instagram, TikTok, YouTube, Pinterest, Google Flow and Codex plugins listed in the functional analysis.

## System Context

La pianificazione vive in `projects/post-social`, mentre gli output operativi file-based vivono in `src/RugbyRadioSocial`. La soluzione resta una capacita locale, non nel prodotto web RRL. In futuro potra diventare plugin/skill/agent riusabile. Per ora deve convivere con:

- `company/agents`: agenti locali esistenti;
- `company/skills`: skill operative;
- `projects/post-social`: analisi, architettura e task di progetto;
- `src/RugbyRadioSocial`: configurazioni social, bozze, media prompt e Social Workbench;
- `raw`/`wiki`: fonti e conoscenza RRL;
- eventuali contenuti RRL da sorgenti backend o blog.

## Affected Components

Componenti nuovi consigliati:

- `company/agents/agent-social-post.md`: agente operativo per generare post.
- `company/skills/social-post-generator/SKILL.md`: skill riusabile per generazione post.
- `src/RugbyRadioSocial/config/socials/*.md`: prompt e regole per canale.
- `src/RugbyRadioSocial/raw/posts/<social>/`: archivio bozze e storico.
- `src/RugbyRadioSocial/raw/media-prompts/`: prompt immagini/video.
- `src/RugbyRadioSocial/web/index.html`: pagina Social Workbench.
- `src/RugbyRadioSocial/web/app.js`: stato UI, lettura/scrittura via API file-only, filtri e form.
- `src/RugbyRadioSocial/web/styles.css`: stile coerente con `company/web`.
- `src/RugbyRadioSocial/web/server.js` o endpoint equivalente file-only: serve la pagina e persiste file social senza accesso a Codex.
- futuro `company/web` action launcher per generare post da dashboard.

## Frontend Impact

Nessun impatto sul frontend RRL in MVP.

Nuova superficie locale `Social Workbench`:

- layout operativo simile a `company/web`: sidebar, metriche/filtri, card dense, editor/preview;
- navigazione social;
- aggiunta social;
- toggle active/inactive;
- editor prompt e regole;
- lista bozze/post per social e stato;
- dettaglio bozza con testo, hashtag, CTA, media prompt e note;
- salvataggio esplicito su file;
- nessun bottone `Run`, `Queue`, `Agent`, `Codex` o equivalente.

Possibile impatto dashboard `company/web`:

- aggiungere un'azione "Generate social post" su progetto o inbox;
- mostrare stato bozze generate;
- aprire file bozza in editor Markdown;
- in futuro mostrare preview per social.
- linkare o aprire il Social Workbench, senza fargli ereditare le capacita di esecuzione Codex.

## Backend Impact

Nessun impatto backend RRL in Fase 1.

In Fase 2 si puo scegliere tra:

- adapter locali in `company` che chiamano API social;
- integrazione backend RRL dedicata se si vuole pubblicazione server-side;
- riuso parziale di pattern da `FacebookJob`, evitando duplicazioni per token, retry e log.

## Data Impact

Formato bozza consigliato:

```markdown
---
type: social-post
social: instagram
status: draft
created: "YYYY-MM-DDTHH:mm:ss+TZ"
topic: "..."
source: "..."
fingerprint: "..."
publishedUrl: ""
publishedAt: ""
---

# <Title>

## Post

## Hashtags

## CTA

## Media Prompt

## Notes
```

Configurazione social consigliata:

```markdown
---
type: social-channel-config
social: linkedin
status: active
phase: manual
label: LinkedIn
order: 20
---

# LinkedIn

## Prompt

## Format Rules

## Hashtag Rules

## Media Rules

## API Notes
```

La UI deve trattare frontmatter e sezioni Markdown come contratto persistente. Quando modifica un prompt o uno stato, riscrive il file corrispondente mantenendo le sezioni note.

## API And Contract Changes

MVP prodotto RRL: nessuna API applicativa.

MVP Social Workbench locale:

- `GET /api/socials` -> lista configurazioni social da `src/RugbyRadioSocial/config/socials`;
- `POST /api/socials` -> crea configurazione social;
- `POST /api/socials/<socialId>/status` -> aggiorna stato active/inactive;
- `POST /api/socials/<socialId>/config` -> salva prompt e regole;
- `GET /api/posts` -> lista bozze/post da `src/RugbyRadioSocial/raw/posts`;
- `GET /api/posts/<id>` -> dettaglio bozza;
- `POST /api/posts` -> crea o aggiorna bozza;
- `POST /api/posts/<id>/status` -> aggiorna stato bozza.

Queste API sono file-only: non lanciano processi, non chiamano Codex, non leggono segreti e non pubblicano sui social.

Fase 2 adapter:

- `generatePost(context, socialId) -> SocialPostDraft`
- `saveDraft(draft) -> path`
- `publishDraft(path, confirm) -> PublishResult`
- `listHistory(socialId, limit) -> SocialPostDraft[]`

## Integrations And Side Effects

Social consigliati:

- Instagram: prioritario per visual e community; API disponibile per account Professional con vincoli Meta.
- LinkedIn: prioritario per racconto prodotto, founder update e partnership; API possibile ma con permission ristrette.
- Facebook: gia parzialmente coperto da pipeline RRL; utile come canale stabile.
- TikTok: utile solo quando il flusso video e maturo; API Direct Post richiede audit.
- YouTube Shorts: utile per video highlights; upload via YouTube Data API con OAuth e possibili restrizioni su progetti non verificati.
- Pinterest: utile per evergreen visual e contenuti ispirazionali; API pin relativamente adatta a immagini/video.
- Threads: candidato naturale se l'ecosistema Meta resta centrale, da verificare in fase tecnica.

Plugin Codex/ChatGPT:

- Nella lista plugin disponibile in questa sessione non risultano connettori Instagram, LinkedIn, TikTok, YouTube o Pinterest.
- Plugin potenzialmente utili ma indiretti: Google Drive per archiviazione contenuti, Google Calendar per schedulazione editoriale, Slack/Teams/Gmail/Outlook solo per review e notifiche, se installati.
- Per pubblicazione social servono adapter/API proprie o un futuro plugin dedicato.

Google Flow:

- Google Flow e documentato come tool creativo con requisiti di account/piano e crediti.
- Per automazione tecnica va verificato se esiste un endpoint ufficiale utilizzabile nel workspace; in mancanza, usare prompt media esportabili manualmente o valutare API Google generative video disponibili separatamente.

Social Workbench:

- Il Workbench legge e scrive solo file del progetto `post-social`.
- Non pubblica sui social e non invoca agenti.
- Puo essere servito da un piccolo server locale dedicato o da endpoint file-only equivalenti, pur mantenendo l'esperienza utente in HTML/JS/CSS.

## Security And Permissions

- Non salvare token in Markdown.
- Il Workbench puo scrivere solo in `src/RugbyRadioSocial/config/socials`, `src/RugbyRadioSocial/raw/posts` e `src/RugbyRadioSocial/raw/media-prompts`.
- Il Workbench non deve esporre endpoint generici di scrittura file e non deve accedere a `company/web/.runtime`.
- Il Workbench non deve invocare Codex, agenti o queue.
- Usare variabili ambiente o secret store locale per adapter futuri.
- Richiedere conferma prima di pubblicare.
- Loggare ID bozza, social e risultato, non token.
- Separare permessi lettura storico da permessi pubblicazione.

## Observability And Analytics

Metriche locali:

- bozze generate per social;
- bozze pubblicate;
- errori pubblicazione;
- ripetizioni evitate;
- temi piu usati;
- tempo tra generazione e pubblicazione.

## Deployment Or Migration Notes

MVP non richiede deploy. E una capacita locale nel repository.

Fase 2 richiedera setup OAuth/app developer per ogni social scelto.

## Architectural Decisions

- MVP file-based.
- Social Workbench file-based, senza esecuzione Codex.
- Social come adapter configurabili.
- Prompt per social separati dalla logica agente.
- Storico obbligatorio prima della generazione.
- Pubblicazione API fuori dalla prima fase.
- Google Flow trattato come dipendenza da validare, non come contratto gia garantito.
- Nessun segreto nei file progetto.

## Risks And Mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| API social ristrette o soggette ad audit | Alto | MVP manuale, adapter opzionali, verifica per social |
| Contenuti ripetitivi | Medio | Storico locale, fingerprint, tags |
| Token esposti | Alto | Env/secret store, mai Markdown |
| Workbench con permessi troppo larghi | Alto | API allowlist su cartelle social e nessuna esecuzione processi |
| Utente confonde Workbench con dashboard Codex | Medio | UI senza comandi agent/queue e testo operativo focalizzato sui file |
| Google Flow non automatizzabile | Medio | Prompt media manuali, valutare API alternative |
| Troppi canali troppo presto | Medio | Instagram + LinkedIn in MVP, altri in backlog |

## Sequencing

1. Creare struttura progetto e configurazioni social.
2. Creare agente/skill di generazione manuale.
3. Definire formato bozza e archivio.
4. Definire contratto file/API del Social Workbench.
5. Creare pagina Workbench e salvataggio file-only.
6. Aggiungere anti-ripetizione.
7. Generare primi post manuali.
8. Validare API Instagram/LinkedIn.
9. Introdurre adapter publishing.
10. Introdurre schedulazione.

## Open Questions

Nessuna bloccante per MVP.

## Notes For Task Planning

Le task devono separare fondazione locale, generazione contenuti, storage, Social Workbench, media prompt, adapter social e schedulazione. Evitare di iniziare da OAuth/API finche il flusso manuale e la gestione file non producono contenuti utili.
