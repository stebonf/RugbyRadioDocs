---
title: "ChannelsPage (web)"
type: frontend-page
layer: frontend
---

# ChannelsPage (web)

## Sintesi

Lista canali dell'utente con drawer animato per la creazione di un nuovo canale. Navigazione a ChannelPage al click su un canale.

## Route

`/user-channels` — Guard: AuthGuardService

## Responsabilità

Visualizza la lista dei canali di cui l'utente è proprietario o co-editor. Offre un drawer animato per la creazione di un nuovo canale tramite form. Al click su un canale naviga verso la relativa ChannelPage per la gestione.

## Componenti usati

- [[EntityPageHeaderComponent (web)]]
- [[EntityButtonComponent (web)]]
- EntityCardSmallComponent (web)
- EntityFieldComponent (web)

## Servizi FE usati

- [[ChannelService (web)]]
- [[AnalyticsService (web)]]

## Modelli FE usati

- [[channelDto (web)]]
- channelAddDto (web)

## API dipendenti

- [[ChannelsV1Controller (api)]]

## Workflow correlati

- [[Gestione Canale (workflow)]]

## Stati UI

- Loading
- Drawer creazione aperto
- Saving
- Form submitted

## Note

Protetta da AuthGuardService. Il drawer di creazione canale è animato e include validazione del form.

