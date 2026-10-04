# AI Applications with Oracle Database 26ai and APEX 26.1

The example code of the book **AI Applications with Oracle Database 26ai and APEX 26.1: Vector
Search, RAG, and AI Agents by Example** by Vinish Kapoor — 237 examples, each with the output it
produced in Oracle AI Database 26ai Free (release 23.26) with Oracle APEX 26.1, the scripts that
install the book's sample schema, **Atlas Support**, a software company's help desk, and the
finished APEX application.

## The Book

- **Paperback** on Amazon: [amazon.com/dp/B0HLXFCF1G](https://www.amazon.com/dp/B0HLXFCF1G) — 409 pages, 7.5 x 9.25 in, ISBN 9798178836798
- **Kindle edition** on Amazon: [amazon.com/dp/B0HLXN2BD4](https://www.amazon.com/dp/B0HLXN2BD4)
- **Author:** [Vinish Kapoor](https://www.amazon.com/author/vinish-kapoor) · [vinish.dev](https://vinish.dev)

## Contents

- `setup/atlas/` — the ATLAS schema: `create-user.sql` (run as a DBA), `install.sql` (run as ATLAS:
  products, customers, agents, tickets, comments, and knowledge base articles), `uninstall.sql`,
  `archive.sql` (the 50,000 archived tickets of Chapter 7), and `documents/`, the library of
  manuals, FAQs, and release notes (PDF, Word, and HTML) that Chapter 9 loads.
- `setup/login.sql` — the SQLcl settings the examples ran with.
- `examples/` — one folder per chapter. Each `name.sql` is an example as the book prints it, and
  `name.out` the output it produced.
- `apex/f200.sql` — the finished **Atlas Support** application (application 200) of Parts IV and V,
  and `apex/f250.sql`, the application **Atlas KB Admin** that Chapter 22 creates from a
  description.

## Installing the Sample Schema

Chapter 2 of the book describes the lab. In short, with the database container of Chapter 2:

1. Connect to the pluggable database as a DBA and run `setup/atlas/create-user.sql` with a
   password for ATLAS: `sql system@localhost:1521/FREEPDB1 @create-user.sql 'Your_Atlas_Password1'`.
2. Connect as ATLAS from the folder `setup/atlas` and run `install.sql`.
3. For the embedding examples (Chapter 5), download Oracle's prebuilt
   `all_MiniLM_L12_v2_augmented.zip` (linked from the *AI Vector Search User's Guide*), unzip it, and
   copy `all_MiniLM_L12_v2.onnx` to `/opt/oracle/atlas_files` in the container. Chapter 9 copies
   `setup/atlas/documents` to the same folder.
4. Chapter 7 runs `archive.sql` as ATLAS for the archive of 50,000 tickets.

## Your Gemini Key

The examples that call Gemini need your own API key, which Chapter 2 shows how to create. Put it
in place of `<your-gemini-api-key>` in `examples/ch02/create-credential.sql`, and never commit it.
The APEX examples use an APEX web credential, which you fill in on the Web Credentials page of your
workspace (Chapter 16).

## Running the Examples

Connect as ATLAS with SQLcl, in the folder that contains `setup/login.sql` (or with `SQLPATH`
pointing to it), and run an example with `@examples/folder/name.sql`, or paste it.

Lines that start with `-- @` are instructions for the program that ran the examples for the
book, and are not printed in it:

- `-- @setup statement` prepares the example (for example, drops a table it creates) — run it first.
- `-- @cleanup statement` tidies up after the example — run it afterwards.
- `-- @connect sysdba` means the example runs as SYS (`sql / as sysdba`), in the pluggable
  database FREEPDB1 (`alter session set container = FREEPDB1`).
- `-- @expect-error` marks an example that shows an error on purpose.
- `-- @keep-output` marks an example whose recorded output depends on a moment that can't be
  repeated, such as the calls of a past session.

The examples of a chapter can depend on earlier ones; run the chapters in order. A language model
writes a new answer each time: the text of AI answers, timings, and token counts will differ from
the book's.

## Installing the APEX Applications

Import `apex/f200.sql` into a workspace whose schema is ATLAS (**App Builder › Import**), after
running the examples of Parts II to IV, which create the database objects it uses. The application
uses workspace components that an export doesn't contain; create them first, as Chapter 16 shows:

- the Generative AI services **Gemini** (static ID `gemini`) and **Gemini Lite** (`gemini-lite`),
  with your web credential, and
- the vector provider **Atlas MiniLM** (static ID `atlas-minilm`), of the type Database ONNX Model.

## Examples by Chapter

| Folder | Chapter | Examples |
|---|---|---|
| `examples/ch01` | Chapter 1. How to Use This Book | 1 |
| `examples/ch02` | Chapter 2. The AI Lab | 5 |
| `examples/ch03` | Chapter 3. AI for Oracle Developers | 3 |
| `examples/ch04` | Chapter 4. The VECTOR Type | 20 |
| `examples/ch05` | Chapter 5. Embeddings Inside the Database | 16 |
| `examples/ch06` | Chapter 6. Embeddings from a Provider | 14 |
| `examples/ch07` | Chapter 7. Vector Indexes | 18 |
| `examples/ch08` | Chapter 8. Semantic and Hybrid Search | 14 |
| `examples/ch09` | Chapter 9. Loading Documents | 13 |
| `examples/ch10` | Chapter 10. Calling an LLM from the Database | 11 |
| `examples/ch11` | Chapter 11. Practical Generation | 12 |
| `examples/ch12` | Chapter 12. RAG in SQL and PL/SQL | 8 |
| `examples/ch13` | Chapter 13. Natural Language to SQL | 11 |
| `examples/ch14` | Chapter 14. Classic Machine Learning in the Database | 8 |
| `examples/ch15` | Chapter 15. Vectors with JSON, Graphs, and Relational Data | 9 |
| `examples/ch17` | Chapter 17. The APEX_AI Package | 11 |
| `examples/ch18` | Chapter 18. AI Assistants in Pages | 2 |
| `examples/ch19` | Chapter 19. AI Agents | 3 |
| `examples/ch20` | Chapter 20. AI in Forms and Workflows | 3 |
| `examples/ch22` | Chapter 22. APEX's Built-in AI for Developers | 1 |
| `examples/ch23` | Chapter 23. Project: the Atlas Knowledge Assistant | 6 |
| `examples/ch24` | Chapter 24. Project: the AI Help Desk | 9 |
| `examples/ch25` | Chapter 25. Project: Ask Your Data | 5 |
| `examples/ch26` | Chapter 26. Running AI Locally | 7 |
| `examples/ch27` | Chapter 27. Security and Privacy | 8 |
| `examples/ch28` | Chapter 28. Quality, Cost, and Speed | 8 |
| `examples/ch29` | Chapter 29. Deploying AI Applications | 7 |
| `examples/appb` | Appendix B. APEX_AI and APEX's AI Components | 1 |
| `examples/appc` | Appendix C. Switching Providers | 3 |
