# Running PostgreSQL from Cursor (SQLTools)

This guide matches the **Connection Assistant** flow in Cursor and fixes the **“Couldn’t find any installed drivers”** message.

## Why that error appears

**SQLTools** (the main extension) does not ship database drivers. Drivers are **separate extensions**. Until at least one driver extension is installed and loaded, Step 1 of the Connection Assistant shows *Couldn’t find any installed drivers*.

## 1. Install the extensions (required)

1. Open Extensions: **Ctrl+Shift+X**.
2. Install **SQLTools** (publisher: *mtxr*).
3. Install a driver for your database:
   - For PostgreSQL (matches class SQL like `sql_example-1.sql`): **SQLTools PostgreSQL/Cockroach Driver** (same publisher family; search for `SQLTools PostgreSQL`).
4. **Reload the window**: **Ctrl+Shift+P** → `Developer: Reload Window`.

After reload, open the Connection Assistant again; drivers should appear.

## 2. Connection Assistant (3 steps)

1. **Step 1 — Select driver**  
   Choose **PostgreSQL** (or **Cockroach** if you use that; both use the PG driver).

2. **Step 2 — Connection details**  
   Typical local install:

   | Field        | Example              |
   |-------------|----------------------|
   | Name        | `Local Postgres`     |
   | Server      | `localhost`          |
   | Port        | `5432`               |
   | Database    | `postgres` (or your DB) |
   | Username    | `postgres` (or your role) |
   | Password    | (your role password) |
   | SSL         | Off for local        |

3. **Step 3 — Save / test**  
   Save the connection, then use **Test connection** if offered.

## 3. Connect and run your `.sql` file

1. Open the **SQLTools** sidebar and **Connect** to your saved connection.
2. Open your file (e.g. `sql_example-1.sql`).
3. **Ctrl+Shift+P** → **SQLTools: Run Current File**  
   Or select statements → **SQLTools: Run Selected Query**.

## 4. If drivers still do not show

- Confirm the **PostgreSQL driver** extension is **Enabled** for this workspace (not Disabled).
- Reload the window again after enabling.
- Fully quit Cursor and reopen the project.
- If you use **Remote / SSH / WSL**, install **SQLTools + the driver** in the **same scope** as the workspace (e.g. on the remote host or in WSL), not only on local UI.

## 5. If connection fails (but drivers work)

- Ensure the PostgreSQL service is running (Windows: Services → *postgresql*).
- Check host, port, database name, user, and password (same as `psql`).
- University servers: use the host and SSL settings your course specifies.

## 6. PSU `dbclass.cs.pdx.edu` (SQLTools `AggregateError` / code `-32001`)

Class Postgres lives at **`dbclass.cs.pdx.edu`**, port **`5432`**. Your **database name** and **username** are usually the same string; **password** is the one from Canvas (not always the same as MCECS). See [CAT: Database class PostgreSQL](https://cat.pdx.edu/services/web/databases/connect-to-postgresql-database-class/).

**Why connections fail from home:** the DB host is not meant to be reached “straight from the internet” the way a public website is. The CAT notes you often need the **PSU network** (campus or [VPN](https://cat.pdx.edu/services/network/vpn-services/)) for a **direct** client.

**Important for CS 486:** the course handout **`DBMS Conection.docx.pdf`** has you use an **SSH tunnel** through **`ada.cs.pdx.edu`** or **`babbage.cs.pdx.edu`** in DBeaver. If SQLTools is pointed at `dbclass` **without** that tunnel (and without some other path onto the right network), you will often see **`AggregateError` / `-32001`**. Fix by following **§7** below (same logical path as DBeaver).

## 7. CS 486 handout: DBeaver steps → Cursor (SQLTools)

Your PDF walks through **DBeaver → New Database Connection → PostgreSQL**, then two layers of credentials. Here is the same story in Cursor.

| DBeaver step (handout) | What it means | In SQLTools (Cursor) |
|------------------------|----------------|----------------------|
| New connection → **PostgreSQL** | Driver is PostgreSQL | **SQLTools** + **SQLTools PostgreSQL/Cockroach Driver**; new connection → PostgreSQL |
| Main screen: host, database, username, password | **Postgres** endpoint and **class DB** login (Canvas) | **Server** = `dbclass.cs.pdx.edu`, **Port** = `5432`, **Database** = your DB user, **Username** = same, **Password** = DB password from Canvas |
| “Test connection” fails until tunneling | Traffic must go through MCECS SSH first | Enable **SSH tunnel** on the connection (see below). Without it, “test” often fails |
| SSH tunnel: Host **`ada.cs.pdx.edu`** or **`babbage.cs.pdx.edu`**, **MCECS** user + password | Jump host; **Odin/MCECS** account | In connection settings, open **SSH Tunnel** (wording varies slightly by version): **Enable**, **Host** = `ada.cs.pdx.edu` *or* `babbage.cs.pdx.edu`, **Port** = `22`, **Username** / **Password** = MCECS. **Test tunnel** if the UI offers it |
| Final **Test connection** | Postgres reachable through the tunnel | **Test connection** on the main Postgres tab again |

**Order of operations:** configure **both** the SSH jump box (ada/babbage + MCECS) **and** the Postgres target (dbclass + Canvas DB user), then test.

### `The "path" argument … Received undefined` when testing (SSH enabled)

The **SQLTools PostgreSQL driver** (e.g. v0.5.6) builds the SSH tunnel by always reading **`privateKeyPath` with `fs.readFileSync`**, even when you only want **password** auth. If **Private Key File Path** is empty, Node throws this **path** error—**filling the SSH password is not enough**.

**Reliable fix:** turn **Over SSH** to **Disabled** and use a **manual `ssh -L` tunnel** (next section). That avoids the broken code path entirely.

**Possible workaround (not guaranteed):** set **Private Key File Path** to a **real file** that contains a valid OpenSSH private key (any key on disk, e.g. `C:\Users\You\.ssh\id_ed25519` if you have one). The server may ignore that key and still authenticate with your **MCECS password**; behavior depends on the SSH stack. If it still fails, use the manual tunnel.

### If SQLTools does not expose SSH tunnel (or it misbehaves)

Do the tunnel yourself, then aim SQLTools at **localhost**:

1. In PowerShell (leave the window open):

   ```powershell
   ssh -N -L 15432:dbclass.cs.pdx.edu:5432 YOUR_MCECS_USER@ada.cs.pdx.edu
   ```

   Use `babbage.cs.pdx.edu` instead of `ada` if you prefer. `15432` is an arbitrary local port.

2. In SQLTools, set **Server** = `127.0.0.1`, **Port** = `15432`, **Database** / **Username** / **Password** = same Canvas DB values as before. **No** SSH section needed in SQLTools—the `ssh` command already forwards the port.

3. When done, **Ctrl+C** in the PowerShell window stops the tunnel.

### `psql` path from the handout (page 7)

The PDF’s **`psql`** flow is: SSH to **`linux.cs.pdx.edu`**, then run `psql -h dbclass.cs.pdx.edu -U your_user_name your_user_name` and use the **DB** password. That is a different topology (shell on `linux` first); the **DBeaver** path uses **ada/babbage** as the tunnel host instead. Follow whichever the course staff say to standardize on.

### Still stuck

- Confirm you can **SSH** to ada or babbage from your network (from home you may need **VPN** first).
- Re-read Canvas values for **DB user / password** vs **MCECS** password—they are different on purpose.
- Optional check once the tunnel is up: `Test-NetConnection 127.0.0.1 -Port 15432` (if you used the manual `-L` recipe).
