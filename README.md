# AI Applications with Oracle Database 26ai and APEX 26.1

The example code of the book **AI Applications with Oracle Database 26ai and APEX 26.1: Vector
Search, RAG, and AI Agents by Example** by Vinish Kapoor — 237 examples, each with the output it
produced in Oracle AI Database 26ai Free (release 23.26) with Oracle APEX 26.1, the scripts that
install the book's sample schema, **Atlas Support**, a software company's help desk, and the
finished APEX application.

## The Book

- **Book page:** [vinish.dev/oracle-ai-applications-book](https://vinish.dev/oracle-ai-applications-book) — what the book covers, sample pages, and the table of contents
- **Paperback** on Amazon: [amazon.com/dp/B0HLXFCF1G](https://www.amazon.com/dp/B0HLXFCF1G) — 409 pages, 7.5 x 9.25 in, ISBN 9798178836798
- **Kindle edition** on Amazon: [amazon.com/dp/B0HLXN2BD4](https://www.amazon.com/dp/B0HLXN2BD4)
- **Apple Books:** [books.apple.com](https://books.apple.com/us/book/ai-applications-with-oracle-database-26ai-and-apex-26-1/id6819165636)
- **Author:** [Vinish Kapoor](https://www.amazon.com/author/vinish-kapoor) · [vinish.dev](https://vinish.dev)

## Contents

- `setup/atlas/` — the ATLAS schema: `create-user.sql` (run as SYS), `install.sql` (run as ATLAS:
  products, customers, agents, tickets, comments, and knowledge base articles), `uninstall.sql`,
  `archive.sql` (the 50,000 archived tickets of Chapter 7), and `documents/`, the library of
  manuals, FAQs, and release notes (PDF, Word, and HTML) that Chapter 9 loads.
- `setup/login.sql` — the SQLcl settings the examples ran with.
- `examples/` — one folder per chapter. Each `name.sql` is an example as the book prints it, and
  `name.out` the output it produced.
- `apex/f200.sql` — the finished **Atlas Support** application (application 200) of Parts IV and V,
  and `apex/f250.sql`, the application **Atlas KB Admin** that Chapter 22 creates from a
  description.

## Errata

- **Chapter 2, "The ATLAS Schema":** run `create-user.sql` as **SYS**, not as SYSTEM:

  ```bash
  sql sys@localhost:1521/FREEPDB1 as sysdba @create-user.sql 'Your_Atlas_Password1'
  ```

  As SYSTEM, five grants fail with *ORA-01031: insufficient privileges*: SYSTEM may not grant
  `EXECUTE` on `DBMS_VECTOR`, `DBMS_VECTOR_CHAIN`, `DBMS_HYBRID_VECTOR`, `DBMS_DATA_MINING`, and
  `UTL_HTTP`, and the examples that need them fail later. If you ran the script as SYSTEM
  already, connect as SYS and run it again: it reports that the user ATLAS exists (*ORA-01920*, which you can ignore),
  leaves the user as it is, and gives the missing grants. The book's examples ran as SYS.

## Installing the Sample Schema

Chapter 2 of the book describes the lab. In short, with the database container of Chapter 2:

1. Connect to the pluggable database as SYS and run `setup/atlas/create-user.sql` with a
   password for ATLAS: `sql sys@localhost:1521/FREEPDB1 as sysdba @create-user.sql 'Your_Atlas_Password1'`
   (not as SYSTEM; see [Errata](#errata)).
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

| Application | APEX Cloud (apex.oracle.com, OCI) | Local lab (Chapter 2) |
|---|---|---|
| `apex/f250.sql`, **Atlas KB Admin** (Chapter 22) | Import it. That's all. | Import it. That's all. |
| `apex/f200.sql`, **Atlas Support** (Parts IV and V) | Not supported: it needs the lab. | Run two scripts, then import it (below). |

### Atlas KB Admin (application 250): one import

In **App Builder**, click **Import**, choose `apex/f250.sql`, click **Next** and **Import
Application**, click **Next** on the Credentials page, and then **Install Supporting Objects**.
Click **Run Application** and sign in with your workspace user.

The import creates the six tables of the Atlas Support sample schema and their data in your
workspace's schema, the same as `setup/atlas/install.sql`, and gives you, the developer who imports
it, the **Administrator** role. If the schema already has the Atlas tables (you ran `install.sql`
in Chapter 2, for example), they stay as they are. If you import the application first, skip
`install.sql` later: the tables are already there.

Use a workspace whose schema has no other tables named `PRODUCTS`, `CUSTOMERS`, `AGENTS`, `TICKETS`,
`TICKET_COMMENTS` or `KB_ARTICLES`. If it has one from another application (a `CUSTOMERS` table
with other columns, for example), the import leaves it alone and stops with *"Supporting Objects
Install Error"*; **Install Summary** names the table. On apex.oracle.com you can request a new
workspace for the book.

Other users of the workspace can open it and view the data; to change data, they need the
**Contributor** or **Administrator** role in **Shared Components › Application Access Control**.

### Atlas Support (application 200): the local lab only

Atlas Support is the finished application of the book. It needs the database objects of Chapters 5
to 29 (the `atlas_security` package of Chapter 27, for example, which it calls when a session
starts), an embedding model loaded into the database from a folder on the database server, and
network access from the database to Gemini. Hosted services such as apex.oracle.com allow neither
of the last two, so there it stops with *"Error processing database session setup code"*.

In the lab of Chapter 2 (the container `db26ai`, with APEX), you don't have to work through the book
first: the scripts of `setup/app200` install everything the application needs, in the version the
book ends with. They skip what is already there, so they also run in a schema where you ran the
examples, and you can run them again.

1. **The model and the documents.** Download `all_MiniLM_L12_v2_augmented.zip` from the link in
   Oracle's *AI Vector Search User's Guide* (section on importing pretrained ONNX models; Chapter 5)
   and unzip it. Then, from the folder of this repository:

   ```bash
   docker exec db26ai mkdir -p /opt/oracle/atlas_files
   docker cp <unzipped folder>/all_MiniLM_L12_v2.onnx db26ai:/opt/oracle/atlas_files/
   docker cp setup/atlas/documents/. db26ai:/opt/oracle/atlas_files/
   ```

2. **As SYS**, from the folder `setup/app200`, with a password for ATLAS (used only if ATLAS
   doesn't exist yet):

   ```bash
   sql sys@localhost:1521/FREEPDB1 as sysdba @dba.sql 'Your_Atlas_Password1'
   ```

   It creates the user ATLAS and its privileges, the network access to Gemini for ATLAS and for
   APEX, the folder `ATLAS_FILES`, the application context of Chapter 27, and `ATLAS_READER`, the
   user that runs the queries of Ask Your Data (Chapter 13).

3. **As ATLAS**, from the same folder:

   ```bash
   sql atlas@localhost:1521/FREEPDB1 @install.sql
   ```

   It creates the Atlas tables if they aren't there, loads the model, creates the tables, functions,
   and views of Chapters 5 to 29, loads the documents, computes the embeddings, adds the
   classification of Chapter 11, and asks once for your Gemini API key (not shown as you type),
   which it stores in the database credential `GEMINI_CRED`. It takes about a minute and ends with a
   check: 400 tickets and 24 articles embedded, 9 documents, 400 tickets classified, 0 invalid
   objects.

4. **Import the application.** In a workspace whose schema is ATLAS (Chapter 2), click **App
   Builder › Import**, choose `apex/f200.sql`, and click **Next** and **Import Application**. On the
   Credentials page, for **Credentials for gemini**, enter `x-goog-api-key` in **Client ID or
   Username** and your Gemini API key in **Client Secret** and **Verify Client Secret**. Click
   **Next**.

5. Click **Run Application** and sign in with your workspace user.

The import also creates the workspace's Generative AI service **Gemini** and the vector provider
**Atlas MiniLM**, if the workspace doesn't have them. To change the Gemini key later: in the database,
run `gemini-credential.sql` as ATLAS; in APEX, **Workspace Utilities › Web Credentials › Credentials
for gemini**.

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
