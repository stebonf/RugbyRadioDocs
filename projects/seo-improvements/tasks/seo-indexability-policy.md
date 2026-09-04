# SEO INDEXABILITY POLICY

Un match è indicizzabile se soddisfa TUTTE le condizioni obbligatorie:

- pubblico
- stato terminato, MatchStatus = FullTime
- entrambe le squadre presenti
- almeno 10 eventi registrati
- esiste il blog statico associato
- non appartenente a Channel con `IsTestChannel = true`

Escludere:

- draft
- live in corso
- cancellati
- partite senza squadre
- partite con contenuto insufficiente
- match di test (`Channel.IsTestChannel = true`)