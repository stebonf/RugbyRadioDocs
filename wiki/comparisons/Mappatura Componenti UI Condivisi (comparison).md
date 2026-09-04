---
title: "Mappatura Componenti UI Condivisi (comparison)"
type: comparison
layer: comparisons
---

# Mappatura Componenti UI Condivisi (comparison)

## Sintesi

Mappa i componenti frontend condivisi che formano il sistema UI ricorrente della web app: controlli atomici, feedback, navigazione per entita, liste, skeleton, ads, share e analytics/toast collegati.

## Scope

La pagina confronta componenti e servizi frontend gia documentati nella wiki. Non definisce un design system completo o linee guida visuali non presenti nelle pagine esistenti.

## Componenti atomici e feedback

| Componente/servizio | Responsabilita | Consumer principali |
|---|---|---|
| [[IconComponent (web)]] | Render SVG inline da mappa interna, con sanitizzazione tramite DomSanitizer | Usato trasversalmente nell'app |
| [[EntityButtonComponent (web)]] | Pulsante riusabile con varianti `pill`, `panel`, `close` e colori `primary`, `secondary`, `ghost` | Pagine e componenti trasversali |
| [[EntityAlertComponent (web)]] | Banner informativo/errore con dismiss persistente in localStorage | Login, registrazione, feedback, danger e altre pagine con stati informativi |
| [[EntityToastComponent (web)]] | Rendering delle notifiche toast | [[ToastService (web)]] |
| [[ToastService (web)]] | Coda toast success/info/warning/error con auto-dismiss a 4000ms | Tutti i componenti che mostrano notifiche utente |

## Layout, liste e stati

| Componente | Responsabilita | Parent documentati |
|---|---|---|
| [[EntityPageHeaderComponent (web)]] | Header pagina con background, media circolare, titolo, sottotitolo, badge e skeleton | [[GChannelPage (web)]], [[GTeamPage (web)]], [[ProfilePage (web)]], [[ChannelsPage (web)]], [[ChannelPage (web)]] |
| [[EntitySkeletonComponent (web)]] | Placeholder animati per `header`, `card`, `list`, `text` | [[EntityPageHeaderComponent (web)]], [[ChannelCardListComponent (web)]], [[MatchCardListComponent (web)]] |
| [[EntityPaginationComponent (web)]] | Paginazione con ellissi adattiva e comportamento responsive | [[ChannelCardListComponent (web)]], [[MatchCardListComponent (web)]] |
| [[EntitySearchComponent (web)]] | Campo ricerca con valueChange, search e clear | [[GMatchesPage (web)]], [[GChannelsPage (web)]] |

## Componenti per entita e contenuti pubblici

| Componente | Responsabilita | Parent documentati |
|---|---|---|
| [[EntityTabsComponent (web)]] | Tab bar configurabile per sezioni di pagine entita | [[GChannelPage (web)]], [[GMatchPage (web)]], [[GTeamPage (web)]], [[ChannelPage (web)]], [[MatchPage (web)]] |
| [[EntityShareComponent (web)]] | Condivisione e copia link | [[GChannelPage (web)]], [[GMatchPage (web)]], [[GTeamPage (web)]], [[MatchPage (web)]] |
| [[EntityAdsComponent (web)]] | Inserimento AdSense in feed e pagine pubbliche | [[MatchCardListComponent (web)]], [[ChannelCardListComponent (web)]], [[GStatsPage (web)]], [[HomePage (web)]] |

## Servizi trasversali collegati

- [[AnalyticsService (web)]] isola Firebase Analytics e viene usato dalle pagine principali per eventi e page view.
- [[ToastService (web)]] separa lo stato delle notifiche dalla loro resa visiva in [[EntityToastComponent (web)]].
- [[UserService (web)]] alimenta componenti e pagine con stato utente, sessione e preferenze.

## Pattern ricorrenti

- I componenti condivisi espongono input/output semplici e lasciano al parent la responsabilita dei dati.
- I componenti atomici non chiamano API e dipendono poco dai servizi applicativi.
- Le pagine entita usano componenti specializzati per tab, header, share e ads, evitando duplicazione di UI ricorrente.
- Gli stati di caricamento sono gestiti con skeleton riusabili invece che con loader specifici per singola pagina.

## Gap noti

- Non e deducibile una tassonomia completa di tutte le varianti visuali supportate dal sistema UI.
- Non sono documentate linee guida accessibilita, focus management o test visuali.
- Non tutte le pagine consumer sono elencate per componenti dichiarati come trasversali.

## Note

Pagina creata usando solo pagine gia presenti in `llm-wiki/wiki`. Non sono state lette fonti RAW.
