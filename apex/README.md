# The APEX Applications of the Book

| File | Application | Where it runs |
|---|---|---|
| `f250.sql` | **Atlas KB Admin** (Chapter 22): the knowledge base, tickets, and customers, with a dashboard | APEX Cloud (apex.oracle.com, OCI) and your local lab |
| `f200.sql` | **Atlas Support** (Parts IV and V): the finished AI application of the book | Your local lab only (Chapter 2) |

Both need Oracle APEX 26.1.

## Atlas KB Admin (`f250.sql`)

1. In **App Builder**, click **Import** and choose `f250.sql`.
2. Click **Next**, then **Import Application**.
3. On the Credentials page, click **Next**.
4. Click **Install Supporting Objects**.
5. Click **Run Application** and sign in with your workspace user.

The import creates the Atlas Support tables and their data in your workspace's schema, if they
aren't there yet, and makes you the application's Administrator.

Use a workspace whose schema has no other tables named `PRODUCTS`, `CUSTOMERS`, `AGENTS`, `TICKETS`,
`TICKET_COMMENTS`, or `KB_ARTICLES`. If it has one from another application, the import stops with
*"Supporting Objects Install Error"*, and **Install Summary** names the table. On apex.oracle.com,
request a new workspace for the book.

## Atlas Support (`f200.sql`)

It needs the lab of Chapter 2: an Oracle AI Database 26ai container (`db26ai`) with APEX, and a
Gemini API key. You don't have to work through the book first. Run these from the folder of the
code repository:

1. **Copy the embedding model and the documents into the container.** Download
   `all_MiniLM_L12_v2_augmented.zip` from Oracle's *AI Vector Search User's Guide* (Chapter 5),
   unzip it, and run:

   ```bash
   docker exec db26ai mkdir -p /opt/oracle/atlas_files
   docker cp <unzipped folder>/all_MiniLM_L12_v2.onnx db26ai:/opt/oracle/atlas_files/
   docker cp setup/atlas/documents/. db26ai:/opt/oracle/atlas_files/
   ```

2. **Prepare the database, as SYS** (the password is for the user ATLAS):

   ```bash
   cd setup/app200
   sql sys@localhost:1521/FREEPDB1 as sysdba @dba.sql 'Your_Atlas_Password1'
   ```

3. **Install what the application needs, as ATLAS.** It asks once for your Gemini API key:

   ```bash
   sql atlas@localhost:1521/FREEPDB1 @install.sql
   ```

   It ends with a check: 400 tickets and 24 articles embedded, 9 documents, 400 tickets
   classified, 0 invalid objects.

4. **Import the application.** In a workspace whose schema is ATLAS, click **App Builder ›
   Import**, choose `apex/f200.sql`, and click **Next** and **Import Application**.
5. On the Credentials page, for **Credentials for gemini**, enter `x-goog-api-key` as the
   **Client ID or Username** and your Gemini API key as the **Client Secret** (twice). Click
   **Next**.
6. Click **Run Application** and sign in with your workspace user.

Both scripts skip what is already there, so you can run them again, also in a schema where you ran
the book's examples. More details are in the [main README](../README.md#installing-the-apex-applications).
