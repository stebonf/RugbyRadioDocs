---
type: design-system-notes
created: 2026-07-23T21:38:00+02:00
source: tasklist-nextjs-tailwind-migration
topic: "Design system RugbyRadioWebNext"
---

# Design system RugbyRadioWebNext

## Direzione

Il design system Next centralizza token e componenti ricorrenti in Tailwind. L'estetica resta Rugby Radio Live: sportiva, chiara, rapida da usare a bordo campo, con superfici leggibili e accenti teal/lime controllati.

## Token iniziali

- Colori: surface, surface-alt, panel, border, text, muted, primary, primary-strong, accent, danger, warning, success.
- Tipografia: font sans variabile da sistema, scale compatta per pannelli operativi e heading piu editoriali solo nelle pagine pubbliche.
- Spaziature: scala Tailwind standard, con container `--container-page`.
- Radius: 6-8px per card e controlli; pill solo per bottoni o badge dove gia coerente.
- Stati: hover, focus-visible, disabled, loading, empty, error.

## Componenti base previsti

- Layout: `PublicShell`, `AuthenticatedShell`, `Header`, `Footer`.
- UI: `Button`, `Alert`, `Skeleton`, `Tabs`, `Search`, `Pagination`, `EmptyState`.
- Domain: `MatchCard`, `ChannelCard`, `PageHeader`, `AdsSlot`.
- Demo: `/design-system`.

## Demo di governance

La route interna `/design-system` resta `noindex` e fuori sitemap. Deve mostrare almeno:

- swatch dei token colore principali con nome e valore;
- esempi di `shadow-panel`, `shadow-control` e radius globale;
- stati `primary`, `secondary`, `ghost`, `danger` e `disabled` per bottoni e icon button;
- feedback states `info`, `success`, `warning`, `danger`;
- controlli form server-friendly (`Search`, `SelectField`, textarea);
- card dominio, pagination, share, empty e skeleton.

## Regola di governance

Le pagine non devono creare nuove varianti visuali locali se una variante equivalente esiste nel DS. Le eccezioni vanno promosse a token o componente condiviso se riusate da piu route.
