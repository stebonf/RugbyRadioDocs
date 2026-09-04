# SEO MONTHLY REPORT TEMPLATE

## Scope

Template mensile per monitorare SEO Rugby Radio Live usando export manuali GSC, GA, AdSense e dati piattaforma.

Non integra API. Il report va compilato copiando i valori dagli export archiviati in `llm-wiki/raw`.

Periodo report:

`YYYY-MM-01` - `YYYY-MM-DD`

Mese confronto:

`YYYY-MM-1`

Baseline utile:

- GSC 2026-01/2026-04: 302 clic, 8422 impressioni.
- GSC mobile 2026-01/2026-04: 260 clic, 5296 impressioni, CTR 4.91%, posizione 7.79.
- GSC coverage 2026-05: 109 pagine scansionate ma non indicizzate, 5 duplicate senza canonical selezionato, 18 alternative con canonical appropriato.
- GA marzo 2026: 142 utenti attivi, 133 nuovi utenti, 215.9 durata media coinvolgimento, 4840 eventi.
- AdSense 2026-01/2026-04: 0.33 EUR totali.

---

## 1. Executive Summary

### Sintesi

- Stato organico del mese:
- Variazione principale rispetto al mese precedente:
- Rischio SEO principale:
- Opportunita principale:
- Azione raccomandata per il prossimo mese:

### Health Score

Assegnare colore e motivazione:

| Area | Stato | Motivo |
|---|---|---|
| Discovery sitemap | Green / Yellow / Red | |
| Index coverage | Green / Yellow / Red | |
| Organic performance | Green / Yellow / Red | |
| CTR SERP | Green / Yellow / Red | |
| Blog/static SEO | Green / Yellow / Red | |
| Monetizzazione UX | Green / Yellow / Red | |

Regola pratica:

- Green: metrica stabile o in miglioramento, nessun blocco tecnico.
- Yellow: metrica peggiora fino al 20% o contiene issue controllabile.
- Red: peggioramento oltre 20%, canonical/robots/sitemap rotti, o molte pagine strategiche non indicizzabili.

---

## 2. Dati Richiesti

### Export GSC

- Performance query.
- Performance pagine.
- Performance dispositivi.
- Performance paesi.
- Index coverage problemi critici.
- Index coverage problemi non critici.
- Pagine indicizzate.
- Pagine scansionate ma non indicizzate.
- Dati sitemap/status se esportabili.
- Core Web Vitals se disponibile.

### Export GA

- Landing page organiche.
- Sorgente/mezzo con filtro `google / organic`.
- Utenti attivi.
- Nuovi utenti.
- Sessioni o visualizzazioni.
- Durata media coinvolgimento.
- Event count.
- Eventi conversione soft se configurati: follow canale, share, login/registration, creazione canale, apertura match.
- Device category.

### Export AdSense

- Earnings.
- Impressions.
- Clicks.
- Ad requests.
- CTR annunci.
- RPM pagina o impression RPM se disponibile.
- Breakdown per ad unit o placement: HOME, BLOG-MATCH, G-MATCH-EVENTS, statiche.

### Export Piattaforma

- Users.
- Channels.
- Matches.
- Teams.
- Players.
- Events.
- Blog statici generati nel mese.
- Nuovi match idonei alla sitemap secondo policy.

---

## 3. KPI Principali

### GSC Performance

| KPI | Mese corrente | Mese precedente | Delta | Delta % | Interpretazione |
|---|---:|---:|---:|---:|---|
| Clic organici | | | | | |
| Impressioni | | | | | |
| CTR | | | | | |
| Posizione media | | | | | |
| Query con clic | | | | | |
| Pagine con clic | | | | | |
| Pagine con impressioni e 0 clic | | | | | |

Formule:

- `CTR = clic / impressioni`.
- `Delta = mese corrente - mese precedente`.
- `Delta % = delta / mese precedente`.
- `Pagine zero clic = count(pagine dove impressioni > 0 e clic = 0)`.
- `Opportunity CTR = impressioni * (CTR target - CTR attuale)` per pagine con posizione media 3-12.

Interpretazione:

- Clic su, impressioni su: crescita sana.
- Impressioni su, CTR giu: problema snippet/title/intent.
- Posizione stabile, CTR giu: title/description o SERP feature da rivedere.
- Impressioni giu, posizione giu: perdita ranking o discovery.
- Pagine zero clic alte: priorita a metadata e contenuto above-the-fold.

### GSC Device

| Device | Clic | Impressioni | CTR | Posizione | Nota |
|---|---:|---:|---:|---:|---|
| Mobile | | | | | |
| Desktop | | | | | |
| Tablet | | | | | |

Interpretazione:

- Mobile e il canale dominante nella baseline. Peggioramenti mobile pesano piu dei desktop.
- Se mobile CTR scende ma desktop no, controllare snippet mobile, velocita e layout above-the-fold.

### GSC Query

Top query per clic:

| Query | Clic | Impressioni | CTR | Posizione | Pagina principale | Azione |
|---|---:|---:|---:|---:|---|---|
| | | | | | | |

Query opportunita:

| Query | Impressioni | CTR | Posizione | Pagina candidata | Task derivabile |
|---|---:|---:|---:|---|---|
| live rugby commentary today | | | | `/`, `/g-matches`, landing dedicata | |
| live rugby commentary | | | | `/`, landing dedicata | |
| rugby radio live | | | | `/` | |
| live rugby on radio today | | | | `/g-matches`, landing dedicata | |

Regola opportunita:

- Priorita alta se posizione 3-12, impressioni alte, CTR sotto media sito.
- Priorita media se posizione 13-30 e pagina gia pertinente.
- Priorita bassa se query non allineata al prodotto.

---

## 4. Index Coverage

| Stato GSC | Mese corrente | Mese precedente | Delta | Severita | Azione |
|---|---:|---:|---:|---|---|
| Indicizzate | | | | Info | |
| Scansionata, ma attualmente non indicizzata | | | | High | |
| Duplicata senza canonical selezionato dall'utente | | | | High | |
| Alternativa con canonical appropriato | | | | Medium | |
| Pagina con reindirizzamento | | | | Low/Medium | |
| 404 | | | | Medium | |
| 403 | | | | High | |
| 5xx | | | | Critical | |

Interpretazione:

- `Scansionata, ma attualmente non indicizzata` alta: contenuto sottile, metadata deboli, linking o qualita.
- Duplicate senza canonical: controllare redirect, canonical, lowercase blog.
- Alternative canonical appropriate: accettabile se prevista da redirect/canonical strategy.
- 5xx o 403: aprire task tecnico immediato.

Campione da analizzare ogni mese:

- 10 URL `g-match` non indicizzate.
- 5 URL blog non indicizzate.
- 5 URL statiche o landing.
- Tutte le URL con 5xx/403.

---

## 5. Sitemap E Discovery

| Sitemap | URL count | Lastmod recente | Status GSC | Errori | Note |
|---|---:|---|---|---|---|
| `sitemap.xml` | | | | | |
| `sitemap-static.xml` | | | | | |
| `sitemap-matches.xml` | | | | | |
| `sitemap-channels.xml` | | | | | |
| `sitemap-teams.xml` | | | | | |
| blog sitemap | | | | | |

Controlli:

- Root sitemap e sitemap sezionali raggiungibili.
- URL count coerente con inventory pubblica.
- Nessuna URL esclusa: `/user-*`, `/assets/static/`, `www`, uppercase blog, pagine test.
- Match in sitemap rispettano policy indicizzabilita.
- Blog sitemap usa URL lowercase.

Task derivabili:

- URL canonica mancante in sitemap: correggere inventory/job sitemap.
- URL esclusa in sitemap: correggere regole SEO inventory.
- Sitemap non aggiornata: controllare schedulazione `GenerateSeoSitemapJob`.
- Blog sitemap errata: controllare `CreateMatchBlogHtmlJob`.

---

## 6. GA Organic Landing

Filtro consigliato:

`session source / medium = google / organic`

| Landing page | Utenti | Nuovi utenti | Sessioni/Views | Durata media coinvolgimento | Eventi | Conversioni soft | Nota |
|---|---:|---:|---:|---:|---:|---:|---|
| `/` | | | | | | | |
| `/g-matches` | | | | | | | |
| `/g-match/{id}` | | | | | | | |
| `/g-channel/{id}` | | | | | | | |
| `/g-team/{id}` | | | | | | | |
| blog post | | | | | | | |
| statiche | | | | | | | |

KPI:

- Organic users.
- Organic new users.
- Organic engagement time.
- Organic event count.
- Organic soft conversion rate.

Formule:

- `Soft conversion rate = conversioni soft / sessioni organiche`.
- `Engaged value proxy = utenti organici * durata media coinvolgimento`.
- `Organic event density = eventi organici / utenti organici`.

Interpretazione:

- Molte impressioni GSC ma pochi utenti GA: problema CTR o snippet.
- Molti utenti GA ma basso engagement: intent mismatch o UX.
- Alto engagement su pagina con poche impressioni: candidata a linking interno/sitemap/landing expansion.

---

## 7. AdSense E UX

| KPI | Mese corrente | Mese precedente | Delta | Nota |
|---|---:|---:|---:|---|
| Earnings EUR | | | | |
| Impressions | | | | |
| Clicks | | | | |
| Ad requests | | | | |
| Ad CTR | | | | |
| RPM | | | | |

