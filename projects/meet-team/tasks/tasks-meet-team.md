# Task di dettaglio - Meet the Team

## Fonte

- Analisi funzionale: `projects/meet-team/analysis/analisi-funzionale-meet-team.md`
- Analisi architetturale: `projects/meet-team/analysis/architettura-meet-team.md`

## Obiettivo operativo

Implementare la nuova esperienza pubblica statica Meet the Team:

- index canonico `/team`;
- dettagli statici `/team-{slug}.html`;
- rimozione pura di `/ai-talkers`;
- tutte le lingue gia presenti negli statici attuali;
- AdSense slot `2308901507`;
- analytics Team;
- nessuna modifica a backend, API, database o job AI.

## Milestone

| Milestone | Risultato |
|---|---|
| M1 - Struttura statica | Build e hosting servono `/team` e `/team-{slug}.html` come HTML statici |
| M2 - Contenuti | Index e pagine dettaglio contengono founder, AI-Talkers, SEO e contenuti multilingua |
| M3 - Integrazione sito | Link interni, rimozione `/ai-talkers`, footer/header/home e sitemap sono coerenti |
| M4 - Tracking e monetizzazione | GA e AdSense funzionano sulle pagine Team |
| M5 - Verifica release | Build, output statico, responsive, SEO e regressioni sono verificati |

## Task

### MT-T01 - Definire slug e inventario pagine

**Tipo:** contenuto / preparazione  
**Dipendenze:** nessuna  
**File previsti:** documentazione o dati editoriali locali se introdotti

Creare l'inventario finale dei membri e degli slug:

| Membro | Slug | File atteso |
|---|---|---|
| Stefano | `stefano` | `/team-stefano.html` |
| Vox | `vox` | `/team-vox.html` |
| Nitro | `nitro` | `/team-nitro.html` |
| Beat Breaker | `beat-breaker` | `/team-beat-breaker.html` |
| Orfeo | `orfeo` | `/team-orfeo.html` |
| Zoe | `zoe` | `/team-zoe.html` |
| Maul | `maul` | `/team-maul.html` |
| Zorblax | `zorblax` | `/team-zorblax.html` |
| Elixir | `elixir` | `/team-elixir.html` |
| Bulldog | `bulldog` | `/team-bulldog.html` |
| El Mangiapolenta | `el-mangiapolenta` | `/team-el-mangiapolenta.html` (hidden from public references) |
| Trasteverino | `trasteverino` | `/team-trasteverino.html` (hidden from public references) |
| Newsly | `newsly` | `/team-newsly.html` |
| Brushy | `brushy` | `/team-brushy.html` |

**Acceptance criteria**

- Tutti gli AI-Talkers della pagina attuale hanno uno slug.
- Gli slug sono lowercase, ASCII, senza spazi.
- Gli slug sono usati in modo coerente in URL, tracking e link interni.

### MT-T02 - Configurare pubblicazione root degli HTML Team

**Tipo:** build / frontend  
**Dipendenze:** MT-T01  
**File previsti:** `src/RugbyRadioWeb/angular.json`

Aggiungere un asset glob dedicato:

```json
{
  "glob": "team*.html",
  "input": "src/assets/static",
  "output": "/"
}
```

**Acceptance criteria**

- Il build copia `team.html` e `team-*.html` nella root di `dist/rugby-radio-web/browser`.
- Gli asset statici esistenti continuano a essere copiati in `/assets`.
- Non vengono alterate le regole di copia degli altri asset.

**Validazione**

- `npm run build` da `src/RugbyRadioWeb`.
- Verificare esistenza di `dist/rugby-radio-web/browser/team.html`.

### MT-T03 - Aggiungere rewrite Firebase per `/team`

**Tipo:** hosting / deploy  
**Dipendenze:** MT-T02  
**File previsti:** `src/RugbyRadioWeb/firebase.json`

Aggiungere in entrambi i target `prod` e `uat`:

```json
{ "source": "/team", "destination": "/team.html" }
```

La regola deve precedere il fallback verso `/index.html`.

**Acceptance criteria**

- `/team` viene servito da `team.html`.
- Non esistono rewrite o redirect per `/ai-talkers`.
- La configurazione resta allineata tra `prod` e `uat`.

### MT-T04 - Creare index statico Meet the Team

**Tipo:** frontend statico / contenuto  
**Dipendenze:** MT-T01  
**File previsti:** `src/RugbyRadioWeb/src/assets/static/team.html`

Creare la pagina index Team con:

- hero Meet the Team;
- sezione founder con placeholder visual/testuale e LinkedIn;
- griglia di tutti gli AI-Talkers;
- spiegazione "Come funziona";
- link discovery verso Matches, Channels, Tutorial, How It Works e Blog;
- AdSense slot `2308901507`;
- blocchi lingua `it`, `en`, `fr`, `es`, `ja`;
- footer statico;
- `data-static-page="team"`.

