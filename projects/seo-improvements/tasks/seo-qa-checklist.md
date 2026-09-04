# SEO QA CHECKLIST

## Scope

Checklist operativa per validare modifiche SEO di Rugby Radio Live prima e dopo il deploy.

Dominio canonico:

https://rugbyradiolive.com

Sitemap principali:

- https://rugbyradiolive.com/sitemap.xml
- https://rugbyradiolive.com/sitemap-static.xml
- https://rugbyradiolive.com/sitemap-matches.xml
- https://rugbyradiolive.com/sitemap-channels.xml
- https://rugbyradiolive.com/sitemap-teams.xml
- https://blog.rugbyradiolive.com/sitemap.xml

Campione minimo URL:

- `https://rugbyradiolive.com/`
- `https://rugbyradiolive.com/g-matches`
- `https://rugbyradiolive.com/g-channels`
- `https://rugbyradiolive.com/g-stats`
- una URL `g-match` inclusa in `sitemap-matches.xml`
- una URL `g-channel` inclusa in `sitemap-channels.xml`
- una URL `g-team` inclusa in `sitemap-teams.xml`
- una pagina statica: `/tutorial`, `/how-to`, `/news`, `/why`, `/ai-talkers`, `/terms`
- un post blog lowercase: `https://blog.rugbyradiolive.com/en/{matchId-lowercase}.html`

---

## Pre-Deploy

### Build

- [ ] Eseguire `npm run -s build` in `src/RugbyRadioWeb` se sono cambiati frontend, metadata Angular, statiche, robots o sitemap transitoria.
- [ ] Eseguire `dotnet build src/RugbyRadio/HF/HF.csproj -v minimal` se sono cambiati job, sitemap backend, blog statico o servizi SEO.
- [ ] Verificare che eventuali warning siano noti o non collegati alla modifica SEO.
- [ ] Verificare che `src/RugbyRadioWeb/src/robots.txt` sia incluso nel build output.

### Canonical

- [ ] Ogni URL pubblica indicizzabile deve avere canonical assoluta su `https://rugbyradiolive.com` o `https://blog.rugbyradiolive.com`.
- [ ] Nessuna canonical deve puntare a `www.rugbyradiolive.com`.
- [ ] Nessuna canonical deve puntare a `/index.html`.
- [ ] Le URL blog generate devono usare lingua lowercase e `matchId` lowercase.
- [ ] Blog e `g-match` devono restare pagine distinte: il blog canonicalizza verso il blog, non verso `g-match`.
- [ ] Il post blog deve linkare la partita con `https://rugbyradiolive.com/g-match/{matchId-lowercase}`.

### Metadata

- [ ] Home, `g-matches`, `g-channels`, `g-stats` hanno title e description specifici.
- [ ] `g-match` usa metadata dinamici con squadre, data/stato o punteggio quando disponibili.
- [ ] `g-channel` e `g-team` usano metadata dinamici con nome entita e fallback sicuro.
- [ ] Le statiche principali hanno title, description, canonical e Open Graph dedicati.
- [ ] Navigando tra pagine Angular non si accumulano tag duplicati `title`, `description`, `canonical`, Open Graph o JSON-LD.
- [ ] JSON-LD deve essere valido JSON e non contenere placeholder non sostituiti.

### Sitemap

- [ ] `GenerateSeoSitemapJob` deve essere eseguibile senza modificare dati applicativi.
- [ ] `SeoSitemap:OutputPath` punta alla cartella pubblicata dal sito principale.
- [ ] `sitemap.xml` deve essere un sitemap index, non un urlset misto.
- [ ] Il sitemap index deve referenziare sitemap statiche, match, canali, squadre e blog.
- [ ] Le sitemap sezionali devono includere solo URL canoniche e indicizzabili.
- [ ] `sitemap-matches.xml` deve includere solo match che rispettano la policy: FullTime, squadre presenti, almeno 10 eventi, blog statico associato, no test channel.
- [ ] `lastmod` deve derivare da data contenuto realistica quando disponibile.
- [ ] Nessuna URL in sitemap deve contenere `www`, `/assets/static/`, `/user-`, uppercase blog language directory o `index.html` non canonico.

### Robots

- [ ] `robots.txt` deve essere servibile a `/robots.txt`.
- [ ] Deve dichiarare `Sitemap: https://rugbyradiolive.com/sitemap.xml`.
- [ ] Deve dichiarare o permettere discovery della sitemap blog.
- [ ] Non deve bloccare JS, CSS, immagini o asset necessari al rendering.
- [ ] Non deve esporre regole contraddittorie con le sitemap.

### XML

- [ ] Validare `sitemap.xml` e sitemap sezionali come XML well-formed.
- [ ] Verificare namespace `http://www.sitemaps.org/schemas/sitemap/0.9`.
- [ ] Ogni `<loc>` deve essere assoluto `https://`.
- [ ] Nessun `<loc>` duplicato dentro la stessa sitemap.
- [ ] Date `<lastmod>` in formato ISO accettato dai crawler.
- [ ] Nessun carattere non escapato in URL o testo XML.

