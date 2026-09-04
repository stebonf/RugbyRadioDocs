---
type: functional-analysis
created: 2026-05-16T23:36:37+02:00
source: llm-wiki + seo-audit-generale-rrl
topic: "Miglioramento SEO Rugby Radio Live"
slug: miglioramento-seo-rrl
---

# Analisi funzionale: Miglioramento SEO Rugby Radio Live

## Sintesi

Il miglioramento SEO di Rugby Radio Live deve trasformare le pagine pubbliche gia presenti nel prodotto in asset organici chiari, indicizzabili, misurabili e orientati alla crescita. L'obiettivo funzionale non e solo aumentare visibilita, ma portare utenti coerenti con il prodotto: spettatori che cercano telecronache rugby live, club o cronisti che vogliono creare una radio/canale, visitatori che leggono recap partita e utenti interessati agli AI-Talker.

L'audit SEO `seo-audit-generale-rrl.md` evidenzia priorita funzionali: consolidare URL canoniche, rendere le pagine pubbliche comprensibili ai motori di ricerca, completare sitemap, differenziare contenuti e metadata, rafforzare blog statico e attivare monitoraggio SEO ricorrente.

## Ambito

Incluso:

- gestione URL canoniche e redirect funzionali;
- metadata SEO per home, pagine pubbliche Angular, pagine statiche e blog;
- sitemap pubbliche per discovery di pagine statiche, partite, canali, squadre e blog;
- pagine pubbliche SEO-ready per match, canali, squadre, statistiche, liste e landing editoriali;
- linking interno tra asset pubblici;
- differenziazione funzionale tra pagina live partita e post blog recap;
- monitoraggio SEO mensile con dati GSC, GA, AdSense e stati indicizzazione.

Escluso:

- implementazione tecnica SSR/prerender;
- scelta infrastrutturale definitiva per redirect/CDN/hosting;
- revisione completa UX o visual design;
- ricerca keyword esterna con volumi commerciali;
- piano editoriale dettagliato articolo per articolo.

## Fonti wiki usate

- [[Rugby Radio Live (product)]]
- [[Cronista (actor)]]
- [[Spettatore (actor)]]
- [[HomePage (web)]]
- [[GChannelsPage (web)]]
- [[GChannelPage (web)]]
- [[GMatchesPage (web)]]
- [[GMatchPage (web)]]
- [[GTeamPage (web)]]
- [[GStatsPage (web)]]
- [[BlogService (web)]]
- [[AnalyticsService (web)]]
- [[Public Sitemap (article)]]
- [[Static Blog SEO Headers (article)]]
- [[Pubblicazione Blog Statico (workflow)]]
- [[CreateMatchBlogJob (api)]]
- [[CreateMatchBlogHtmlJob (api)]]
- [[BlogV1Controller (api)]]
- [[StatsV1Controller (api)]]
- [[matchDto (web)]]
- [[channelPublicDto (web)]]
- [[teamPublicDto (web)]]
- [[blogDto (web)]]
- [[Partita (concept)]]
- [[Radio Canale (concept)]]
- [[AI-Talker (concept)]]
- [[Google Analytics Traffic 2026-01 2026-04 (analytic)]]
- [[Search Console Performance 2026-04 (analytic)]]
- [[Search Console Index Coverage 2026-05 (analytic)]]
- [[Platform Stats 2026-05-13 (analytic)]]
- [[AdSense Performance 2026-01 2026-04 (analytic)]]
- [[AdSense Placements 2026-05 (analytic)]]

## Attori del sistema

