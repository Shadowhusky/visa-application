# Demo

A fictional but representative end-to-end run. Real session, slightly compressed for readability.

---

**You:** I want to apply for a Schengen visa to Italy from the UK. My VFS appointment is in 3 days.

**Skill:** *Using the visa-application skill — first I need to capture a few basics about your trip, then I'll research the current rules and assemble your document pack.*

Four quick questions:

1. Destination — which cities?
2. Confirming origin: UK / London?
3. Visa type — Tourist, Business, Study, or Work?
4. Trip dates (departure → return) and how many days total?

**You:** Rome and Milan. Yes UK. Tourist. 22 June to 26 June 2026 — 5 days.

---

**Skill:** Searching your machine for an existing profile…

Found one at `~/Library/Mobile Documents/com~apple~CloudDocs/Travel/Italy/personal_profile.json` (last updated 2026-05-24). Copying it to the canonical location at `~/.claude/visa-profile.json` so future applications can find it too.

You're **Yuxuan Liao**, Chinese passport `EJ3963586` valid until 18 May 2030, employed at **Thema AI** as a Frontend Engineer on a UK Graduate Route eVisa. Anything changed since last week?

**You:** No, all current.

---

**Skill:** Searching for an existing Italy application folder…

Found one at `iCloud/Travel/Italy/` containing flights, hotel bookings, payslips, and a bank statement. I'll use this as the application folder rather than create a new one.

Researching current Italy Schengen tourist visa requirements for UK applicants. Sources I'll cross-check:

- Italian Consulate London (`conslondra.esteri.it`)
- VFS Italy London (`visa.vfsglobal.com/gbr/en/ita`)
- Italian MFA (`esteri.it`)
- Wise 2026 guide (sanity check)

Researching… *[3 minutes pass]*

---

**Skill:** Research summary written to `Italy-2026/research-summary.md`. Headline findings, all cross-validated:

| Requirement | Verified value | Source |
|---|---|---|
| Visa fee | €90 (adult), paid at VFS | Consulate + VFS, agree |
| Photo spec | 35×45 mm, white background, < 6 months old | Consulate + VFS, agree |
| Insurance minimum | €30,000 cover, all Schengen states | Consulate + Wise, agree |
| Fund minimum | €269.60 for 1–5 day trip | MFA, single source — flagged |
| Passport validity | ≥ 3 months past return | Consulate |
| Application form | E-application portal preferred; standalone PDF also accepted | Both sources |
| Biometrics | Reused if given < 59 months ago | Consulate + EU regulation |
| Processing | 5–15 working days at the consulate | VFS |

Recent changes you should know about:
- **EES live at the Schengen border since Oct 2025.** First crossing at Rome Ciampino takes a biometric capture instead of a passport stamp.
- **Italy fully digital from 1 Jun 2026** — your 27 May appointment is on the legacy paper track.
- **You gave fingerprints 14 Apr 2025 for the France visa** — within the 59-month reuse window, so VFS won't recapture.

Cross-checks against your profile:

✅ Passport valid until 18/05/2030 — 4+ years past return
✅ Insurance £10M cover (Monzo/Zurich), 22–27 Jun — beats the €30k bar by 333×
✅ Bank balance ~£5,917 — 25× the €269.60 minimum
✅ Last 3 months payslips already in folder
⚠️ Cover letter present but dated "22 to 27 June" — should be "22 to 26 June" (return flight lands 26th)
⚠️ Hotel bookings show 2 adults but you're travelling solo — officer may ask
❌ Employment letter not yet present — needed, must be ≤ 30 days old

---

**Skill:** Generating documents…

- `Italy-2026/Cover Letter.pdf` — regenerated with corrected dates, train-travel sentence added for the Rome→Milan gap
- `Italy-2026/Employment Letter (for Pedro to sign).pdf` — draft on Thema AI letterhead, signature space, salary line omitted per your previous preference
- `Italy-2026/Visa-application-form-FILLED.pdf` — generated via `e-applicationvisa.esteri.it` portal, all fields populated from profile, 2D barcode on page 6, signature pending
- `Italy-2026/Print Pack/00 - CHECKLIST.pdf` — one-page summary, includes stack order, signature reminders, likely officer questions and how to answer them

Assembling Print Pack… 16 documents copied with numbered prefixes in officer order. Folder ready at `Italy-2026/Print Pack/`.

---

**Skill:** Final report:

✅ **Compliant out of the box:** passport validity, insurance cover, financial means, accommodation across all 4 nights, round-trip flights, 3-month bank statement, 3 payslips, UK eVisa status proof, cover letter, application form.

❌ **Still needed before Wed 27 May 09:30:**
1. Employment letter signed by Pedro (Slack draft ready in `messages/`)
2. 2 biometric photos (Snappy Snaps, Timpson, station booth — ~£10)
3. Print everything in `Print Pack/`, sign file 02 page 5 and file 03 bottom

⚠️ **At the appointment:**
- Card preferred for €90 visa fee, cash backup
- Officer scans the 2D barcode on file 02 → your data auto-populates their system
- If asked about Milan hotel (form only allows one inviter): point to file 11
- If asked about 2 guests on hotel bookings: "Travelling alone — booked as a double room"

Updating `~/.claude/visa-profile.json` with this application as `visa_history[2]` so the next Schengen application can answer "previous visas in last 3 years" automatically.

---

That's the full loop. From "I want a Schengen visa" to "print and walk in" in a single session.
