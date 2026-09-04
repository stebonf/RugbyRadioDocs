# Wiki Lint Report

## Sintesi

- Data analisi: 2026-06-15
- Pagine analizzate: 244
- Problemi totali: 16
- Priorità alta: 5
- Priorità media: 7
- Priorità bassa: 4

## Problemi trovati

### 1. Articoli e comparazioni hanno layer errato

- Priorità: Alta
- Tipo: struttura
- File coinvolti:
  - `wiki/articles/Product Updates 2026 (article).md`
  - `wiki/articles/Public Sitemap (article).md`
  - `wiki/articles/Static Blog SEO Headers (article).md`
  - `wiki/comparisons/Mappatura Modelli FE e Entity BE (comparison).md`
  - `wiki/comparisons/Mappatura Pagine e API (comparison).md`
  - `wiki/comparisons/Mappatura Servizi FE e BE (comparison).md`
- Descrizione: I file in `articles/` dichiarano `layer: concept` invece di `layer: articles`. I file in `comparisons/` dichiarano `layer: concept` invece di `layer: comparisons`. Lo schema prevede `articles` e `comparisons` come layer distinti.
- Suggerimento: Correggere il frontmatter: `layer: articles` per gli articoli, `layer: comparisons` per le comparazioni.

### 2. Pagina architettura con sezioni incomplete

- Priorità: Alta
- Tipo: contenuto
- File coinvolti:
  - `wiki/architecture/Rugby Radio Live (architecture).md`
- Descrizione: La pagina di architettura ha solo 3 sezioni (`Sintesi`, `Scope`, `Componenti coinvolti`). Il template schema richiede anche: `Relazioni principali`, `Decisioni architetturali`, `Rischi`, `Note`.
- Suggerimento: Aggiungere le sezioni mancanti `Relazioni principali`, `Decisioni architetturali`, `Rischi` e `Note` per allinearsi al template.

### 3. `wiki-20260615.md` non è una pagina wiki valida

- Priorità: Alta
- Tipo: struttura
- File coinvolti:
  - `wiki/wiki-20260615.md`
- Descrizione: File generato come merge di tutti i file .md, privo di frontmatter (`title`, `type`, `layer`), collocato nella root di wiki senza appartenere a nessuna cartella di tipo. Non corrisponde ad alcun type definito dallo schema.
- Suggerimento: Spostare in `projects/` o `raw/` se e' materiale di lavoro/fonte, eliminarlo se obsoleto, oppure aggiungere frontmatter appropriato se deve rimanere come pagina wiki.

### 4. Relazioni minime: `SitemapXmlWriter (api)` è gravemente incompleto

- Priorità: Alta
- Tipo: relazioni
- File coinvolti:
  - `wiki/backend/api/services/SitemapXmlWriter (api).md`
- Descrizione: Ha solo sezioni `Sintesi`, `Responsabilità`, `Consumer`, `Note`. Manca `Repository usati`, `Integrazioni usate`, `Jobs usati`, `Entities coinvolte`, `Workflow correlati`, `Side effects`. Le relazioni minime per `backend-service` richiedono almeno `Repository usati`, `Integrazioni usate`, `Jobs usati`, `Entities coinvolte`.
- Suggerimento: Completare le sezioni mancanti in `SitemapXmlWriter (api)`.

### 5. `Fake Agent (concept)` senza link in entrata

- Priorità: Media
- Tipo: relazioni
- File coinvolti:
  - `wiki/concepts/Fake Agent (concept).md`
- Descrizione: Pagina concettuale su Fake Agent non referenziata da alcuna altra pagina wiki.
- Suggerimento: Verificare se va collegata da altri documenti (es. `Ciclo di Vita Partita (concept)`, workflow).

### 6. `Mappatura Modelli FE e Entity BE (comparison)` orfana

- Priorità: Media
- Tipo: relazioni
- File coinvolti:
  - `wiki/comparisons/Mappatura Modelli FE e Entity BE (comparison).md`
- Descrizione: Nessuna pagina wiki collega a questa comparazione. È una risorsa di mappatura utile ma non referenziata.
- Suggerimento: Aggiungere link da `Rugby Radio Live (architecture)` o dalle pagine entity/model coinvolte.