- **Spettatore anonimo** - Cerca una partita, un risultato o una telecronaca rugby live da Google e atterra su home, match, canale, squadra, blog o landing. Deve capire rapidamente se RRL risponde al suo bisogno.
- **Spettatore autenticato** - Dopo ingresso da traffico organico puo seguire partite/canali, commentare o interagire con eventi secondo workflow esistenti.
- **Cronista** - Beneficia della crescita organica per portare spettatori alle proprie partite e canali; puo diventare nuovo utente se arriva da query su come creare telecronache rugby.
- **Gestore prodotto RRL** - Decide canonical domain, priorita contenuti, pagine da indicizzare e KPI SEO.
- **Sistema RRL pubblico** - Espone pagine, contenuti, sitemap, metadata e link interni leggibili da utenti e crawler.
- **Sistema di generazione blog** - Genera post e HTML statici multilingua da partite terminate.
- **Motore di ricerca / crawler** - Scopre URL, interpreta contenuto, canonical, hreflang, metadata e decide indicizzazione/ranking. Attore esterno non controllato.

## Obiettivi funzionali

- Consolidare una sola URL canonica per ogni contenuto pubblico rilevante.
- Rendere ogni pagina pubblica indicizzabile con title, description, canonical e contenuto principale coerenti con il suo intento.
- Permettere a crawler e utenti di scoprire partite, canali, squadre, blog e landing tramite sitemap e linking interno.
- Separare funzionalmente pagina partita live e post blog recap per ridurre duplicazione e chiarire intenti.
- Aumentare CTR delle pagine gia visibili in GSC tramite snippet piu specifici.
- Ridurre pagine scansionate ma non indicizzate attraverso qualita, canonical, linking e scelta consapevole delle URL indicizzabili.
- Usare i dati GSC/GA/AdSense per monitorare effetti SEO e decidere priorita mensili.

## Funzionalita principali

### Governance URL canoniche

- **Descrizione** - Definisce quale URL rappresenta ufficialmente ogni contenuto pubblico e come trattare varianti `www`, non-`www`, `/index.html`, uppercase/lowercase e duplicati.
- **Attori coinvolti** - Gestore prodotto RRL, Sistema RRL pubblico, Motore di ricerca / crawler.
- **Input** - Dominio canonico scelto, mappa URL pubbliche, varianti rilevate da GSC.
- **Output** - URL canoniche coerenti, redirect o regole equivalenti, canonical presenti sulle pagine.
- **Regole e vincoli** - L'audit rileva segnali divisi tra `rugbyradiolive.com`, `www.rugbyradiolive.com` e `/index.html`; blog mostra varianti lingua uppercase/lowercase.
- **Dipendenze** - [[Public Sitemap (article)]], [[Static Blog SEO Headers (article)]], [[CreateMatchBlogHtmlJob (api)]], hosting non documentato.

### Metadata SEO per pagine pubbliche

- **Descrizione** - Ogni pagina pubblica deve comunicare contenuto e intento tramite title, description, H1/heading principale, canonical e social metadata.
- **Attori coinvolti** - Spettatore anonimo, Cronista, Sistema RRL pubblico, Motore di ricerca / crawler.
- **Input** - Dati pagina: match, canale, squadra, statistiche, contenuto statico, lingua.
- **Output** - Snippet piu specifico in SERP e pagina piu comprensibile al crawler.
- **Regole e vincoli** - L'audit rileva title/description generici su Angular e description duplicate sulle statiche. Le pagine pubbliche usano dati gia presenti in DTO.
- **Dipendenze** - [[GMatchPage (web)]], [[GChannelPage (web)]], [[GTeamPage (web)]], [[GStatsPage (web)]], [[matchDto (web)]], [[channelPublicDto (web)]], [[teamPublicDto (web)]], [[blogDto (web)]].

### Sitemap pubblica completa

