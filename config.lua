-- ============================================================
--  Nevera_Court_Lite / config.lua
--  Customer-editable configuration (escrow_ignore)
-- ============================================================

Config = Config or {}

-- ============================================================
--  GENERAL
-- ============================================================

Config.Debug = false            -- true = print debug messages to console
Config.Locale = 'en'            -- UI + form HTML folder: en→forms_en | hr→forms_hr | de→forms_de | fr→forms_fr | es→forms_es
-- Hours east of UTC for texts the server writes itself (Discord). Player toasts use the PC clock.
-- e.g. 1 = CET (winter), 2 = CEST (summer), -5 = EST. nil = UTC on the server side only.
Config.TimeZoneOffset = 0
                                -- Form templates live in web/dist/forms_<lang>/ (edit the HTML, restart the resource)
                                -- Missing file falls back to forms_en
Config.Currency = '€'           -- Money symbol shown everywhere (UI, fines, fees, notifications): '€', '$', '£', ...
Config.PageSize = 20            -- Records per page (pagination)

-- Chat commands. Change the name here; the script reads these keys.
-- legacyAliases = true also keeps the old names: jpdezurni, doj_jury_odjava, refreshnkz.
Config.Commands = {
    juryJoin      = 'doj_jury',
    juryLeave     = 'doj_jury_leave',
    refreshLaws   = 'refreshlaws',
    help          = 'doj_help',
    legacyAliases = false,
}

-- Your server / court name. Used in UI titles, the official seal, Discord logs and the A4 forms
-- (the form templates say "Nevera" — it is replaced at runtime with ServerName).
-- ============================================================
--  EDITION — Nevera Court LITE (core court)
--  Included: cases, forms, warrants, verdicts, bail, hearings, fines, penal code,
--      gavel, arraignment, bench warrants, contempt, penal code editor.
--  Not included (Full only): jury, judicial police, archive, wall projector,
--      house arrest, database editor, exams, appointments, treasury, appeals,
--      expungement, plea deals, evidence screen, court session, public board,
--      alternative sentences, restraining orders, detention limits.
--  Set a module to false to turn it off. Full-only modules cannot be turned on.
-- ============================================================
Config.Edition = 'lite'   -- fixed for this build

Config.Modules = {
    bail           = nil,  -- nil = on, false = off
    hearings       = nil,
    gavel          = nil,
    arraignment    = nil,  -- plea entry + public defender
    bench_warrants = nil,  -- failure to appear → arrest warrant
    contempt       = nil,  -- contempt of court
    law_editor     = nil,  -- in-game penal code editor
}

Config.Branding = {
    ServerName = 'Los Santos',  -- e.g. 'Nevera' → "DISTRICT COURT NEVERA", "Nevera criminal code"
    PenalCode  = 'PC',          -- short name of your penal code shown in titles (e.g. 'PC', 'NKZ')
}

-- Court filing fees charged from the player's bank (Config.Fees.Account).
-- Adjust amounts to your server economy before go-live.
Config.Fees = {
    Enabled = true,
    Account = 'bank',
    CurrencyLabel = nil,        -- nil = use Config.Currency
    request_certificate_no_criminal = 500,
    name_change_request = 2000,
}

-- Framework bridge: 'auto' | 'qb' | 'qbox' | 'esx' | 'standalone'
-- auto = detect Qbox > QBCore > ESX > OX; use standalone only when set explicitly
Config.Framework = 'auto'

-- ESX-only options (ignored on QB / Qbox / OX)
Config.ESX = {
    -- ESX jobs usually have no job.onDuty. false = treat nil as on-duty (default).
    -- true  = require job.onDuty == true (only if your ESX duty script sets it).
    RequireDuty = false,
    -- Groups allowed for Bridge.AddCommand(..., restricted = true, ...)
    AdminGroups = { 'admin', 'superadmin' },
}

-- Inventory bridge: 'auto' | 'ox' | 'qs-inventory' | 'qb-inventory' | 'ps-inventory' | 'codem-inventory' | 'tgiann-inventory' | 'origen_inventory' | 'ak47_inventory'
-- auto: ox_inventory wins if both ox and qb-inventory are started.
-- Pure QB (no ox_inventory): leave 'auto' or set 'qb-inventory'.
-- Mixed servers switching to QB-only: set provider = 'qb-inventory' so ox is ignored.
Config.Inventory = {
    provider = 'auto',
}

-- ============================================================
--  TIMERS (seconds)
-- ============================================================

