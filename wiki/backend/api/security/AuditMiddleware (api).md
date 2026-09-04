---
title: "AuditMiddleware (api)"
type: backend-security
layer: backend
---

# AuditMiddleware (api)

## Sintesi

Middleware di audit logging applicato a tutte le richieste HTTP eccetto HEAD. Registra metodo, path, corpo request/response (compressi), status code, tempo risposta, user ID, lingua e nome operazione interno. Non blocca le richieste.

## Responsabilità

- Cattura e salva ogni richiesta HTTP in tabella `Audit`
- Legge `ClaimTypes.NameIdentifier` per user ID (null se anonimo)
- Legge header `X-USER-LANGUAGE` e `X-COMMENTARY-LANGUAGE`
- Esclude richieste OPTIONS e senza `RequestInternalName`
- Compressione body con `DbConfiguratorHelper.Zip/Unzip`
- Errori durante audit silenziatи (log su file, non interrompono la risposta)

## Regole auth

Middleware di osservazione, non di autorizzazione. Non blocca le richieste.

## Policies

Nessuna

## Consumer

Tutte le richieste HTTP non-HEAD dell'API

## Configurazioni

Nessuna configurazione esterna

## Entities coinvolte

- [[Audit (api)]] — scrittura

## Nome nel codice

`AuditMiddleware` — `src/RugbyRadio/Lib/Core/Middlewares/AuditMiddleware.cs`
