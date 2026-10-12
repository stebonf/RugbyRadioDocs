# Valutazione delle risposte — Q&A 01

Fonte: `qa/Q&A - 01.md`. Le risposte sono state confrontate con `analysis/01-user-flows.md`, `analysis/02-ui-inventory.md`, `analysis/03-mobile-experience.md`, `analysis/04-anonymous-home-options.md`, `analysis/05-information-architecture.md` e `delivery/07-priorities-and-rollout.md`.

## Esito per domanda

| # | Esito | Sintesi della risposta | Pertinenza e aggiornamento necessario |
|---|---|---|---|
| 1. Ruolo sul primo schermo | **Parzialmente chiusa** | Home diversa per stato sessione: anonimo deve capire RRL, vedere esempi, capire come usarlo e accedere; autenticato deve trovare un’esperienza operativa. La preferenza cronista/spettatore nel profilo è una possibilità (“potremmo”), non una decisione. | È una decisione centrale per home e dashboard; recepita in `Decisions.md`. Restano da definire le azioni e l’eventuale configurazione di ruolo, e se abbia effetto su landing, dashboard o entrambe. |
| 2. CTA e prova del prodotto | **Parzialmente chiusa** | Dare risalto alla prova della telecronaca: wizard rapido per canale/squadre/partita e canale privato di test per utente. | Pertinente a home, onboarding e percorso cronista. Registrare come direzione di prodotto. Prima di promuovere il canale di test come funzionalità disponibile, verificarne flusso, visibilità e permessi in wiki/codice/API. Restano da decidere CTA precise, accesso/registrazione e destinazione dopo il click. |
| 3. Atterraggio autenticato | **Chiusa a livello di direzione** | L’utente connesso non deve vedere contenuti marketing; serve una home/dashboard operativa. | Coerente con `HomePage` e con l’analisi dei flussi. Da definire le priorità e gli stati della dashboard; non serve riaprire la scelta “dashboard o home pubblica” come questione strategica. |
| 4. Navigazione mobile | **Aperta** | Obiettivo: semplificare. Voci attuali dichiarate: Home, Radio, Crea, Partite, Profilo. | Conferma il contesto attuale, non decide la navigazione futura. Va verificato che l’elenco corrisponda al codice corrente e poi provato quali destinazioni rendere persistenti o secondarie. |
| 5. Interazioni che richiedono login e ritorno all’intento | **Aperta** | La risposta riafferma semplicità e pochi click, ma non specifica quali azioni richiedono account né come gestire il ritorno dopo il login. | La risposta non risolve i dubbi su rating, follow, reazioni, commenti e contesto/tab di ritorno. Serve matrice per azione e stato di autenticazione, allineata alle policy effettive. |
| 6. TWA e splash | **Parzialmente chiusa** | Lo splash TWA deve differire da quello/esperienza anonima web, perché l’installazione dallo store ha già introdotto l’utente a RRL. | La ragione di differenziazione è una direzione di prodotto pertinente. Resta da decidere cosa vede l’utente anonimo TWA dopo lo splash, e cosa accade ai ritorni/alle sessioni autenticate. La risposta non prescrive necessariamente una home TWA interamente diversa. |
| 7. Pagine pubbliche | **Chiusa sul perimetro, aperta sulla gerarchia** | Radio, squadra, statistiche e feedback sono importanti come dimostrazione concreta del prodotto e perché portano traffico e mostrano attività. | Conferma che queste superfici vanno considerate nel perimetro UX/UI. Non decide quali siano destinazioni primarie, link contestuali o voci di navigazione; SEO/traffico non sono stati quantificati. |
| 8. Home senza match live / errore dati | **Parzialmente chiusa** | Se non ci sono match live, omettere la sezione; restano disponibili gli storici di canali e partite. | È una regola di contenuto pertinente e recepita come direzione. Verificare che gli storici siano effettivamente disponibili e definire separatamente il fallback quando il servizio dati fallisce: omettere una sezione vuota non deve mascherare un errore di caricamento. |

## Decisioni registrate

Le direzioni sufficientemente esplicite sono state aggiunte al registro `Decisions.md`: esperienza iniziale distinta per anonimo e autenticato; dashboard operativa; valorizzazione della prova cronista tramite wizard/canale test; differenziazione dello splash TWA; rilevanza delle superfici pubbliche; omissione della sezione live quando non ci sono partite live con uso dello storico.

Le formulazioni esplorative o incomplete non sono state registrate come decisioni chiuse. In particolare restano aperti navigazione mobile, policy di autenticazione/ritorno, specifica home TWA post-splash e fallback su errori dati.

## Valutazione complessiva

Le risposte sono molto pertinenti al brief e chiariscono la direzione di prodotto su home anonima, home autenticata, prova del cronista e valore delle superfici pubbliche. Raffinano la proposta di home mista: per gli anonimi, una breve spiegazione con esempi e accesso; per gli utenti autenticati, una dashboard operativa. La differenza per stato di sessione è confermata; una personalizzazione cronista/spettatore resta solo un’ipotesi.

Al momento di questa prima valutazione rimanevano aperti alcuni dettagli e la verifica del wizard/canale test. Il successivo `docs/Q&A - 02.md` ha delegato esplicitamente agli agenti le raccomandazioni mancanti: si vedano `qa/02-assessment.md` e gli elaborati collegati. Questi producono proposte esperte invece di richiedere al responsabile di rispondere a ogni punto. La privacy del canale demo risulta però una dipendenza tecnica da risolvere prima di prometterlo come privato.

