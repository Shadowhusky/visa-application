---
name: visa-application
description: Use when the user wants help applying for any visa from any country — Schengen tourist (Italy, France, Germany, Spain, etc.), US B1/B2, UK visitor, Japan, Canada, China, Australia, or any other. Triggers on phrases like "I need to apply for a visa", "help me with my Schengen visa", "Italy visa application", "US B1/B2", "UK visitor visa", "Japan tourist visa", "Canada eTA", "Australian visa", mentions of VFS / TLScontact / BLS visa centres, consulate appointments, biometrics, or visa renewals. Walks the user from a one-line ask to a fully assembled, officer-ready Print Pack: brief Q&A → research current official requirements online (cross-validated against ≥2 sources, government sites preferred) → reuse or build a portable user profile → set up or reuse the application folder → generate cover letter, employment letter, filled application form, and printable checklist PDF → assemble numbered Print Pack. Maintains a profile so the next application is a one-day job, not a one-week job.
---

# Visa Application

A general-purpose workflow for assembling a complete, officer-ready visa application from any country to any country. Designed to be invoked once per application and reused across them — the user's reusable data is captured once and replayed forever.

## Why this skill exists

Visa applications are high-stakes, high-paperwork, and rules drift. Most applicants either over-search and waste days, or under-search and get rejected on a single missing line. This skill standardises the workflow:

1. **Capture the few things only the user knows** (destination, dates, employment) up front, in a single Q&A turn.
2. **Look up the rest from official sources** — consulate page first, visa-centre operator (VFS/TLS/BLS) second, recent third-party guides only as a sanity check.
3. **Cross-validate** because consulate sites are often stale and third-party guides are often wrong.
4. **Generate every document the consulate actually wants**, in the order they want it, in a folder ready to print.
5. **Persist what is reusable** — passport, address, employer, banking — so the next application takes 45 minutes, not 5 days.

Accuracy is the principal currency here. If a fact disagrees between two sources, surface the disagreement to the user — don't paper over it.

## When to invoke

Whenever the user mentions applying for a visa to any country, even casually ("can you help me sort out my visa for Japan?"). Don't wait for them to ask for "the visa skill" — that's not a phrase they'll use.

When the skill activates, briefly announce it: *"Using the visa-application skill — first I need to capture a few basics about your trip, then I'll research the current rules and assemble your document pack."* That sets the right expectation for the user about what's coming and lets them course-correct early if they wanted something narrower (e.g., "I only need help with the cover letter").

## The workflow

The skill runs in six phases. Don't skip steps; the late-phase output depends on the early-phase data being clean.

### Phase 1 — Capture user intent (1 turn)

Ask the user, in one batched message (ideally via the structured-question tool if available):

1. **Destination country and city/cities?** (e.g., "Italy — Rome and Milan")
2. **Country you're applying from?** (i.e., where you legally reside and will lodge the application — "UK / London")
3. **Visa type?** (Tourist, Business, Visit family, Study, Work, Transit. Default: Tourist.)
4. **Trip dates** (departure → return) **and how many days**.

Don't ask anything else yet. Personal details come from the profile (phase 2). If they're a first-time user with no profile, you'll capture identity later — capture it once, never again.

### Phase 2 — Locate or create the user profile

The user's reusable identity, employment, banking, residence, and prior-visa data lives in **one** file across all applications. The canonical location is:

```
~/.claude/visa-profile.json
```

**Always search first.** Before assuming there isn't one, check the canonical location AND common scattered locations the user may have used in past sessions. Use the helper:

```bash
bash scripts/find-existing.sh profile
```

This searches: `~/.claude/`, `~/Documents/`, `~/Desktop/`, iCloud Drive's `Documents/` and `Travel/`, and prints anything matching `*visa-profile*.json` or `*personal_profile*.json`.

**If found**: read it, summarise the headline identity to the user in one sentence, and ask "anything changed since {last_updated}?"

**If not found**: capture the data from the user (see `references/profile-schema.md` for the full schema), write to the canonical location, and proceed. Don't ask for everything in one go — ask only what's needed for *this* application, mark the rest as `null`, and grow the profile organically over time. See "Document intake" below for the upload-driven shortcut.

