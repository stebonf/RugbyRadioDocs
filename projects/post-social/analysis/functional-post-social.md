---
type: functional-analysis
created: 2026-08-02T21:54:17+02:00
topic: "Post Social"
project: "post-social"
slug: "post-social"
---

# Functional Analysis: Post Social

## Summary

L'iniziativa `post-social` introduce un agente locale per generare post social per Rugby Radio Live e una pagina web locale di gestione dei file social. La prima fase e assistita: l'utente configura social e prompt, naviga bozze e storico dal Social Workbench, richiede o registra contenuti, e poi copia/incolla manualmente sui social.

Le fasi successive automatizzano la pubblicazione e, in seguito, la schedulazione. L'agente deve supportare Instagram e LinkedIn all'inizio, ma deve essere configurabile per aggiungere altri social senza riscrivere la logica principale.

## Goal

- Generare post social coerenti con RRL senza ripetersi.
- Separare le istruzioni editoriali per social.
- Tenere memoria locale dei contenuti generati.
- Offrire una pagina web locale per gestire social, prompt, stato canali e bozze salvate su file.
- Preparare un percorso verso pubblicazione automatica e schedulazione.
- Integrare, o almeno preparare, generazione immagini/video tramite Google Flow o alternativa tecnica verificabile.

## Scope

Fase 1:

- agente locale invocabile su richiesta;
- configurazione prompt per social;
- storico locale dei post generati per ogni social;
- pagina web locale in HTML, JS e CSS, con stile coerente a `company/web`;
- navigazione, aggiunta, attivazione e disattivazione dei social configurati;
- modifica dei prompt e delle regole per social;
- lista e dettaglio delle bozze/post creati;
- salvataggio di configurazioni e contenuti su filesystem;
- generazione testo post, hashtag e proposta media;
- output copiabile manualmente dall'utente;
- suggerimento dei social aggiuntivi utili a RRL.

Fase 2:

- pubblicazione automatica tramite API quando il social lo consente;
- gestione token e consenso umano prima della pubblicazione;
- stato locale di pubblicazione.

Fase 3:

- schedulazione e automazione ricorrente;
- regole di calendario editoriale;
- generazione periodica con guardrail anti-duplicazione.

## Out Of Scope

- Pubblicazione automatica in Fase 1.
- Lancio di agenti, esecuzione Codex o interazione con la queue dalla pagina Social Workbench.
- Acquisto o gestione commerciale di piani social advertising.
- Invio automatico senza consenso umano nella prima iterazione.
- Uso di credenziali personali salvate in chiaro.
- Promessa di supporto API per social non verificati.
- Sostituzione del flusso backend esistente `FacebookJob`.

## Sources Reviewed

- `company/inbox/20260802194951-post-social.md`
- `projects/post-social/README.md` idea `20260803070301-web-page`
- `wiki/business/product/Rugby Radio Live (product).md`
- `wiki/concepts/Pubblicazione Social (concept).md`
- `wiki/articles/Pubblicazione Social Post Partita (article).md`
- `wiki/backend/api/jobs/FacebookJob (api).md`
- LinkedIn Posts API: https://learn.microsoft.com/en-us/linkedin/marketing/community-management/shares/posts-api
- Instagram Graph API / publishing overview: https://www.postman.com/meta/instagram/documentation/6yqw8pt/instagram-api
- TikTok Content Posting API: https://developers.tiktok.com/doc/content-posting-api-reference-direct-post
- YouTube Data API videos.insert: https://developers.google.com/youtube/v3/docs/videos/insert
- Pinterest API create pins: https://developers.pinterest.com/docs/api/v5/pins-create/
- Google Flow Help: https://support.google.com/flow/answer/16353333
- Codex Plugins Help: https://help.openai.com/en/articles/20001256

## Actors And Stakeholders

- Product owner RRL: decide canali, tono e priorita.
- Content operator: richiede post e li copia sui social in Fase 1.
- Future scheduler/operator: approva calendario e automazioni.
- Spettatori e community rugby: destinatari dei contenuti.
- Piattaforme social: Instagram, LinkedIn e futuri canali.

## Current State

RRL ha gia una pipeline social backend per Facebook post partita, centrata su `FacebookJob`, `FacebookService`, Facebook Graph API e contenuti partita/blog. Esiste anche generazione immagine per match e canali. Il nuovo agente non deve duplicare quella pipeline in modo cieco: deve partire come strumento editoriale locale e puo poi integrarsi con i flussi social esistenti.

La dashboard AI-Company sotto `company/web` fornisce un riferimento di stile e di ergonomia, ma il Social Workbench non deve ereditarne le azioni Codex: deve essere una superficie file-based per configurare e consultare i contenuti social.

## Target State

