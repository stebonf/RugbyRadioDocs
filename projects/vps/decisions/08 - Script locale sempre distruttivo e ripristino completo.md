# Decisione 08 - Script locale sempre distruttivo e ripristino completo

## Decisione

Lo script `Initialize-LocalRrl.ps1` non accetta flag. Ogni esecuzione:

1. rigenera i file `.env` locali dai template;
2. rimuove i container API e Hangfire;
3. rimuove il volume SQL Server locale;
4. avvia SQL Server Express;
5. ripristina `RugbyRadioLive.bak` nel database `RugbyRadioLive`;
6. ripristina `RugbyRadioLive-HF.bak` nel database `RugbyRadioLive-HF`;
7. builda e avvia `rrl-api-s1`, `rrl-api-s2` e `rrl-hangfire`.

## Motivazione

Durante la fase locale corrente l'ambiente viene ricreato frequentemente e la ripetibilita' completa e' piu' utile della conservazione dei dati locali. I backup approvati sono la fonte di ripristino a ogni esecuzione.

## Conseguenze

- Il comando e' semplice e non richiede di ricordare combinazioni di flag.
- Il volume `sqlserver-express-data` viene cancellato a ogni esecuzione.
- Il percorso dei due backup deve essere corretto e i file devono esistere.
- Lo script non e' adatto a UAT/PROD senza una futura modalita' non distruttiva e una gestione backup esplicita.