### 7. `EntityScrollToTopComponent (web)` orfano e con sezioni ridotte

- Priorità: Media
- Tipo: relazioni
- File coinvolti:
  - `wiki/frontend/web/components/EntityScrollToTopComponent (web).md`
- Descrizione: Componente non referenziato da nessuna pagina. Inoltre manca la sezione `Modelli FE usati` rispetto al template standard dei componenti FE.
- Suggerimento: Verificare se è effettivamente usato e collegarlo, oppure aggiungere la sezione mancante.

### 8. `MatchCardSmallComponent (web)` usa sezione non standard

- Priorità: Bassa
- Tipo: contenuto
- File coinvolti:
  - `wiki/frontend/web/components/MatchCardSmallComponent (web).md`
- Descrizione: Il template schema prevede `Parent pages`, ma questo componente usa `Parent components` e manca `Child components`.
- Suggerimento: Allineare al template: usare `Parent pages` e `Child components` come da schema.

### 9. Articoli usano sezioni simili a architecture template

- Priorità: Media
- Tipo: contenuto
- File coinvolti:
  - `wiki/articles/Product Updates 2026 (article).md`
  - `wiki/articles/Public Sitemap (article).md`
  - `wiki/articles/Static Blog SEO Headers (article).md`
- Descrizione: I tre articoli hanno sezioni (`Sintesi`, `Scope`, `Componenti coinvolti`, `Relazioni principali`, `Decisioni architetturali`, `Rischi`, `Note`) copiate dal template architecture. Per `article` lo schema non definisce sezioni obbligatorie ma chiede "sezioni coerenti con schema".
- Suggerimento: Valutare se le sezioni sono appropriate per un articolo o se vanno rielaborate.

### 10. `UsbBackupJob (api)` ha apostrofo invece di accento

- Priorità: Bassa
- Tipo: contenuto
- File coinvolti:
  - `wiki/backend/api/jobs/UsbBackupJob (api).md`
- Descrizione: La sezione `Responsabilita'` usa apostrofo dritto (`'`) invece di accento grave (`à`).
- Suggerimento: Uniformare a `Responsabilità`.

### 11. DTO model usano naming lowercase (camelCase)

- Priorità: Media
- Tipo: naming
- File coinvolti:
  - `wiki/frontend/web/models/blogDto (web).md`
  - `wiki/frontend/web/models/channelDto (web).md`
  - `wiki/frontend/web/models/channelPublicDto (web).md`
  - `wiki/frontend/web/models/channelTableDto (web).md`
  - `wiki/frontend/web/models/lineupPlayerDto (web).md`
  - `wiki/frontend/web/models/matchAddDto (web).md`
  - `wiki/frontend/web/models/matchDto (web).md`
  - `wiki/frontend/web/models/matchEventAddDto (web).md`
  - `wiki/frontend/web/models/matchEventDto (web).md`
  - `wiki/frontend/web/models/matchMinDto (web).md`
  - `wiki/frontend/web/models/matchQuickAddDto (web).md`
  - `wiki/frontend/web/models/pageDto (web).md`
  - `wiki/frontend/web/models/playerDto (web).md`
  - `wiki/frontend/web/models/statsDto (web).md`
  - `wiki/frontend/web/models/teamAddDto (web).md`
  - `wiki/frontend/web/models/teamChannelDto (web).md`
  - `wiki/frontend/web/models/teamLogoDto (web).md`
  - `wiki/frontend/web/models/teamMinDto (web).md`
  - `wiki/frontend/web/models/teamPublicDto (web).md`
  - `wiki/frontend/web/models/teamUpdateDto (web).md`
  - `wiki/frontend/web/models/userProfileDto (web).md`
  - `wiki/frontend/web/models/userTokenDto (web).md`
- Descrizione: I DTO usano naming in camelCase (`blogDto`) invece di PascalCase (`BlogDto`). Altri model come `StatsCardViewModel`, `ChannelTabIdModel` usano PascalCase correttamente.
- Suggerimento: Rinominare i file e aggiornare title/h1 in PascalCase per coerenza con il resto della wiki.

