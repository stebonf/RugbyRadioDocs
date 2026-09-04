# Analisi architetturale - Meet the Team

## Contesto

Fonte funzionale: `llm-wiki/artifacts/analysis/analisi-funzionale-meet-team.md`.

La feature introduce un hub pubblico statico `/team` e pagine dettaglio statiche `/team-{slug}.html` per founder e AI-Talkers. Sostituisce la pagina pubblica separata `/ai-talkers`, che deve essere rimossa senza alias o redirect.

L'architettura esistente di RRL separa frontend Angular, API backend, job backend e contenuti statici. La feature appartiene al perimetro frontend/static content: non modifica il dominio partita, la generazione degli eventi, i job AI, il database o le API.

## Driver architetturali

- Pagine pubbliche indicizzabili, senza login.
- URL canonico index: `/team`.
- URL dettagli: `/team-{slug}.html`.
- Rimozione pura di `/ai-talkers`, senza redirect o alias.
- Pagine statiche, non route Angular.
- Contenuti in tutte le lingue gia presenti negli statici attuali: `it`, `en`, `fr`, `es`, `ja`.
- Slot AdSense unico per index e dettagli: `2308901507`.
- Analytics GA per view, click membro, play video, click discovery e social click.
- Nessuna AI realtime e nessuna nuova promessa funzionale sugli AI-Talkers.
- Placeholder founder accettati in MVP, da sostituire prima della produzione.

## Architettura proposta

La soluzione resta interamente nel frontend web:

```mermaid
flowchart TD
  U["Utente / crawler"] --> H["Firebase Hosting"]
  H -->|/team| R["Rewrite a team.html"]
  H -->|/team-{slug}.html| D["File statici root"]
  R --> T["Meet Team index statico"]
  D --> M["Dettaglio membro statico"]
  T --> C["static-common.css/js"]
  M --> C
  T --> A["GA + AdSense"]
  M --> A
  T --> P["Pagine pubbliche Angular e blog"]
  M --> T
```

Decisione consigliata:

- Tenere le sorgenti HTML sotto `src/RugbyRadioWeb/src/assets/static/` per continuita editoriale con `tutorial.html`, `why.html`, `news.html` e `architecture.html`.
- Pubblicare gli HTML Team anche alla root del build usando una configurazione assets dedicata, cosi `/team-stefano.html` e gli altri dettagli sono file reali e non route Angular.
- Aggiungere in Firebase solo il rewrite `/team -> /team.html`, analogo al rewrite `/architecture -> /assets/static/architecture.html`, ma puntato al file root generato.
- Non aggiungere rewrite, redirect o fallback per `/ai-talkers`.

## Component design

### Static pages

Nuovi file sorgente consigliati:

- `src/RugbyRadioWeb/src/assets/static/team.html`
- `src/RugbyRadioWeb/src/assets/static/team-stefano.html`
- `src/RugbyRadioWeb/src/assets/static/team-vox.html`
- `src/RugbyRadioWeb/src/assets/static/team-nitro.html`
- `src/RugbyRadioWeb/src/assets/static/team-beat-breaker.html`
- `src/RugbyRadioWeb/src/assets/static/team-orfeo.html`
- `src/RugbyRadioWeb/src/assets/static/team-zoe.html`
- `src/RugbyRadioWeb/src/assets/static/team-maul.html`
- `src/RugbyRadioWeb/src/assets/static/team-zorblax.html`
- `src/RugbyRadioWeb/src/assets/static/team-elixir.html`
- `src/RugbyRadioWeb/src/assets/static/team-bulldog.html`
- `src/RugbyRadioWeb/src/assets/static/team-el-mangiapolenta.html`
- `src/RugbyRadioWeb/src/assets/static/team-trasteverino.html`
- `src/RugbyRadioWeb/src/assets/static/team-newsly.html`
- `src/RugbyRadioWeb/src/assets/static/team-brushy.html`

Ogni pagina usa:

- `src/assets/css/rrl.css`
- `assets/static/static-common.css`
- `assets/static/static-common.js`
- `assets/static/footer.component.html`

Per i file serviti alla root, i riferimenti relativi `assets/static/...` restano validi.

### Build assets

`src/RugbyRadioWeb/angular.json` gia copia `src/assets` in `/assets`. Per servire i dettagli al root path richiesto, aggiungere un asset glob dedicato:

```json
{
  "glob": "team*.html",
  "input": "src/assets/static",
  "output": "/"
}
```

Questo produce:

- `/team.html`
- `/team-stefano.html`
- `/team-vox.html`
- altri dettagli.

`/team` richiede comunque una regola hosting per puntare a `/team.html`.

### Firebase hosting

Aggiornare entrambi i target `prod` e `uat` in `src/RugbyRadioWeb/firebase.json`:

```json
{ "source": "/team", "destination": "/team.html" }
```

La regola deve precedere il fallback `{ "source": "**", "destination": "/index.html" }`.

