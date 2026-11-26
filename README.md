<div align="center">

<img src="https://nevera-rp.com/tebex/assets/nevera-court-github-banner.png" alt="Nevera Court — FiveM DOJ / Court System" width="100%">

# Nevera Court Lite

### Department of Justice — Core Court Roleplay for FiveM (Lite edition)

[![FiveM](https://img.shields.io/badge/FiveM-cerulean-orange?style=for-the-badge)](https://fivem.net/)
[![Lua](https://img.shields.io/badge/Lua-5.4-blue?style=for-the-badge&logo=lua)](https://www.lua.org/)
[![ox_lib](https://img.shields.io/badge/ox__lib-required-2ECC71?style=for-the-badge)](https://overextended.dev/)
[![Version](https://img.shields.io/badge/version-1.0.0-informational?style=for-the-badge)](#changelog)
[![Locale](https://img.shields.io/badge/locale-EN%20%7C%20HR%20%7C%20DE%20%7C%20FR%20%7C%20ES-purple?style=for-the-badge)](#localization)
[![License](https://img.shields.io/badge/license-Proprietary-red?style=for-the-badge)](#license--support)

**Cases · Forms · Warrants · Bail · Hearings · Fines · Penal Code · Gavel · MDT · Discord**

[Overview](#overview) ·
[Features](#features) ·
[Requirements](#requirements) ·
[Installation](#installation) ·
[Configuration](#configuration) ·
[Localization](#localization) ·
[Discord & webhooks](#discord--webhooks) ·
[Roles](#roles--permissions) ·
[In-game usage](#in-game-usage) ·
[Legal forms](#legal-forms) ·
[Exports](#exports--integration) ·
[Troubleshooting](#troubleshooting) ·
[Support](#support--community) ·
[Changelog](#changelog)

</div>

---

## Changelog

### 1.0.0 — Initial release (Lite)

**Core court** — everything you need to run real court RP:
- DOJ court laptop (F5): cases, 37 A4 forms × 5 languages, warrants, bail, hearings, fines, penal code
- Hard-RP verdict flow: guilty verdict → commitment order → custody / DOC executes at prison intake
- Official court seal, Discord logs + court transcripts (optional, `Config.Forms.requireTranscript`)
- Framework bridges: ESX / QBCore / Qbox / standalone + multi inventory / phone / MDT / prison
- `ox_target` or `qb-target`; gavel with real sound heard by everyone near the judge (`/gavel`)
- One money symbol everywhere (`Config.Currency`) and your own server name (`Config.Branding`) in UI, seal, logs and all A4 forms
- **In-game penal code editor** (`/courtlaws` or Law Code → Edit) + fine calculator table in `config_fines.lua`

**Court procedure**
- **Arraignment / plea** — guilty · not guilty · no contest; **public defender** auto-assigned from registered public defenders
- **Bench warrant on failure to appear** — one click: active arrest warrant (`BW-YYYY-####`), bail forfeited, police notified + MDT sync
- **Contempt of court** — judge picks a nearby player: on-the-spot fine and/or prison minutes

**Court laptop (new UI)**
- F5 opens a **court laptop**: a desktop with folders for every Lite module (Cases, Forms, Requests, Warrants, Bail / Bond, Hearings, Fines, Law Code) and the Admin tool
- Own dark dropdowns, date fields in `dd.mm.yyyy HH:mm` (per language), no game keys while typing (chat `T` etc. stay closed)
- Every module opens in its own **window** — back button + **ESC** (closes a dialog → goes back → closes the laptop), minimize to the taskbar, size slider + **Letters** slider (80–125 % text size, remembered per player)
- **Taskbar:** open windows, **Help**, **Gavel** (judges), your court role and the clock · **Today in court** card on the desktop
- **Help** window: one card per command — click it to open the right window; you only see what your role allows
- **Admin → Role Management:** add players (online search or CitizenID), remove roles, ACE admins shown with an **ACE** tag — ESX / QB / Qbox / standalone
- **Audit log with Rockstar license** of whoever did the action
- **Penal code editor inside the laptop** (Law Code → Edit) — prices, prison time, texts in 5 languages, **activate / deactivate** articles
- Server time zone for every date (`Config.TimeZoneOffset`)

**Forms & cases**
- **Forms linked to a case** — "+ New Form" inside a case saves the case number (`CR-…` / `CV-…`); the server checks the case exists and that the player has access to it
- **Automatic archiving** — when a case is *Dismissed* or *Closed*, all its forms become `archived`
- **Forms page** — enter a case number to list its forms; status filter matches the database (draft, filed, approved, denied, signed, archived, withdrawn)
- Bail payments / refunds and civil damages go through the framework bridge (QB / Qbox / ESX / standalone); money that can't be paid right now becomes a **pending fine**

**Job names from `config.lua` only**
- `Config.JobRoleMap` — your framework job → court role (e.g. `Config.JobRoleMap.sudac = 'judge'`), no protected code to touch
- `Config.Permissions.policeProsecutorGrade` (police of that grade also act as prosecutor, `false` = off) · `Config.AdminPermissions` (who counts as Supreme Court)

**Customization**
- Every Lite module can be switched off in `Config.Modules`
- Escrow-open: `config.lua`, `config_fines.lua`, `locales/`, `bridge/`, `web/dist`, `Install/` and **`editable/`** hooks for your own scripts
- Performance: server role cache and batched cron queries; client idle ≈ 0.00 ms

### Lite vs Full

| | Lite | Full |
|---|:---:|:---:|
| Court laptop UI · Role Management · audit log with license | ✅ | ✅ |
| Cases · forms · warrants · bail · hearings · fines · penal code · verdict / commitment | ✅ | ✅ |
| Gavel · penal code editor · arraignment / public defender · bench warrants · contempt | ✅ | ✅ |
| Jury pool & selection | — | ✅ |
| Judicial Police (court security, prisoner transport, command alarm, GPS, metal detectors) | — | ✅ |
| House arrest + ankle monitor (live map) | — | ✅ |
| Database editor (laptop → Tools → Database) | — | ✅ |
| Document archive stashes · courtroom wall screen | — | ✅ |
| Bar exam & licences · attorney appointments · DOJ treasury | — | ✅ |
| Appeals · expungement · plea deals · evidence per case | — | ✅ |
| Courtroom session & minutes · public court board | — | ✅ |
| Probation & community service · restraining orders · pre-trial detention limits | — | ✅ |

**Upgrading to Full later keeps your database.** Lite already uses the same `nevera_court.sql` schema — swap the resource, no extra SQL.

Docs: [Nevera Docs — Court](https://nevera-hard-rp.com/Nevera-Docs/#/docs/sudstvo/overview) · Support: [discord.gg/MUw2uR5MZ6](https://discord.gg/MUw2uR5MZ6)

---

## Overview

**Nevera Court Lite** is the core **Department of Justice (DOJ)** system for serious legal roleplay on FiveM. Police, prosecutors, defense counsel, judges, clerks, and citizens run criminal and civil procedure end-to-end inside one resource:

- Open and manage cases with auto docket numbers  
- Fill, sign, print, and archive official A4 court forms  
- Request and execute arrest / search warrants  
- Set bail and schedule hearings  
- Enter verdicts and issue **commitment orders** (hard RP prison handoff)  
- Calculate fines, browse the penal code (NKZ), and log actions to Discord  

Designed for **Tebex / Cfx.re Asset Escrow**: buyers edit configs, locales, bridges, SQL, hooks and the built NUI while core gameplay logic can be encrypted.

| | |
|---|---|
| **Version** | `1.0.0` (`fxmanifest.lua`) |
| **Frameworks** | **ESX** · QBCore · Qbox · Standalone (`Config.Framework = 'auto'`) |
| **Inventory** | ox · qs · qb · ps · codem · tgiann · origen · ak47 (`auto`) |
| **Phone** | LB · Quasar · YSeries · 17mov · GKS · NPWD · qb-phone (`auto`) |
| **MDT** | Bridge for tk_mdt (full) · Advanced (manual) · ps-mdt (patch) — see `Install/MDT.md` |
| **UI** | React NUI + ox_lib menus / alerts / targets |
| **Languages** | `en` · `hr` · `de` · `fr` · `es` — **full UI + A4 forms + NKZ titles** (`Config.Locale`) |

> **Install pack:** `Install/README.md`

---

## Features

### Case management
- Criminal & civil cases with a full status pipeline:  
  `open` → `investigation` → `pending_indictment` → `probable_cause` → `pre_hearing` → `pre_trial` → `trial` → `awaiting_verdict` → `closed` / `dismissed`
- Auto docket numbers (e.g. `CR-2026-00001`, `CV-2026-00042`)
- Parties, charges linked to the penal code, timeline & audit trail
- Verdicts: Guilty / Not Guilty / Mistrial

### Legal forms (37 A4 HTML templates × 5 languages)
- Fillable US-style court forms in-game (affidavits, complaints, warrants, motions, orders, subpoenas, civil filings, …)
- **Full HTML per language:** `web/dist/forms_{en,hr,de,fr,es}/`
- Role-based form access
- Legal misuse warning before print
- Print → `document_a4` inventory item (+ **Discord court transcripts** via imgbb webhook)
- Judge approve / deny / sign workflow
- Optional chrome i18n: `web/dist/i18n/forms_{en,hr,de,fr,es}.json` (`data-i18n`)

### Warrants
- Arrest (AW) & search (SW): request → judge approve / deny → police execute
- Auto-expiry timers and login warrant alerts

### Bail / bond
- Cash / surety / property · HUT (hold until trial)
- Fail-to-appear rules & bail bans
- Courthouse bail desk (`ox_target`) · forfeiture & refund

### Hearings
- Bail, probable cause, pre-trial, bench trial, sentencing, civil
- Hearing reminders · Discord event webhooks

### Court procedure
- Arraignment / plea entry + public defender assignment (case tools menu)
- Failure to appear → bench warrant + bail forfeiture
- Contempt of court (fine and/or prison minutes on the spot)

### Fines & economy
- **Penal code editor in-game** (`/courtlaws` or Law Code → *Edit*) — change fines, prison time, severity and texts (5 languages), add / deactivate articles; saved to the database and active immediately
- **Fine calculator** table (offences + modifiers) in **`config_fines.lua`**
- **`Config.Currency = '$'` or `'€'`** (or any symbol) — UI display only
- Rookie fine multiplier · civil damages range (`Config.Economy`)
- Pending fines on login · optional `peleg-billing` (pcall-safe)

### Penal code (NKZ)
- ~93 articles · 9 categories · LawPicker on criminal forms
- Localized display titles (`title_hr` / `title_de` / `title_fr` / `title_es`) — all seeded by `nevera_court_laws.sql`
- Server exports for MDT / third-party scripts

### Prison / commitment (hard RP)
- When `Config.Prison.commitmentOrder = true`, a guilty verdict does **not** auto-jail
- Custody / DOC executes the commitment order near the inmate → prison provider handoff
- Bridges: `qb-prison` · `rcore_prison` · `pickle_prisons` · `custom` · `none`

### Admin & audit
- **Role Management** (laptop → Admin): add players (online search or CitizenID), remove roles, ACE admins tagged **ACE**
- Audit log for key DOJ actions — with the **Rockstar license** of whoever did it
- Discord: system event logs + **printed form transcripts** (image archive per channel)

### Framework & MDT bridges (new)
- **ESX** + QBCore + Qbox + Standalone (`Config.Framework = 'auto'`)
- MDT push: warrants / cases / verdicts / commitments → `Install/MDT.md`
- Honest sync levels: tk_mdt full · Advanced manual · ps-mdt patch
- `Config.MDT.trustedInvokers` gates every cross-resource write export — `IssueFine`, `CreateFormProgrammatically`, `CreateCommitmentOrder`, `CanExecuteCommitment`, `GetBakedFormHtml` — to your own resource plus this allowlist

### Localization
- One switch: `Config.Locale = 'en' | 'hr' | 'de' | 'fr' | 'es'`
- Covers ox_lib UI, React panel, **full A4 form HTML**, print warning, and NKZ titles  
- Does **not** rename exports / API (always English)

---

## Requirements

| Resource | Required |
|----------|----------|
| [oxmysql](https://github.com/overextended/oxmysql) | **Yes** |
| [ox_lib](https://github.com/overextended/ox_lib) | **Yes** |
| Framework (**ESX** / QB / Qbox) or `standalone` | **Yes** |
| [ox_inventory](https://github.com/overextended/ox_inventory) **or** [qb-inventory](https://github.com/qbcore-framework/qb-inventory) | **Yes** for print `document_a4` (`Config.Inventory.provider = 'auto'`; force `'qb-inventory'` on mixed servers) |
| [ox_target](https://github.com/overextended/ox_target) **or** [qb-target](https://github.com/qbcore-framework/qb-target) | Recommended (courthouse eye). F5 panel works without either. `Config.Target.provider = 'auto'` |
| [nevera_printeri](https://nevera-hard-rp.com/Nevera-Docs/#/docs/sudstvo-lite/printeri) | **Optional, sold separately** — physical printers. Court already views filled forms on Use. |
| MDT (ps-mdt / tk_mdt / Advanced) | Optional — `Install/MDT.md` |
| Phone / prison | Optional |
| [peleg-billing](https://github.com/Pelegrino/peleg-billing) | Optional — invoices use `Config.Billing.issuerJob`; filing prices are `Config.Fees` |

> **Optional:** `nevera_menuguard` (soft lock).  
> **OneSync** recommended. Full guide: [`Install/README.md`](Install/README.md)

---

## Installation

Use the buyer pack under **`Install/`** (SQL, items, Discord convars, guides).

### 1. Place the resources

```text
resources/[nevera]/Nevera_Court_Lite/     ← this resource
resources/[nevera]/nevera_printeri/       ← optional, sold separately
```

Use the **exact folder name** in `ensure`. Printer / NUI paths resolve with `GetCurrentResourceName()`.

### 2. Database

Same schema for every framework. **Fresh install** — run two files:

```text
Install/sql/nevera_court.sql        # all tables — safe to run again, never deletes rows
Install/sql/nevera_court_laws.sql   # penal code (93 articles, 5 languages) — run ONCE
```

Then give yourself Supreme Court (see [Roles](#roles--permissions)) — or edit and run `Install/sql/first_supreme_court.sql`.

**Updating an older Lite?** Run `nevera_court.sql` again. New columns (audit license) are added when the resource starts. `Install/sql/upgrade/` is only for very old databases — see its README.

#### Upgrade — database from an earlier build

If your database was created **before** this build, run once:

```text
Install/sql/upgrade/forms_status.sql   # adds form statuses 'archived' and 'withdrawn'
```

Without it, case-linked forms can't be archived when a case is closed. A fresh install does **not** need it.

⚠ Running `nevera_court_laws.sql` again resets the penal code to defaults (in-game Law Code edits are lost).

**Verify:**

```sql
SELECT COUNT(*) AS categories FROM doj_law_categories;  -- expect 9
SELECT COUNT(*) AS laws FROM doj_laws;                  -- expect ~93
SELECT COUNT(*) AS laws_hr FROM doj_laws WHERE title_hr IS NOT NULL;  -- ~93
SELECT * FROM doj_roles WHERE role = 'supreme_court';
```

**ESX `first_supreme_court.sql`:** use exact `users.identifier` (e.g. `char1:…`), not a short QB citizenid.

### 3. Inventory item (`document_a4`)

| Inventory | File |
|-----------|------|
| **ox_inventory** (QB / **Qbox** / ESX) | `Install/items/ox_inventory_document_a4.lua` → `ox_inventory/data/items.lua` |
| **Qbox (`qbx_core`)** | same ox block — `qbx_core` has **no** `shared/items.lua` — see `Install/items/qbx_core_document_a4.lua` |
| **qb-core** + qb/ps inventory | `Install/items/qbcore_document_a4.lua` → `qb-core/shared/items.lua` |
| **Legacy ESX** (`items` SQL table) | `Install/items/esx_document_a4.sql` |

**ESX + ox_inventory:** use the **ox** file only.  
**Do not** paste a second `document_a4` from a printer item file (overwrites Court).

Copy `Install/items/document_a4.png` → `ox_inventory/web/images/` **or** `qb-inventory/html/images/`.

**Critical (ox_inventory):**

```lua
consume = 0,                           -- otherwise Use DELETES the item
stack = false,
export = 'Nevera_Court_Lite.viewDocument',  -- MUST match folder name (case-sensitive)
```

F8 `No such export viewDocument in resource nevera_court` → wrong folder/export casing.  
Filled forms open in **Court NUI**. If you also own `nevera_printeri`, `ensure` it before Court to use the printer UI.

### 4. `server.cfg`

```cfg
ensure oxmysql
ensure ox_lib
ensure ox_target          # or qb-target — Config.Target.provider = 'auto'
ensure ox_inventory
ensure [your-framework]   # es_extended / qb-core / qbx_core

ensure nevera_printeri    # optional — only if purchased separately
ensure Nevera_Court_Lite       # exact folder name
```

If you own `nevera_printeri`, also run its own SQL once — see its install guide.

Optional Discord convars — see [Discord & webhooks](#discord--webhooks) and `Install/server_cfg_discord.cfg`.

### 5. First-boot checklist

- [ ] NKZ: 9 categories, ~93 laws
- [ ] `Config.Locale` + `Config.Framework = 'auto'` (or `'esx'` / `'qb'` / `'qbox'`)
- [ ] Supreme Court in `doj_roles` (ESX: id = `users.identifier`)
- [ ] `document_a4` with `consume = 0` + correct `export`
- [ ] `nevera_printeri` only if you bought it (optional)
- [ ] Print → inventory → **Use** → filled document (Court viewer)
- [ ] Courthouse coords / webhooks (optional)
- [ ] Job names: `Config.JobRoleMap` matches **your** framework jobs (see [Roles](#roles--permissions))

### 6. Before going live

- [ ] `Config.AdminPermissions` lists only groups you trust (they count as Supreme Court)
- [ ] Discord webhooks in `server.cfg` convars, not in a `config.lua` you share
- [ ] Existing database: `Install/sql/upgrade/forms_status.sql` run once
---

## Configuration

Primary editable file: [`config.lua`](config.lua) (escrow-open). Fine table: [`config_fines.lua`](config_fines.lua).

### Essentials

```lua
Config.Debug     = false
Config.Locale    = 'en'       -- 'en' | 'hr' | 'de' | 'fr' | 'es'
Config.Currency  = '€'        -- money symbol everywhere: '€', '$', '£', …
Config.Branding  = { ServerName = 'Los Santos', PenalCode = 'PC' }  -- your server name in UI / seal / forms
Config.TimeZoneOffset = 0     -- hours added to server time for every date in the UI
Config.Modules   = { bail = nil, hearings = nil, gavel = nil, ... }  -- false = turn a Lite module off
Config.Framework = 'auto'     -- 'esx' | 'qb' | 'qbox' | 'standalone'
Config.Target    = { provider = 'auto' }  -- 'auto' | 'ox_target' | 'qb-target'
Config.MDT = {
    provider = 'auto',        -- tk_mdt → ps-mdt (advanced = manual + resourceName)
    trustedInvokers = { 'ps-mdt', 'tk_mdt' },  -- also gates IssueFine / CreateCommitmentOrder / etc. — see Exports & integration
}
-- MDT sync levels + ps-mdt patch: Install/MDT.md
Config.ESX = { RequireDuty = false, AdminGroups = { 'admin', 'superadmin' } }
Config.Inventory = { provider = 'auto' }
Config.Phone     = { provider = 'auto' }
```

### Currency (`$` / `€`)

Buyers set the symbol themselves — it is **display only** (panel, notifies, forms chrome):

```lua
Config.Currency = '$'   -- US / dollar servers
Config.Currency = '€'   -- EU / euro servers
```

Changing the symbol does **not** convert amounts. Adjust the penal code (in-game editor), `config_fines.lua` and `Config.Economy` to your server economy.

### Fines — where the amounts live

| What | Where | How to change |
|------|-------|---------------|
| **Penal code** (fine & prison range per article — used for verdicts) | database `doj_laws` | **In-game:** `/courtlaws` or Law Code → *Edit* (Supreme Court or ACE `nevera.sudstvo.admin`). Prices, prison, severity, category, name & description in every language, new / deactivated articles. Active immediately. |
| **Fine calculator** (panel → Fines tab) | [`config_fines.lua`](config_fines.lua) | Edit `baseAmount` / `multi`, add your own offences with a `label`. Restart the resource. |
| Court fees, exam / expungement fees | `config.lua` → `Config.Fees`, `Config.Exams`, `Config.Expungement` | Edit the numbers. |

```lua
Config.FineCalculator = {
    maxTotal = 250000,
    categories = {
        { id = 'pljacka', baseAmount = 18000 },                          -- built-in (translated)
        { id = 'illegal_fishing', label = 'Illegal Fishing', baseAmount = 1500 },  -- your own
    },
    modifiers = {
        { id = 'povratnik', multi = 1.50 },
    },
}
```

Civil damages range and related economy knobs:

```lua
Config.Economy = {
    civilDamagesMin = 1000,
    civilDamagesMax = 500000,
    -- … see config.lua
}
```

Defaults are a reference economy. **Adjust for your city** before go-live.

### MDT sync levels (before you market “4 MDTs”)

| Provider | Level |
|----------|--------|
| `tk_mdt` | Full sync (exports) |
| `advanced` | Partial/Full — set `provider` + `resourceName` (no auto-guess) |
| `ps-mdt` | Events + optional patch (`Install/patches/ps-mdt_nevera_warrant.lua`) |

### Map locations (courthouse, desks) — **you must set these**

Nevera Court does **not** know your MLO. Every buyer places targets / zones on **their** map:

| Config | What it is | Who uses it |
|--------|------------|-------------|
| `Config.Courthouse.mainZone` | Main DOJ / court interaction | Open panel at the courthouse |
| `Config.Courthouse.terminalZone` | Clerk / filing terminal | Forms / filings desk |
| `Config.Courthouse.bailZone` | Bail desk | Pay / process bail |
| `Config.Prison.intakeZone` (if used) | Prison intake | Commitment / custody handoff |

Ship coords are **placeholders** (or generic downtown). Before go-live:

1. Stand in-game where the desk / courtroom should be  
2. Copy your `vector3(x, y, z)` (and heading if needed)  
3. Paste into the matching entry in [`config.lua`](config.lua)  
4. Restart / `ensure` the resource and test `ox_target` prompts  

There is **no** separate “lawyer office” resource forced by Nevera Court — attorneys use the same DOJ panel + roles. If you want a dedicated law-firm prop/MLO, put a Courthouse point there yourself.

```lua
Config.Courthouse = {
    mainZone = {
        coords = vector3(0.0, 0.0, 0.0),  -- ← your courtroom / lobby
        -- …
    },
    terminalZone = { coords = vector3(0.0, 0.0, 0.0) }, -- filing desk
    bailZone     = { coords = vector3(0.0, 0.0, 0.0) }, -- bail window
}

```

### Prison / commitment

```lua
Config.Prison = {
    provider = 'auto',
    commitmentOrder = true,   -- hard RP (recommended)
    executeJobs = { 'police', 'doc', 'correctional', --[[ … ]] },
    requireNearby = true,
}
```

### UI

```lua
Config.UI = {
    openKey = 'F5',
    closeKeys = { 'Escape', 'F5' },
}
```

### System Discord webhooks

```lua
Config.Webhooks = {
    cases = '', warrants = '', bail = '', fines = '',
    verdicts = '', admin = '', audit = '',
}
```

Form **screenshot** channels use `server.cfg` convars (below), not this table.

---

## Localization

| Code | Language | UI (`locales/`) | Full A4 HTML | Form chrome JSON | NKZ titles |
|------|----------|-----------------|--------------|------------------|------------|
| `en` | English (default) | `en.lua` | `forms_en/` | `forms_en.json` | `title` (base) |
| `hr` | Croatian | `hr.lua` | `forms_hr/` | `forms_hr.json` | `title_hr` (`03`) |
| `de` | German | `de.lua` | `forms_de/` | `forms_de.json` | `title_de` (`03`) |
| `fr` | French | `fr.lua` | `forms_fr/` | `forms_fr.json` | `title_fr` (`03`) |
| `es` | Spanish | `es.lua` | `forms_es/` | `forms_es.json` | `title_es` (`03`) |

### What `Config.Locale` controls

One switch drives **panel + ox_lib + full form HTML folder + NKZ display titles**. Public API / export names stay **English**.

| Area | Localized |
|------|-----------|
| ox_lib notifies, alerts, menus, targets | Yes |
| React panel (`OPEN_PANEL` strings) | Yes |
| Print legal warning | Yes |
| **Full HTML court forms** (`forms_<locale>/`) | Yes (37 templates each) |
| HTML `data-i18n` chrome (`forms_*.json`) | Yes |
| NKZ titles in DB (`title_*`) | Yes (SQL `03` — HR/DE/FR/ES) |
| Export / event names | No (always English) |

**Important:** FiveM NUI loads **`web/dist/`**. Edit the A4 forms directly in `web/dist/forms_*/` and restart. Missing `forms_hr` (etc.) falls back to `forms_en`.

**Add a language:** copy `locales/en.lua` → `locales/xx.lua`, register in `fxmanifest.lua`, add `forms_xx/` (37 HTML) + `forms_xx.json`, extend `FORM_LOCALES` / `forms_i18n.js` / `sv_printer.lua`, add SQL `title_xx` columns + seed, set `Config.Locale = 'xx'`.

---

## Discord & webhooks

Two separate Discord layers:

| Layer | Purpose |
|-------|---------|
| **1. System logs** | Case / warrant / bail / fine / verdict / admin / audit text events (`Config.Webhooks`) |
| **2. Court transcripts** | Every **printed** A4 form is screenshot → uploaded → posted to Discord as a lasting visual record |

### Court transcripts (printed forms → Discord)

When a player **Save / Print**s a court form (and accepts the legal warning), Nevera Court can:

1. Capture the filled A4 page as an image  
2. Upload it via **imgbb**  
3. Post an embed into the matching Discord channel  

That channel becomes your **transcript archive** — staff can scroll history and prove what was filed/printed (complaint, warrant, bail bond, verdict, etc.), even if the in-game item is lost.

**Organize like a real docket room:**

- Create **one webhook per channel** (recommended), e.g. `#court-criminal`, `#court-verdicts`, `#court-bail`, …  
- **Or** one shared `#court-transcripts` channel if you prefer a single feed  
- Keep channels staff-only / read-only for citizens if you want controlled access  

By default (`Config.Forms.requireTranscript = true`), the transcript is **mandatory**: if `nevera_court_imgbb_key` and the matching `nevera_court_wh_*` URL aren't configured (or the upload fails), the **print itself is rejected** — before any fee is charged or the form is saved — so there's always a Discord original to catch later tampering. Set `Config.Forms.requireTranscript = false` to go back to optional screenshots, or list form types in `Config.Forms.transcriptExempt` to exempt only those.

> **New to Discord webhooks?** Official guide: [Intro to Webhooks (Discord Support)](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks)

### How to create a webhook (quick steps)

1. Open your Discord server → **Server Settings** → **Integrations** → **Webhooks** → **New Webhook**.
2. Name it (e.g. `Nevera Court — Criminal transcripts`), pick the target **text channel**.
3. Click **Copy Webhook URL** — `https://discord.com/api/webhooks/ID/TOKEN`.
4. Paste into the matching `set nevera_court_wh_…` line in `server.cfg` (or into `Config.Webhooks` for system logs).
5. Repeat per channel so transcripts stay organized.

**Tips**

- You need **Manage Webhooks** permission.
- Treat the URL like a password.
- After editing `server.cfg`, restart the server (or `ensure Nevera_Court_Lite`).

**Imgbb API key (required for transcripts)**

1. Free account at [imgbb.com](https://imgbb.com/) → API → copy key.  
2. `set nevera_court_imgbb_key "YOUR_KEY"` in `server.cfg`.

### 1) System event webhooks — `config.lua`

Used for case / warrant / bail / fine / verdict / admin / audit **text** logs (`Config.Webhooks`). These are activity logs, not full form images.

### 2) Form transcript channels — `server.cfg` convars

Printed forms → imgbb → Discord embed (visual **transcript**). Reference: [`Install/server_cfg_discord.cfg`](Install/server_cfg_discord.cfg).

```cfg
set nevera_court_imgbb_key "YOUR_IMGBB_API_KEY"

set nevera_court_wh_criminal "https://discord.com/api/webhooks/..."
set nevera_court_wh_verdict  "https://discord.com/api/webhooks/..."
set nevera_court_wh_fines    "https://discord.com/api/webhooks/..."
set nevera_court_wh_bail     "https://discord.com/api/webhooks/..."
set nevera_court_wh_citizen  "https://discord.com/api/webhooks/..."
set nevera_court_wh_admin    "https://discord.com/api/webhooks/..."
set nevera_court_wh_audit    "https://discord.com/api/webhooks/..."
```

| Convar | Transcript channel for |
|--------|-------------------------|
| `nevera_court_imgbb_key` | Imgbb upload (required) |
| `nevera_court_wh_criminal` | Criminal filings / complaints / warrants |
| `nevera_court_wh_verdict` | Verdicts / judgments |
| `nevera_court_wh_fines` | Fine-related prints |
| `nevera_court_wh_bail` | Bail / bond prints |
| `nevera_court_wh_citizen` | Citizen / civil prints |
| `nevera_court_wh_admin` | Admin / Supreme Court prints |
| `nevera_court_wh_audit` | General / catch-all document shots |


---

## Roles & permissions

| Role | Key | Typical access |
|------|-----|----------------|
| Supreme Court | `supreme_court` | Full admin + all panels + role management |
| Judge | `judge` | Cases, warrants, bail, hearings, fines, contempt |
| Prosecutor / DA | `prosecutor` | Cases, forms, warrants, hearings |
| Defense attorney | `defense_attorney` | Cases, defense forms, hearings |
| Public defender | `public_defender` | Same as defense |
| Police | `police` | Affidavit, warrant requests, pre-filing |
| Clerk | `clerk` | Forms / hearings support |
| Citizen | `citizen` | Limited forms (default) |

Assignable DB roles (new install): `supreme_court`, `judge`, `prosecutor`, `defense_attorney`, `public_defender`, `police`.

**First admin:** give yourself ACE `nevera.sudstvo.admin`, open **Admin → Role Management → Add player** and assign `supreme_court`. Or edit and run `Install/sql/first_supreme_court.sql` with your **citizenid**.

### Framework jobs → court roles (`config.lua`)

Players without a `doj_roles` row get their role from their **framework job**. All names live in `config.lua`:

| Config key | Default | Purpose |
|------------|---------|---------|
| `Config.JobRoleMap` | `judge→judge`, `district_attorney→prosecutor`, `prosecutor→prosecutor`, `lawyer→defense_attorney`, `defense_attorney→defense_attorney`, `public_defender→public_defender` | Framework **job name** → court role |
| `Config.AdminPermissions` | `{ 'qbcore.god', 'admin', 'superadmin' }` | ACE / QB permission / group names that count as Supreme Court |
| `Config.Permissions.policeMinGrade` | `2` | Min police grade to file police forms |
| `Config.Permissions.policeProsecutorGrade` | `4` | Police grade that also acts as prosecutor (`false` = off) |

Police jobs: built-in `police`, `sheriff`, `bcso`, `sasp`, `lspd`, `correctional`, `doc`, `judicial_police`, plus every job in `Config.Prison.executeJobs`. Another police job name? Add it there, or map it directly: `Config.JobRoleMap.mypolice = 'police'`.

**Example — your judge job is `sudac`:** `Config.JobRoleMap.sudac = 'judge'`

---

## In-game usage

### Opening the panel

| Method | Description |
|--------|-------------|
| Keybind | `Config.UI.openKey` (default **F5**) — opens the court laptop desktop |
| Courthouse | `ox_target` or `qb-target` on `Config.Courthouse` zones |
| Menus | ox_lib context / radial (where enabled) |

### Typical criminal flow

```text
Arrest / Affidavit
  → Criminal Pre-Filing / Complaint
  → Case opened (docket number)
  → Warrant request (optional) → Judge approve → Execute
  → Bail hearing / HUT
  → Motions & hearings
  → Arraignment / plea → Trial
  → Verdict
  → Commitment order (if Guilty + prison) → DOC / custody executes
  → Print forms
```

### Commands

| Command / bind | Description |
|----------------|-------------|
| **F5** (default) | Open / close the court laptop |
| `/doj_help` | List DOJ commands |
| `/doj_commitment` | Commitment orders (custody / DOC / judges) |
| `/refreshlaws` | Reload penal code from DB (console or admin) |
| `/courtlaws` | In-game penal code editor (Supreme Court / ACE admin) |
| `/court` | Open the court laptop (citizens → **Requests**, staff → **Cases**). Plea, public defender, bench warrant and contempt are in a case → **case tools** |
| `/gavel` | Strike the gavel (judge) |

### Print flow

```text
Save/Print → legal warning → Accept → copy count
  → Discord court transcript (imgbb + nevera_court_wh_* if configured)
  → document_a4 item(s) in inventory
  → Hand to counsel / judge
```

Discord transcript = lasting channel history of what was printed (staff evidence / docket archive).

## Legal forms

Templates live in **per-language folders** (full HTML each — **37 files** + `form-loader.js`):

| `Config.Locale` | Folder (edit `public`, ship `dist`) |
|-----------------|-------------------------------------|
| `en` | `web/dist/forms_en/` |
| `hr` | `web/dist/forms_hr/` |
| `de` | `web/dist/forms_de/` |
| `fr` | `web/dist/forms_fr/` |
| `es` | `web/dist/forms_es/` |

Missing file in a locale folder **falls back to `forms_en`**.  
Optional JSON chrome: `web/dist/i18n/forms_*.json` (HTML `data-i18n`).  

Access is gated by `Enums.FormsByRole`. Keep `name=` / `id=` on inputs identical across languages (autofill).

---

## Project structure

```text
Nevera_Court_Lite/
├── Install/                      # Buyer pack
│   ├── README.md · USER_GUIDE.md · MDT.md
│   ├── patches/ps-mdt_nevera_warrant.lua
│   ├── server_cfg_discord.cfg
│   ├── items/                    # ox + qb-core + legacy ESX item
│   └── sql/
│       ├── nevera_court.sql              # all tables (safe to re-run)
│       ├── nevera_court_laws.sql         # penal code, 5 languages (run once)
│       ├── first_supreme_court.sql       # optional first admin
│       └── upgrade/                      # very old databases only
├── bridge/                       # framework · mdt · inventory · phone
├── client/ · server/ · shared/ · locales/
├── editable/                     # open hooks for your own scripts
├── web/dist                      # NUI + A4 forms
├── config.lua · config_fines.lua
└── fxmanifest.lua
```

### Escrow — editable files

Typically open (`escrow_ignore`):

- `config.lua` · `config_fines.lua`
- `locales/**`
- `bridge/**`
- `Install/**` · `editable/**`
- `web/**` (built NUI + all A4 form HTML)

Encrypted on release: core `server/` + `client/` logic (except files left open by the author).

---

## Exports & integration

Useful for MDT and other resources. **Resource name in `exports['…']` must match the folder name.**

Primary export names are **English**. Croatian names are legacy aliases. `Config.Locale` does not rename exports.

| Export | Module |
|--------|--------|
| `MDT_GetProvider` / `MDT_IsFelon` / `MDT_HasWarrant` / `MDT_NotifyWarrant` / `MDT_NotifyCase` / `MDT_NotifyVerdict` / `MDT_CreateIncident` | MDT bridge (`Install/MDT.md`) |
| `GetLaws` / `GetLaw` / `GetCategories` | Laws |
| `GetCase` / `GetActiveCasesForCitizen` | Cases |
| `HasActiveWarrant` / `GetActiveWarrants` | Warrants |
| `HasActiveBail` / `GetBailForCase` | Bail |
| `IssueFine` / `GetPendingFines` | Fines |
| `GetPlayerRoles` / `HasRole` | Roles |
| `CreateCommitmentOrder` / `CanExecuteCommitment` | Prison |
| `GetHearingsForCase` / `GetNextHearing` | Hearings |
| `GetFormById` / `GetFormsForCase` / `CreateFormProgrammatically` / `GetBakedFormHtml` | Forms |

**Legacy HR aliases** (same functions): `GetZakoni` → `GetLaws`, `GetZakon` → `GetLaw`, `GetKategorije` → `GetCategories`, `GetFormaById` → `GetFormById`. Prefer English in new code.

**Restricted exports:** `IssueFine`, `CreateFormProgrammatically`, `CreateCommitmentOrder`, `CanExecuteCommitment`, and `GetBakedFormHtml` only answer calls from this resource itself or from a resource name listed in `Config.MDT.trustedInvokers` — everything else gets `nil`/`false` and a `BLOCKED …` line in console. Add your MDT/other integration's resource name to that list if a call is being rejected.

```lua
local laws = exports['Nevera_Court_Lite']:GetLaws()
local law  = exports['Nevera_Court_Lite']:GetLaw('NKZ-304')
local cats = exports['Nevera_Court_Lite']:GetCategories()
```

Events & NUI callbacks use English names (`nevera_court:…`, `getCases`, `printForm`, …).

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Resource won’t start | Check `oxmysql` + `ox_lib`; read console |
| Panel shows **Citizen** despite SQL | `doj_roles.citizenid` = live framework id (ESX = `users.identifier`); relog |
| NKZ shows 0 laws | Run `nevera_court_laws.sql` |
| Laws still English on HR/DE/FR/ES | Run `nevera_court_laws.sql`; set `Config.Locale`; restart |
| Form half English / half locale | Sync all `public/forms_*` → `dist/forms_*`; restart |
| `No such export viewDocument…` | Item `export` must match **folder name** casing |
| Use deletes item / nothing opens | `consume = 0` + correct `export` folder name |
| Save / Print error | Add `document_a4` + PNG; check `[sv_printer]` |
| Discord screenshots fail | `nevera_court_imgbb_key` + `nevera_court_wh_*` |
| “duplicate column” in `upgrade/` | Fresh install: skip `upgrade/`. `nevera_court.sql` already has every column. |
| Print rejected: “requires a Discord transcript” | Expected — `Config.Forms.requireTranscript = true` by default. Configure `nevera_court_imgbb_key` + `nevera_court_wh_*`, or set `requireTranscript = false` / add the type to `transcriptExempt`. |

---

## Support & community

Buyers should use **Discord** and **Tebex**. That is the standard setup for escrow FiveM products and is enough for install help, bugs, and re-downloads.

| Channel | Use for |
|---------|---------|
| **Discord** | Install help, bugs, feature requests, RP questions |
| **Tebex** | Purchase, invoices, license, re-download |

Replace placeholders before you publish:

- Discord: https://discord.gg/MUw2uR5MZ6
- Store: https://nevera.tebex.io/
- Docs: https://nevera-hard-rp.com/Nevera-Docs/#/docs/sudstvo/overview

### When opening a support ticket, include

1. Resource version (`fxmanifest.lua` → `version`)  
2. Framework + inventory + phone  
3. `Config.Locale`  
4. Server console excerpt (`[nevera_court]`, `[sv_printer]`, `[DISCORD]`)  
5. Clear steps to reproduce  

We do **not** support modified escrow binaries, leaked copies, or “fix it for me” tickets without logs.

### Optional: GitHub Issues / Discussions

Enabled on the public docs/support repo if you want them:

| Channel | Use for |
|---------|---------|
| **GitHub Issues** | Reproducible bugs (logs + steps) |
| **GitHub Discussions** | Ideas, RP workflows, translations |

Primary buyer support remains **Discord + Tebex**.

---

## License & support

**Proprietary — Nevera Dev Team.**

Purchase grants a license for **your** FiveM server(s) under Tebex / Cfx.re Asset Escrow terms. Redistribution, resale, or leaking escrow source is prohibited.

© Nevera Dev Team — All rights reserved.

---

<div align="center">

**Nevera Court Lite** `v1.0.0` · Built for serious DOJ roleplay

[Discord](https://discord.gg/MUw2uR5MZ6) · [Tebex](https://nevera-rp.tebex.io/) · [Docs](https://nevera-hard-rp.com/Nevera-Docs/#/docs/sudstvo/overview)

</div>
