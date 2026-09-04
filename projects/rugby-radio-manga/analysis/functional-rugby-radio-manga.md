---
type: functional-analysis
created: 2026-08-04T12:30:00+02:00
topic: "Rugby Radio Manga"
project: "rugby-radio-manga"
slug: "rugby-radio-manga"
---

# Functional Analysis: Rugby Radio Manga

## Summary

Rugby Radio Manga e un progetto narrativo e contenutistico collegato a Rugby Radio Live. L'obiettivo e costruire un universo seriale in cui il Team RRL diventa cast, le funzionalita della piattaforma emergono attraverso la storia e i problemi reali di una partita o di una telecronaca diventano antagonisti, conflitti o incidenti narrativi.

Il progetto deve evitare l'effetto pubblicita. La piattaforma deve essere scoperta dal lettore come conseguenza dell'affezione a mondo, personaggi e dinamiche.

## Goal

Definire una struttura di progetto che permetta di produrre nel tempo:

- web manga;
- tavole verticali per social;
- capitoli completi pubblicabili sul sito;
- PDF scaricabili;
- motion manga;
- mini episodi video;
- contenuti SEO e social riutilizzabili.

## Scope

La prima fase copre la progettazione editoriale dell'universo:

- Bibbia dell'universo;
- personaggi principali;
- fazioni;
- luoghi;
- timeline;
- regole del mondo;
- macro saghe;
- formato standard dei capitoli;
- requisiti di produzione AI.

## Out Of Scope

Non rientrano nella prima fase:

- implementazione tecnica di una sezione manga sul sito;
- generazione immagini definitive;
- produzione video;
- doppiaggio;
- automazione completa della pipeline;
- pubblicazione effettiva dei capitoli.

## Sources Reviewed

- `src/RugbyRadioManga/README.md`
- `wiki/index.md`
- `wiki/business/product/Rugby Radio Live (product).md`
- `wiki/concepts/AI-Talker (concept).md`
- `wiki/concepts/Pipeline Contenuti (concept).md`
- `wiki/articles/Meet the Team (article).md`
- `raw/docs/rrl-team.md`
- `src/RugbyRadioWebNext/lib/content/team-members.ts`

Nota: `wiki/summary.md` e citato dalle istruzioni repository ma non esiste nel workspace attuale.

## Actors And Stakeholders

- Lettore: fruitore principale del manga.
- Fan o spettatore RRL: persona che puo riconoscere eventi, partite, commenti, canali e contenuti.
- Founder: personaggio e riferimento narrativo del progetto.
- AI-Talkers: personaggi editoriali che trasformano eventi partita in stili di racconto.
- AI-Dev: personaggi che rappresentano costruzione, analisi e architettura del sistema.
- Team RRL: gruppo protagonista dell'universo narrativo.
- Publisher/editor RRL: responsabile della coerenza narrativa e del riuso dei contenuti.

## Current State

Esiste un README iniziale in `src/RugbyRadioManga/README.md` che definisce:

- obiettivo comunicativo;
- filosofia non pubblicitaria;
- visione in tre fasi;
- ordine di progettazione;
- struttura documentale proposta;
- lista dei personaggi principali;
- idea degli antagonisti come problemi reali;
- pipeline ideale di produzione AI.

La wiki documenta gia RRL come piattaforma di telecronaca testuale, AI-Talker come personalita editoriali e pipeline contenuti come catena post-partita per blog, immagini, staticizzazione, social e sitemap.

## Target State

Il progetto deve avere una documentazione narrativa stabile che faccia da fonte canonica per ogni contenuto futuro.

La prima forma target e un set di documenti coerente:

- `01-bibbia-universo.md`
- `02-personaggi.md`
- `03-fazioni.md`
- `04-luoghi.md`
- `05-timeline.md`
- `06-regole-universo.md`
- `07-tecnologia.md`
- `08-saga-001.md`
- template capitolo;
- template tavola;
- template prompt immagine.

## Main Flows

### Flow 1: Progettazione universo

1. Raccogliere fonti canoniche RRL.
2. Definire premessa narrativa.
3. Definire regole del mondo.
4. Definire tecnologia e metafore visive.
5. Definire limiti: cosa puo e non puo accadere.
6. Salvare la Bibbia dell'Universo.

### Flow 2: Progettazione personaggi

1. Partire dal Team RRL esistente.
2. Separare Founder, AI-Talkers e AI-Dev.
3. Definire ruolo narrativo, desiderio, paura, punto debole e arco.
4. Definire segni visivi ricorrenti.
5. Definire voce, frasi tipiche e rapporti.

### Flow 3: Progettazione antagonisti

1. Prendere un problema reale della piattaforma o della partita.
2. Trasformarlo in entita, forza, fazione o evento.
3. Assegnare motivazione credibile.
4. Collegarlo a una funzionalita RRL senza spiegazione promozionale.
5. Definire come il conflitto fa crescere uno o piu personaggi.

### Flow 4: Produzione capitolo

