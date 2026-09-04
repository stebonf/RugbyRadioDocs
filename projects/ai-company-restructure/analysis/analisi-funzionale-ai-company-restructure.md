# Analisi funzionale - ristrutturazione AI Company

## Goal

Creare una struttura repository riusabile per lavorare con LLM su piu' progetti, separando sorgenti, iniziative, knowledge base canonica e kit operativo aziendale.

## Utenti e stakeholder

- Owner del repository.
- LLM agent che analizzano, pianificano, implementano e documentano.
- Futuri progetti che riuseranno il meccanismo `ai-company`.

## Target state

```text
src/
projects/
company/
wiki/
README.md
AGENTS.md
```

## Responsabilita' delle cartelle

`src` contiene i sorgenti applicativi e gli asset tecnici versionati.

`projects` contiene le iniziative. Ogni sottocartella e' un project con analisi funzionali, architetture, task, decisioni, ricerche e raw material specifico dell'iniziativa.

`company` contiene il kit LLM riusabile: agent, skill e prompt. Deve essere copiabile da un progetto all'altro.

`wiki` contiene la knowledge base canonica e consolidata. Include documenti prodotti, informazioni di dominio, architettura, workflow, analytics e dati trasversali non legati a un singolo project.

## Regole funzionali

- Il sistema di lavoro deve separare working material e conoscenza canonica.
- Un documento in `projects` diventa fonte canonica solo dopo promozione esplicita nella `wiki`.
- Gli LLM devono preferire skill, prompt e agenti in `company` rispetto a definizioni globali o installate altrove.
- La cartella `company` deve restare project-agnostic.
- Le istruzioni specifiche del repository devono restare in `AGENTS.md` e nella `wiki`.
- `README.md` deve descrivere scopo, struttura e flusso operativo.

## Decisioni proposte

- Usare `wiki` come nome target della knowledge base, mantenendo temporaneamente `llm-wiki/wiki` come fonte storica durante la migrazione.
- Mantenere `skills/` in root come compatibilita' finche' serve alla discovery runtime, ma dichiarare `company/skills` come fonte organizzativa preferita.
- Creare un agent di ingest `raw -> wiki` prima di spostare documenti esistenti in massa.

## Open questions

- La discovery locale delle skill supporta direttamente `company/skills` oppure richiede ancora `skills/` in root?
- Vuoi migrare fisicamente `llm-wiki/wiki` in `wiki` subito o tenerlo come storico per una fase intermedia?
- Le iniziative storiche sono state trasformate in cartelle `projects/<project-id>` durante la migrazione.

## Primo slice implementabile

Creare le cartelle target, aggiornare README/AGENTS, aggiungere un indice wiki minimo e documentare le regole di promozione.