- **Descrizione** - Espone a crawler l'elenco aggiornato e canonico delle pagine indicizzabili.
- **Attori coinvolti** - Sistema RRL pubblico, Sistema di generazione blog, Motore di ricerca / crawler, Gestore prodotto RRL.
- **Input** - Pagine statiche, partite pubbliche, canali pubblici, squadre pubbliche, blog statici, data modifica o pubblicazione.
- **Output** - Sitemap root e sitemap specializzate per sezioni o contenuti.
- **Regole e vincoli** - [[Public Sitemap (article)]] indica sitemap attuale limitata; audit rileva `lastmod` datati e assenza di URL dinamiche.
- **Dipendenze** - [[CreateMatchBlogHtmlJob (api)]], [[BlogV1Controller (api)]], [[GMatchesPage (web)]], [[GChannelsPage (web)]], [[GTeamPage (web)]].

### Pagine partita SEO-ready

- **Descrizione** - Le pagine `g-match` devono funzionare come destinazione organica per live commentary, risultato, eventi e condivisione.
- **Attori coinvolti** - Spettatore anonimo, Spettatore autenticato, Cronista, Motore di ricerca / crawler.
- **Input** - ID partita, squadre, data, stato, punteggio, eventi, canale, eventuale blog.
- **Output** - Pagina partita con contenuto leggibile, metadata specifici, link a canale/squadre/blog e CTA coerente.
- **Regole e vincoli** - [[GMatchPage (web)]] e pubblica, ha tab Events, Lineup, Stats, Share e polling durante partite in corso. [[matchDto (web)]] contiene eventi, punteggio, stato, canale e scoreboard.
- **Dipendenze** - [[GMatchPage (web)]], [[MatchService (web)]], [[BlogService (web)]], [[MatchesV1Controller (api)]], [[BlogV1Controller (api)]], [[Partita (concept)]].

### Pagine canale e squadra SEO-ready

- **Descrizione** - Canali e squadre diventano hub interni per raccogliere partite, link e segnali tematici.
- **Attori coinvolti** - Spettatore anonimo, Cronista, Motore di ricerca / crawler.
- **Input** - Canale pubblico, squadre associate, partite, classifiche, dati squadra e giocatori.
- **Output** - Pagine hub con metadata specifici e link verso partite, squadre e condivisione.
- **Regole e vincoli** - [[GChannelPage (web)]] ha tab Radio, Matches, Teams, Tables e Share; [[GTeamPage (web)]] ha tab Team, Players, Matches e Share.
- **Dipendenze** - [[GChannelPage (web)]], [[GTeamPage (web)]], [[channelPublicDto (web)]], [[teamPublicDto (web)]], [[Radio Canale (concept)]].

### Blog recap editoriale

- **Descrizione** - Il blog statico racconta il recap post partita e non deve competere in modo ambiguo con la pagina live.
- **Attori coinvolti** - Spettatore anonimo, Sistema di generazione blog, Motore di ricerca / crawler.
- **Input** - Partita terminata, eventi, punteggio, AI response, lingua.
- **Output** - Post multilingua statico con canonical, hreflang, contenuto recap, link alla partita live e sitemap blog.
- **Regole e vincoli** - [[CreateMatchBlogJob (api)]] genera EN e traduce IT/FR/ES/JA; [[CreateMatchBlogHtmlJob (api)]] genera HTML, indici, landing e sitemap; nessun retry automatico documentato.
- **Dipendenze** - [[Pubblicazione Blog Statico (workflow)]], [[Static Blog SEO Headers (article)]], [[Blog (api)]], [[blogDto (web)]].

### Landing editoriali SEO

- **Descrizione** - Pagine dedicate a intenti organici gia validati da GSC, come "live rugby commentary today" e "free live rugby commentary".
- **Attori coinvolti** - Spettatore anonimo, Cronista potenziale, Gestore prodotto RRL.
- **Input** - Query GSC, proposta valore RRL, link a partite/canali/tutorial.
- **Output** - Landing indicizzabili con contenuto evergreen e CTA verso uso prodotto.
- **Regole e vincoli** - Audit rileva query organiche gia coerenti; non esistono ancora pagine dedicate documentate.
- **Dipendenze** - [[HomePage (web)]], [[GMatchesPage (web)]], [[GChannelsPage (web)]], pagine statiche pubbliche.

