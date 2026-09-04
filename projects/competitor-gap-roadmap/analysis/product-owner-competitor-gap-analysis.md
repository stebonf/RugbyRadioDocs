# Product Owner Gap Analysis: Rugby Radio Live

## Executive Summary

Rugby Radio Live (RRL) ha una proposta distintiva: permettere a un cronista di generare una telecronaca rugby testuale e audio-like da telefono, con pochi click, per spettatori che non sono al campo. La wiki aggiornata mostra un prodotto gia funzionante su creazione rapida partita con canale contestuale, eventi live, commenti, reazioni, follow, TTS, blog statico multilingua, SEO, pipeline post-partita, social publishing, account e AdSense.

I gap piu importanti non sono "aggiungere piu feature", ma chiudere il ciclo di adozione:

- completare e misurare il percorso da creazione rapida partita a prima diretta reale;
- trasformare gli spettatori anonimi in utenti che seguono, ricevono notifiche e tornano;
- rendere la modalita radio affidabile su mobile, PWA e TWA;
- rendere misurabile il funnel da visita organica, blog o share a registrazione, follow, evento e ritorno;
- spostare la monetizzazione oltre il solo AdSense, che oggi produce revenue trascurabile.

Rispetto alle aspettative di mercato, RRL e piu focalizzato di piattaforme club come Pitchero e piu verticale/partecipativo di live-score generalisti come Sofascore. La sua opportunita e diventare il "live companion" leggero per rugby amatoriale e giovanile, non un gestionale club completo. La roadmap dovrebbe quindi privilegiare activation, live reliability, retention e distribuzione.

## Evidence Reviewed

Fonti wiki principali:

- `llm-wiki/wiki/business/product/Rugby Radio Live (product).md`
- `llm-wiki/wiki/architecture/Rugby Radio Live (architecture).md`
- `llm-wiki/wiki/business/actors/Cronista (actor).md`
- `llm-wiki/wiki/business/actors/Spettatore (actor).md`
- `llm-wiki/wiki/workflows/Cronista Telecronaca (workflow).md`
- `llm-wiki/wiki/workflows/Spettatore Partita (workflow).md`
- `llm-wiki/wiki/workflows/Gestione Canale (workflow).md`
- `llm-wiki/wiki/workflows/Riproduzione Audio Telecronaca (workflow).md`
- `llm-wiki/wiki/workflows/Autenticazione Utente (workflow).md`
- `llm-wiki/wiki/comparisons/Mappatura Frontend Pubblico e Autenticato (comparison).md`
- `llm-wiki/wiki/comparisons/Mappatura Interazioni e Notifiche (comparison).md`
- `llm-wiki/wiki/comparisons/Mappatura SEO e Analytics (comparison).md`
- `llm-wiki/wiki/business/monetization/Monetizzazione (monetization).md`
- `llm-wiki/wiki/analytics/ga/Google Analytics Traffic 2026-01 2026-06 (analytic).md`
- `llm-wiki/wiki/analytics/gsc/Search Console Performance 2026-06 (analytic).md`
- `llm-wiki/wiki/analytics/gsc/Search Console Index Coverage 2026-05 (analytic).md`
- `llm-wiki/wiki/analytics/product/Platform Stats 2026-05-13 (analytic).md`
- `llm-wiki/wiki/articles/Creazione Rapida Partita (article).md`
- `llm-wiki/wiki/articles/Esperienza Spettatore Partita (article).md`
- `llm-wiki/wiki/articles/Radio Live e Audio Telecronaca (article).md`
- `llm-wiki/wiki/articles/Blog Statico Multilingua (article).md`
- `llm-wiki/wiki/articles/Superficie SEO e Indicizzazione (article).md`
- `llm-wiki/wiki/articles/Monetizzazione AdSense (article).md`
- `llm-wiki/wiki/articles/Pipeline Contenuti Post Partita (article).md`
- `llm-wiki/wiki/articles/Pubblicazione Social Post Partita (article).md`
- `llm-wiki/wiki/articles/Account e Profilo Utente (article).md`
- `llm-wiki/wiki/articles/Backup e Operativita Backend (article).md`
- `llm-wiki/wiki/analytics/ads/AdSense Blog Alignment 2026-06 (analytic).md`

Benchmark esterno leggero:

