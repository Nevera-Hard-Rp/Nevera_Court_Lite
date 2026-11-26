# Nevera Court Lite — Staff & Player Guide (English)

**File purpose:** explain **how to use** the in-game panel (not how to install the resource).  
Installation = `Install/README.md` · `Install/README_HR.md` · root `README.md`.

UI language follows `Config.Locale` (`en` / `hr` / `de` / `fr`). **Sidebar labels below use English** (same order as the panel).

---

## 1. Big picture — who does what

```text
CITIZEN / DEFENDANT
  • Limited forms, pay bail (where allowed)

POLICE
  • Affidavit, pre-filing, warrant REQUESTS → then wait for judge

PROSECUTOR (DA)
  • Open / drive cases, complaints, warrants, hearings, motions

DEFENSE / PUBLIC DEFENDER
  • Appear on case, defense forms, motions, hearings

CLERK
  • Filing / hearing support (role-dependent)

JUDGE
  • Approve warrants, bail, schedule hearings, plea, fines, verdicts, contempt

SUPREME COURT
  • Everything judge has + Admin (roles) + audit

SYSTEM (automatic)
  • Prints → document_a4 + optional Discord screenshots
```

**There is no automatic phone “summons script” for every event.**  
Staff schedule **Hearings**; Discord tags / RP cover the rest.

---

## 2. Typical criminal timeline (order of work)

Use this as the default RP + system order. Skip steps your city does not use.

```text
1. POLICE     Affidavit / arrest facts          → Forms
2. POLICE/DA  Criminal Pre-Filing / Complaint   → Forms
3. DA/JUDGE   Case opened (docket number)       → Cases
4. POLICE/DA  Warrant request (optional)        → Warrants / Forms
5. JUDGE      Approve / deny warrant            → Warrants
6. POLICE     Execute warrant (RP + MDT if used)
7. JUDGE      Bail / bond                       → Bail / Bond  (+ optional Hearing)
8. ANY STAFF  Schedule courtroom time           → Hearings
9. JUDGE      Arraignment / plea (+ public defender) → Cases → case tools
10. JUDGE     Trial / verdict                   → Cases + Forms
11. CUSTODY   Commitment order if prison        → /doj_commitment
12. ANYONE    Print papers → inventory
```

### Common confusion

| Screen | What it is | What it is NOT |
|--------|------------|----------------|
| **Hearings** | Calendar: when/where people meet in court | Not the verdict itself |
| **Bail Hearing** (hearing type) | One scheduled event about bail | Does not set bail by itself — use **Bail / Bond** |

---

## 3. How to open the panel

| Method | Notes |
|--------|--------|
| Keybind | Default **F5** (`Config.UI.openKey`) |
| Courthouse target | `ox_target` zones in `Config.Courthouse` |
| Close | **Esc** or same key again |

**Court laptop:** F5 opens a desktop. Each module below is a **folder** — double-click / click to open it in its own window. Back button + **Esc** go one step back; minimize to the taskbar. The taskbar has **Help** (one card per command, only what your role allows), **Gavel** (judges), your role and the clock. Size and **Letters** sliders (80–125 %) are remembered per player.

Your **role** (shown on the taskbar, e.g. Supreme Court) comes from `doj_roles` in the database — not from the framework job alone. Supreme Court / ACE admins assign roles in **Admin → Role Management**.

---

## 4. Laptop folders (what each module does)

### 4.1 Dashboard

- Snapshot of open work (counts / shortcuts depending on build).
- Start here to see if anything needs attention; real work is in the other tabs.

---

### 4.2 Cases

**Purpose:** the **docket** — one row = one legal matter with a number (`CR-…` criminal, civil numbers as configured).

**Who:** prosecutor, judge, defense (view/manage by permission), Supreme Court.

**How to create (typical):**

1. Open **Cases** → **+ New Case**
2. Choose Criminal or Civil
3. Enter defendant CitizenID / identifier + full name
4. Optional: MDT incident, charges, facts
5. Create → note the **case number** (needed for warrants, hearings, plea)

**Later:** open the case to update status, link forms, follow the proceeding.

---

### 4.3 Forms

**Purpose:** fill legal templates, save/print to inventory (`document_a4`).

**Who:** each role only sees forms allowed for that role (see role matrix below).

**How to use:**

1. Pick a form type
2. Fill fields. Best: open the **case** first and use **+ New Form** there — the form is saved with the case number automatically
3. Save / Print → accept legal warning → choose copies
4. Item appears in inventory → **Use** opens the filled document in Court's own viewer (`nevera_printeri` optional)
5. Optional Discord channel screenshot if webhooks/imgbb are configured

**Tip:** printing does **not** replace opening a Case or scheduling a Hearing — it produces the paper trail.

**Forms page:** enter a case number to list its forms. Status filter: draft, filed, approved, denied, signed, archived, withdrawn.
When a case is **Dismissed** or **Closed**, all its forms become **archived** automatically.

---

### 4.4 Warrants

**Purpose:** arrest / search warrant **requests** and **judicial decisions**.

**Flow:**

```text
Police/DA request  →  Judge reviews  →  Approved or Denied  →  Police execute (RP)
```

Often tied to a case number. Paper forms also exist under **Forms** (Request Arrest Warrant, Arrest Warrant, etc.).

---

### 4.5 Bail / Bond

**Purpose:** set bail, record payment / forfeiture / conditions for a defendant.

**Who:** mainly judge (and staff with bail permissions).

**Related:**

