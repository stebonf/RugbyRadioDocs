# Valutazione delle risposte — Q&A 03

**Data:** 2026-09-24  
**Esito:** risposte pertinenti e sufficienti per definire il prototipo. Non occorre inviare un altro questionario per procedere con le analisi e il mockup.

| Tema | Risposta | Pertinenza e conseguenza |
|---|---|---|
| Privacy demo | Inserire verifica e fix nel piano | Pertinente e coerente con il rilievo API. La demo non va chiamata privata come fatto attuale finché i percorsi pubblici per ID non sono protetti. Il mockup può illustrare il comportamento target etichettandolo. Vedi review tecnica e architettura prototipo. |
| Signup | Mantenere il flusso corrente | Risposta netta; conservare email, nickname e password, non introdurre email-only/passwordless. |
| Autorizzazioni | Verificare prima di procedere | Pertinente. Gli agenti hanno già fornito mappa delle route e dei gate visibili; il residuo è una verifica tecnica server-side, registrata come prerequisito per il rollout reale. Non blocca il mockup. |
| Errore recupero dati | Messaggio generico quando non è possibile caricare informazioni | Decisione implementabile. Usare copy generico nella sezione interessata, distinguendo errore da lista vuota e lasciando gli altri blocchi attivi. |
| Navigazione e TWA | Approvare le raccomandazioni, provarle | Approvazione sufficiente per includere nel mockup la navigazione mobile **Home · Partite · Crea · Profilo** e la proposta TWA. |
| Validazione | Rinviare test utenti/device e SEO/analytics/pubblicità a UX completa | Chiaro. Non blocca il design system/mockup; pianificare tali valutazioni dopo il completamento del pacchetto UX. |

## Raccomandazione coordinatore

Procedere con un’app dimostrativa autonoma sotto `src/RugbyRadioLayout2026`, con componenti HTML e CSS riusabili e mock HTTP allineati a method/path/query/body/response dei contratti verificati. I mock usano fixture locali e rendono visibili le differenze tra comportamento API corrente e comportamento target. Nessuna API reale o dato reale deve essere raggiunto dal prototipo.

La richiesta successiva autorizza il mockup, non il redesign di produzione. La prima versione è stata realizzata in `src/RugbyRadioLayout2026` ed è stata compilata con successo. Validare il prototipo prima di pianificare modifiche a `RugbyRadioWeb` e al backend. Dettagli e stato: `qa/09-mockup-architecture.md` e `STATUS.md`.

## Punti aperti, senza richiesta immediata allo stakeholder

Sono dipendenze tecniche da chiudere con analisi degli agenti e poi nel rollout, non domande da rinviare al responsabile ora:

1. **Privacy demo:** bloccare accesso anonimo diretto per ID a canale, match e risorse correlate, poi verificare ogni route pubblica.
2. **Matrice auth:** confrontare policy desiderata con i controller, in particolare route senza attributo esplicito e azioni di scrittura; simulare nel mock i gate attuali e documentare qualsiasi proposta target.
3. **Feed home:** API/client non distinguono attualmente le categorie mostrate come live/prossime/storiche; raccomandazione esperta: non simulare filtri non inviati e marcare la discrepanza per decisione d’integrazione.
4. **Aggiornamento statistiche:** typing Angular non coincide col DTO/backend e payload costruito dal componente; preservare nel mock il contratto backend effettivo e registrare il fix typing.
5. **Wizard:** confermare gestione di scritture parziali, retry e idempotenza prima di implementare il flusso reale; nel mock rendere gli errori espliciti e non fingere rollback.

Questi punti sono già assegnati ai profili tecnici/UX nei documenti `qa/06-prototype-technical-review.md` e `qa/08-prototype-screen-map.md`. Nessun altro punto richiede un nuovo input stakeholder per avviare il prototipo.
