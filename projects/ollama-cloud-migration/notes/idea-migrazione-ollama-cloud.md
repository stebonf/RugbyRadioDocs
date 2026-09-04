 # Migrazione Ollama Cloud

 ## AS-IS

 Le chiamate LLM vengono fatte attraverso API Tailoor.

 Configurazione:
 - modello: gpt-oss:20b
 - TokenMax: 5500
 - Coefficient: 1
 - Options: {"NumCtx":8192,"MaxOutputTokens":2600}

 ## TO-BE

Le chiamate LLM devono essere fatte chiamando Ollama Cloud direttamente.
E' il caso di introdurre una classe per fare ciò rispettato i prompt attuali.
Il recupero dei prompt per talker rimane invariato come meccanismo
