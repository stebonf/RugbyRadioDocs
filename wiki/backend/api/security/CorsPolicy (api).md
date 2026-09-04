---
title: "CorsPolicy (api)"
type: backend-security
layer: backend
---

# CorsPolicy (api)

## Sintesi

CORS completamente aperto: `AllowAnyOrigin`, `AllowAnyHeader`, `AllowAnyMethod`. Policy denominata `AllowAllOrigins`. Applicata dopo `app.MapControllers()` nella pipeline.

## Responsabilità

- Policy `AllowAllOrigins` — nessuna restrizione di origine, header o metodo
- `app.UseCors("AllowAllOrigins")` nella pipeline `Program.cs`

## Regole auth

Non applicabile

## Policies

`AllowAllOrigins` — completamente permissivo

## Consumer

Tutti gli endpoint dell'API

## Configurazioni

Nessuna configurazione esterna (tutto hardcoded in `Program.cs`)

## Note

CORS completamente aperto. Accesso da qualsiasi origine consentito.

## Nome nel codice

`Program.cs` — `src/RugbyRadio/Api/Program.cs`