- Pitchero: club website/app, membership, payments, team management, content, fixtures/results, access control, fundraising, sponsor tools. Fonte: https://www.pitchero.com/
- Sofascore: live scores, fixtures, live/finished/upcoming filters, favourites, statistics, standings, player comparison, broad sport coverage including rugby. Fonte: https://www.sofascore.com/
- RugbyPass TV: rugby video destination, live/on-demand content category expectation. Fonte: https://rugbypass.tv/
- GameChanger: grassroots scorekeeping, stats, video, recaps, fan subscriptions, live game stream expectation. Fonte: https://en.wikipedia.org/wiki/GameChanger

Nota: competitor non nominati dall'utente. Le comparazioni sono quindi assunzioni di categoria, non claim di parita diretta.

## Product Context

- Target users: cronisti volontari, team manager, genitori, tifosi e spettatori remoti di rugby amatoriale/giovanile.
- Core jobs: creare rapidamente una partita anche creando canale e squadre contestuali, aggiornare eventi da mobile, condividere il link, seguire live score/commentary, ascoltare audio TTS, interagire, ricevere notifiche, leggere contenuti post-partita.
- Current value proposition: telecronaca rapida con pochi click, senza parlare e senza scrivere testi lunghi; spettatori aggiornati con eventi, punteggio e riepilogo in tempo reale.
- Creation experience: il wizard rapido collega drawer frontend, DTO quick, endpoint MTC-17 e `RugbyRadioLiveService`, creando o recuperando canale, squadre, partita e formazioni in un'unica operazione.
- Current traction evidence: snapshot del 13/05/2026 con 230 utenti, 62 canali, 281 partite, 10.940 eventi, 24.339 emoji e 6.396 commenti.
- Organic demand: giugno 2026 mostra query con click su "live rugby commentary today" e "live rugby commentary on radio free"; mobile e il canale dominante.
- Content engine: partite `FullTime` alimentano blog multilingua, immagini, pagine statiche, sitemap e pubblicazione Facebook.
- Monetization: solo AdSense, circa 0,08 EUR/mese medi gennaio-giugno 2026; il blog statico usa lo slot unico `BLOG-HOME = 6223722056` su home, landing, indici e pagine match/post.
- Competitor/category assumptions: live-score app creano aspettativa di immediatezza, notifiche e statistiche; club platforms creano aspettativa di onboarding, gestione team, calendario, comunicazione e sponsor; grassroots scoring app creano aspettativa di scoring semplice, fan alerts e contenuti post-match.

## Prioritized Gaps

