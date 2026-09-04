# HEADER PAGINE BLOG

Le pagine HTML statiche del blog sono costruite da un JOB HANGFIRE che si occupa anche di scrivere gli HEADER ai fini SEO.
La struttura è:
- index.html
- {language}/index.html, dove language = en, it, fr, es, ja
- {language}/{matchId}.html, una pagina per ogni partita per ogni lingua
 

## https://blog.rugbyradiolive.com/index.html

Questi gli HEADER della pagina index.html:

<meta charset="utf-8">
<title>Rugby Radio Live — Blog</title>
<meta name="description" content="AI-generated rugby match reports in 5 languages. Read narrative articles for every rugby match — Six Nations, Rugby Championship, and more.">
<link rel="canonical" href="https://blog.rugbyradiolive.com/">
<link rel="alternate" hreflang="en" href="https://blog.rugbyradiolive.com/en/index.html">
<link rel="alternate" hreflang="it" href="https://blog.rugbyradiolive.com/it/index.html">
<link rel="alternate" hreflang="fr" href="https://blog.rugbyradiolive.com/fr/index.html">
<link rel="alternate" hreflang="es" href="https://blog.rugbyradiolive.com/es/index.html">
<link rel="alternate" hreflang="ja" href="https://blog.rugbyradiolive.com/ja/index.html">
<link rel="alternate" hreflang="x-default" href="https://blog.rugbyradiolive.com/">
<meta property="og:title" content="Rugby Radio Live — Blog">
<meta property="og:description" content="AI-generated rugby match reports in 5 languages.">
<meta property="og:url" content="https://blog.rugbyradiolive.com/">
<meta property="og:type" content="website">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/x-icon" href="/assets/img/favicon.ico">


## https://blog.rugbyradiolive.com/{language}/index.html

Questi gli HEADER della pagina index.html sotto una specifica lingua:

<meta charset="utf-8">
<title>Rugby Match Reports — AI</title>
<meta name="description" content="Rugby Match Reports — AI — AI-generated match analysis by Rugby Radio Live.">
<link rel="canonical" href="https://blog.rugbyradiolive.com/en/index.html">    
<link rel="next" href="https://blog.rugbyradiolive.com/en/index-2.html" />
<meta property="og:title" content="Rugby Match Reports — AI">
<meta property="og:description" content="AI-generated match analysis by Rugby Radio Live.">
<meta property="og:url" content="https://blog.rugbyradiolive.com/en/index.html">
<meta property="og:type" content="website">
<meta name="viewport" content="width=device-width, initial-scale=1">


## https://blog.rugbyradiolive.com/{language}/{matchId}.html

Questo un esempio di ciò che viene scritto per una pagina di una partita:

<title>Ironwood Hammers - Sovereign Stormhawks</title>
<meta name="keywords" content="rugby commentary, commentary generator, online commentary, amateur rugby commentary, live rugby matches, share rugby commentary, rugby online, sports commentary, personalized commentary, fun rugby commentary" />
<meta name="description" content="Ironwood Hammers 22 - Sovereign Stormhawks 5 del 12/05/2026. Hammers Smash Stormhawks in 22‑5 Thriller" />
<link rel="canonical" href="https://blog.rugbyradiolive.com/en/20260512001046EDFFDA.html">
<link rel="alternate" hreflang="it" href="https://blog.rugbyradiolive.com/it/20260512001046EDFFDA.html">
<link rel="alternate" hreflang="en" href="https://blog.rugbyradiolive.com/en/20260512001046EDFFDA.html">
<link rel="alternate" hreflang="fr" href="https://blog.rugbyradiolive.com/fr/20260512001046EDFFDA.html">
<link rel="alternate" hreflang="es" href="https://blog.rugbyradiolive.com/es/20260512001046EDFFDA.html">
<link rel="alternate" hreflang="ja" href="https://blog.rugbyradiolive.com/ja/20260512001046EDFFDA.html">
<link rel="alternate" hreflang="x-default" href="https://blog.rugbyradiolive.com/en/20260512001046EDFFDA.html">
<meta property="og:title" content="Ironwood Hammers - Sovereign Stormhawks">
<meta property="og:description" content="Ironwood Hammers 22 - Sovereign Stormhawks 5 del 12/05/2026. Hammers Smash Stormhawks in 22‑5 Thriller">
<meta property="og:image" content="https://storage-sh.rugbyradiolive.com/site/images/logo/024.png">
<meta property="og:url" content="https://blog.rugbyradiolive.com/en/20260512001046EDFFDA.html">
<meta property="og:type" content="article">
<meta property="og:locale" content="en_US">
<meta name="twitter:card" content="summary">
<meta name="twitter:title" content="Ironwood Hammers - Sovereign Stormhawks">
<meta name="twitter:description" content="Ironwood Hammers 22 - Sovereign Stormhawks 5 del 12/05/2026. Hammers Smash Stormhawks in 22‑5 Thriller">