### Document intake — when the user uploads files

Most users have IDs, payslips, bank statements, hotel bookings, and flight confirmations as PDFs or images already. Treat every uploaded file as an opportunity to **(a)** extract structured data, **(b)** cross-check against the profile, and **(c)** file it into the application folder.

When a user pastes or attaches a file:

1. **Read it** with the Read tool (PDF, JPG, PNG all supported). Extract every field that maps to the profile schema or to a per-application document.
2. **Confirm** the extracted values to the user in one short message — "I read your passport: name SHARMA PRIYA, passport Z7621984, expires 2030-08-13. Saving to profile." — and stop if anything looks wrong.
3. **File it** into the application folder with a clean name. Don't dump it next to a dozen other files; rename to something like `passport-bio.pdf`, `payslip-{YYYY-MM}.pdf`, `hotel-{city}.pdf`.
4. **Cross-check** against the profile. If the payslip says salary £80k but the profile says £65k, flag it — the user may have had a raise, or one of them is wrong.
5. **Update the profile** with anything new (NI number, employer registered office, bank IBAN, etc.).

The user shouldn't have to retype data that's already on a document they have. The flow should feel like *"drop the file, get a short summary back, move on"*.

### Phase 3 — Locate or create the application folder

Each application gets its own folder. **Always search first** for an existing one the user may have started:

```bash
bash scripts/find-existing.sh folder "{destination}"
```

This searches the common iCloud Drive `Travel/` and Documents tree, and prints any folder whose name matches `*{destination}*`, `*visa*{destination}*`, or `*{destination}*visa*`. If anything plausibly matches, show the user and ask whether to use it.

**If creating new**: default to `~/Documents/Visa Applications/{destination}-{year}/` and ask the user to confirm. Don't create silently — they might prefer iCloud, Dropbox, or somewhere specific.

Inside the application folder, you'll later create:

```
{destination}-{year}/
├── Cover Letter.pdf
├── Employment Letter.pdf            (if employed)
├── Visa-application-form-FILLED.pdf (if portal exists) or application_form_data.md
├── application_status.md             (running checklist)
├── (user-provided documents the user drops in)
└── Print Pack/
    ├── 00 - CHECKLIST.pdf
    ├── 01 - …
    └── …
```

### Phase 4 — Research current official requirements

This is the part where accuracy matters most. Read `references/research-protocol.md` for the full protocol — the short version:

1. **Hit the destination consulate page in the user's origin country first.** That's the most authoritative source. E.g., for Italy from UK: `conslondra.esteri.it`. Search "{destination} consulate {origin city} visa {type}".
2. **Hit the visa-centre operator second.** VFS Global for most Schengen + UK + many others; TLScontact for France, China, Saudi; BLS for some others. Search "VFS {destination} {origin}" or "TLScontact {destination} {origin}".
3. **Hit one third-party 2026 guide third** as a sanity check (Wise, Visard, Schengen Visa Support, etc.) — but treat as a tertiary signal, not a source of truth.
4. **Cross-validate at least two sources for every material claim** (fees, photo specs, insurance minimum, fund minimum, required documents, biometric rules, processing time, online vs paper form). If they disagree, surface to user.
5. **Check the published / updated date** of every source. Visa rules change often (EES launched Oct 2025; Italy goes fully digital 1 Jun 2026; UK BRPs phased out for eVisa late 2024 onward). Old guidance is dangerous.

See `references/known-portals.md` for known online application portals (Italy `e-applicationvisa.esteri.it`, US `ceac.state.gov` DS-160, UK `gov.uk/standard-visitor`, etc.) and `references/document-checklist.md` for typical document lists by visa type — both as starting points, not gospel; always re-verify online.

### Phase 5 — Generate documents + assemble Print Pack

For each document type, prefer the proven approach — render HTML via Chrome headless to PDF.

```bash
bash scripts/render-pdf.sh templates/cover-letter.html /tmp/cover.html "{application-folder}/Cover Letter.pdf"
```

(See `scripts/render-pdf.sh` for the canonical invocation. It uses Chrome headless on macOS; for Linux/Windows the script self-adjusts.)

Documents to produce, in order:

