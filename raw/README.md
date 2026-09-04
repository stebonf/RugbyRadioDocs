# Raw

`raw` contains structured source material for the wiki.

Files in this folder are inputs for future synthesis, ingestion, and wiki maintenance. They are not the wiki itself.

## Structure

```text
raw/
  projects/
```

## Rules

- Store final project closeout documents under `raw/projects/<project-id>`.
- Keep raw material structured enough that an LLM can ingest it later.
- Do not store secrets, credentials, tokens, private keys, or unfiltered sensitive exports.
- Do not use `raw` for temporary working notes; use `projects/<project-id>` instead.