Per placement:

| Placement | Earnings | Impressions | Clicks | Requests | CTR | Rischio UX |
|---|---:|---:|---:|---:|---:|---|
| HOME | | | | | | |
| BLOG-MATCH | | | | | | |
| G-MATCH-EVENTS | | | | | | |
| Pagine Statiche | | | | | | |

Formule:

- `Ad CTR = clicks / impressions`.
- `RPM = earnings / pageviews * 1000` se pageviews disponibile.
- `Earnings per organic user = earnings / organic users`.

Interpretazione:

- Baseline revenue bassa: non sacrificare UX o Core Web Vitals per AdSense finche traffico organico e CTR SERP non crescono.
- Se placement ha revenue minima e peggiora engagement/CWV, ridurlo o spostarlo.

---

## 8. Core Web Vitals

Compilare se disponibili da GSC, CrUX o PageSpeed Insights.

| URL group | LCP | INP | CLS | Stato mobile | Stato desktop | Azione |
|---|---:|---:|---:|---|---|---|
| Home | | | | | | |
| GMatch | | | | | | |
| Blog | | | | | | |
| Statiche | | | | | | |

Soglie:

- LCP buono: <= 2.5s.
- INP buono: <= 200ms.
- CLS buono: <= 0.1.

Interpretazione:

- CWV peggiora dopo AdSense: rivedere placement/lazy loading.
- CWV peggiora su `g-match`: priorita alta per SEO e UX mobile.

---

## 9. Pagine Zero Clic

Top pagine con impressioni e 0 clic:

| URL | Impressioni | Posizione | Tipo | Problema probabile | Azione |
|---|---:|---:|---|---|---|
| | | | `g-match` / blog / static / channel / team | | |

Classificazione:

- `Snippet`: title/description non promettono valore.
- `Intent`: pagina non risponde bene alla query.
- `Thin`: contenuto debole o non renderizzato nel primo HTML.
- `Duplicate`: canonical/URL competing.
- `Discovery`: poco linking interno.

Task derivabili:

- Riscrivere title/description.
- Aggiungere contenuto above-the-fold.
- Aggiungere link interni da blog/home/statiche.
- Valutare prerender/SSR.
- Escludere da sitemap se non abbastanza forte.

---

## 10. Backlog Derivato

| Priorita | Segnale | Evidenza | Task proposto | Owner | Scadenza |
|---|---|---|---|---|---|
| P0 | 5xx/403 o sitemap rotta | | | | |
| P1 | Canonical duplicate o mismatch | | | | |
| P1 | Pagine strategiche zero clic | | | | |
| P1 | Match validi non in sitemap | | | | |
| P2 | Query opportunita posizione 3-12 CTR basso | | | | |
| P2 | AdSense peggiora UX senza revenue | | | | |
| P3 | CWV borderline | | | | |

Regola priorita:

- P0: impedisce crawling/indexing o rompe produzione.
- P1: impatta pagine organiche strategiche.
- P2: migliora crescita o revenue senza blocco.
- P3: ottimizzazione o osservazione.

---

## 11. Decisioni Del Mese

- Continuare, fermare o modificare sitemap generation:
- URL/pagine da aggiungere in sitemap:
- URL/pagine da rimuovere o noindex:
- Landing editoriali da creare:
- Metadata da riscrivere:
- Placement AdSense da mantenere/rimuovere:
- Esperimenti CTR da avviare:

---

## 12. Appendice Fonti

Inserire link o path dei file usati:

| Fonte | Path / Export | Periodo | Note |
|---|---|---|---|
| GSC performance query | `llm-wiki/raw/gcs/...` | | |
| GSC performance pagine | `llm-wiki/raw/gcs/...` | | |
| GSC coverage | `llm-wiki/raw/gcs/...` | | |
| GA | `llm-wiki/raw/ga/...` | | |
| AdSense | `llm-wiki/raw/adsense/...` | | |
| Platform stats | `llm-wiki/raw/dev/stats-...md` | | |
| Sitemap live snapshot | | | |
| CWV / PSI | | | se disponibile |

---

## Done Definition

Il report mensile e completo quando:

- [ ] Tutti i KPI obbligatori sono compilati o marcati "non disponibile".
- [ ] Clic, impressioni, CTR, coverage, zero-click pages, organic landing, AdSense e CWV sono coperti.
- [ ] Ogni peggioramento rilevante ha una interpretazione.
- [ ] Ogni issue P0/P1 ha un task derivato.
- [ ] Le azioni del mese precedente sono state verificate.
- [ ] Il report indica una sola priorita SEO principale per il mese successivo.
