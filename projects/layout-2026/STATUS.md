# Stato lavori — revisione UX/UI 2026

Ultimo aggiornamento: 2026-09-24.

| Incarico | Profilo responsabile | Stato | Deliverable |
|---|---|---|---|
| Verifica fonti, flussi e confronto wiki-codice | Analista funzionale / UX researcher | Completato | `analysis/01-user-flows.md` |
| Inventario UI e verifica tecnica del frontend | Frontend engineer Angular | Completato; review tecnica di delivery e verifica Q&A 02 completate | `analysis/02-ui-inventory.md`, `qa/04-technical-verification.md` |
| Alternative home anonima | Product designer / product analyst | Completato | `analysis/04-anonymous-home-options.md` |
| Esperienza mobile e cronista | UX designer mobile | Completato | `analysis/03-mobile-experience.md` |
| Architettura dell’informazione | UX designer / information architect | Completato; raccomandazione Q&A 02 completata | `analysis/05-information-architecture.md`, `qa/03-navigation-and-twa-recommendation.md` |
| Design system | UI designer / design systems specialist | Completato | `analysis/06-design-system-proposal.md` |
| Revisione accessibilità | Accessibility specialist | Completato | `analysis/07-accessibility-review.md` |
| Policy di autenticazione e intento | Analista funzionale / product analyst | Completato | `qa/05-auth-and-intent-recommendation.md` |
| Home, signup e prova cronista | Product designer / product analyst | Completato | `qa/02-home-and-trial-recommendation.md` |
| Valutazione risposte Q&A 02 e integrazione | Coordinatore UX/prodotto | Completato | `qa/02-assessment.md`, `Decisions.md`, `delivery/07-priorities-and-rollout.md` |
| Valutazione Q&A 03 e aggiornamento indirizzi | Coordinatore UX/prodotto | Completato | `qa/09-mockup-architecture.md`, `Decisions.md` |
| Pertinenza risposte Q&A 03 e punti residui | Coordinatore UX/prodotto | Completato | `qa/03-assessment.md` |
| Piano design system mockup | UI designer / design systems specialist | Completato | `qa/07-prototype-design-system-plan.md` |
| Mappa schermate mockup | UX designer / information architect | Completato | `qa/08-prototype-screen-map.md` |
| Verifica contratti API e strategia di simulazione | Frontend engineer Angular | Completato | `qa/06-prototype-technical-review.md` |
| Implementazione mockup isolato | Frontend engineer Angular con UI/UX/accessibilità | Prima versione implementata; revisione visuale dopo feedback completata, build riuscita; in attesa di nuova validazione stakeholder | `src/RugbyRadioLayout2026` |

## Stato del progetto

Il responsabile ha autorizzato il mockup isolato in `src/RugbyRadioLayout2026`, non modifiche ai progetti runtime o alle API di produzione. Il prototipo Angular autonomo, il design system CSS, le schermate e l’interceptor mock sono implementati; la build di sviluppo è riuscita il 24 settembre 2026. Le chiamate `/v1` del prototipo sono servite localmente. Il comportamento target per privacy demo è marcato separatamente dalla compatibilità con l’API esaminata.

In risposta al feedback visivo, un art director ha impostato una direzione editoriale da quaderno illustrato di rugby: copertine protagoniste e titoli serif. Su richiesta del responsabile, la palette calda è stata sostituita con la palette RRL già in uso (`#f4fbfb`, `#ecf8f8`, `#1f4c4e`, `#1d8391`, `#166874`, `#7fd6d2`); per le CTA con testo bianco si usa il teal strong per il contrasto. Sono stati rivisti spaziature e reflow mobile e integrate sei copertine JPEG locali distinte (tre match e tre radio), ottimizzate a 1280×720. Sono artwork creati per il mockup e non i dipinti associati a record reali del backend. Build e render mobile/desktop sono stati verificati; la qualità estetica attende validazione stakeholder.

La navigazione mobile a quattro voci e le proposte TWA sono approvate per la prova nel mockup. Il mockup mostra un messaggio generico nell’area che fallisce. I test con utenti/dispositivi e le verifiche SEO/analytics/ads sono rinviati a pacchetto UX/prototipo completato, secondo Q&A 03. Prossimo passo: stakeholder valida le schermate, i flussi e il design system; poi si registrano le modifiche richieste e si pianifica il rollout nei progetti reali.