**Acceptance criteria**

- `/team` contiene HTML reale e leggibile anche senza JS.
- Ogni card AI-Talker linka al relativo `/team-{slug}.html`.
- La pagina non promette generazione AI realtime.
- Tutte le lingue gia presenti negli statici attuali sono rappresentate.

### MT-T05 - Creare pagina dettaglio founder

**Tipo:** frontend statico / contenuto  
**Dipendenze:** MT-T01  
**File previsti:** `src/RugbyRadioWeb/src/assets/static/team-stefano.html`

Creare dettaglio founder con:

- hero;
- ruolo;
- bio e immagini placeholder;
- motivazione progetto;
- obiettivi futuri;
- link LinkedIn `https://www.linkedin.com/in/stefanobonfiglio/`;
- related content;
- AdSense slot `2308901507`;
- contenuti in `it`, `en`, `fr`, `es`, `ja`.

**Acceptance criteria**

- I placeholder sono facili da individuare e sostituire prima della produzione.
- Il solo link social presente e LinkedIn.
- Il link esterno usa `target="_blank"` e `rel="noopener noreferrer"`.

### MT-T06 - Creare pagine dettaglio AI-Talker

**Tipo:** frontend statico / contenuto  
**Dipendenze:** MT-T01  
**File previsti:** `src/RugbyRadioWeb/src/assets/static/team-*.html`

Creare una pagina dettaglio per ciascun AI-Talker:

- Vox
- Nitro
- Beat Breaker
- Orfeo
- Zoe
- Maul
- Zorblax
- Elixir
- Bulldog
- El Mangiapolenta
- Trasteverino
- Newsly
- Brushy

Ogni pagina include:

- hero;
- immagine;
- ruolo/personality;
- stile comunicativo;
- lingue supportate;
- esempi di commentary inventati;
- fun facts;
- video se disponibile;
- related content;
- link ritorno a `/team`;
- AdSense slot `2308901507`;
- contenuti in `it`, `en`, `fr`, `es`, `ja`.

**Acceptance criteria**

- Tutti i file `/team-{slug}.html` esistono.
- Ogni pagina chiarisce che l'AI-Talker e un personaggio virtuale.
- Gli esempi non sono presentati come generati realtime.
- I video mancanti non lasciano placeholder vuoti.

### MT-T07 - Implementare SEO e social metadata

**Tipo:** SEO / frontend statico  
**Dipendenze:** MT-T04, MT-T05, MT-T06  
**File previsti:** tutti gli HTML Team

Per ogni pagina aggiungere:

- `title`;
- `meta description`;
- canonical;
- Open Graph;
- Twitter Card;
- `og:image` e `twitter:image`;
- JSON-LD dove appropriato.

**Acceptance criteria**

- `team.html` canonical: `https://rugbyradiolive.com/team`.
- Ogni dettaglio canonical: `https://rugbyradiolive.com/team-{slug}.html`.
- `og:url` coincide con il canonical.
- Founder usa structured data compatibile con `Person`/`ProfilePage`.
- AI-Talkers evitano `Person` se puo confondere il personaggio virtuale con una persona reale.

### MT-T08 - Estendere tracking statico Team

**Tipo:** analytics / frontend statico  
**Dipendenze:** MT-T04, MT-T05, MT-T06  
**File previsti:** `src/RugbyRadioWeb/src/assets/static/static-common.js`

Estendere `static-common.js` per:

- mantenere `static_page_viewed`;
- inviare `team_page_view` su `data-static-page="team"`;
- inviare `team_detail_view` su dettagli Team;
- tracciare click con attributi `data-track-event`;
- supportare `team_member_click`, `team_discovery_click`, `team_social_click`;
- decidere se tracciare `team_video_play` via click embed/CTA o YouTube IFrame API.

**Acceptance criteria**

- Gli statici esistenti continuano a funzionare.
- Le pagine Team emettono eventi specifici con parametri minimi.
- In assenza di `gtag`, la pagina resta funzionante.

### MT-T09 - Inserire AdSense Team

**Tipo:** monetizzazione / frontend statico  
**Dipendenze:** MT-T04, MT-T05, MT-T06  
**File previsti:** tutti gli HTML Team

Inserire lo slot AdSense `2308901507`:

- sotto hero o meta sezione per index;
- meta pagina o fondo pagina per dettagli;
- con label discreta coerente con statici attuali.

**Acceptance criteria**

- Ogni pagina Team usa `data-ad-slot="2308901507"`.
- Gli annunci non coprono contenuti o CTA.
- La pagina resta leggibile se AdSense non carica.

