---
title: "PlatformService (web)"
type: frontend-service
layer: frontend
---

# PlatformService (web)

## Sintesi

Rileva la piattaforma di esecuzione al momento della costruzione del servizio. Determina se l'app è in esecuzione come TWA (Trusted Web Activity) o in modalità mobile.

## Responsabilità

- Rilevamento modalità TWA tramite controllo `display-mode: standalone` e user agent TWA
- Rilevamento dispositivo mobile tramite user agent (Android, iPhone, iPad)
- Esposizione delle proprietà booleane `isTwa` e `isMobile`

## Consumer FE

- HeaderComponent (web)
- HomeComponent

## API chiamate

- Nessuna

## DTO o modelli usati

- Nessuno

## Side effects

- Nessuno (lettura sola dell'ambiente browser al costruttore)

## Note

Il rilevamento avviene una sola volta al costruttore e le proprietà sono immutabili per tutta la durata della sessione. `isTwa` è utilizzato per adattare l'UI quando l'app è distribuita come app Android tramite TWA. `isMobile` condiziona layout e funzionalità responsive.