### 12. Entity backend hanno sezioni extra (`Tabella DB`, `Nome nel codice`)

- Priorità: Bassa
- Tipo: contenuto
- File coinvolti:
  - Molti file in `wiki/backend/api/entities/`
- Descrizione: Le entity backend aggiungono sezioni `Tabella DB` e `Nome nel codice` non previste dal template schema. Sono aggiunte informative utili ma extra.
- Suggerimento: Valutare se formalizzare come sezioni opzionali nello schema.

### 13. `GenerateSeoSitemapJob (api)` non ha `Nome nel codice` come gli altri job

- Priorità: Bassa
- Tipo: contenuto
- File coinvolti:
  - `wiki/backend/api/jobs/GenerateSeoSitemapJob (api).md`
- Descrizione: Mentre gli altri job hanno `Nome nel codice`, questo job usa invece `Configurazione`. Incoerenza minore tra pagine dello stesso type.
- Suggerimento: Valutare se aggiungere `Nome nel codice` per coerenza.

### 14. `Platform Stats 2026-05-13 (analytic)` linka correttamente a `StatsV1Controller (api)`

- Priorità: Media (verifica)
- Tipo: link
- File coinvolti:
  - `wiki/analytics/product/Platform Stats 2026-05-13 (analytic).md`
- Descrizione: Il file linka a `StatsV1Controller (api)` senza suffisso di path. Il link è risolvibile. La pagina analytics è correttamente collegata al backend API corrispondente. Questo è un buon pattern. Nessuna violazione.
- Suggerimento: Mantenere questo pattern per le altre pagine analytics.

### 15. `concepts/Ciclo di Vita Partita (concept)` ha sezioni minime

- Priorità: Media
- Tipo: contenuto
- File coinvolti:
  - `wiki/concepts/Ciclo di Vita Partita (concept).md`
- Descrizione: Ha solo 2 sezioni (`Sintesi`, `Stati e transizioni`). Gli altri concept ne hanno di più (es. Scope, Componenti coinvolti, Relazioni principali, ecc.). Sebbene il type `concept` non abbia sezioni obbligatorie rigide, la pagina appare incompleta rispetto agli altri concept.
- Suggerimento: Estendere con sezioni aggiuntive per coerenza con gli altri concept.

### 16. `concepts/Pipeline Contenuti (concept)` usa sezioni non standard

- Priorità: Bassa
- Tipo: contenuto
- File coinvolti:
  - `wiki/concepts/Pipeline Contenuti (concept).md`
- Descrizione: Usa `Attori coinvolti`, `Fasi della pipeline`, `Entita dati coinvolte`, `Servizi backend coinvolti` invece delle sezioni standard degli altri concept (`Scope`, `Componenti coinvolti`, `Relazioni principali`, `Decisioni architetturali`, `Rischi`). Coerente per contenuto ma atipico.
- Suggerimento: Valutare se adottare le sezioni standard per omogeneità.

## Pagine orfane

- `wiki/concepts/Fake Agent (concept)` — concetto isolato, nessun collegamento entrante
- `wiki/frontend/web/components/EntityScrollToTopComponent (web)` — componente non referenziato
- `wiki/comparisons/Mappatura Modelli FE e Entity BE (comparison)` — comparazione non referenziata
- `wiki/wiki-20260615` — file merge generato, non è una pagina wiki

## Link rotti o incoerenti

Nessun link `[[...]]` rotto rilevato. Tutti i 240+ riferimenti interni puntano a file esistenti. Nessun markdown link classico `[text](path)` usato per collegamenti interni.

## Duplicazioni semantiche possibili

- `wiki/concepts/Fake Agent (concept)`
- `wiki/backend/api/entities/FakeAgentSetting (api)`
- `wiki/backend/api/jobs/FakeFantasyAgentJob (api)`
- `wiki/backend/api/jobs/FakeLastYearAgentJob (api)`
- `wiki/backend/api/jobs/FakeLeagueAgentJob (api)`
- Motivazione: I confini tra concept "Fake Agent", la sua entity di configurazione e i tre job di simulazione sono chiari ma potrebbero generare overlap informativo. Verificare che il concept non ripeta dettagli implementativi dei job.