| Priority | Gap | Type | User Value | Business Value | Effort | Confidence | Evidence | Recommended Next Slice |
|---|---|---|---|---|---|---|---|---|
| P1 | Creazione rapida presente ma activation cronista non chiusa | Parity | High | High | Medium | High | Il wizard rapido crea/recupera canale, squadre, partita e formazioni, ma KPI, checklist pre-match, demo e recupero errori non sono deducibili | "Prima diretta" sopra il wizard esistente: demo/reale, invito spettatori, QR, checklist e tracking step |
| P1 | Funnel spettatore anonimo -> follow/notifiche non misurato ne ottimizzato | User Delight | High | High | Medium | High | Interazioni richiedono login; conversioni da visita a registrazione/follow non deducibili | CTA contestuali post-like/comment/follow, login callback misurato, evento analytics `viewer_activation_step` |
| P1 | Affidabilita radio mobile non validata | Risk/Trust | High | High | Medium | High | Wiki: background audio, lock screen e Media Session API non validati; browser puo bloccare Audio.play | Spike + MVP Media Session: play/pause lock screen, resume, stato persistito, test PWA/TWA/mobile |
| P1 | Realtime/polling e freschezza live poco espliciti | Parity | High | High | Medium | Medium | GMatch usa polling, ma meccanismo completo UI realtime non deducibile | Indicatore "live aggiornato X sec fa", retry visibile, stato connessione, misurazione lag feed |
| P1 | Analytics prodotto incompleti per adoption, contenuti e retention | Operational Efficiency | Medium | High | Low | High | Esistono GA/GSC/AdSense/stats, ma funnel quick match, share, blog, follow, notifiche e ritorno non sono collegati | Event taxonomy minima: signup, quick match, first event, share, blog click-through, follow, notification opt-in, return |
| P2 | SEO con impressioni ma pochi click fuori home | Monetization | Medium | High | Medium | High | GSC giugno: home concentra click; pagine blog/team/match generano impressioni senza click | Ottimizzare title/description per match/canali/team, snippet "live rugby commentary", audit top 20 URL |
| P2 | Problemi canonical/duplicati/non indicizzate | Risk/Trust | Medium | Medium | Medium | High | GSC maggio: 140 scansionate non indicizzate, 48 canonical appropriate, 20 duplicate canonica diversa | Backlog tecnico SEO: canonical rules, redirect matrix, URL inventory, pagine escluse motivate |
| P2 | Notifiche limitate al caso evento; commenti e engagement non chiudono il loop | User Delight | Medium | Medium | Medium | Medium | Notifiche push per nuovi commenti non deducibili; analytics notifica non deducibile | Notification preference center: eventi partita, inizio/fine match, commenti su partita seguita |
| P2 | Moderazione, limiti e sicurezza contenuti sociali non definiti | Risk/Trust | Medium | Medium | Medium | High | Commenti pubblici; rate limiting, limiti quantitativi e moderazione non deducibili | Limiti caratteri/rate, report commento, delete owner/admin, regole visibili |
| P2 | Condivisione match/canale non trattata come growth loop | Monetization | High | Medium | Low | Medium | Pagine hanno tab Share, ma non emergono metriche o inviti strutturati | Share kit pre-match: link WhatsApp, QR code, copy pronto, tracking source |
| P2 | Mancano strumenti per calendario/prossime partite ricorrenti | Parity | Medium | Medium | Medium | Medium | Home/GMatches mostrano partite, ma non e documentato un workflow calendario/schedule club | Sezione "prossime partite canale" con reminder e creazione rapida da match precedente |
| P2 | Monetizzazione solo AdSense, anche dopo allineamento slot blog | Monetization | Low | High | Medium | High | Il blog ora converge su `BLOG-HOME = 6223722056`, ma AdSense medio resta ~0,08 EUR/mese e alternative non sono documentate | Sperimentare sponsor canale/match e pagina "supporta il canale"; niente paywall sul live |
| P2 | Trust pubblico e proof per nuovi club deboli | Risk/Trust | Medium | Medium | Low | Medium | Sono presenti stats globali e Meet the Team, ma non emergono case study club/come iniziare | Landing "per club e genitori" con demo match, metriche reali, privacy e setup in 5 minuti |
| P3 | Import roster/player/team e storico stagioni non evidente | Operational Efficiency | Medium | Medium | High | Medium | Esistono team/player/lineup, ma import/export e archivio stagioni non emergono | Import CSV roster + duplicazione formazione da partita precedente |
| P3 | Pipeline post-partita non ancora governata come prodotto editoriale | User Delight | Medium | Medium | Medium | Medium | Blog statico multilingua, immagini, Facebook e sitemap esistono; review editoriale, retry, analytics di fase e canali social ulteriori non sono deducibili | Dashboard pipeline: stato contenuto, retry, anteprima, export social copy e metriche URL |
| P3 | Admin/business operations poco productizzate | Operational Efficiency | Low | Medium | Medium | High | Hangfire, audit, manutenzione e backup USB sono documentati; retention, checksum, cifratura e notifiche operative non sono deducibili | Mini admin UI per stato job, messaggi draft, backup, health check e alert operativi |

## Key Missing Capabilities

### 1. Activation del cronista

Il cronista ha il job piu critico: deve riuscire a usare RRL durante una partita vera, da mobile, con poca attenzione disponibile. La wiki ora documenta un wizard rapido che puo creare o recuperare canale, squadre, partita e formazioni tramite MTC-17 e `RugbyRadioLiveService`. Il gap non e piu "manca la creazione rapida", ma "manca la chiusura productizzata della prima diretta": checklist, share, demo, recupero errori e misurazione del completamento.

Capacita mancante: un percorso guidato sopra il wizard esistente che trasformi "mi registro" in "ho una partita condivisa e sono pronto a cronacarla".

Smallest useful slice:

- estendere il wizard rapido con scelta demo/reale, AI-Talker/lingua e link pubblico;
- partita demo cancellabile per provare gli eventi;
- checklist pre-match con link pubblico e QR;
- analytics su apertura drawer, step completati, creazione partita, condivisione e primo evento.

### 2. Activation e retention dello spettatore

