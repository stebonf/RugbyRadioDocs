# Infrastructure is part of the user experience

## Status

`draft`

## Angle

Raccontare che Rugby Radio Live usa Firebase per il frontend; tutti gli altri servizi sono ora erogati da una VPS Linux. Il punto tecnico accessibile: per chi costruisce un prodotto, l'infrastruttura non è solo una scelta operativa; influenza quanto è semplice mantenere e far evolvere il servizio. La migrazione è completa; backup e ulteriori strumenti di supporto operativo sono i prossimi passi.

## Post

Infrastructure work rarely makes the match highlights.

But it is part of the user experience.

Rugby Radio Live keeps its frontend on Firebase, while all the other services now run on a Linux VPS. The move from the home server is complete, giving the platform a new foundation as we support its users and community.

The high-level shape is simple:

`Supporters` ⇄ `RRL services on VPS`

`Frontend` → `Firebase Hosting`

All RRL services outside the frontend are now delivered from the VPS; the frontend remains on Firebase. The next work is operational: adding further support tools, including backups.

Moving production is a milestone, not the end of infrastructure work. We’ll keep strengthening the operational setup as RRL evolves.

A practical lesson from the process: infrastructure choices become product choices when they affect how safely a team can operate, update and support a service.

The target is not complexity for its own sake. It is a setup we can understand, maintain and grow with.

#SoftwareArchitecture #CloudInfrastructure #Docker #ProductDevelopment #SportsTech #RugbyRadioLive

## CTA

No traffic CTA. Invite discussion around how infrastructure decisions affect product operations and user support.

## Image Concept

Schema semplice e leggibile in un'unica immagine LinkedIn verticale:

`Supporters` → `Frontend on Firebase` → `RRL services on VPS`

Il diagramma mostra il frontend su Firebase e tutti gli altri servizi RRL sulla VPS.

## Image Prompt

Create a clean LinkedIn technical visual, portrait 1080 x 1350 px (4:5), explaining the current RRL hosting split: frontend on Firebase, all other services on a VPS. Professional, restrained and understandable to a broad product and software audience. Use deep rugby green, off-white, charcoal and one subtle coral accent. Keep all elements inside generous mobile-safe margins.

Show a simple architecture flow with large readable labels:

`Supporters` → `Frontend on Firebase` → `RRL services on VPS`

Add the title:
`A stronger foundation for the game`

Add a small footer:
`Rugby Radio Live`

Use simple geometric icons for people, a frontend, application services, containers and a server. Show two connected parts: `Supporters` → `Frontend` → `Firebase Hosting`; then `Frontend` → `RRL services` → `Docker containers` → `Linux VPS`. Make clear that the frontend remains on Firebase and all other RRL services are now running on the VPS. No cloud-provider logos, fake dashboards, code snippets, port numbers, database details, claims of high availability, or extra text. Preserve exact spelling and make labels readable on a phone.

## Notes

Pubblicare sulla pagina LinkedIn Rugby Radio Live. La migrazione dei servizi backend alla VPS è completata; il frontend resta su Firebase. Backup e ulteriori strumenti di supporto operativo sono attività successive, non ancora presentate come concluse. Un eventuale repost personale può aggiungere una nota sul rapporto tra scelte infrastrutturali e capacità di supportare un prodotto nel tempo.



