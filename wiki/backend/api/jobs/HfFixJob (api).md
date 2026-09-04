---
title: "HfFixJob (api)"
type: backend-job
layer: backend
---

# HfFixJob (api)

## Sintesi

Job Hangfire proposto per bonifica periodica conservativa dei dati operativi. Il job deve correggere anomalie note prodotte da simulazioni Fake Agent, prove utente incomplete o processi temporanei non completati.

La pagina descrive una progettazione non ancora implementata nel codice sorgente.

## Trigger

Hangfire ricorrente orario. La schedulazione deve essere configurata manualmente da dashboard Hangfire.

## Responsabilità

- Chiudere partite `InProgress` con `DateUtc` oltre soglia di 5 giorni impostando `Status = FullTime`.
- Correggere team con `Name` nullo, vuoto o whitespace usando la logica Fake Agent di generazione nome.
- Correggere partite con `ImageUrl` nullo, vuoto o whitespace riusando la logica esistente di assegnazione immagine.
- Correggere radio/canali con `ImageUrl` nullo, vuoto o whitespace riusando la logica esistente di assegnazione immagine canale.
- Correggere radio/canali con `Name` nullo, vuoto o whitespace usando la logica Fake Agent di generazione nome canale.
- Correggere utenti con `Nickname` nullo, vuoto o whitespace usando la logica Fake Agent di generazione nickname.
- Loggare conteggi, correzioni e skip per singolo controllo.

## Services usati

Servizi o helper proposti:

- `IFakeTeamNameGenerator` — generazione riusabile del nome team.
- `IFakeChannelNameGenerator` — generazione riusabile del nome canale.
- `IFakeUserNicknameGenerator` — generazione riusabile del nickname utente.
- `IMatchImageAssigner` — assegnazione immagine partita condivisa con [[RepairMatchImageJob (api)]].
- `IChannelImageAssigner` — assegnazione immagine radio/canale condivisa con le logiche di creazione canale.

Accesso dati proposto:

- [[MatchRepository (api)]]
- [[TeamRepository (api)]]
- [[ChannelRepository (api)]]
- [[UserRepository (api)]]

## Entities coinvolte

- [[Match (api)]] — lettura/scrittura di `Status` e `ImageUrl`.
- [[Team (api)]] — lettura/scrittura di `Name`.
- [[Channel (api)]] — lettura/scrittura di `Name` e `ImageUrl`.
- [[User (api)]] — lettura/scrittura di `Nickname`.

## Side effects

- Aggiornamento conservativo di record database.
- Possibili side effect filesystem quando vengono assegnate immagini tramite logiche gia esistenti.
- Nessuna cancellazione di partite, team, canali, utenti, eventi o dati collegati.
- Nessuna pubblicazione social, notifica o rigenerazione di blog prevista dall'MVP.

## Failure points

- `DateUtc` non valorizzata correttamente su partite storiche.
- API o helper AI non disponibili durante generazione nomi o nickname.
- Pool immagini vuoto o immagine sorgente non disponibile.
- Errori filesystem durante copia, spostamento o compositing immagini.
- Errori di salvataggio su singolo record.
- Query whitespace non tradotta correttamente dal provider EF/SQL Server.

Gli errori puntuali devono produrre skip e log senza interrompere gli altri controlli. Gli elementi saltati devono restare eleggibili per l'esecuzione successiva.

## Note

Pattern proposti:

- ereditarieta da `BaseCoreJob`;
- `[AutomaticRetry(Attempts = 0)]`;
- `[DisableConcurrentExecution(timeoutInSeconds: 3600)]`;
- batch size e soglia inizialmente costanti;
- controlli interni indipendenti: `CloseStaleInProgressMatchesAsync`, `FixUnnamedTeamsAsync`, `FixMatchImagesAsync`, `FixChannelImagesAsync`, `FixUnnamedChannelsAsync`, `FixUsersWithoutNicknameAsync`.

Workflow correlato: [[Data Quality Maintenance (workflow)]].

## Nome nel codice

`HfFixJob` — `src/RugbyRadio/HF/Jobs/HfFixJob.cs` proposto, non implementazione verificata.
