---
title: "Pubblicazione Blog Statico (workflow)"
type: workflow
layer: workflow
---

# Pubblicazione Blog Statico (workflow)

## Obiettivo

Generare contenuti blog da partite terminate e pubblicarli come pagine HTML statiche indicizzabili, con sitemap e header SEO.

## Trigger

Esecuzione Hangfire RecurringJobAdmin dei job di generazione blog e staticizzazione HTML.

## Attori

Non deducibile

## Frontend coinvolto

Non deducibile

## Backend coinvolto

- [[CreateMatchBlogJob (api)]]
- [[CreateMatchBlogHtmlJob (api)]]
- [[BlogV1Controller (api)]]
- [[BlogStaticFilePublishingIntegration (api)]]
- [[PublicMediaUrlReferenceIntegration (api)]]
- [[SocialShareUrlIntegration (api)]]

## Data coinvolti

- [[Match (api)]]
- [[Blog (api)]]

## Analytics tracking

Non deducibile

## Failure points

- Risposta AI vuota durante la generazione del post.
- Eccezione nel job di generazione blog propagata a Hangfire.
- Nessun retry automatico nei job coinvolti.
- Generazione HTML statico o sitemap su filesystem non completata.
- Riferimenti media pubblici o link social generati in HTML non validi.

## Gap noti

- Frequenza cron dei job non deducibile dalla wiki.
- Consumer frontend del blog non deducibile con certezza dalla wiki.
- Eventuali metriche analytics specifiche del blog statico non deducibili.

## Note

Workflow tecnico creato da pagine wiki esistenti e suggerimento lint. La catena collega generazione del contenuto, staticizzazione HTML, endpoint pubblico blog, header SEO e sitemap pubblica.