### Linking interno SEO

- **Descrizione** - Collega contenuti pubblici in percorsi coerenti: home -> landing -> liste -> canali/squadre -> partite -> blog.
- **Attori coinvolti** - Spettatore anonimo, Motore di ricerca / crawler.
- **Input** - Relazioni tra match, canale, squadra, blog e statiche.
- **Output** - Maggiore discovery e maggiore chiarezza semantica.
- **Regole e vincoli** - Le relazioni sono documentate: partita appartiene a canale, squadra appartiene a canale, blog e associato a partita.
- **Dipendenze** - [[Partita (concept)]], [[Radio Canale (concept)]], [[GMatchPage (web)]], [[GChannelPage (web)]], [[GTeamPage (web)]], [[BlogService (web)]].

### Monitoraggio SEO operativo

- **Descrizione** - Produce lettura periodica di performance, copertura, CTR, pagine problematiche e impatto monetizzazione.
- **Attori coinvolti** - Gestore prodotto RRL.
- **Input** - GSC query/pagine/copertura, GA traffico, AdSense performance, platform stats.
- **Output** - Report mensile e priorita aggiornate.
- **Regole e vincoli** - Dati storici presenti in wiki: 302 clic, 8422 impressioni, 109 pagine scansionate non indicizzate, mobile dominante.
- **Dipendenze** - [[Search Console Performance 2026-04 (analytic)]], [[Search Console Index Coverage 2026-05 (analytic)]], [[Google Analytics Traffic 2026-01 2026-04 (analytic)]], [[AdSense Performance 2026-01 2026-04 (analytic)]], [[AnalyticsService (web)]].

## Flussi principali

### Flusso discovery organica partita

1. Utente cerca una query tipo "live rugby commentary today".
2. Motore di ricerca mostra una pagina RRL indicizzata: landing, lista partite o pagina partita.
3. Utente apre pagina con title e description coerenti.
4. Pagina mostra contenuto principale: partita, stato, punteggio, eventi o accesso alle partite.
5. Utente puo seguire partita, condividere link, leggere recap o autenticarsi per interagire.

### Flusso generazione recap blog SEO

1. Partita termina e diventa eleggibile per contenuto blog.
2. [[CreateMatchBlogJob (api)]] genera post EN e traduzioni.
3. [[CreateMatchBlogHtmlJob (api)]] produce HTML statico, indici e sitemap.
4. Post blog espone canonical/hreflang e link alla pagina partita.
5. Sitemap blog consente discovery e GSC misura impressioni/clic.

### Flusso aggiornamento sitemap

1. Sistema identifica URL pubbliche indicizzabili.
2. Sistema distingue URL canoniche da varianti non canoniche.
3. Sistema genera sitemap root e sitemap specializzate.
4. Sitemap include `lastmod` basato su cambi contenuto sostanziali.
5. Motori di ricerca scoprono o aggiornano contenuti pubblici.

### Flusso ottimizzazione pagina pubblica

1. Sistema recupera dati pagina da API o contenuto statico.
2. Sistema costruisce title, description, canonical e dati principali.
3. Pagina rende contenuto coerente per utente e crawler.
4. Link interni collegano entita correlate.
5. Analytics registra page view e, se presente, interazione successiva.

### Flusso monitoraggio e decisione SEO

1. Gestore prodotto raccoglie GSC, GA, AdSense e dati piattaforma.
2. Confronta KPI mensili: clic, impressioni, CTR, pagine non indicizzate, mobile, revenue.
3. Identifica pagine con ranking ma CTR basso o URL scansionate non indicizzate.
4. Decide interventi su metadata, contenuto, linking, sitemap o canonical.
5. Misura risultato nel ciclo successivo.

## Dati, modelli ed entity coinvolti