L'utente puo chiedere un post per uno o piu social. L'agente:

1. legge configurazione social e prompt editoriale;
2. legge storico locale dei post generati per quel social;
3. acquisisce contesto RRL disponibile, ad esempio match, blog, iniziativa o tema;
4. genera testo specifico per il social;
5. propone media prompt per immagine/video;
6. salva bozza generata in archivio locale;
7. in Fase 1 mostra contenuto copiabile;
8. in Fase 2 puo pubblicare tramite API dopo conferma;
9. in Fase 3 puo pianificare o generare in modo schedulato.

In parallelo, l'utente puo aprire il Social Workbench locale e:

1. vedere i social configurati e il loro stato;
2. aggiungere un nuovo social;
3. attivare o disattivare un social;
4. modificare prompt, regole formato, hashtag e note API;
5. navigare bozze/post per social e stato;
6. aprire il dettaglio di una bozza;
7. salvare modifiche su file;
8. creare bozze manuali o registrare contenuti prodotti altrove;
9. copiare testo, hashtag, CTA e media prompt.

## Main Flows

### Fase 1 - Generazione manuale

1. L'utente seleziona social target, ad esempio Instagram o LinkedIn.
2. L'utente fornisce tema, link, match, blog o obiettivo del post.
3. L'agente legge `projects/post-social` e la configurazione dei prompt social.
4. L'agente legge lo storico locale del social.
5. L'agente genera post e proposta visuale.
6. L'agente salva la bozza locale con stato `draft`.
7. L'utente copia e incolla manualmente sul social.

### Fase 1 - Social Workbench file-based

1. L'utente apre la pagina locale del progetto.
2. La pagina legge configurazioni social e bozze da file.
3. L'utente seleziona un social dalla navigazione.
4. L'utente modifica prompt o stato canale.
5. La pagina salva la configurazione su file.
6. L'utente visualizza bozze/post creati, filtrando per social e stato.
7. L'utente apre una bozza, ne modifica note o stato e salva su file.
8. La pagina non mostra e non invoca azioni Codex, agenti o queue.

### Fase 2 - Pubblicazione assistita

1. L'utente seleziona una bozza.
2. Il sistema verifica canale, token, permessi e formato media.
3. Il sistema mostra preview e richiede conferma.
4. Il sistema pubblica via API supportata.
5. Il sistema aggiorna stato locale a `published` o `failed`.

### Fase 3 - Schedulazione

1. L'utente definisce calendario editoriale.
2. Il sistema genera bozze in slot pianificati.
3. Il sistema evita ripetizioni leggendo storico e temi recenti.
4. La pubblicazione resta confermata manualmente o automatica solo se abilitata.

## Alternative Flows

- Se il social non ha API adatta, l'agente produce solo output copiabile.
- Se il token e assente o scaduto, la bozza resta pronta ma non pubblicata.
- Se Google Flow non offre automazione API adeguata, l'agente produce prompt media da usare manualmente o valuta alternative come API Veo/Gemini dove disponibili.
- Se lo storico e vuoto, l'agente applica solo linee guida editoriali.
- Se lo storico contiene contenuti simili, l'agente deve cambiare angolo editoriale.
- Se il workbench non puo salvare direttamente dal browser statico, deve usare un endpoint locale file-only o una capacita browser esplicita di salvataggio file; non deve aggirare il vincolo tramite Codex.

## Business Rules

- Ogni social ha prompt dedicato e regole proprie.
- Ogni social configurato ha stato `active` o `inactive`.
- Il Social Workbench puo creare e modificare solo file del dominio social del progetto.
- Il Social Workbench non deve esporre pulsanti per lanciare agenti, eseguire Codex, creare queue item o pubblicare automaticamente.
- Ogni modifica da UI deve persistere su filesystem.
- L'agente deve leggere lo storico prima di generare.
- La Fase 1 non pubblica automaticamente.
- La pubblicazione automatica richiede conferma esplicita almeno fino a decisione contraria.
- I contenuti devono restare coerenti con RRL: rugby amatoriale/giovanile, live storytelling, AI-Talker, valore community.
- Le bozze devono essere salvate per social e data.
- Non salvare segreti nei file progetto.
- Un post gia pubblicato non deve essere ripubblicato senza nuova decisione esplicita.

## Data Needs

- `socialId`: instagram, linkedin, facebook, tiktok, youtube, pinterest, threads, ecc.
- stato canale: `active`, `inactive`, `draft`, `deprecated`;
- prompt editoriale per social;
- regole formato, hashtag, media e API notes per social;
- tema o sorgente del post;
- testo generato;
- hashtag;
- call to action;
- media prompt;
- eventuale path o URL media generato;
- stato: `draft`, `ready`, `published`, `failed`, `dropped`;
- data generazione;
- data pubblicazione;
- fingerprint semantico o tags per anti-ripetizione;
- note utente.
- metadati UI opzionali: colore, ordinamento, icona/label, ultimo aggiornamento.