Config.Timers = {
    prefilingDeadline       = 86400,    -- 24h to file Criminal Complaint after arrest
    civilAppearanceDeadline = 172800,   -- 48h for civil Appearance after service
    searchWarrantExpiry     = 1209600,  -- 14 days search warrant validity
    failToAppearBailBan     = 14,       -- days without bail after Fail to Appear
    cronInterval            = 60000,    -- cron check interval (ms)
}

-- Target eye (courthouse / gavel)
-- 'auto' = ox_target if started, otherwise qb-target
Config.Target = {
    provider = 'auto', -- 'auto' | 'ox_target' | 'qb-target'
}

-- ============================================================
--  COURTHOUSE — target zones (ox_target or qb-target)
-- ============================================================

Config.Courthouse = {
    mainZone = {
        coords = vector3(234.89, -1314.04, 29.22),
        size   = vector3(8.0, 12.0, 3.0),
        rotation = 0.0,
        heading  = 0.0,
    },
    terminalZone = {
        coords = vector3(234.89, -1309.04, 29.22),
        size   = vector3(2.0, 2.0, 2.0),
        rotation = 0.0,
    },
    bailZone = {
        coords = vector3(240.50, -1314.04, 29.22),
        size   = vector3(2.0, 2.0, 2.0),
        rotation = 0.0,
    },
}

-- Gavel (move coords to your judge's desk in your courtroom MLO)
Config.Courtroom = {
    gavel = {
        enabled   = true,
        -- Target point + optional desk prop. The STRIKE itself plays from the judge's
        -- real position, so it works even if these coords are not exact.
        coords    = vector3(234.89, -1314.04, 29.35),
        heading   = 0.0,
        spawnProp = true,          -- static gavel on the judge's desk at coords
        prop      = `prop_cs_gavel`, -- desk prop only; a missing model spawns nothing (no claw hammer)
        -- No strike animation. amb@world_human_hammering is a worker nailing wood
        -- (claw hammer in hand + three loud hits). The strike is the gavel sound only.
        range     = 22.0,          -- hearing distance (m)
        command   = 'gavel',       -- /gavel for judges ('' = disabled). Also: target eye + NUI button
        -- Sound: 'nui' = real gavel sound (web/dist/gavel.wav) with distance fall-off
        --        'native' = GTA sound (soundName / soundSet below)
        sound     = 'nui',
        volume    = 0.9,           -- 0.0 - 1.0 (nui only)
        knocks    = 3,             -- strikes per use (1-5)
        gapMs     = 330,           -- ms between strikes
        soundName = 'PICK_UP',
        soundSet  = 'HUD_FRONTEND_DEFAULT_SOUNDSET',
    },
}

-- ============================================================
--  PERMISSIONS / JOB → DOJ ROLE
-- ============================================================
-- Framework job names that grant a court role WITHOUT a doj_roles row.
-- Values = DOJ role strings (same as Enums.Roles / doj_roles.role).
-- Example — your judge job is named "sudac" instead of "judge":
--   Config.JobRoleMap.sudac = 'judge'
-- Police / DOC / JP jobs are merged separately from Prison.executeJobs,
-- JudicialPolice.units / assignableJobs / commandJobs, HouseArrest.policeJobs,
-- RestrainingOrders.policeJobs (see shared/utils.lua).
Config.JobRoleMap = {
    judge             = 'judge',
    district_attorney = 'prosecutor',
    prosecutor        = 'prosecutor',
    lawyer            = 'defense_attorney',
    defense_attorney  = 'defense_attorney',
    public_defender   = 'public_defender',
}

-- ACE / QB permission / ESX-group names that grant Supreme Court access
-- (same behaviour as before: qbcore.god ACE, group admin/superadmin, HasPermission).
Config.AdminPermissions = { 'qbcore.god', 'admin', 'superadmin' }

Config.Permissions = {
    -- Kept for docs / billing-style single-job hints; form submit uses JobRoleMap POLICE list.
    policeJob         = 'police',
    policeMinGrade    = 2,
    -- Police job grade that also counts as prosecutor. false = disable this rule.
    policeProsecutorGrade = 4,
}

-- ============================================================
--  BILLING — peleg-billing (optional)
--  Filing amounts live in Config.Fees above. This block is only
--  for the optional peleg-billing invoice issuer, not a second price list.
-- ============================================================

Config.Billing = {
    useBank = true,
    issuerJob = 'police',
}

-- ============================================================
--  PHONE — multi-phone bridge (optional)
-- ============================================================

Config.Phone = {
    -- auto | lb-phone | qs-smartphone | yseries | 17mov | gksphone | npwd | qb-phone
    provider = 'auto',
    dojNumber = 'DOJ-SYSTEM',
    senderName = 'Department of Justice',
    appIcon = nil,                -- nil = built-in DOJ icon (works with any resource folder name)
    appColor = '#1a1a2e',
    enableSMS = true,
    enableNotify = true,
}

-- ============================================================
--  MDT — police MDT bridge (optional)
--  auto | ps-mdt | tk_mdt | advanced | none
--  See Install/MDT.md for exports + hook examples
-- ============================================================

Config.MDT = {
    enabled  = true,
    -- auto priority: tk_mdt → ps-mdt
    -- 'advanced' is NEVER auto-detected — set provider = 'advanced' + resourceName
    provider = 'auto',  -- 'auto' | 'tk_mdt' | 'ps-mdt' | 'advanced' | 'none'
    -- Required when provider = 'advanced' (exact folder name from Keymaster)
    resourceName = nil,  -- e.g. 'p_mdt'
    -- Resources allowed to call IssueFine / CreateFormProgrammatically (SUD-004)
    -- Do NOT add a generic 'mdt' name — anyone can name a resource that.
    trustedInvokers = {
        'ps-mdt',
        'tk_mdt',
    },
    -- Push court events into the linked MDT
    syncWarrants    = true,
    syncCases       = true,
    syncVerdicts    = true,
    syncCommitments = true,
}

-- ============================================================
--  DISCORD WEBHOOKS (panel / system event logs — TEXT embeds)
--
--  Prefer server.secrets.cfg / server.cfg convars (see Install/server_cfg_discord.cfg):
--    set nevera_court_log_cases    "https://discord.com/api/webhooks/..."
--    set nevera_court_log_warrants "..."
--    … same for bail, fines, verdicts, admin, audit
--
--  Leave these empty for buyers. Convars override Config.Webhooks when set.
--  A4 form screenshots (transcripts) use NEVERA_COURT_WH_* — separate layer.
-- ============================================================

Config.Webhooks = {
    cases    = '',   -- new / closed cases          → nevera_court_log_cases
    forms    = '',   -- printed / filed forms (text) → nevera_court_log_forms
    warrants = '',   -- arrest & search warrants   → nevera_court_log_warrants
    bail     = '',   -- bail events
    fines    = '',   -- monetary fines
    verdicts = '',   -- judgments
    admin    = '',   -- admin actions
    audit    = '',   -- audit log
    judicial = '',   -- judicial police: transport + protection requests → nevera_court_log_judicial
}

-- ============================================================
--  PRISON — hard-RP commitment order + jail handoff
-- ============================================================
-- Flow when commitmentOrder = true (recommended for hard RP):
--   1) Judge enters Guilty + prison minutes
--   2) Court creates a Commitment Order (pending) — NO instant jail
--   3) Custody / judicial police / DOC jobs get notified
--   4) They escort the inmate (RP), then Execute the order
--   5) Only then Config.Prison.provider jails the player
-- Set commitmentOrder = false to restore instant jail on verdict.

