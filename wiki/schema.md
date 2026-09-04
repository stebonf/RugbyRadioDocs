# LLM-Wiki Schema

## Scopo

LLM-Wiki è un framework generico per costruire una knowledge base persistente, strutturata e interrogabile, pensata per consentire a modelli LLM di comprendere, analizzare ed evolvere piattaforme software complesse.

LLM-Wiki non è documentazione passiva.

È una rappresentazione strutturata della piattaforma che consente:

- comprensione architetturale;
- analisi funzionale;
- analisi tecnica;
- gap analysis;
- SEO analysis;
- growth analysis;
- product analysis;
- task generation;
- supporto implementativo.

Il framework deve restare completamente domain-agnostic.

---

# Principi fondamentali

## 1. Separazione dei layer

La conoscenza deve essere separata per layer logici.

Layer supportati:

- frontend
- backend
- data
- analytics
- business
- workflows
- architecture
- concepts
- articles
- comparisons

Non mescolare livelli differenti.

Errato:

```text
wiki/services/
```
Corretto:

```text
wiki/frontend/services/
wiki/backend/services/
```

---

## 2. Zero ambiguità

FE e BE spesso usano naming simili.

Questo crea ambiguità.

Esempio ambiguo:

- Match
- MatchService
- User
- AuthService

Esempio corretto:

- MatchPage
- MatchService
- MatchController
- MatchService
- MatchEntity
- UserProfileComponent

Naming esplicito obbligatorio, ma i suffissi tecnici `FE`, `API` e `BE` non sono obbligatori quando `project` e valorizzato.

Quando un workflow usa un parametro opzionale `project`, il nome visibile delle pagine tecniche deve aggiungere il progetto dopo il nome canonico:

```text
Match ({project})
MatchService ({project})
MatchComponent ({project})
G-Match ({project})
```

Il suffisso tecnico (`FE`, `API`, `BE`) non e obbligatorio quando `project` e valorizzato. Il progetto diventa qualificatore visibile e deve essere coerente tra nome file, frontmatter `title`, heading `#` e link `[[...]]`.

---

## 3. Relazioni esplicite

Ogni documento deve dichiarare relazioni di primo livello.

Esempio:

MatchPage
 -> MatchService
 -> MatchController
 -> MatchService
 -> MatchRepository
 -> MatchEntity

 Non affidarsi a deduzioni implicite

 ---

## 4. Workflows first-class

I workflow non sono documentazione secondaria.

Sono parte centrale del modello.

Ogni workflow deve collegare:

- attori
- frontend
- backend
- dati
- analytics
- failure points

---

## 5. Analytics separata dal codice

Analytics non appartiene al codice.

Separare:

- implementazione software
- comportamento runtime
- dati di business

---

## 6. Domain agnostic

Mai introdurre:

- naming specifico progetto
- entità hardcoded
- assumptions architetturali specifiche

Schema riutilizzabile ovunque.

---

# Struttura cartelle

```text
llm-wiki/
  raw/
  artifacts/
  wiki/
```

---

# raw

Contiene estrazioni grezze.

Non rappresenta la knowledge base finale.

Esempio:

```text
raw/frontend/
raw/frontend/{project}/
raw/backend/
raw/backend/{project}/
raw/data/
raw/analytics/
raw/business/
```

`{project}` e opzionale. Quando presente, isola RAW tecnici di uno specifico progetto o modulo senza cambiare layer.

---

# artifacts

Output derivati.

Usati per valutazione e miglioramento.

Non sono knowledge canonica.

Esempio:

```text
artifacts/analysis/
artifacts/reports/
artifacts/tasks/
```

---

# wiki

Knowledge base strutturata.

```text
wiki/
  architecture/
  frontend/
    {project}/
      pages/
      components/
      services/
      models/
    pages/
    components/
    services/
    models/
  backend/
    {project}/
      apis/
      services/
      entities/
      repositories/
      jobs/
      integrations/
      security/
    apis/
    services/
    entities/
    repositories/
    jobs/
    integrations/
    security/
  data/
    schemas/
    events/
    telemetry/
  analytics/
    ga/
    gsc/
    ads/
    product/
  business/
    actors/
    product/
    monetization/
  workflows/
  concepts/
  articles/
  comparisons/
  log.md
```