- Hearing type **Bail Hearing** under **Hearings** = courtroom appointment about bail
- Forms: Bail Agreement, Bond Order
- Paying / desk interaction may also use courthouse **bail zone** (`Config.Courthouse.bailZone`)

---

### 4.6 Hearings

**Purpose:** **schedule** court sessions (calendar).

**How to schedule:**

1. **Hearings** → **+ Schedule hearing**
2. Case number, type (e.g. Bail Hearing, Probable Cause, Trial…), courtroom, date/time
3. Optional Discord link for voice
4. Status: Scheduled → (later) completed / cancelled via edit as your RP requires

**Who is “called”:**

- The system stores the appointment for staff to see
- **Players are not auto-teleported**; notify them via RP, Discord, phone script, or in-game announce
- Use this tab so everyone shares the same time/place on the docket

---

### 4.8 Fines

**Purpose:** court fines / money judgments tracked by the script (amounts from config / laws).

**Who:** judge / authorized staff.

Use after verdict or as ordered; pair with printed fine-related forms if your city requires paper.

---

### 4.9 Law Code (Penal Code / NKZ)

**Purpose:** browse statutes used on charges and forms (seeded in SQL).

**Who:** most staff roles (read). Supreme Court / ACE admins edit laws in-game: Law Code → **Edit** (or `/courtlaws`).

Set display language with `Config.Locale` (titles in 5 languages come from `Install/sql/nevera_court_laws.sql`).

---

### 4.10 Admin

**Purpose:** Supreme Court tools.

| Sub-tab | Use |
|---------|-----|
| **Role management** | Assign / change DOJ roles (`judge`, `police`, …) |
| **Audit log** | Who did what (`CASE OPENED`, warrants…) |

First Supreme Court user: **Admin → Role Management → Add player** (needs ACE `nevera.sudstvo.admin`) or `Install/sql/first_supreme_court.sql` (correct framework identifier).

---

## 5. Outside the sidebar (still part of the system)

### Printed documents

- Inventory item **`document_a4`** → **Use**
- Needs `consume = 0` and export matching folder name (`Nevera_Court_Lite.viewDocument`)
- Opens in the Court viewer (`nevera_printeri` optional)

### Commitment / prison

- After Guilty + custody: `/doj_commitment` (police / DOC / judges per config)
- Not a sidebar tab — separate command / menu

---

## 6. Commands & keybinds

| Command / key | Who | What |
|---------------|-----|------|
| **F5** (default) | Everyone with access | Open / close the court laptop |
| `/doj_help` | Everyone | Short command list |
| `/doj_commitment` | Custody / DOC / judges | Commitment orders after prison sentence |
| `/refreshlaws` | Console / admin | Reload penal code from database |
| `/court` | Everyone with access | Open the court laptop. Plea, public defender, bench warrant, contempt: a case → **case tools** |
| `/courtlaws` | Supreme Court / ACE | In-game penal code editor |
| `/gavel` | Judge | Strike the gavel |

Keybind for commitment can be set via FiveM keybind settings (`doj_commitment`).

---

## 6b. For the server owner (setup in `config.lua`)

- `Config.JobRoleMap` — your framework job → court role. Example: judge job `sudac` → `Config.JobRoleMap.sudac = 'judge'`.
- Police jobs: built-in list plus `Config.Prison.executeJobs`; or map directly, e.g. `Config.JobRoleMap.mypolice = 'police'`.
- `Config.Permissions.policeProsecutorGrade = 4` — police of that grade also act as prosecutor (`false` = off).
- `Config.AdminPermissions = { 'qbcore.god', 'admin', 'superadmin' }` — who counts as Supreme Court.
- Database from an earlier build: run `Install/sql/upgrade/forms_status.sql` once.

---

## 7. Role → panel access (summary)

| Role | Cases | Forms | Warrants | Bail | Hearings | Fines | Law | Admin |
|------|:-----:|:-----:|:--------:|:----:|:--------:|:-----:|:---:|:-----:|
| Supreme Court | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| Judge | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | — |
| Prosecutor | ✓ | ✓ | ✓ | ~ | ✓ | ~ | ✓ | — |
| Defense / PD | ✓ | ✓ | — | ~ | ✓ | — | ✓ | — |
| Police | ~ | ✓ | request | — | ~ | — | ✓ | — |
| Citizen | ~ | limited | — | ~ | — | — | ~ | — |

`~` = limited / view / situational. Exact form list = `Enums.FormsByRole` in `shared/enums.lua`.

---

## 8. Quick FAQ (reduces tickets)

**“Panel shows Citizen but I ran SQL.”**  
`doj_roles.citizenid` must equal the live framework id (ESX: full `users.identifier`). Relog.

**“Use on document does nothing / deletes item.”**  
`consume = 0` and correct export casing (`Nevera_Court_Lite.viewDocument`).

---

## 9. One-page cheat sheet

```text
OPEN PANEL     F5 / courthouse target
NEW CASE       Cases → + New Case → keep the number
PAPERWORK      Forms → fill → Print → document_a4
WARRANT        request → judge approve → police execute
BAIL           Bail tab + optional Bail Hearing
COURT TIME     Hearings → + Schedule (tell players in RP)
PLEA / PD      Cases → case tools → plea / public defender
NO-SHOW        Cases → case tools → bench warrant
PRISON         /doj_commitment
ROLES/AUDIT    Admin (Supreme Court)
```

---

*End of guide. For install / SQL / items see `Install/README.md`. For config deep-dive see root `README.md`.*