Config.Prison = {
    -- auto | qb-prison | rcore_prison | pickle_prisons | custom | none
    provider = 'auto',
    -- Used by UI when converting NKZ months → suggested prison minutes
    minutesPerMonth = 60,

    -- Hard RP: create commitment order instead of teleporting on verdict
    commitmentOrder = true,

    -- Framework jobs allowed to EXECUTE a commitment order (intake → prison)
    -- Add your judicial police / DOC / corrections job names here.
    executeJobs = {
        'police',
        'sheriff',
        'bcso',
        'sasp',
        'lspd',
        'correctional',
        'doc',
        'judicial_police',
    },
    executeMinGrade = 0,

    -- Also allow anyone with DOJ police role in doj_roles
    allowPoliceRole = true,

    -- Executor must be near the defendant to execute (anti-remote jail)
    requireNearby = true,
    nearbyDistance = 5.0,

    -- Optional intake zone at the state prison gate (ox_target or qb-target)
    intakeZone = {
        enabled  = true,
        coords   = vector3(1845.0, 2585.0, 45.0), -- Bolingbroke / adjust to your MLO
        size     = vector3(4.0, 4.0, 3.0),
        rotation = 0.0,
        label    = 'Execute Commitment Order',
    },

    -- How custody / police get the order when it is issued
    notify = {
        oxLib    = true,   -- red ox_lib popup for online executeJobs
        phoneSMS = true,   -- phone notification via Config.Phone bridge
        -- Dispatch alert (soft): auto | ps-dispatch | cd_dispatch | qs-dispatch | custom | none
        dispatch = 'auto',
        -- Jobs shown on dispatch (defaults to executeJobs if empty)
        dispatchJobs = {},
        -- custom dispatch: TriggerEvent(serverEvent, payload)
        customDispatchEvent = '',
    },

    -- custom: set event names if provider = 'custom'
    custom = {
        -- TriggerClientEvent(event, src, minutes)
        clientEvent = 'prison:client:Enter',
        -- TriggerEvent / TriggerServerEvent (server-side) — leave empty to skip
        serverEvent = '',
    },
}