- [[matchDto (web)]] - Fonte funzionale per title/description di `g-match`: data, stato, punteggio, eventi, canale, scoreboard.
- [[channelPublicDto (web)]] - Fonte per pagina canale: nome, owner, partite, follower/like, squadre e classifiche.
- [[teamPublicDto (web)]] - Fonte per pagina squadra: nome, logo, giocatori e canale.
- [[blogDto (web)]] - Fonte contenuto blog associato a partita.
- [[pageDto (web)]] - Supporto liste paginabili di partite, canali e blog.
- [[Blog (api)]] - Entity per post blog e stato staticizzazione.
- [[Match (api)]] - Entity base per partita, eventi e generazione post.
- [[Channel (api)]] - Entity base per canale/radio.
- [[Team (api)]] - Entity base per squadra.
- [[StatsV1Controller (api)]] - Fonte statistiche aggregate pubbliche.

## Frontend, backend e workflow coinvolti

- [[HomePage (web)]] - Porta organica principale e pagina pubblica di orientamento.
- [[GMatchesPage (web)]] - Lista pubblica partite, candidata hub SEO per query live.
- [[GMatchPage (web)]] - Pagina pubblica partita, asset long-tail prioritario.
- [[GChannelsPage (web)]] - Lista pubblica canali, candidata hub per discovery.
- [[GChannelPage (web)]] - Pagina canale/radio, hub per partite e squadre.
- [[GTeamPage (web)]] - Pagina squadra, hub per rosa e partite.
- [[GStatsPage (web)]] - Pagina statistiche globali, utile come proof di attivita piattaforma.
- [[BlogService (web)]] - Recupera lista blog e blog per match.
- [[AnalyticsService (web)]] - Traccia page view e eventi.
- [[MatchesV1Controller (api)]] - API per dati partita.
- [[ChannelsV1Controller (api)]] - API per dati canale.
- [[TeamsV1Controller (api)]] - API per dati squadra.
- [[BlogV1Controller (api)]] - API pubblica per blog.
- [[StatsV1Controller (api)]] - API pubblica per statistiche.
- [[CreateMatchBlogJob (api)]] - Genera post blog.
- [[CreateMatchBlogHtmlJob (api)]] - Staticizza blog e genera sitemap.
- [[Pubblicazione Blog Statico (workflow)]] - Workflow SEO blog.
- [[Spettatore Partita (workflow)]] - Workflow consumo partita.
- [[Cronista Telecronaca (workflow)]] - Workflow produzione eventi.
- [[Gestione Canale (workflow)]] - Workflow gestione canali.

## Regole di business e vincoli

- La pagina partita pubblica non richiede autenticazione.
- Follow e like richiedono login, gestito tramite callback.
- Lo spettatore puo seguire una partita senza account; interazioni avanzate possono richiedere autenticazione.
- La partita appartiene a un canale/radio.
- A fine partita puo essere generato un post blog.
- Blog statico e generato per lingue IT, EN, FR, ES, JA.
- [[CreateMatchBlogJob (api)]] e [[CreateMatchBlogHtmlJob (api)]] hanno retry automatico disabilitato secondo wiki.
- La sitemap deve includere solo URL canoniche, pubbliche e indicizzabili.
- Pagine con contenuto duplicato o sottile devono essere consolidate, arricchite o escluse dalla discovery SEO.
- Mobile e canale dominante per traffico organico, quindi qualunque pagina SEO deve essere funzionalmente valida da mobile.

## Stati, eccezioni e casi limite

- Partita pianificata, in corso, intervallo, terminata.
- Partita senza blog associato.
- Blog generato ma non ancora staticizzato.
- Risposta AI vuota durante generazione blog.
- Sitemap generata con URL non canoniche o `lastmod` non affidabile.
- URL duplicata per `www`, non-`www`, `/index.html`, uppercase/lowercase.
- Pagina scansionata ma non indicizzata.
- Pagina con ranking ma CTR zero.
- Pagina statica con piu lingue nello stesso URL.
- Pagine pubbliche disponibili via JavaScript ma deboli nel primo HTML.
- AdSense presente su mobile con possibile impatto UX.

