# Nevera Court Lite — INSTALL (Tebex)

Do steps **in order**. Keep this folder with the resource.

```
Install/
  README.md
  sql/nevera_court.sql        ← all tables (safe to re-run)
  sql/nevera_court_laws.sql   ← penal code, 5 languages (run once)
  sql/first_supreme_court.sql ← optional first admin
  sql/upgrade/                ← very old databases only
  items/ox_inventory_document_a4.lua
  items/qbcore_document_a4.lua     ← qb-core + qb-inventory
  items/qbx_core_document_a4.lua   ← Qbox: inventory how-to
```

**In-game usage:** F5 (default `Config.UI.openKey`) opens the court laptop — see root `README.md` (Features).

---

## Requirements

| Resource | Required | Why |
|----------|----------|-----|
| `oxmysql` | Yes | Database |
| `ox_lib` | Yes | Notify, keybinds, callbacks |
| `ox_inventory` **or** `qb-inventory` | Yes | `document_a4` item (`Config.Inventory.provider`) |
| `ox_target` **or** `qb-target` | Recommended | Courthouse eye (F5 panel key works without it). `Config.Target.provider = 'auto'` |
| Framework (ESX / QB / Qbox) | Yes | Auto bridge |
| [`nevera_printeri`](https://nevera-hard-rp.com/Nevera-Docs/#/docs/sudstvo-lite/printeri) | Optional, **sold separately** | Physical printers / extra print UI. Court already opens `document_a4` in its own viewer. |

Court **does not** require `nevera_printeri` to view printed forms.

### server.cfg order

```cfg
ensure oxmysql
ensure ox_lib
ensure ox_inventory           # or: ensure qb-inventory  (not both unless you force provider)
ensure ox_target              # or: ensure qb-target
ensure qbx_core               # or es_extended / qb-core

ensure nevera_printeri        # optional — only if you bought it separately
ensure Nevera_Court_Lite
```

Recommended folder name: **`Nevera_Court_Lite`** (must match item export).

---

## SQL

### Fresh install (all frameworks)

Run **two** files:

```
sql/nevera_court.sql        # all tables — safe to run again, never deletes rows
sql/nevera_court_laws.sql   # penal code (9 categories, ~93 articles, EN/HR/DE/FR/ES) — run ONCE
```

⚠ Running `nevera_court_laws.sql` again resets the penal code to defaults (in-game Law Code edits are lost).

### First Supreme Court (admin)

Easiest: give yourself ACE `nevera.sudstvo.admin` → F5 → **Admin → Role Management → Add player** → `supreme_court`.

Or edit `sql/first_supreme_court.sql`:
- QB / Qbox: short `citizenid`
- ESX: exact `users.identifier` (e.g. `char1:…`) — must match 1:1

### Updating an older Lite

Run `nevera_court.sql` again. Missing columns (audit license) are added when the resource starts.
`sql/upgrade/` is only for very old databases — see `sql/upgrade/README.md`.

**Database from an earlier build:** run `sql/upgrade/forms_status.sql` once (adds form statuses `archived` / `withdrawn`).

### Upgrade to Full later

Same database. Stop Lite, start Nevera_Court (Full). No extra SQL.

---

## Item `document_a4`

### qb-core + qb-inventory (no ox_inventory)

1. Paste `Install/items/qbcore_document_a4.lua` into `qb-core/shared/items.lua`
2. Copy `document_a4.png` → `qb-inventory/html/images/`
3. Set `Config.Inventory.provider = 'qb-inventory'` if ox_inventory is still started on the machine
4. `unique = true` + `useable = true` — Court registers `CreateUseableItem` on start (opens NUI from `item.info.doc_id`)

### Qbox (`qbx_core`)

`qbx_core` has **no** `shared/items.lua`. Define the item **only** in `ox_inventory/data/items.lua`.  
See **`Install/items/qbx_core_document_a4.lua`**.

### All frameworks (same Lua block)

1. Paste `Install/items/ox_inventory_document_a4.lua` into `ox_inventory/data/items.lua`
2. Copy `document_a4.png` → `ox_inventory/web/images/`
3. **Do not** paste a second `document_a4` from a printer item file (overwrites Court)

**Critical:**

```lua
consume = 0,  -- otherwise ox DELETES the item on Use
stack = false,
export = 'Nevera_Court_Lite.viewDocument',  -- MUST match folder name (case-sensitive)
```

If your folder is `nevera_court`, use `nevera_court.viewDocument`.  
F8 `No such export viewDocument…` = wrong casing.

---

## Config

```lua
Config.Locale = 'en'       -- en | hr | de | fr | es
Config.Framework = 'auto'  -- or 'esx' | 'qb' | 'qbox'
Config.Inventory.provider = 'auto'  -- or 'ox' | 'qb-inventory' (force QB if ox is still started)
```

DOJ roles live in `doj_roles` (not ESX `users.group` / QB job alone).

### Languages (ready out of the box)

| Locale | Panel UI | 37 A4 forms | NKZ titles |
|--------|----------|-------------|------------|
| `en` / `hr` / `de` / `fr` / `es` | `locales/*.lua` | `web/dist/forms_*` | seeded in `03` |

NUI reads **`web/dist/`**. Edit forms directly in `web/dist/forms_*`.


## What this version includes (buyer FAQ)

| Issue | Fix / note |
|-------|------------|
| Panel shows Citizen despite SQL | `doj_roles.citizenid` must equal live framework id; relog |
| Use deletes item / does nothing | `consume = 0` + export = exact folder name |
| Use opens empty English frame | Check `web/dist/forms_*` exists for your locale; Court viewer does not need printeri |
| Form half EN / half locale | Make sure `web/dist/forms_<locale>` has all 37 forms |
| Laws still English | Run `03`; set `Config.Locale`; restart |
| ox_target / qb-target missing | Optional; F5 panel key still works |

---

## Verify

```sql
SELECT COUNT(*) FROM doj_laws;                              -- ~93
SELECT COUNT(*) FROM doj_laws WHERE title_hr IS NOT NULL;   -- ~93 after 03
SELECT COUNT(*) FROM doj_laws WHERE title_es IS NOT NULL;   -- ~93 after 03
SELECT * FROM doj_roles WHERE role = 'supreme_court';
```

In-game: relog → F5 → Supreme Court → print form → inventory → **Use** → filled document.