- `wiki/articles/Public Sitemap (article)`
- `wiki/articles/Static Blog SEO Headers (article)`
- `wiki/concepts/Superficie SEO Pubblica (concept)`
- Motivazione: Tre pagine su temi SEO affini (sitemap, header SEO, superficie SEO pubblica). I ruoli sembrano distinti (article vs concept) ma verificare overlap.

## Relazioni minime mancanti

- `wiki/backend/api/services/SitemapXmlWriter (api)` — mancano `Repository usati`, `Integrazioni usate`, `Jobs usati`, `Entities coinvolte`, `Workflow correlati`, `Side effects` (richiesti per backend-service)

## Nuove pagine suggerite

### Pipeline Dati Generale (workflow)

- Tipo suggerito: workflow
- Cartella suggerita: `wiki/workflows/`
- Priorità: Media
- Motivazione: Manca una vista workflow end-to-end della pipeline contenuti: dalla creazione evento partita alla pubblicazione statica (blog, sitemap, social). `Pipeline Contenuti (concept)` descrive i componenti ma non ha la struttura formale di workflow con attori, trigger, failure points.
- Collegamenti attesi:
  - `[[Pipeline Contenuti (concept)]]`
  - `[[Ciclo di Vita Partita (concept)]]`
  - `[[Pubblicazione Blog Statico (workflow)]]`

### Amministrazione Piattaforma (workflow)

- Tipo suggerito: workflow
- Cartella suggerita: `wiki/workflows/`
- Priorità: Bassa
- Motivazione: Esiste `Operazioni Amministrative (workflow)` ma manca un workflow più granulare per la gestione della piattaforma (backup, manutenzione, audit). `Operativita Backend (concept)` descrive i componenti ma non è un workflow formale.
- Collegamenti attesi:
  - `[[Operativita Backend (concept)]]`
  - `[[Operazioni Amministrative (workflow)]]`

### EntitySchema (concept)

- Tipo suggerito: concept
- Cartella suggerita: `wiki/concepts/`
- Priorità: Bassa
- Motivazione: Diverse entity backend condividono `EntityBase` (Id, IsDeleted, Ts). Un concept che descriva questo pattern di persistenza potrebbe ridurre ripetizioni e centralizzare la documentazione.
- Collegamenti attesi:
  - `[[EntityBase (api)]]`
  - `[[AppDbContext (api)]]`

## Azioni consigliate

1. Correggere `layer` in frontmatter per articoli (`articles`) e comparazioni (`comparisons`) — 6 file, alta priorità.
2. Completare `wiki/architecture/Rugby Radio Live (architecture).md` con sezioni mancanti (`Relazioni principali`, `Decisioni architetturali`, `Rischi`, `Note`).
3. Spostare o eliminare `wiki/wiki-20260615.md` (artefatto generato, non pagina wiki).
4. Completare sezioni minime in `wiki/backend/api/services/SitemapXmlWriter (api)`.
5. Collegare le 3 pagine orfane: `Fake Agent (concept)`, `EntityScrollToTopComponent (web)`, `Mappatura Modelli FE e Entity BE (comparison)`.
6. Valutare rinomina DTO lowercase → PascalCase per coerenza dei model FE.

## Note

- Tutti i `[[link]]` Obsidian interni sono validi (0 broken link su 240+ riferimenti).
- Nessun markdown link classico per collegamenti interni (tutti usano `[[..]]`).
- 244 pagine analizzate escluse non-.md e `.obsidian/`.
- Cartelle legacy (`wiki/entities/`, `wiki/pages/`, `wiki/services/`, `wiki/sources/`) assenti.
- Type legacy (`entity`, `application-page`, `service-interface`, `source-summary`) assenti.
- Il file `wiki/nul` è presente nella directory root ma non è un file .md.
- Alcune pagine includono sezioni extra (`Nome nel codice`, `Configurazioni`, `Tabella DB`) non previste dal template ma utili; da valutare per formalizzazione nello schema.