### MT-T10 - Rimuovere `/ai-talkers`

**Tipo:** cleanup / SEO / frontend  
**Dipendenze:** MT-T04, MT-T06  
**File previsti:**

- `src/RugbyRadioWeb/src/assets/static/ai-talkers.html`
- eventuali link interni

Rimuovere la pagina pubblica separata `/ai-talkers` senza alias o redirect.

**Acceptance criteria**

- `src/RugbyRadioWeb/src/assets/static/ai-talkers.html` non esiste piu.
- Non ci sono rewrite Firebase per `/ai-talkers`.
- Non ci sono redirect verso `/team`.
- Non ci sono link interni a `assets/static/ai-talkers.html`.

**Validazione**

- `rg "ai-talkers|AiTalkers|AI-Talkers" src/RugbyRadioWeb`
- I riferimenti testuali legittimi al concetto AI-Talkers possono restare, ma non linkare la pagina rimossa.

### MT-T11 - Aggiornare link interni a Team

**Tipo:** navigazione / frontend  
**Dipendenze:** MT-T04, MT-T10  
**File osservati:**

- `src/RugbyRadioWeb/src/app/site/header/header.component.ts`
- `src/RugbyRadioWeb/src/app/site/home/home-help/home-help.component.html`
- eventuali traduzioni CTA in `src/RugbyRadioWeb/src/assets/i18n/*.json`

Sostituire i link o metodi che aprono `assets/static/ai-talkers.html` con `/team`.

**Acceptance criteria**

- Header/menu apre `/team`.
- Home help CTA apre `/team`.
- Le label possono restare "AI-Talkers" se il contesto lo richiede, ma il target e Team.
- Nessun link punta al file rimosso.

### MT-T12 - Aggiornare sitemap e inventario SEO

**Tipo:** SEO / deploy  
**Dipendenze:** MT-T04, MT-T05, MT-T06, MT-T10  
**File previsti:** da individuare per `sitemap-static.xml` / inventory SEO

Aggiornare la sitemap statica o il relativo inventario SEO per:

- rimuovere `/ai-talkers`;
- aggiungere `/team`;
- aggiungere tutti i dettagli `/team-{slug}.html`.

**Acceptance criteria**

- La sitemap pubblica non contiene `/ai-talkers`.
- La sitemap pubblica contiene `/team`.
- La sitemap pubblica contiene tutti i dettagli membro.
- `src/RugbyRadioWeb/src/sitemap.xml` resta un sitemap index, salvo diversa decisione architetturale.

### MT-T13 - Aggiornare stili statici Team

**Tipo:** UI / CSS  
**Dipendenze:** MT-T04, MT-T06  
**File previsti:** `src/RugbyRadioWeb/src/assets/static/static-common.css` o CSS page-specific

Integrare stili necessari per:

- hero Team;
- griglia member card;
- profili dettaglio;
- blocchi example commentary;
- fun facts;
- related content;
- layout mobile.

**Acceptance criteria**

- Nessun testo esce dal contenitore su mobile.
- Card e bottoni hanno dimensioni stabili.
- La palette resta coerente con RRL e non diventa monocromatica.
- Le pagine sono fruibili con contenuti lunghi e lingue diverse.

### MT-T14 - Verificare accessibilita e fallback no-JS

**Tipo:** QA / accessibilita  
**Dipendenze:** MT-T04, MT-T05, MT-T06, MT-T13

Controllare:

- heading order;
- alt text;
- link name;
- focus states;
- contenuto primario visibile senza JS;
- lingua fallback;
- iframe lazy e immagini lazy.

**Acceptance criteria**

- Ogni immagine informativa ha alt text utile.
- I link CTA sono comprensibili fuori contesto.
- Senza JS, contenuto principale e link principali restano disponibili.

### MT-T15 - Verificare build e output statico

**Tipo:** QA / build  
**Dipendenze:** MT-T02-MT-T13

Eseguire build e controlli output.

**Validazione**

- `npm run build` da `src/RugbyRadioWeb`.
- Verificare output root:
  - `team.html`
  - `team-stefano.html`
  - tutti i `team-{slug}.html`
- Verificare assenza output `assets/static/ai-talkers.html`.
- Verificare che `firebase.json` abbia rewrite `/team`.

**Acceptance criteria**

- Build completata.
- I file statici richiesti sono presenti nel dist.
- Nessun file/link pubblico residuo per `/ai-talkers`.

### MT-T16 - Verificare pagine in browser

**Tipo:** QA / manuale-browser  
**Dipendenze:** MT-T15

Aprire e verificare:

- `/team`;
- almeno `team-stefano.html`;
- almeno 3 dettagli AI-Talker, inclusi uno con video e uno senza video;
- desktop e mobile.

**Acceptance criteria**

- Le pagine non sono blank.
- Hero, griglia, dettagli, footer, AdSense container e contenuti multilingua renderizzano.
- Link interni funzionano.
- Non ci sono overlap evidenti o testo tagliato.

### MT-T17 - Verificare tracking e monetizzazione

**Tipo:** QA / analytics  
**Dipendenze:** MT-T08, MT-T09, MT-T16

Controllare in ambiente locale o UAT:

- evento page view Team;
- click card membro;
- click discovery;
- click LinkedIn founder;
- eventuale click/play video;
- slot AdSense `2308901507`.

**Acceptance criteria**

- Gli eventi non lanciano errori JS.
- I parametri minimi sono valorizzati.
- AdSense non blocca rendering o layout.

### MT-T18 - Checklist pre-produzione founder

**Tipo:** release gate / contenuto  
**Dipendenze:** MT-T05

Prima della produzione:

- sostituire foto placeholder founder;
- sostituire bio placeholder founder;
- verificare motivazione e obiettivi futuri;
- confermare link LinkedIn;
- verificare social image founder.

**Acceptance criteria**

- Nessun testo placeholder resta nella pagina founder pubblica.
- Nessun asset placeholder founder resta in OG/Twitter image.
- Il contenuto founder e approvato per pubblicazione.

## Ordine consigliato di esecuzione

1. MT-T01
2. MT-T02
3. MT-T03
4. MT-T04
5. MT-T05
6. MT-T06
7. MT-T07
8. MT-T08
9. MT-T09
10. MT-T11
11. MT-T10
12. MT-T12
13. MT-T13
14. MT-T14
15. MT-T15
16. MT-T16
17. MT-T17
18. MT-T18

## Stato implementazione

Aggiornato dopo l'implementazione iniziale.

| Task | Stato | Note |
|---|---|---|
| MT-T01 | Completato | Inventario slug applicato a index, dettagli, SEO inventory e regole sitemap. |
| MT-T02 | Completato | Build Angular copia `team*.html` alla root del `dist`. |
| MT-T03 | Completato | Rewrite `/team -> /team.html` aggiunto per `prod` e `uat`. |
| MT-T04 | Completato | Creato `team.html` con founder, AI-Talkers, discovery, lingue e AdSense. |
| MT-T05 | Completato con placeholder | Pagina founder creata con LinkedIn; contenuti e foto finali restano release gate. |
| MT-T06 | Completato | Create tutte le pagine statiche AI-Talker previste. |
| MT-T07 | Completato | Metadata SEO/social presenti su tutte le pagine; JSON-LD inserito dove utile. |
| MT-T08 | Completato parziale | View e click tracking implementati; `team_video_play` richiede verifica/decisione tecnica su YouTube IFrame API o overlay dedicato. |
| MT-T09 | Completato | Tutte le 15 pagine Team usano `data-ad-slot="2308901507"`. |
| MT-T10 | Completato | File `ai-talkers.html` rimosso e nessun link/rewrite residuo trovato. |
| MT-T11 | Completato | Header e Home help puntano a `/team`. |
| MT-T12 | Completato | Aggiornati inventory SEO, regole pubbliche e candidate files del job sitemap. |
| MT-T13 | Completato | Stili Team aggiunti in `static-common.css`. |
| MT-T14 | Completato a livello statico | Alt/link/no-JS fallback impostati; resta raccomandata verifica browser manuale su device reali. |
| MT-T15 | Completato | Build frontend e backend completate; output statico verificato. |
| MT-T16 | Bloccato in ambiente Codex | Browser in-app blocca `localhost`, `127.0.0.1` e `file://` per policy; serve verifica manuale/UAT. |
| MT-T17 | Parziale | Struttura analytics e AdSense presente; eventi GA e rendering annunci da verificare in UAT con `gtag`/AdSense reali. |
| MT-T18 | Aperto | Sostituire placeholder founder prima della produzione. |

## Definition of Done

- `/team` e tutti i `/team-{slug}.html` sono serviti come pagine statiche.
- `/ai-talkers` e il file `ai-talkers.html` sono rimossi senza redirect o alias.
- Tutti gli AI-Talkers attuali hanno una pagina dettaglio.
- Tutte le pagine hanno metadati SEO/social coerenti.
- Sitemap/inventory SEO aggiornato.
- Header/home/link interni puntano a `/team`.
- Analytics Team e AdSense `2308901507` integrati.
- Build completata e output verificato.
- Verifica browser desktop/mobile completata.
- Placeholder founder sostituiti o esplicitamente bloccati prima della produzione.