## Permissions And Access

Fase 1 richiede solo accesso locale ai file.

Il Social Workbench richiede permessi di lettura/scrittura limitati alle cartelle del progetto dedicate a configurazioni e bozze social. Non deve avere permessi di esecuzione agenti o accesso a segreti.

Fase 2 richiedera OAuth/token per ogni social. Le API ufficiali indicano vincoli importanti:

- LinkedIn Posts API supporta creazione post, ma alcune permission sono ristrette e richiedono approvazione.
- Instagram publishing richiede account Professional e collegamento a una Facebook Page.
- TikTok Content Posting API richiede app registrata, consenso utente e audit per contenuti pubblici.
- YouTube upload richiede OAuth e progetti non verificati possono avere restrizioni di visibilita.
- Pinterest consente creazione Pin con OAuth e scope dedicati.

## Integrations And Side Effects

- Archivio locale bozze/storico.
- Social Workbench locale file-based.
- Futuri client API social.
- Possibile generazione media via Google Flow manuale o integrazione alternativa verificata.
- Possibile riuso di contenuti RRL: match, blog, canali, immagini.
- Possibile riuso concettuale del flusso `FacebookJob`, senza accoppiarlo nella Fase 1.

## Error States And Edge Cases

- Prompt social mancante.
- Storico locale non leggibile.
- Errore di salvataggio filesystem da UI.
- File social malformato o frontmatter non valido.
- Stato social non coerente con bozze esistenti.
- Output troppo simile a post precedenti.
- Social API non disponibile o non approvata.
- Token scaduto o permessi insufficienti.
- Media non conforme a formato/dimensione piattaforma.
- Pubblicazione parziale: testo pubblicato ma media fallito.
- Schedulazione che genera troppi contenuti simili.

## Acceptance Criteria

- AC-01: dato un social configurato, l'agente genera un post seguendo il prompt dedicato.
- AC-02: prima di generare, l'agente legge lo storico locale del social.
- AC-03: la bozza generata viene salvata localmente con stato e metadati.
- AC-04: in Fase 1 non parte nessuna pubblicazione automatica.
- AC-05: Instagram e LinkedIn sono supportati come target iniziali.
- AC-06: un nuovo social puo essere aggiunto creando configurazione e prompt dedicato.
- AC-06b: un nuovo social puo essere aggiunto anche dal Social Workbench e salvato su file.
- AC-07: l'output include testo, hashtag, CTA e proposta media.
- AC-08: l'agente segnala quando una pubblicazione API non e disponibile o richiede approvazione.
- AC-09: la roadmap distingue Fase 1 manuale, Fase 2 pubblicazione assistita, Fase 3 schedulazione.
- AC-10: la pagina Social Workbench consente navigazione, attivazione/disattivazione social, configurazione prompt e visualizzazione bozze/post.
- AC-11: la pagina Social Workbench non lancia agenti, non interagisce con Codex e non crea queue item.
- AC-12: ogni creazione o modifica fatta dal Social Workbench viene salvata su filesystem.

## Assumptions

- Il primo agente sara file-based e locale.
- La UI Social Workbench puo riusare stile e pattern di `company/web`, ma resta separata dal runner Codex.
- Per salvare da browser a filesystem potrebbe servire un piccolo server locale file-only, anche se l'esperienza utente resta una pagina HTML/JS/CSS.
- L'utente accetta copia/incolla manuale nella Fase 1.
- Le credenziali social saranno configurate solo in una fase successiva.
- Google Flow potrebbe non essere direttamente automatizzabile via API pubblica; va validato.
- I plugin Codex disponibili in questa sessione non includono connettori diretti Instagram o LinkedIn.

## Blocking Questions

Nessuna domanda bloccante per la pianificazione.

## Non-Blocking Questions

- Quale tono editoriale preferisci per LinkedIn: founder/product, community sportiva o tecnico?
- Vuoi generare post da eventi partita, blog, idee libere o tutti questi input?
- Lo storico locale vive sotto `src/RugbyRadioSocial/raw`.
- Il Social Workbench vive sotto `src/RugbyRadioSocial/web`.
- Vuoi approvare manualmente anche la Fase 3 o pubblicare automaticamente in slot fidati?

## Notes For Architecture

Progettare un core file-based con adapter per social. Separare generazione contenuti, storage locale, media generation, Social Workbench e publishing. Le API social devono essere adapter opzionali e attivabili solo quando credenziali e permessi sono verificati. Il Workbench deve usare un perimetro file-only e non deve dipendere da Codex.
