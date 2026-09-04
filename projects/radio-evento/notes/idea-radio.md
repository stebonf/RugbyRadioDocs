# IDEA - MODALITÀ RADIO EVENTO

## Obiettivo

Evolvere Rugby Radio Live da semplice telecronaca testuale con supporto TTS ad una esperienza "Radio Evento" più immersiva, mantenendo invariato il principio fondamentale della piattaforma:

- il cronista continua a premere solo pulsanti
- nessun microfono
- nessuna registrazione audio
- nessuna chiamata AI realtime
- compatibilità completa con architettura attuale
- esperienza fruibile da browser web e dispositivi mobili

L'obiettivo non è trasformare RRL in una radio tradizionale, ma avvicinare l'esperienza percepita a quella di una radiocronaca automatica. La wiki conferma che il TTS è già disponibile come layer opzionale sopra la telecronaca e che gli audio evento vengono già generati e riprodotti tramite frontend e backend esistenti.

---

# Visione

Uno spettatore deve poter:

- aprire una partita
- premere Play
- mettere il telefono in tasca
- ascoltare la partita come una radio

senza dover leggere continuamente il feed eventi.

La partita continua comunque ad esistere come:

- feed eventi
- punteggio live
- statistiche
- commenti
- emoji

L'audio diventa un canale alternativo di fruizione.

---

# Principi da rispettare

## Nessun impatto sul cronista

Il cronista non deve imparare nulla di nuovo.

Continua a:

- creare la partita
- premere eventi

Tutto il resto deve essere generato automaticamente dalla piattaforma.

---

## Nessuna AI realtime

La piattaforma utilizza già contenuti generati offline.

La modalità radio deve continuare a sfruttare:

- frasi già esistenti
- audio TTS già disponibili
- eventuali contenuti pre-generati

senza introdurre dipendenze realtime da modelli AI.

---

## Compatibilità web

La modalità deve funzionare:

- browser desktop
- browser mobile
- PWA
- TWA Android

senza richiedere applicazioni dedicate.

---

# Concetto di Radio Evento

La modalità Radio Evento introduce un player audio continuo.

Quando lo spettatore attiva la modalità radio:

1. la piattaforma si sottoscrive agli eventi della partita
2. ogni nuovo evento viene convertito in audio
3. gli audio vengono accodati
4. la riproduzione procede automaticamente

L'utente non deve cliccare il pulsante audio per ogni evento.

---

# Evoluzione proposta

## Fase 1 - Auto Play Telecronaca

### Obiettivo

Automatizzare la riproduzione degli eventi.

### Esperienza

Lo spettatore:

- apre la partita
- seleziona l'AI-Talker
- preme Play

Da quel momento:

- ogni evento viene riprodotto automaticamente
- gli audio vengono messi in coda
- la riproduzione continua fino alla fine della partita

### Benefici

- sfrutta componenti già esistenti
- rischio basso
- valore percepito elevato

---

## Fase 2 - Pagina Radio

### Obiettivo

Creare una vista dedicata all'ascolto.

### Layout

Mostrare solamente:

- copertina partita
- squadre
- punteggio
- timer
- AI-Talker selezionato
- controlli play / pause

Nascondere:

- statistiche dettagliate
- feed completo
- elementi secondari

### Esperienza

Simile ad un player musicale.

---

## Fase 3 - Radio Lock Screen

### Obiettivo

Favorire ascolto passivo.

### Scenario

Genitore:

- in auto
- al lavoro
- in viaggio

può seguire la partita senza guardare continuamente il telefono.

### Requisiti da analizzare

- comportamento browser mobile
- gestione background audio
- comportamento PWA/TWA

---

## Fase 4 - Notifiche Audio

### Obiettivo

Ridurre il rischio che l'utente perda momenti importanti.

### Idee

Notifiche push per:

- meta
- trasformazione
- cartellino
- fine primo tempo
- fine partita

Apertura diretta della modalità radio.

---

## Fase 5 - Jingle Radio

### Obiettivo

Rendere l'esperienza più simile ad una trasmissione.

### Esempi

Tra eventi distanziati:

- identificazione del canale
- slogan RRL
- messaggi della squadra
- annunci generici

I contenuti devono essere statici e pre-generati.

---

## Fase 6 - Multi Speaker

### Obiettivo

Sfruttare gli AI-Talker come una squadra editoriale.

La wiki descrive già diversi personaggi con personalità differenti. :contentReference[oaicite:1]{index=1}

### Esempio

Vox:
- telecronista principale

Bulldog:
- commento da ex giocatore

Newsly:
- aggiornamenti e riepiloghi

### Possibile esperienza

Evento:

"Meta del Petrarca"

Segue:

- telecronaca principale
- commento del personaggio secondario
- aggiornamento punteggio

---

## Fase 7 - Radio Canale

### Obiettivo

Estendere il concetto di Radio oltre la singola partita.

La wiki definisce già la Radio come contenitore di partite e identità della squadra o società. :contentReference[oaicite:2]{index=2}

### Evoluzione

Quando non è in corso una partita:

la radio potrebbe proporre contenuti del canale:

- ultime partite
- risultati recenti
- articoli blog
- curiosità
- presentazione della società

Quando parte una partita:

la radio passa automaticamente alla diretta evento.

---

# Casi d'uso principali

## Genitore assente

Non può essere presente al campo.

Attiva la modalità radio e ascolta la partita.

---

## Nonni e parenti

Possono seguire l'incontro senza comprendere l'interfaccia completa.

Premono Play e ascoltano.

---

## Allenatore

Può ascoltare l'andamento della partita mentre segue altre attività.

---

## Tifoso occasionale

Può ricevere notifiche degli eventi principali e rientrare facilmente nella diretta.

---

# Benefici attesi

## Per gli spettatori

- maggiore immersione
- utilizzo a schermo spento
- minore necessità di leggere

## Per Rugby Radio Live

- differenziazione rispetto ai live score tradizionali
- valorizzazione del sistema TTS già esistente
- valorizzazione degli AI-Talker
- rafforzamento del concetto di "Radio" presente nel brand

## Per i cronisti

- nessun cambiamento operativo

---

# Domande aperte per analisi funzionale

- Come gestire la coda audio lato frontend?
- Come gestire eventi arrivati mentre il player è in riproduzione?
- Come evitare sovrapposizioni audio?
- Come gestire perdita di connessione?
- Come gestire il background audio nei browser mobili?
- Come gestire notifiche push e riapertura della radio?
- Come gestire più AI-Talker contemporaneamente?
- È preferibile una modalità radio dedicata o integrata nella pagina partita?
- Come misurare l'utilizzo della modalità radio tramite analytics?
- Come riutilizzare blog, statistiche e contenuti già presenti per una futura Radio Canale?