Lo spettatore puo seguire senza account, ma le azioni ad alto valore richiedono login: follow, commenti, voti, like. Questo e corretto per fiducia e identita, ma deve essere gestito come conversione progressiva, non come blocco improvviso.

Capacita mancante: un funnel leggero che spieghi perche fare login nel momento giusto.

Smallest useful slice:

- CTA "Segui questa partita e ricevi aggiornamenti" sopra il feed live;
- login callback con ritorno garantito al match e ripresa dell'azione;
- opt-in notifiche subito dopo follow;
- misurazione drop-off: view match -> click follow -> login -> follow completato -> token FCM.

### 3. Radio mobile affidabile

La modalita Radio e una differenziazione forte: non compete direttamente con dirette video o live-score, ma crea presenza. La wiki pero segnala esplicitamente che background audio, lock screen e Media Session API non sono ancora validati.

Capacita mancante: esperienza audio da smartphone che si comporta come un player credibile.

Smallest useful slice:

- Media Session API con metadata partita/canale;
- controlli lock screen play/pause;
- stato "audio non disponibile" chiaro per talker/eventi mancanti;
- tracking `radio_queue_lag`, errori e completamento evento;
- matrice test Chrome Android, Safari iOS/PWA, TWA.

### 4. Live trust e freschezza

Sofascore e altri live-score hanno abituato gli utenti a stati live, refresh immediato, filtri live/finished/upcoming e feedback di aggiornamento. RRL usa polling nelle pagine pubbliche, ma la wiki non rende evidente l'intero comportamento realtime.

Capacita mancante: segnalare chiaramente che la partita e viva, aggiornata e affidabile.

Smallest useful slice:

- badge "Live", "Ultimo aggiornamento X sec fa", "connessione instabile";
- retry/backoff non invasivo;
- evento analytics per lag feed;
- stato vuoto utile se la partita non e iniziata.

### 5. Misurazione prodotto

La wiki contiene GA, GSC, AdSense, Platform Stats e ora anche articoli che collegano SEO, blog statico, pipeline post-partita e slot AdSense unico del blog. Tuttavia non collega ancora queste superfici ai workflow di adozione. Non sono deducibili conversioni da visita organica, pagina blog o share a registrazione, follow, commento, monetizzazione o ritorno.

Capacita mancante: funnel prodotto minimo.

Smallest useful slice:

- definire eventi canonici: `signup_completed`, `quick_match_started`, `match_created`, `first_match_event_created`, `match_shared`, `blog_match_clicked`, `match_followed`, `notification_enabled`, `viewer_returned_to_live`;
- dashboard settimanale: activation cronisti, activation spettatori, retention 7 giorni, live matches, notification opt-in, CTR blog -> match/canale;
- collegamento tra source/share/blog/organic e match view.

### 6. Monetizzazione sostenibile

AdSense e gia esteso su molte superfici e il blog statico e stato riallineato sullo slot unico `BLOG-HOME = 6223722056`. Questo riduce il rischio configurativo, ma non cambia il problema strategico: i ricavi documentati restano quasi nulli. Per una nicchia sportiva locale, sponsor di canale/match, supporto volontario e strumenti per club sono piu coerenti del solo volume pubblicitario.

Capacita mancante: monetizzazione allineata a club e community.

Smallest useful slice:

- sponsor logo/link per canale o partita, gestito dal cronista;
- pagina pubblica "supporta questo canale";
- tracking click sponsor;
- non introdurre paywall sul live prima di avere retention.

## Competitor And Market Expectations

### Pitchero category expectation

Pitchero posiziona il valore su gestione club completa: website/app, membership, payments, team management, fundraising, competitions, content, sponsor e comunicazioni. RRL non deve copiare tutto. Pero per convincere volontari e club deve prendere tre aspettative:

- setup semplice per volontari non tecnici;
- contenuti e comunicazioni aggiornabili da mobile;
- sponsor/fundraising come valore per il club.

### Sofascore category expectation

Sofascore crea aspettativa di live score ordinato: live/finished/upcoming, favourites, statistiche, standings, notifiche e copertura mobile. RRL puo differenziarsi con telecronaca AI/TTS e community rugby, ma deve raggiungere una soglia minima di fiducia live: stato aggiornamento, follow, filtri, statistiche chiare e pagine match leggibili.

### RugbyPass / media category expectation