1. **Cover letter** — addressed to "Visa Section, Consulate General of {destination}, {origin city}". One page. State purpose, dates, employment, self-funding, and reference to enclosed evidence. Avoid promising things the documents don't back. See `templates/cover-letter.html`.
2. **Employment letter** — if employed. Should be signed by manager or HR on company letterhead. Render a draft, give to user, they get it signed. See `templates/employment-letter.html`.
3. **Filled visa application form** — strongly prefer the destination's official online portal (it issues a 2D barcode the officer can scan in seconds). If the portal exists, walk the user through it field by field using a browser MCP if available (`mcp__Claude_in_Chrome__*` if present — load via ToolSearch). Navigate to the portal, read each page, fill from the profile, take screenshots so the user can verify, and at the end click "Print" to download the generated PDF. If no portal exists, fill the standalone PDF (you can use `pymupdf` to overlay text on flat forms — pip install --break-system-packages pymupdf) or write a `application_form_data.md` sheet the user can transcribe by hand.
4. **Checklist PDF (00 - CHECKLIST.pdf)** — a one-page summary the user prints as the cover sheet of the Print Pack. See `templates/checklist.html`. Include: appointment time/place, before-leaving-home tick list, the numbered stack order, likely officer questions and how to answer them, and the cross-checks you've already verified.

After documents are generated, assemble the Print Pack:

```bash
bash scripts/build-print-pack.sh "{application-folder}"
```

This copies (not moves — keep originals) each PDF into a `Print Pack/` subfolder with a numbered, human-readable prefix in the order an officer flips through them.

### Phase 6 — Final cross-check report

Tell the user what's done, what's still pending, and what specifically to bring to the appointment. Use this exact template:

```
✅ Compliant out of the box: <list of items already met>
❌ Still needed before {appointment date}: <action items>
⚠️ Items the user must verify themselves: <e.g., recent immigration status, fund balance>
📦 At the appointment: <€XX visa fee, biometric photos, original passport>
```

Surface any inconsistency you find — better to flag a date mismatch now than have the officer find it.

## Things to be paranoid about

- **Stale data.** Today's date is whatever the harness says. Use it. Visa rules change quarterly.
- **The "current address" trap.** The user may have moved. Confirm address against payslips/bank statements before generating the cover letter.
- **The "passport about to expire" trap.** Many countries require 3 *or 6* months past return. Spell it out.
- **The "BRP vs eVisa" trap.** Several countries (UK, Australia, EU member states) have migrated from physical residence cards to digital eVisas. Don't reference outdated physical cards.
- **The "two adults on a single hotel booking" trap.** If the user is travelling solo but their hotel booking is for two, the officer will notice. Flag it.
- **Insurance dates one day short.** The travel insurance must cover ≥1 day past return, every single day of the trip.
- **EES (Entry/Exit System).** Live in the Schengen area since Oct 2025. First crossing captures biometrics at the border. Mention it so the user isn't surprised.
- **Multiple-entry visa signing.** For multiple-entry Schengen visas some consulates expect a second signature acknowledging the insurance clause. Verify per consulate.

## Reuse mindset

Every time you finish a visa application, **update `~/.claude/visa-profile.json`** with anything new learned (new employer, new address, new prior visa, new passport). The next application — for the same person, possibly to a different country — should be substantially faster because the profile is already 80% filled.

Also update `~/.claude/visa-history.json` with a summary of what was applied for (country, type, dates, outcome if known). Past prior-visa entries matter: many Schengen forms have a "previous visas in last 3 years" question, and the past entries are exactly what's needed.

## File map for this skill

- `SKILL.md` — this file, the workflow
- `references/research-protocol.md` — how to research and cross-validate
- `references/document-checklist.md` — standard document lists by visa type
- `references/known-portals.md` — known online application portals + country quirks
- `references/profile-schema.md` — the visa-profile.json schema
- `templates/cover-letter.html` — letter template, A4 single page
- `templates/employment-letter.html` — letter template, A4 single page
- `templates/checklist.html` — Print Pack cover-sheet checklist
- `scripts/render-pdf.sh` — HTML → PDF using Chrome headless
- `scripts/find-existing.sh` — search the user's machine for existing profile / folder
- `scripts/build-print-pack.sh` — assemble the numbered Print Pack