-- ============================================================
--  UI — NUI PANEL
-- ============================================================

Config.UI = {
    openKey        = 'F5',
    closeKeys      = { 'Escape', 'F5' },
    notifyDuration = 6000,
    blink          = true, -- taskbar badge pulse; set false to keep a steady badge
    tablePageSize  = 15,
    pageSize       = 20,

    -- Everyone picks their own look by default (theme/density/language);
    -- admin can lock it server-wide. Same pattern as a theme.locked option
    -- in off-the-shelf inventory NUIs.
    theme = {
        default = '',      -- '' = built-in default look
        locked  = false,    -- true = players can't change it themselves
    },
}

-- ============================================================
--  FORMS — anti-fraud: require a Discord transcript on print
--  (sv_printer.lua rejects the save if the screenshot never
--  reached Discord — no more "original" lost to lag/bug/closed window)
-- ============================================================
Config.Forms = {
    -- true = printing is REJECTED unless the A4 screenshot reached Discord
    --        (needs nevera_court_imgbb_key + nevera_court_wh_* convars, see Install/server_cfg_discord.cfg)
    -- false = screenshots are optional (recommended until Discord/ImgBB is set up)
    requireTranscript = false,
    -- Form types exempt from the requirement (e.g. internal drafts you add here)
    transcriptExempt = {},
}

-- ============================================================
--  OFFICIAL COURT SEAL (2D on printed A4 — baked into html_content)
--  Only court staff roles. Citizens cannot add/edit the seal.
-- ============================================================
Config.Seal = {
    Enabled = true,
    -- Roles that imprint the official seal when printing
    Roles = {
        judge = true,
        clerk = true,
        supreme_court = true,
    },
    -- Show VALID/INVALID seal notify when opening a sealed document (Use)
    NotifyOnOpen = true,
}

-- ============================================================
--  ECONOMY
-- ============================================================

Config.Economy = {
    referenceHourlyRate = 950,
    misdemeanorMaxHours = 4,
    felonyMaxHours = 20,
    rookiePlaytimeThreshold = 35,
    rookieFineMultiplier    = 0.7,
    civilDamagesMin = 1000,
    civilDamagesMax = 500000,
}

-- ============================================================
--  COURT COMMAND
-- ============================================================
Config.Extras = {
    command         = 'court',   -- opens the court laptop (same as F5 for staff). '' = no command
    servicesCommand = '',        -- Court Services menu is Full only
    target          = true,      -- eye at Config.Courthouse.mainZone → laptop
}

-- In-game penal code editor (/court → Penal code editor): change prices, prison time, texts,
-- add / deactivate articles. Saved to the database and active immediately.
Config.LawEditor = {
    enabled = true,
    roles   = { 'supreme_court' },        -- DOJ roles allowed
    ace     = 'nevera.sudstvo.admin',     -- or anyone with this ACE (txAdmin admins)
    command = 'courtlaws',                -- direct command ('' = only via /court menu)
}

-- ============================================================
--  COURT PROCEDURE (Install/sql/nevera_court.sql)
-- ============================================================

-- Arraignment: judge enters the plea (guilty / not guilty / no contest).
-- Guilty / no contest → case goes straight to sentencing.
Config.Arraignment = {
    enabled = true,
    -- Public defender is assigned automatically when the defendant asks for one
    -- (or the judge / clerk assigns it). Online public defenders are preferred.
    publicDefenderRoles = { 'public_defender' },
}

-- Bench warrant: judge marks "failed to appear" → active arrest warrant, police + MDT notified
Config.BenchWarrant = {
    enabled     = true,
    forfeitBail = true,    -- paid bail of that case is forfeited to the DOJ treasury
}

-- Contempt of court: judge punishes a person in the courtroom on the spot
Config.Contempt = {
    enabled     = true,
    radius      = 25.0,     -- players near the judge that can be selected
    maxFine     = 5000,
    maxMinutes  = 30,       -- prison minutes (direct to prison provider, no commitment order)
}
