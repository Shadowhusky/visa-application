# End-to-end test scenarios

The skill is mostly behavioural — its correctness lives in how a future Claude agent runs the workflow when invoked. These scenarios document expected behaviour so reviewers can trace whether the skill is doing what it should. Each scenario lists the user's opening message, what state the system is in, and the expected behaviour of the agent during the activation ritual + Phase 1.

Run any of these by starting a fresh Claude Code session and pasting the **You** line. The skill should respond as described.

---

## Scenario 1 — Cold start, generic ask

| | |
|---|---|
| State | No profile, no application folder, no history |
| You | "I need help with a visa application." |
| Expected | Banner → silent Phase 0 search → AskUserQuestion with **all four** kickoff questions (destination, origin, visa type, duration) because the message gave nothing |

**Pass criteria:** Banner printed before any question. Phase 0 searches run silently. AskUserQuestion has 4 questions with proper options.

---

## Scenario 2 — Cold start, message names destination + origin

| | |
|---|---|
| State | No profile |
| You | "I want to apply for a Schengen visa to Italy from the UK." |
| Expected | Banner → Phase 0 → AskUserQuestion with **only** the missing two questions (visa type, duration) — destination + origin are already in the message |

**Pass criteria:** AskUserQuestion does not re-ask destination or origin. One short confirmation sentence acknowledges the parsed facts before the question.

---

## Scenario 3 — Cold start, complete message

| | |
|---|---|
| State | No profile |
| You | "I need a Schengen visa to Italy from the UK, tourist, 5 days late June." |
| Expected | Banner → Phase 0 → **no AskUserQuestion** at all. Single confirmation sentence. Skill proceeds straight to Phase 2 (asking for documents to build profile) |

**Pass criteria:** No structured question is shown because all four facts are known. Skill moves to document intake.

---

## Scenario 4 — Warm start, existing profile, no in-progress folder

| | |
|---|---|
| State | `~/.claude/visa-profile.json` exists, no application folder on disk for any destination |
| You | "Help me with a visa for Japan." |
| Expected | Banner → Phase 0 → AskUserQuestion using the **warm-start variant** (Continue/New/Update/Other). Since no folder exists, "Continue existing application" should not be offered |

**Pass criteria:** Warm-start question shown, not the cold-start 4-question batch.

---

## Scenario 5 — Warm start, application folder shows `Status: submitted`

| | |
|---|---|
| State | Profile exists, application folder contains `application_status.md` with `Status: submitted` |
| You | "Update on my Italy visa." |
| Expected | Banner → Phase 0 reads the status file → AskUserQuestion with the **post-submission variant** (Still waiting / Approved / Refused / Other) — NOT the standard warm-start |

**Pass criteria:** Question matches Phase 8 trigger. Status field drives the variant selection.

---

## Scenario 6 — User declines the structured question

| | |
|---|---|
| State | Any |
| You | (Hit Esc on the AskUserQuestion modal) |
| Expected | Skill falls back to a single short plain-text prompt: *"No worries — just tell me in your own words..."* and continues from the free-text reply |

**Pass criteria:** Skill doesn't freeze or skip Phase 1. Conversational fallback engages.

---

## Scenario 7 — Document upload after Q&A

| | |
|---|---|
| State | After Phase 1, no profile exists yet |
| You | (Drops passport-scan.jpg, payslip.pdf, bank-statement.pdf in chat) |
| Expected | Skill reads each file via the Read tool, extracts fields, confirms each in one short message, files each into the application folder under a clean name, writes the profile to `~/.claude/visa-profile.json`. Does NOT ask the user to retype any data that's in the document |

**Pass criteria:** No "what's your passport number?" or "what's your salary?" questions after upload. Extracted values shown back to user briefly.

---

## Scenario 8 — Appointment not booked

| | |
|---|---|
| State | After Phase 4 research, profile and folder ready |
| You | (answers "No, need to book now" to the Phase 5 question) |
| Expected | Skill loads Chrome MCP via ToolSearch, opens the official booking URL, walks through centre/category/slot, **stops at the payment step**, waits for user to enter card details, captures the confirmation details after |

**Pass criteria:** Skill never enters card details. Appointment details captured into `application_status.md` after user confirms payment.

---

## Scenario 9 — Visa refused

| | |
|---|---|
| State | Application folder has `application_status.md` showing `Status: refused` |
| You | "What now?" |
| Expected | Phase 8 Branch C engages. Skill asks for the refusal letter or reason code, distinguishes documentary vs intent refusals, offers to draft an appeal letter, updates visa_history with `outcome: Refused` |

**Pass criteria:** Skill doesn't just say "sorry, try again" — gives substantive guidance per refusal reason. visa_history updated.

---

## Scenario 10 — Form is flat PDF, no online portal

| | |
|---|---|
| State | Phase 6, destination has no online portal, downloaded PDF has no AcroForm fields |
| You | (just proceeding through Phase 6) |
| Expected | Skill detects no portal (Tier 1 fails) → checks `doc.is_form_pdf` (Tier 2 fails) → renders blank PDF to PNG, uses vision to identify field positions, overlays text via pymupdf, **re-renders and visually inspects**, refines until clean (Tier 3). Only falls to Tier 4 (data sheet) if Tier 3 produces an unfixable mess |

**Pass criteria:** Each tier transition is logged. Quality verification happens at end of each tier. Tier 4 is genuinely the last resort.

---

## How to run

These are conversational tests, not automated unit tests. Each one requires:

1. Setting up the file-system state described in "State".
2. Starting a fresh Claude Code session with the skill installed at `~/.claude/skills/visa-application/`.
3. Pasting the **You** line and observing the skill's response.
4. Marking pass/fail against the **Expected** column.

For mechanical structure validation that doesn't need a live Claude session, see `tests/smoke-test.sh`.
