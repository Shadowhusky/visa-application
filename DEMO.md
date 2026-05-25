# Demo

A complete end-to-end walkthrough using a fictional persona. **All names, passport numbers, employers, and addresses below are invented for illustration** — your real session will use your actual data, stored locally only.

> **Persona:** Priya Sharma, Indian citizen, working in Manchester at a small fintech, applying for a Schengen tourist visa to France for a 7-day Paris + Lyon trip. First-time applicant — no profile exists yet.

---

## Session 1 — First application (cold start, ~45 min)

### Opening

**Priya:** I want to apply for a French tourist visa from the UK. My trip is mid-September.

**Skill:** *Using the visa-application skill — first I need to capture a few basics about your trip, then I'll research the current rules and assemble your document pack.*

Four quick questions to get started:

1. Destination cities? (e.g., Paris and Lyon)
2. Confirming origin: applying from the UK?
3. Visa type — Tourist, Business, Visit family, Study, or Work?
4. Trip dates (departure → return) and total days?

**Priya:** Paris and Lyon, yes UK, tourist, 14 September to 20 September 2026, 7 days.

---

### Phase 2 — Profile lookup

**Skill:** Searching your machine for an existing visa profile…

```
$ bash scripts/find-existing.sh profile
(no results)
```

No profile found — this is your first application through the skill. I'll build one as we go, only asking what's needed *now*. The profile gets reused on every future application, so the next visa will be much faster.

Three quick blocks of questions. Skip anything you'd rather not say yet.

**Block A — Identity (passport bio):**
- Full name as on passport, date of birth, place of birth, sex, nationality
- *Or: drop your passport bio-page scan into the chat and I'll extract it.*

**Block B — UK residence:**
- Current address, residence permit type, your share code from gov.uk

**Block C — Employment:**
- Job title, employer name, gross salary, start date

**Priya:** *[drops `passport-scan.jpg` into chat]*

**Skill:** Reading `passport-scan.jpg`… extracted:

- **Name:** SHARMA PRIYA
- **DOB:** 1994-03-22
- **Nationality:** Indian (IND)
- **Passport number:** Z7621984
- **Issued:** 2020-08-14, New Delhi
- **Expires:** 2030-08-13

Looks good — passport is valid until 2030, comfortably past your trip. Saving to profile.

For the rest, I'll just ask: **What's your UK address, residence status, and current employer?**

**Priya:** 14 Beaumont Road, Manchester M14 7BJ. Skilled Worker visa, share code H4P 2L9 KQ8, valid to August 2028. I'm a Senior Data Engineer at Northstar Fintech, started Jan 2024, £72k.

**Skill:** Profile saved. Two more bits I'll need for the cover letter and proof of funds — *can you drop in your most recent payslip and a recent bank statement?* No need for the full file if you'd rather extract values manually.

**Priya:** *[drops `payslip-August-2026.pdf` and `monzo-statement-Jun-Aug-2026.pdf`]*

**Skill:** Reading…

- **Payslip (Aug 2026):** Northstar Fintech, PAYE 123/AB12345, net £4,521.30, gross £6,000, NI number QQ123456A. Annual gross consistent with £72k claim ✓
- **Bank statement (Jun-Aug 2026):** total balance ~£11,400. Monthly salary deposits visible. Spend pattern stable ✓

Copying both into your application folder. Updating profile with banking details and NI number for future reference.

---

### Phase 3 — Application folder

**Skill:** Searching for an existing France application folder…

```
$ bash scripts/find-existing.sh folder "France"
(no results)
```

Creating new application folder at:

```
~/Documents/Visa Applications/France-2026/
```

Move your dropped documents into this folder now? *(Yes / pick a different location.)*

**Priya:** Yes, that's fine.

**Skill:** Done. Folder created with your passport scan, payslip, and bank statement. Now researching France visa requirements…

---

### Phase 4 — Research (live cross-validation)

**Skill:** Sources I'm consulting:

- 🇫🇷 **France-visas.gouv.fr** (French MFA, official portal)
- **TLScontact UK** (visa-centre operator for France in the UK)
- **Consulate General of France in London** (`consulfrance-londres.org`)
- Recent guides (Wise 2026, Schengen Visa Support) — sanity check only

