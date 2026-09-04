---
title: "SecuritySettings (api)"
type: backend-security
layer: backend
---

# SecuritySettings (api)

## Sintesi

Classe POCO che mappa la sezione `Security` di `appsettings.json`. Istanza letta in `Program.cs` e passata a `RegisterSecurity`. Se la sezione manca in configurazione, la startup fallisce con `ArgumentNullException`.

## Responsabilità

- Binding configurazione sezione `Security`
- Proprietà: `ValidIssuer`, `ValidAudience`, `SecretKey`, `ExpirationMinutes`
- `ArgumentNullException.ThrowIfNull(securitySettings)` in `Program.cs`

## Regole auth

Non applicabile (settings DTO)

## Policies

Nessuna

## Consumer

- [[JwtBearerAuthentication (api)]]

## Configurazioni

- `Security:SecretKey` — chiave di firma JWT; presente in `appsettings.json` in chiaro

## Nome nel codice

`SecuritySettings` — `src/RugbyRadio/Lib/Settings/SecuritySettings.cs`