`{project}` e opzionale per `frontend` e `backend`. Se usato, tutte le pagine tecniche di quel progetto devono restare sotto la stessa sottocartella progetto.

---

# Naming conventions

Naming esplicito obbligatorio, ma i suffissi tecnici `FE`, `API` e `BE` non sono obbligatori quando `project` e valorizzato.

---

## Nomi con `project`

Quando `project` e valorizzato, usa il progetto come qualificatore visibile e non aggiungere suffissi tecnici obbligatori `FE`, `API` o `BE`.

Esempi:

```text
LoginPage ({project})
MatchDetailsPage ({project})
NavbarComponent ({project})
AuthService ({project})
MatchController ({project})
MatchRepository ({project})
MatchEntity ({project})
G-Match ({project})
```

## Nomi senza `project`

Quando `project` non e valorizzato, usa nomi descrittivi e mantieni la disambiguazione tramite cartella, `type` e `layer`.

Esempi:

```text
LoginPage
MatchController
MatchEntity
```

---

## Business, concept, architecture e workflow

Suffissi visibili obbligatori:

```text
Nome (actor)
Nome (product)
Nome (architecture)
Nome (concept)
Nome (workflow)
```

Esempi:

```text
Guest User (actor)
Rugby Radio Live (product)
Frontend Backend Mapping (architecture)
Public Content Discovery (concept)
User Registration (workflow)
Checkout (workflow)
```

Per `architecture`, non usare nomi come `NomeArchitecture` e non includere la parola `Architecture` nel nome base della pagina.

---

## Analytics

Suffisso visibile obbligatorio:

```text
Nome (analytic)
```

Non usare suffissi tipo `GA`, `GSC`, `ADS`, `PRD` nel nome pagina.

Esempio:

```text
Traffic Trend (analytic)
Index Coverage (analytic)
Revenue Trend (analytic)
Feature Usage (analytic)
```

## Article

Suffisso visibile obbligatorio:

```text
Nome (article)
```

Esempio:

```text
Public Sitemap (article)
Static Blog SEO Headers (article)
```

---

## Frontmatter standard

Ogni file markdown deve usare frontmatter.

Formato:

```text
---
title: "DocumentName"
type: document-type
layer: frontend|backend|data|analytics|business|workflow|architecture|concept
---
```

---

## Document types

Tipi consentiti:

```text
frontend-page
frontend-component
frontend-service
frontend-model

backend-api
backend-service
backend-entity
backend-repository
backend-job
backend-integration
backend-security

data-schema
data-event
telemetry

analytics-report

business-actor
business-product
business-monetization

workflow
architecture
concept
article
comparison
```

---

## Template documenti

### Frontend Page

Path:

```text
wiki/frontend/pages/
```

Template:

```text
# MatchDetailsPage

## Sintesi

Descrizione breve.

## Route

URL o route FE.

## Responsabilità

Cosa fa.

## Componenti usati

- [[MatchHeaderComponent]]

## Servizi FE usati

- [[MatchService]]

## Modelli FE usati

- [[MatchViewModel]]

## API dipendenti

- [[MatchController]]

## Workflow correlati

- [[Public Match Viewing (workflow)]]

## Stati UI

Loading / Error / Empty / Success

## Note
```

---

### Frontend Component

```text
# MatchCardComponent

## Sintesi

## Responsabilità

## Parent pages

## Child components

## Servizi FE usati

## Modelli FE usati

## Eventi input/output

## Note
```

---

### Frontend Service

```text
# MatchService

## Sintesi

## Responsabilità

## Consumer FE

## API chiamate

- [[MatchController]]

## DTO o modelli usati

## Side effects

## Note
```

---

### Frontend Model

```text
# MatchViewModel

## Sintesi

## Proprietà

## Origine dati

## Consumer FE

## API correlate

## Note
```

---

### Backend API

Path:

```text
wiki/backend/apis/
```

```text
# MatchController

## Sintesi

## Base route

/api/matches

## Endpoints

- GET /{id}
- POST /

## DTO input

## DTO output

## Backend services usati

- [[MatchService]]

## Regole auth

## Consumer FE

- [[MatchPage]]

## Workflow correlati

## Note
```
---

