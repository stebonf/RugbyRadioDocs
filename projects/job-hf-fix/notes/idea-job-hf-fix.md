# JOB HF FIX

Job schedulato per girare ogni ora che verifica lo stato dei dati di RRL e intraprende se necessario delle misure collettive.
Il job verrà arricchito di funzionalità mano mano che si verificheranno problemi.

## Funzionalità

### 1. Partite mai terminate

FakeAgent o utenti che provano ogni tanto non terminano le partite e quindi risultano sempre "in corso".
Il job deve recuperare le partite in corso e se passati più di 5 giorni deve chiuderle forzatamente cambiando lo stato.

### 2. Team senza nomi

Durante la creazione dei Team con FakeAgent può capitare che non si generino i nomi delle squadre.
Il job deve recuperare eventuali Team senza nome, capire il contesto dal Canale, chiamare la procedura di creazione dei nomi come in FakeAgent.
In caso di errore nella creazione per via delle API che non rispondono, il job dovrà semplicemente skippare la riga in modo che venga processata la volta dopo.

### 3. Partita senza immagine

Verificare se esistono partite su database senza immagine, in caso positivo seguire le logiche esistenti per l'associazione 
dell'immagine quando viene creata una partita.

### 4. Radio senza immagine

Verificare se esistono radio su database senza immagine, in caso positivo seguire le logiche esistenti per l'associazione
dell'immagine quando viene creata una radio.

### 5. Radio/Canale senza nome

Verificare se esistono canali senza nome, in quel caso utilizzare la logica di creazione del nome usata da FakeAgent.

### 6. Utente senza nickname

Verifica se esistono utenti senza nickname, in quel caso utilizzare la logica di creazione del nickname usata da FakeAgent.