Non aggiungere regole per `/ai-talkers`.

### Link interni

Rimuovere tutti i link verso `assets/static/ai-talkers.html` e sostituirli con `/team`.

Punti osservati:

- `src/RugbyRadioWeb/src/app/site/header/header.component.ts`
- `src/RugbyRadioWeb/src/app/site/home/home-help/home-help.component.html`

Verificare anche footer statico, eventuali traduzioni CTA e altri riferimenti con ricerca testuale.

### Static common JS

`static-common.js` oggi gestisce:

- lingua da `localStorage`;
- attivazione dei blocchi `[data-lang]`;
- lazy loading degli iframe;
- footer statico;
- evento GA generico `static_page_viewed`.

Per Meet Team estendere senza rompere gli statici esistenti:

- mantenere `static_page_viewed`;
- aggiungere listener delegati per elementi con `data-track-event`;
- emettere eventi specifici `team_member_click`, `team_video_play`, `team_discovery_click`, `team_social_click`;
- includere `member_id`, `member_type`, `target_area`, `video_id` quando presenti come `data-*`.

## Data e contenuti

Non serve persistenza applicativa. I dati sono editoriali statici, versionati nel repository.

Campi consigliati per ogni membro:

| Campo | Uso |
|---|---|
| `slug` | Nome file e tracking |
| `name` | Titolo pagina e card |
| `member_type` | `founder` o `ai_talker` |
| `role` | Ruolo nel team |
| `style` | Stile comunicativo per AI-Talker |
| `languages` | Lingue supportate |
| `short_description` | Card index |
| `long_description` | Dettaglio |
| `hero_image` | Hero/social image |
| `card_image` | Griglia index |
| `video_url` | Embed opzionale |
| `commentary_examples` | Testi inventati editorialmente |
| `fun_facts` | Sezione dettaglio |
| `related_links` | Team, matches, channels, tutorial, blog |
| `seo` | title, description, canonical, OG, Twitter |

Per evitare duplicazione manuale fuori scala, e consigliabile generare o mantenere i blocchi da una struttura dati editoriale locale, anche se l'MVP puo restare HTML statico manuale.

## SEO e sitemap

Ogni pagina deve avere:

- canonical coerente: `https://rugbyradiolive.com/team` o `https://rugbyradiolive.com/team-{slug}.html`;
- `og:url` allineato al canonical;
- `og:image` dedicata o fallback coerente;
- Twitter Card `summary_large_image`;
- `title` e `meta description` specifici;
- structured data JSON-LD dove utile.

Structured data:

- Founder: `Person` e/o `ProfilePage`, usando LinkedIn come `sameAs`.
- AI-Talker: evitare `Person` se rischia di farli sembrare persone reali; preferire `ProfilePage` o `WebPage` con descrizione chiara di personaggio virtuale.

Sitemap:

- Rimuovere ogni riferimento a `/ai-talkers`.
- Inserire `/team`.
- Inserire tutti i dettagli `/team-{slug}.html`.
- Verificare se l'inserimento avviene in `sitemap-static.xml` generata su `seo-sh.rugbyradiolive.com` o in altro punto della pipeline SEO. Il root `src/sitemap.xml` e un sitemap index e non dovrebbe diventare una lista diretta di URL.

## Analytics e monetizzazione

### Analytics

Eventi consigliati:

| Evento | Trigger | Parametri |
|---|---|---|
| `team_page_view` | Caricamento `/team` | `language`, `page_path` |
| `team_detail_view` | Caricamento dettaglio | `member_id`, `member_type`, `language` |
| `team_member_click` | Click card o CTA membro | `member_id`, `member_type`, `source_section` |
| `team_video_play` | Avvio video rilevabile | `member_id`, `video_id`, `provider` |
| `team_discovery_click` | Click verso matches/channels/tutorial/how-to/blog | `target_area`, `target_url`, `source_page` |
| `team_social_click` | Click LinkedIn founder | `member_id`, `platform` |

Per YouTube iframe, il tracking play richiede YouTube IFrame API o un proxy click su overlay. Se non viene introdotta l'API, tracciare almeno click sull'embed o sulla CTA video.

### AdSense

Usare lo slot `2308901507` su:

- index `/team`;
- dettagli `/team-{slug}.html`.

Posizionamenti consigliati:

- sotto hero per index;
- meta pagina o fondo pagina per dettaglio;
- evitare inserimenti dentro card membro per non compromettere UX e crawlability.

## Sicurezza, privacy e compliance

- Nessuna nuova API e nessun nuovo dato utente.
- Nessun nuovo permesso o autenticazione.
- Link esterni con `target="_blank"` devono usare `rel="noopener noreferrer"`.
- I contenuti founder placeholder devono essere chiaramente tracciabili internamente come da sostituire prima della produzione.
- Gli AI-Talkers devono essere descritti come personaggi virtuali per evitare ambiguita identitaria.
- YouTube e AdSense introducono script/iframe terzi gia presenti negli statici attuali; mantenere lazy loading e fallback leggibile.

