# Visa Scenarios

The default workflow assumes a first-time tourist applicant. Real life is messier. This file lists less-common scenarios the skill should recognise and adapt to.

## 1. Renewal vs. first-time

**Signal:** the user mentions "my visa is expiring" or "I want to renew" or "I had a Schengen visa last year".

**Adjustments:**
- The application form is usually the same; what changes is supporting evidence.
- Prior visa entries from the profile's `visa_history` answer the "previous visas in last 3 years" question on Schengen forms automatically.
- Some countries (US) treat renewal applications under the same visa class within a recent window as eligible for the **interview waiver / dropbox** programme — confirm current eligibility online; it tightens periodically.
- Skip biometric re-capture for Schengen if last enrolment was < 59 months ago.

## 2. Family applications (spouse, children, parents)

**Signal:** "we", "my wife and I", "with my kids".

**Adjustments:**
- One application *per person*, even infants. Each gets a profile (or sub-profile).
- Children need both parents' passport copies and consent letter if travelling without one parent.
- Marriage certificates required for spouse, translated and (sometimes) apostilled.
- Fund minimum is per-person × number of travellers.
- Some consulates accept a single appointment for the whole family; others require separate slots — check.

## 3. Business / conference travel

**Signal:** "business meeting", "conference", "client visit", "B1" (US).

**Adjustments:**
- **Invitation letter from the host company** in the destination becomes the keystone document — far more important than for tourist applications.
- Cover letter mentions the *purpose* (meeting, training, conference) and that the trip is paid for by the user's employer or host.
- Employment letter must explicitly confirm the trip is work-related and that the user will return.
- For some routes (US B1, Schengen), pack a conference agenda or meeting schedule.

## 4. Transit visas (Type A and Type C transit)

**Signal:** the user is changing planes in a country and stays airside <24 hours.

**Adjustments:**
- Most nationalities don't need a Schengen transit visa if they stay airside, but a handful do (Type A — check current list).
- For Type C tourist visas where the user is *only transiting*, the document set is lighter (no hotel, no insurance for the destination itself — only the transit point).
- Check both the destination consulate AND the layover country's transit rules.

## 5. Long-stay (Type D, national visas)

**Signal:** stays > 90 days, study, work, family reunification, residency.

**Adjustments:**
- This is *not* a Schengen visa — it's a national long-stay visa, country-specific rules.
- Documents needed expand significantly: university admission letter, employer sponsorship docs, health checks, criminal record certificates, accommodation contract for longer than 3 months.
- Processing takes 1–3 months typically.
- The skill can scaffold this but **strongly recommend the user engage a specialist for complex national visas**.

## 6. Student visas

**Signal:** "I'm going to study", "Master's at", "exchange semester".

**Adjustments:**
- Acceptance letter from the institution is the keystone.
- Proof of funds requirement is much higher (often €10,000+ for a year).
- Health insurance requirement may exceed €30k (some countries want €50k or €100k for students).
- Need proof of accommodation for the whole academic year, not just a few nights.

## 7. Working holiday / youth mobility

**Signal:** "Working Holiday Visa", "Tier 5 / Youth Mobility" (UK), "WHV" (AUS/NZ).

**Adjustments:**
- Age-gated (usually 18–30 or 18–35).
- Often quota-based and oversubscribed — apply on quota open day.
- Documents lighter (no employer letter required), but proof of funds and return flight reservation usually mandatory.

## 8. Refugee travel documents / stateless travel

**Signal:** "I'm a refugee", "Geneva Convention travel document", "stateless".

**Adjustments:**
- The "passport" field on Schengen forms accepts these documents but uses different codes.
- Some destinations require an additional Schengen visa even when the traveller is exempt with their national passport.
- These applications are sensitive — be helpful but explicit that complex cases benefit from a real visa lawyer or NGO support.

## 9. Express / priority processing

Many consulates offer paid priority routes (1–3 days vs. 15–45 days). If the user's appointment is close to the trip date:

- US: there's no priority within visa-required nationalities — only emergency appointments by request.
- UK Visitor: Priority (£500) and Super Priority (£1000) services for the visa decision.
- Schengen: most consulates don't offer priority for the visa decision itself, but VFS centres offer "Prime Time" / "Premium Lounge" slots (~£50–£100 for a faster appointment, not a faster decision).

Surface these options to the user with cost and decision-time impact. Don't auto-book; let them choose.

## 10. Multi-country Schengen itineraries

**Signal:** the user is visiting 3+ Schengen countries on one trip.

**Adjustments:**
- The application goes to the consulate of the **main destination** (where the user spends the most days) — not the first country of entry.
- If days are equal, the country of *first entry* applies.
- This matters because consulates of different Schengen countries have different processing reputations and document expectations.

## 11. Re-application after a refusal

**Signal:** the user says *"I was refused last time"*, *"my application was rejected"*, or the profile's `visa_history` shows a refused entry for the same destination.

**Adjustments:**

- **Read the previous refusal letter first.** Schengen refusal letters list reasons by code (1–9 typically). The reason determines whether re-applying makes sense.
- **Documentary refusals** (codes around: insufficient proof of funds, unclear purpose, missing supporting documents) → a re-application with a substantively stronger file usually has a real chance.
- **Intent refusals** (insufficient ties to home country, doubt about intent to return) → re-applying immediately is rarely productive. Address the underlying concern (employment continuity, property, family ties) over a few months before re-applying.
- **The application form's "previous refusals" question must be answered honestly.** Lying about prior refusals → permanent ban. Always disclose.
- **Add a paragraph to the new cover letter** acknowledging the prior refusal and explaining what's changed since (new employment, longer banking history, additional ties). Don't bury it.
- **Some consulates require a longer gap** between refusal and re-application — verify in research.

The visa_history entry from Phase 8 Branch C should already have the refusal reason captured — use it.

## 12. Visa-free travel that still requires authorisation (ETIAS, eTA, ESTA)

**Signal:** the user's nationality is visa-free for the destination but mentions "ETIAS", "ESTA", "eTA", "K-ETA", or similar.

**Adjustments:**
- These are *travel authorisations*, not visas — much lighter process, online only, no biometrics.
- Application fee is small (€7–€20).
- The skill can still help — generate a cover letter for the border officer (rare but useful) and a one-page summary of approval status.
- Confirm whether the user's specific nationality is actually visa-free for that destination this quarter; rules change.

---

## How the skill should adapt

Each scenario above should change the Phase 4 research questions and the Phase 5 document list. When the skill recognises a scenario (from user phrasing in Phase 1, or from the visa type chosen), explicitly note it:

> *"This looks like a business visit, not standard tourism. I'll research the invitation-letter requirements for {country} and adjust the document list accordingly — you'll need a host invitation letter on top of the tourist baseline."*

That early signal lets the user correct the categorisation if you got it wrong, before you've generated the wrong document pack.