---

## Post-Deploy

### HTTP

- [ ] `https://rugbyradiolive.com/` risponde 200.
- [ ] `https://www.rugbyradiolive.com/` redirige o canonicalizza verso `https://rugbyradiolive.com/`.
- [ ] `http://rugbyradiolive.com/` redirige a HTTPS.
- [ ] `/index.html` redirige o canonicalizza verso `/`.
- [ ] Le URL campione in sitemap rispondono 200.
- [ ] Le URL escluse principali non compaiono in sitemap: `/user-*`, login/registrazione/reset, utility/debug.
- [ ] I post blog uppercase legacy devono redirigere o non essere linkati/sitemappati; la variante lowercase deve essere quella canonica.

### Head Renderizzato

- [ ] Aprire campione URL e verificare nel DOM finale: un solo canonical, title corretto, description presente.
- [ ] Verificare Open Graph `og:title`, `og:description`, `og:url`, `og:type`.
- [ ] Verificare `twitter:card`, `twitter:title`, `twitter:description` dove previsti.
- [ ] Su post blog verificare `hreflang` per `it`, `en`, `fr`, `es`, `ja`, `x-default`.
- [ ] Su post blog verificare link CTA verso `g-match`.
- [ ] Su `g-match` verificare link verso canale/squadre/blog quando disponibili.

### Sitemap Live

- [ ] Aprire `https://rugbyradiolive.com/sitemap.xml` e verificare che sia aggiornato.
- [ ] Aprire ogni sitemap referenziata dal root.
- [ ] Verificare che la sitemap blog live sia raggiungibile.
- [ ] Prelevare almeno una URL per sezione e aprirla nel browser.
- [ ] Controllare che la URL campione in sitemap abbia canonical uguale a sé stessa.

---

## GSC URL Inspection

Usare Google Search Console su un campione ridotto dopo ogni deploy SEO significativo.

### Campione

- [ ] Home.
- [ ] `g-matches`.
- [ ] Una pagina `g-match` in sitemap.
- [ ] Una pagina `g-channel` in sitemap.
- [ ] Una pagina `g-team` in sitemap.
- [ ] Una pagina statica.
- [ ] Un post blog lowercase.

### Controlli

- [ ] URL è accessibile a Google.
- [ ] Canonical dichiarata = canonical scelta da Google, oppure differenza spiegabile.
- [ ] Pagina è indicizzabile, non `noindex`.
- [ ] Ultima scansione non segnala blocchi robots.
- [ ] Screenshot/rendering non mostra pagina vuota o contenuto principale mancante.
- [ ] La URL è presente nella sitemap dichiarata.
- [ ] Richiedere indicizzazione solo per URL strategiche o appena corrette.

### Dopo 7-14 Giorni

- [ ] Controllare Coverage per nuove pagine "Scansionata, ma attualmente non indicizzata".
- [ ] Controllare duplicati canonical e alternative canonical.
- [ ] Controllare Performance per CTR su home, `g-match`, blog e statiche.
- [ ] Se aumenta il numero di duplicate/canonical mismatch, aprire task correttivo prima di nuove landing.

---

## Rollback

### Quando Fare Rollback

- [ ] Sitemap root non valida o non raggiungibile.
- [ ] `robots.txt` blocca risorse o pagine indicizzabili.
- [ ] Canonical punta al dominio sbagliato o a URL non 200.
- [ ] Redirect crea loop o porta a path errato.
- [ ] Blog post generati con URL/hreflang incoerenti tra lingue.
- [ ] Build o job sitemap fallisce in produzione.

### Azioni

- [ ] Ripristinare ultimo build frontend funzionante se il problema e in `robots.txt`, statiche, metadata Angular o asset.
- [ ] Ripristinare ultimi file sitemap validi se il problema e nel job sitemap.
- [ ] Disabilitare temporaneamente la schedulazione di `GenerateSeoSitemapJob` se genera output non valido.
- [ ] Disabilitare temporaneamente `CreateMatchBlogHtmlJob` se genera post blog duplicati o canonical errati.
- [ ] In GSC non inviare nuove richieste di indicizzazione finche canonical/robots/sitemap non sono stabilizzati.
- [ ] Documentare URL impattate, ora del rollback e verifica post-rollback.

---

## Done Definition

Un deploy SEO e pronto quando:

- [ ] Build frontend/backend necessari sono ok.
- [ ] Sitemap e robots live sono raggiungibili e coerenti.
- [ ] Campione URL passa controlli canonical, metadata e HTTP.
- [ ] XML sitemap validi e senza URL escluse.
- [ ] GSC URL Inspection passa sul campione critico o segnala solo stati attesi.
- [ ] Esiste un piano di rollback applicabile entro pochi minuti.