*Researching… [2 min]*

Findings cross-validated against ≥2 sources:

| Requirement | Confirmed value | Cross-check |
|---|---|---|
| Visa fee | €90 (adult, 2026) | France-visas + TLS ✓ |
| Application form | Mandatory online via `france-visas.gouv.fr` | France-visas + TLS ✓ |
| Photos | 2× 35×45 mm, white background, < 6 months | Consulate + TLS ✓ |
| Insurance min | €30,000, all Schengen, full dates | France-visas + TLS ✓ |
| Fund minimum | €65/day with hotel, €120/day without | France-visas (single source — flagged) |
| Passport validity | ≥ 3 months past return, ≥ 2 blank pages | Consulate + France-visas ✓ |
| Biometrics | Required if not given in last 59 months | France-visas + EU ✓ |
| Processing | 15 working days at consulate (longer in summer) | TLS ✓ |
| Centre address | TLScontact, 18 Ryeland Blvd, Wandsworth, London SW18 1UN | TLS website ✓ |

Recent changes worth noting:
- **EES live since Oct 2025** — your first crossing into France will involve a brief biometric scan at the border, replacing the passport stamp.
- **France-visas portal mandatory** — no paper applications accepted; we'll need to fill the portal together.

Saving research summary to `France-2026/research-summary.md`.

---

### Phase 5 — Document generation

**Skill:** Generating your document pack.

**1. Cover letter** — drafting and rendering to PDF…

```bash
$ bash scripts/render-pdf.sh templates/cover-letter.html /tmp/cover.html "France-2026/Cover Letter.pdf"
Wrote: France-2026/Cover Letter.pdf
```

The letter states: 7-day leisure trip Paris + Lyon, dates, self-funded, employer named, return commitment, accommodation booked. **You'll sign this with a pen before submission.**

**2. Employment letter draft** — Northstar Fintech letterhead, signature space, content:

> *To Whom It May Concern,*
>
> *I am writing to confirm that Priya Sharma is employed by Northstar Fintech as a Senior Data Engineer, having joined on 8 January 2024. She remains in active full-time employment with us and is in good standing.*
>
> *I confirm that her request for paid annual leave from 14 September 2026 to 20 September 2026 (inclusive) has been approved. She is expected back at work on 21 September 2026, and her position will be held open during her absence.*

The salary line is **optional** — I left it out by default since some applicants prefer not to share comp with their manager. Add it back if you want; the consulate will see your salary on the payslips anyway.

*[draft saved to `France-2026/Employment Letter (draft).pdf`]*

Send this to your manager / HR. They print on company letterhead, sign with a pen, scan, and send back. Save the signed version as `Employment Letter - Signed.pdf` in the application folder.

**3. Application form** — the France-visas portal is mandatory and creates the appointment with TLScontact in the same flow.

I'll walk you through it field by field. Open `france-visas.gouv.fr` and click "Start your visa application". I'll read each page with you. *[browser automation begins; skill fills fields from profile, takes screenshots after each page so you can verify; at the end, the portal generates a printable form with a 2D barcode and your TLS appointment receipt]*

**4. Day-by-day itinerary** — not strictly required for France, but I'll draft one (consulates like it):

| Day | Date | City | Accommodation | Main activity |
|---|---|---|---|---|
| 1 | Mon 14 Sep | Paris | Hôtel du Marais | Arrive CDG; Louvre district |
| 2 | Tue 15 Sep | Paris | Hôtel du Marais | Versailles day-trip |
| 3 | Wed 16 Sep | Paris | Hôtel du Marais | Musée d'Orsay, Seine cruise |
| 4 | Thu 17 Sep | Paris → Lyon | TGV midday; Hôtel Le Royal | Arrive Lyon; Vieux Lyon walk |
| 5 | Fri 18 Sep | Lyon | Hôtel Le Royal | Croix-Rousse, food district |
| 6 | Sat 19 Sep | Lyon | Hôtel Le Royal | Parc de la Tête d'Or; museums |
| 7 | Sun 20 Sep | Lyon → London | Return TGV + flight from CDG | Depart |