## Performance e accessibilita

- Usare immagini WebP o asset gia ottimizzati da storage.
- Definire `width`/`height` o layout stabile per immagini hero/card.
- Usare `loading="lazy"` per immagini non hero e iframe.
- Caricare iframe video solo per lingua attiva, come gia fa `static-common.js`.
- Usare heading gerarchici e alt text descrittivi.
- Evitare che placeholder o testi lunghi rompano card e bottoni su mobile.
- Verificare che le pagine statiche funzionino anche senza JS: contenuto primario, link e metadati devono essere HTML reale.

## Deployment e rollout

Sequenza consigliata:

1. Creare nuovi file statici Team e dettaglio.
2. Aggiungere asset glob `team*.html` al build Angular.
3. Aggiungere rewrite `/team -> /team.html` in `firebase.json` per `prod` e `uat`.
4. Aggiornare link interni da `ai-talkers.html` a `/team`.
5. Rimuovere `src/RugbyRadioWeb/src/assets/static/ai-talkers.html`.
6. Aggiornare sitemap statica generata o relativo inventario SEO.
7. Verificare build, output `dist`, URL `/team`, URL `/team-{slug}.html`, assenza di `/ai-talkers`.
8. Prima della produzione, sostituire placeholder founder con contenuti approvati.

Controlli minimi:

- `npm run build` da `src/RugbyRadioWeb`.
- Ispezione output: `dist/rugby-radio-web/browser/team.html` e dettagli.
- Ricerca residui `ai-talkers`.
- Validazione manuale o browser di `/team` e almeno un dettaglio desktop/mobile.
- Controllo metadati SEO su HTML generato.

## Alternative considerate

| Alternativa | Pro | Contro | Esito |
|---|---|---|---|
| Route Angular `/team` e `/team/:slug` | Riutilizzo componenti Angular | Non rispetta vincolo pagine statiche indicizzabili | Scartata |
| Solo file in `/assets/static/team.html` | Pattern simile agli statici attuali | URL pubblico non sarebbe `/team` senza rewrite; dettagli non rispettano `/team-{slug}.html` | Parziale |
| Rewrite Firebase per ogni dettaglio | Non cambia asset build | Duplicazione di regole per molti membri | Non preferita |
| Asset glob root `team*.html` + rewrite solo `/team` | URL richiesti, statico reale, poche regole hosting | Richiede aggiornamento `angular.json` | Raccomandata |
| Redirect `/ai-talkers -> /team` | Preserva traffico vecchio | Contraddice decisione di rimozione pura | Scartata |

## Rischi e mitigazioni

| Rischio | Impatto | Mitigazione |
|---|---|---|
| `/ai-talkers` gia indicizzato senza redirect | Possibile perdita SEO breve periodo | Rimuovere da sitemap/link interni e monitorare Search Console |
| Molti HTML statici duplicano struttura | Manutenzione onerosa | Estrarre pattern editoriale o usare script di generazione in step successivo |
| Placeholder founder dimenticati in produzione | Branding debole o non approvato | Checklist release bloccante su contenuti founder |
| Iframe YouTube multipli pesanti | Performance mobile peggiore | Lazy loading e caricamento solo lingua attiva |
| Confusione tra AI-Talker e persone reali | Rischio comunicativo | Copy e structured data coerenti con "personaggio virtuale" |
| Sitemap su host SEO separato | Aggiornamento non evidente dal solo frontend | Individuare pipeline `sitemap-static.xml` prima dell'implementazione |

## Requirement traceability

| Requisiti funzionali | Decisione architetturale |
|---|---|
| MT-001, MT-001A | `/team` servito via rewrite Firebase a `team.html` statico |
| MT-009, MT-206 | Rimozione file/link/sitemap `/ai-talkers`, nessun redirect |
| MT-010, MT-108 | Blocchi `[data-lang]` e `static-common.js` per lingue esistenti |
| MT-101, MT-107, MT-110 | File statici root `/team-{slug}.html` |
| MT-201, MT-202 | Metadati per ogni HTML statico |
| MT-203 | Aggiornamento sitemap statica/SEO inventory |
| MT-204, MT-205 | JSON-LD differenziato founder vs AI-Talker |
| MT-301-MT-305 | Estensione tracking in `static-common.js` |
| MT-401-MT-403 | Slot AdSense `2308901507` nei template statici |

## Punti aperti tecnici

- Dove viene generata oggi `https://seo-sh.rugbyradiolive.com/sitemap-static.xml` e quale file/config va aggiornato per includere `/team` e dettagli.
- Slug finali approvati per tutti i membri, soprattutto `beat-breaker` ed `el-mangiapolenta`.
- Immagini placeholder founder e asset social provvisori da usare fino alla sostituzione pre-produzione.
- Se il tracking video richiede YouTube IFrame API o se basta tracciare click/interazione sull'embed.
