---
title: "JwtBearerAuthentication (api)"
type: backend-security
layer: backend
---

# JwtBearerAuthentication (api)

## Sintesi

Configurazione autenticazione JWT Bearer per l'API. Schema default per autenticazione, challenge e sign-in. Firma simmetrica HmacSha256. Token con scadenza configurata (~1 anno). Supporta lettura token da header `Authorization` e da cookie `Authentication`.

## Responsabilità

- Schema: `JwtBearerDefaults.AuthenticationScheme`
- Algoritmo firma: `HmacSha256` (simmetrico)
- `ValidateIssuer`, `ValidateAudience`, `ValidateIssuerSigningKey`: tutti `true`
- `SaveToken`: `true`; `RequireHttpsMetadata`: `false`
- Logica `OnMessageReceived`: privilegia cookie `Authentication` sull'header Bearer se il cookie è presente
- `app.UseAuthentication()` + `app.UseAuthorization()` in pipeline

## Regole auth

Nessuna policy globale `RequireAuthorization()` visibile. Gli endpoint senza `[Authorize]` sono accessibili senza token.

## Policies

Nessuna policy custom. Solo attributo `[Authorize]` / `[AllowAnonymous]` per endpoint.

## Consumer

Tutti i controller API che usano `[Authorize]`

## Configurazioni

- `Security:SecretKey` — chiave simmetrica HmacSha256; presente in `appsettings.json` in chiaro (valore sensibile)
- `Security:ValidIssuer` — issuer JWT
- `Security:ValidAudience` — audience JWT
- `Security:ExpirationMinutes` — `525600` (~1 anno)

## Nome nel codice

`ServiceCollectionExtensions.RegisterSecurity` — `src/RugbyRadio/Lib/Core/Extensions/ServiceCollectionExtensions.cs`

## Note

Non deducibile