RugbyPass TV rappresenta la direzione media: video, live/on-demand, contenuti rugby. RRL non ha bisogno di streaming video, anzi la sua forza e leggerezza. Pero la parola "Radio" alza aspettative audio: player mobile, background behavior e qualita del racconto devono essere solidi.

### GameChanger grassroots expectation

GameChanger e utile come riferimento di categoria grassroots: scorekeeping semplice, aggiornamenti live per fan, statistiche, recap e monetizzazione fan/premium. RRL e vicino a questa logica, ma specializzato nel rugby e nel racconto testuale/TTS.

## User-Value Opportunities

- Ridurre il time-to-first-live-match sotto 5 minuti usando il wizard rapido gia presente.
- Far capire subito a uno spettatore anonimo cosa guadagna creando account: follow, notifiche, commenti, voti.
- Usare QR e WhatsApp come canali nativi di distribuzione pre-match.
- Rendere la pagina partita una "second screen" affidabile con live freshness e audio.
- Spingere contenuti post-match come recap condivisibili e misurabili, non solo come SEO/blog.
- Dare ai club un motivo economico o reputazionale per usare RRL: sponsor locali, archivio partite, visibilita.
- Trattare blog statico e pubblicazione Facebook come canali di riattivazione verso match, canali e registrazione.

## Risks And Unknowns

- `llm-wiki/wiki/index.md` e `llm-wiki/wiki/summary.md` non esistono nella wiki corrente; la navigazione della knowledge base dipende da `wiki-20260707.md` e dai file tematici.
- Competitor specifici non indicati dall'utente; benchmark trattato come categoria, non come confronto esaustivo.
- Non e deducibile quanta parte del dataset derivi da utenti reali rispetto a FakeAgent.
- Non e deducibile il funnel registration -> quick match -> first event -> share -> retention.
- Non sono documentati KPI target per SEO, revenue, activation cronista o retention spettatore.
- Non e deducibile la matrice completa di moderazione, rate limiting e policy contenuti.
- Non e deducibile il comportamento completo realtime oltre al polling documentato.
- Non sono deducibili review editoriale, retry, metriche di fase e canali ulteriori della pipeline post-partita.
- Non sono deducibili retention completa, checksum, cifratura e notifiche operative per backup/manutenzione.

## Recommended Roadmap Slices

### Slice 1 - Activation & Measurement Foundation

Obiettivo: capire e migliorare il primo utilizzo.

- Wizard prima diretta per cronista.
- Event taxonomy minima.
- Share kit pre-match con QR/WhatsApp.
- CTA follow/notifica su pagina match.
- Dashboard settimanale funnel.

Success metric: percentuale di nuovi utenti che completano quick match + primo evento + prima condivisione entro 7 giorni.

### Slice 2 - Live Trust & Radio Mobile

Obiettivo: rendere credibile la fruizione live.

- Live freshness UI.
- Stato connessione e retry.
- Media Session API e lock-screen controls.
- Messaggi chiari per audio non disponibile.
- Tracking lag e audio errors.

Success metric: durata media engagement su partite live e completion rate audio evento.

### Slice 3 - Retention & Notifications

Obiettivo: far tornare spettatori e cronisti.

- Preference center notifiche.
- Notifiche inizio/fine match e nuovi eventi.
- Follow canale/partita piu visibile.
- Reminder prossime partite canale.
- Email/push digest leggero post-match.

Success metric: spettatori returning su canali seguiti e notification opt-in rate.

### Slice 4 - SEO Conversion & Distribution

Obiettivo: trasformare impressioni organiche in utenti e match view.

- Audit top URL con impressioni senza click.
- Title/description mirati a "live rugby commentary".
- Canonical/redirect backlog.
- Recap post-match condivisibile e preview editoriale.
- Tracking source per share/social/blog/organic.
- Dashboard pipeline blog/immagini/Facebook/sitemap con retry e metriche URL.

Success metric: CTR organico pagine match/canale/team e conversione organic -> match view/follow.

### Slice 5 - Club Value & Monetization

Obiettivo: dare ai club un motivo stabile per adottare RRL.

- Sponsor canale/partita.
- Pagina "supporta il canale".
- Uso corretto e monitorato dello slot blog `BLOG-HOME = 6223722056`.
- Import roster CSV.
- Archivio stagioni/canale.
- Case study o demo pubblica per club.

Success metric: numero di canali attivi con sponsor/support link configurato e partite ricorrenti.