1. Scegliere saga e obiettivo del capitolo.
2. Definire funzione narrativa del capitolo.
3. Scrivere trama breve.
4. Dividere in tavole.
5. Dividere in vignette.
6. Scrivere dialoghi.
7. Preparare prompt immagini.
8. Revisionare leggibilita mobile e coerenza con la Bibbia.

## Alternative Flows

- Un contenuto social puo nascere da una singola scena senza produrre subito un capitolo completo, se resta coerente con la Bibbia.
- Un antagonista puo comparire come problema tecnico, creatura, organizzazione o effetto ambientale.
- Un AI-Talker puo essere protagonista, spalla, narratore interno o voce di una scena.
- Una funzionalita RRL puo essere mostrata come strumento, luogo, rito, potere o procedura.

## Business Rules

- Il manga non deve sembrare una pubblicita.
- Il rugby non e il protagonista principale: il protagonista e l'universo Rugby Radio Live.
- Ogni capitolo dovrebbe divertire, emozionare, mostrare un personaggio, includere una funzionalita RRL in modo naturale e chiudere con un piccolo cliffhanger.
- La documentazione dell'universo viene prima dei capitoli.
- Ogni nuovo contenuto deve restare coerente con la Bibbia dell'Universo.
- I problemi reali di partita o piattaforma sono candidati naturali per antagonisti.
- Le scene devono essere leggibili su smartphone.
- Tono: alternanza tra comicita ed epicita.

## Data Needs

Servono schede strutturate per:

- personaggi;
- fazioni;
- luoghi;
- antagonisti;
- tecnologie;
- saghe;
- capitoli;
- tavole;
- vignette;
- prompt immagine;
- asset visuali;
- regole di coerenza.

## Permissions And Access

Nessun requisito di permesso applicativo nella prima fase. Quando il progetto entrera nel sito, andranno definiti:

- chi puo creare o modificare capitoli;
- chi approva immagini e testi;
- chi pubblica contenuti;
- eventuale separazione tra bozze, revisione e pubblicazione.

## Integrations And Side Effects

In prima fase non sono previste integrazioni tecniche.

In fasi successive sono possibili integrazioni con:

- generazione immagini;
- generazione PDF;
- pubblicazione static HTML;
- social publishing;
- sitemap SEO;
- motion manga;
- TTS o voci AI per doppiaggio.

## Error States And Edge Cases

- Personaggi troppo simili o poco riconoscibili.
- Funzionalita RRL inserite in modo didascalico o promozionale.
- Antagonisti ridotti a bug tecnici senza personalita.
- Stile visivo non coerente tra capitoli.
- Tavole non leggibili su smartphone.
- Universo troppo dipendente dalla conoscenza tecnica della piattaforma.
- Produzione AI non ripetibile per mancanza di prompt template.

## Acceptance Criteria

- Esiste una Bibbia dell'Universo iniziale.
- Esiste una scheda per ogni personaggio principale.
- Esiste una prima mappa di fazioni e antagonisti.
- Esiste una prima mappa dei luoghi.
- Esiste una timeline minima dell'universo.
- Esiste almeno una macro saga descritta con obiettivo, antagonista, evoluzione e finale.
- Esiste un template capitolo utilizzabile per il Capitolo 001.
- Ogni documento separa fatti canonici, assunzioni e domande aperte.

## Assumptions

- Il progetto editoriale lavorera in italiano nella fase iniziale.
- Il cast principale include Founder, Vox, Bulldog, Newsly, Brushy, Elixir, Stacker, Analysta e Blueprint, come indicato nel README manga.
- I membri aggiuntivi gia esistenti nella pagina Team potranno entrare in una fase successiva.
- Il mondo narrativo usera elementi RRL reali come base, ma con trasformazione fantastica o meta-tecnologica.
- Il genere dominante approvato e un ibrido fantasy tecnologico, comedy-adventure e battle shonen leggero.
- Il Founder sara un alter ego narrativo: creatore della Radio Tower e del primo segnale RRL, mentore imperfetto ma non protagonista assoluto.
- Gli AI-Talker saranno abitanti del sistema e personificazioni editoriali: entita native della Radio Tower nate da esperimenti, cronache, eventi partita e stili narrativi.
- Il mondo reale e il mondo RRL comunicheranno tramite interfaccia rituale e mondo reale come eco: le azioni reali generano effetti visibili nel mondo narrativo, ma i personaggi non entrano normalmente nel mondo reale.

## Blocking Questions

Nessuna domanda bloccante al momento.

## Non-Blocking Questions

- Il primo arco deve introdurre tutto il Team o concentrarsi su pochi personaggi?
- La prima saga deve nascere da una partita specifica o da un incidente generale del sistema?
- I nomi dei documenti finali devono restare numerati come nel README o usare slug piu tecnici?
- Lo stile visivo target deve essere piu manga classico, webtoon verticale, chibi/epic comedy o cinematic manga?

## Notes For Architecture

La pipeline futura dovrebbe separare:

- scrittura;
- storyboard;
- prompt immagini;
- asset;
- balloon;
- revisione;
- export web/social/PDF;
- motion manga;
- doppiaggio;
- pubblicazione.

La progettazione dovrebbe produrre template riutilizzabili prima di generare capitoli completi.
