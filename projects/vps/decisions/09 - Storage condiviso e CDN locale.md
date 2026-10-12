# 09 - Storage condiviso e CDN locale

## Decisione

Lo storage immagini/audio viene gestito da un servizio indipendente chiamato `rrl-storage`, basato su Nginx e collegato al volume Docker nominato `rrl-storage-data`.

API S1, API S2 e Hangfire montano lo stesso volume in `/data/storage` con permessi di scrittura. Il container `rrl-storage` pubblica lo stesso contenuto come file statici HTTP, inizialmente su `http://localhost:5300`.

## Motivazione

API e Hangfire devono poter scrivere immagini e audio nello stesso spazio che viene distribuito come CDN. Separare il processo HTTP dal volume evita di legare la distribuzione dei file al ciclo di vita di un singolo writer e prepara l'integrazione futura con reverse proxy e hostname pubblico.

## Configurazione

- `RRL_STORAGE_ROOT_PATH=/data/storage` è la radice usata dalla libreria condivisa.
- Il backup iniziale è `C:\Repositories\RRL\backup\RugbyRadioStorage`.
- La copia iniziale è ricorsiva e comprende le sottodirectory.
- Lo script locale ricrea il volume e ripopola il seed a ogni esecuzione, coerentemente con la decisione precedente di avere un bootstrap locale sempre distruttivo.

## Implicazioni

Il lifecycle distruttivo è adatto solo al bootstrap locale. Per UAT e produzione il volume dovrà essere persistente e il deploy dovrà aggiornare immagini/audio senza cancellare il contenuto esistente.