**5. Checklist PDF (00 - CHECKLIST.pdf)** — one-page Print Pack cover sheet, listing appointment details, before-leaving-home tick list, the numbered stack order, likely officer questions, and the cross-checks I've already verified.

---

### Phase 6 — Cross-checks + final report

**Skill:**

✅ **Compliant out of the box (10 items):**

- Passport valid until 13/08/2030 — 3+ years past trip
- UK Skilled Worker visa valid to Aug 2028 — covers trip dates
- Insurance you've quoted (€50k via account perk) > €30k minimum
- Both hotels (Paris + Lyon) cover all 6 nights — *flagged inconsistency, see below*
- Eurostar return + TGV Paris→Lyon → CDG flight all booked
- 3 recent payslips uploaded
- Recent bank statement uploaded
- Balance £11,400 ≈ €13,300 — well above €65/day × 7 = €455 minimum
- Cover letter + draft employment letter generated
- Application form filled via France-visas portal + TLS appointment booked

❌ **Action items before 14 September:**

1. **Get employment letter signed** by your manager (4–5 day buffer recommended).
2. **2 biometric passport photos** (35×45 mm, white bg, < 6 months) — Snappy Snaps or station booth, ~£10.
3. **Print everything** in `France-2026/Print Pack/`, single-sided A4.
4. **Sign**: application form last page, cover letter at bottom.

⚠️ **Inconsistency I caught:**

Your **Lyon hotel checkout is 20 Sep at 11:00** but your **TGV back to Paris CDG is 19 Sep at 21:30** — you'd be checking out a day after you've already left the city. Probably a booking-site default. Email the hotel to either:
  - Cancel the night of 19 Sep (refund), or
  - Confirm late check-out / luggage storage if you're leaving early on the 20th.

Resolve before the appointment — officers spot this kind of thing.

📦 **At the TLScontact appointment:**

- €90 visa fee + €33.33 TLS service fee, paid online before the appointment (you've already done this through the portal)
- Original passport
- 2 photos (loose)
- Full printed pack in numbered order
- Phone with digital backups of insurance + hotel confirmations

🗃️ **Profile saved** at `~/.claude/visa-profile.json` — next application reuses everything except the trip itself.

---

## Session 2 — Three months later, second application (~10 min)

**Priya:** I'm thinking of going to Japan for cherry blossom season. Can you help me apply for a Japanese tourist visa?

**Skill:** *Using the visa-application skill.* Profile found at `~/.claude/visa-profile.json` (last updated 2026-09-22). I have:

- Priya Sharma, Indian passport Z7621984 (valid 2030)
- Manchester address, Skilled Worker visa
- Northstar Fintech, Senior Data Engineer, £72k
- Previous Schengen visa: France 2026-09-14 to 2026-09-20, granted

Anything changed since September?

**Priya:** No, all the same.

**Skill:** Quick trip details:

1. Destination cities in Japan? (e.g., Tokyo, Kyoto)
2. Trip dates?
3. Approximate budget — does Japan want proof of funds? Let me research…

**Priya:** Tokyo and Kyoto, 28 March to 5 April 2027, 9 days.

**Skill:** Researching Japan tourist visa requirements for Indian passport holders applying from the UK…

*[2 min of cross-validation against the Embassy of Japan in the UK + VFS Japan + recent guides]*

Note: India is **not** part of Japan's visa-waiver list, so a visa is required (you'll need it; British passport holders don't, but yours is Indian).

Document list (cross-validated, much shorter than Schengen):

1. Application form — Embassy of Japan UK PDF, I'll fill from profile
2. Passport + photocopy ✓ (already on file)
3. 1 passport photo (45×45 mm — different size from Schengen) — get a fresh one
4. Itinerary in Japan — day-by-day with hotels per night
5. Flight reservation
6. Bank statement (last 3 months)
7. Cover letter
8. Visa fee ~£20–24 single-entry, paid at submission

That's the whole list. Generating documents now…

*[same workflow as Session 1, but skipping the profile-build phase entirely; total time: about 10 minutes]*

---

That's the loop. **First application: 45 minutes start-to-finish. Every application after that: ~10–15 minutes** plus whatever time you need to upload trip-specific documents (flights, hotels, itinerary).