### Backend Service

```text
# MatchService

## Sintesi

## Responsabilità

## Consumer

## Repository usati

- [[MatchRepository]]

## Integrazioni usate

## Jobs usati

## Entities coinvolte

- [[MatchEntity]]

## Workflow correlati

## Side effects

## Note
```

---

### Backend Entity

```text
# MatchEntity

## Sintesi

## Proprietà

## Relazioni entity

## Repository correlati

## Services correlati

## Workflow correlati

## Note
```

---

### Backend Repository

```text
# MatchRepository

## Sintesi

## Responsabilità

## Entities gestite

## Query rilevanti

## Consumer

## Note
```

---

### Backend Job

```text
# PublishSocialJob

## Sintesi

## Trigger

## Responsabilità

## Services usati

## Entities coinvolte

## Side effects

## Failure points

## Note
```

---

### Backend Integration

```text
# StripeIntegration

## Sintesi

## Provider esterno

## Responsabilità

## Services consumer

## Payload rilevanti

## Retry/fallback

## Side effects

## Note
```

---

### Backend Security

```text
# AuthSecurity

## Sintesi

## Responsabilità

## Regole auth

## Policies

## Consumer

## Note
```

---

### Data Schema

```text
# MatchSchema

## Sintesi

## Struttura dati

## Entità correlate

## Eventi correlati

## Note
```

---

### Data Event

```text
# MatchCreatedEvent

## Sintesi

## Trigger

## Payload

## Consumer

## Side effects

## Note
```

---

### Telemetry

```text
# ApiErrorTelemetry

## Sintesi

## Fonte

## Eventi monitorati

## Metriche

## Trend

## Note
```

---

### Analytics

```text
# Traffic Trend (analytic)

## Sintesi

## Fonte dati

## Periodo

## Metriche

## Trend

## Implicazioni

## Workflow correlati

## Note
```

---

### Business Actor

```text
# Guest User (actor)

## Sintesi

## Obiettivi

## Pain points

## Workflow usati

## KPI rilevanti

## Note
```

---

### Workflow

Path:

```text
wiki/workflows/
```

Template:

```text
# Public Match Viewing (workflow)

## Obiettivo

## Trigger

## Attori

- [[Guest User (actor)]]

## Frontend coinvolto

- [[MatchPage]]

## Backend coinvolto

- [[MatchController]]
- [[MatchService]]

## Data coinvolti

## Analytics tracking

## Failure points

## Gap noti

## Note
```

---

### Architecture

```text
# FrontendBackendMapping

## Sintesi

## Scope

## Componenti coinvolti

## Relazioni principali

## Decisioni architetturali

## Rischi

## Note
```

---

### Cross-link rules

Cross-link rules

```text
[[DocumentName]]
```

Mai:

```text
[link](path)
```

---

### Relazioni minime obbligatorie

Frontend page:

- FE services
- API
- workflows

Frontend service:

- API
- consumer FE

Backend API:

- FE consumer
- backend service
- workflows

Backend service:

- repository
- integrations
- jobs
- entities

Workflow:

- actors
- frontend
- backend
- analytics

---

### Ingestion rules

L’ingestion deve:

- rispettare i layer
- evitare duplicati
- distinguere FE e BE
- distinguere DTO e entity
- distinguere analytics da runtime code
- creare link di primo livello
- non inventare relazioni

---

### Log

Path:

```text
wiki/log.md
```

Formato:

```text
## [YYYY-MM-DD] action | document

- created
- updated
- linked
- notes
```

---

### Quality rules

Validazione obbligatoria:

- naming coerente
- folder corretta
- tipo corretto
- no duplicati
- link validi
- FE/API distinti
- entity/model distinti
- workflows collegati
- analytics separata

---

### Operating model

Pipeline:

```text
RAW
 -> INGEST
 -> WIKI
 -> LINT
 -> ANALYSIS
 -> TASK GENERATION
 -> IMPLEMENTATION
```

---

### Final principle

LLM-Wiki è un knowledge graph markdown-driven per evoluzione continua di piattaforme software.