## Implicazioni implementative

- Serve una decisione funzionale preliminare sul dominio canonico.
- Serve inventario URL pubbliche con classificazione: indicizzare, non indicizzare, redirect, canonical verso altra URL.
- Serve schema funzionale dei metadata per ogni tipo pagina: home, lista, match, canale, squadra, stats, statiche, blog.
- Serve definizione contenuto minimo indicizzabile per `g-match`, `g-channel`, `g-team`.
- Serve regola chiara tra `g-match` e blog: live/eventi vs recap/editoriale.
- Serve generazione sitemap orientata a entita, non solo pagine statiche.
- Serve monitoraggio mensile come funzionalita di governance, anche se inizialmente manuale.
- Serve backlog separato tra quick win contenutistici e interventi architetturali SEO-first.

## Dati mancanti e domande aperte

- Quale dominio canonico scegliere: `https://rugbyradiolive.com/` o `https://www.rugbyradiolive.com/`?
- Quale hosting/CDN gestisce redirect e canonical HTTP?
- Esiste `robots.txt` in produzione e quali sitemap dichiara?
- Quali URL pubbliche dinamiche devono essere indicizzate tutte e quali solo se superano soglia qualita?
- Quale soglia rende una partita indicizzabile: eventi minimi, squadre valorizzate, punteggio, blog, data?
- Quali campi backend sono affidabili per `lastmod`?
- Il blog statico deve essere fonte primaria per recap post partita o pagina `g-match` deve restare primaria?
- Quali conversioni SEO vanno tracciate: account, canale creato, follow, share, visita blog, apertura match?
- Esistono dati Core Web Vitals reali?
- Chi revisiona qualita dei contenuti blog generati da AI?

## Criteri di accettazione preliminari

- Dato il dominio non canonico, quando un utente o crawler apre una variante, allora viene portato alla URL canonica o riceve canonical coerente.
- Dato `/index.html`, quando viene richiesto, allora non resta una pagina duplicata indicizzabile rispetto a `/`.
- Dato una pagina `g-match` pubblica, quando viene renderizzata per indicizzazione, allora espone title, description, canonical e contenuto principale specifici della partita.
- Dato un canale pubblico, quando viene renderizzato, allora contiene metadata basati su nome canale, partite e squadre disponibili.
- Dato una squadra pubblica, quando viene renderizzata, allora contiene metadata basati su nome squadra, giocatori e canale.
- Dato un post blog statico, quando viene pubblicato, allora canonical, hreflang e sitemap puntano alla variante lowercase canonica.
- Dato un nuovo contenuto pubblico indicizzabile, quando viene pubblicato o aggiornato in modo sostanziale, allora entra nella sitemap corretta con `lastmod` coerente.
- Dato una pagina statica, quando viene valutata da crawler, allora ha title/description unici e coerenti con intento pagina.
- Dato il report GSC mensile, quando una pagina ha posizione media buona e CTR basso, allora viene inserita in lista ottimizzazione snippet.
- Dato il report GSC mensile, quando una pagina risulta scansionata ma non indicizzata, allora viene classificata come arricchire, consolidare, canonicalizzare o escludere.

## Note per analisi successiva

- Derivare backlog tecnico in epiche: canonical/redirect, metadata, sitemap, SSR/prerender, blog, landing editoriali, monitoraggio.
- Produrre specifica metadata per tipo pagina con template title/description.
- Produrre matrice URL: sorgente, canonical, indicizzabile, sitemap, owner, dati necessari.
- Produrre specifica sitemap dinamica da entita.
- Produrre brief funzionale delle prime landing editoriali basate sulle query GSC.
- Produrre piano di tracciamento conversioni SEO in [[AnalyticsService (web)]].
