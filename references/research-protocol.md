# Research Protocol

How to find current, accurate visa requirements without getting fooled by stale or wrong sources.

## The source hierarchy

In order of trustworthiness:

1. **Destination consulate page in the user's origin country** — e.g., `conslondra.esteri.it` for Italy from UK, `uk.china-embassy.gov.cn` for China from UK, `usembassy.gov` for US from any country. This is the most authoritative; the consulate is the one issuing the visa.

2. **Visa-centre operator's per-country page** — e.g., `visa.vfsglobal.com/{country}/{origin}/`, `tlscontact.com/{country}/{origin}/`. They publish the document checklist they actually use at intake. Authoritative for procedural specifics (appointment, fees, accepted formats).

3. **Destination country's foreign ministry visa portal** — e.g., `esteri.it` (Italy MFA), `France-visas.gouv.fr`, `travel.state.gov` (US), `gov.uk/standard-visitor` (UK). Authoritative for rules but sometimes lags consulate-specific implementation.

4. **Recent third-party visa guides (2026)** — Wise, Schengen Visa Support, Visard, AXA Schengen, IATA Timatic. Use as a cross-check, never as the primary source. The good ones cite their primary sources; the bad ones recycle 2019 information.

5. **Reddit / forums / blog posts** — Last resort. Useful for "what was the officer actually like at this centre?" anecdotes. Useless for current rules.

## Mandatory cross-validation

For every claim you put in front of the user, you need **two independent sources agreeing**. If they don't, surface the disagreement.

Material claims to cross-validate:

- Visa fee (in destination currency AND payment method)
- Photo specifications (size, background, age)
- Insurance minimum coverage
- Funds-on-account minimum
- Passport validity rule (3 or 6 months past return; how many blank pages)
- Required documents list
- Biometrics rules (always required, or reused from a previous visa within N months)
- Processing time
- Application form (online portal mandatory, optional, or paper-only)
- Whether the user can submit by post, or must attend in person

## Date sanity

**Always check the published / updated date** of every source. Treat anything older than 18 months as suspicious; anything older than 3 years as wrong-by-default.

Specific watch-outs that may affect rules **today**:
- **EES (EU Entry/Exit System)** — live since 12 Oct 2025 across the Schengen area. First crossing captures biometrics at the border instead of stamping. Affects user experience at arrival, not the visa application itself.
- **ETIAS (EU Travel Information and Authorisation System)** — visa-free nationals will need ETIAS authorisation for Schengen. Phased rollout late 2026 onward. Doesn't apply to visa-required nationals (they already need a visa), but verify the user's situation.
- **Italy digital visa portal** — fully online for new applications from 1 Jun 2026. Applicants before that date are on the legacy paper track.
- **UK eVisa transition** — UK has been retiring physical BRPs (Biometric Residence Permits) for eVisa accounts at gov.uk since 2024. UK residents proving status to other countries' consulates should use a "share code" (gov.uk/view-and-prove-your-immigration-status) or the "View your immigration status" PDF, not an old BRP.
- **US visa interview waiver** — eligibility criteria for the dropbox / interview waiver have tightened multiple times. Check current rules.

## How to search

A useful query pattern:

```
"{destination} consulate {origin city} {visa type} visa requirements"
"VFS {destination} {origin} checklist"
"{destination} Schengen visa from {origin} 2026"   ← include year, force-current
```

For online portals:
```
"{destination} online visa application form" site:gov.{cc}
"{destination} e-application visa"
```

When fetching consulate pages, the **publication or "last updated" date** is usually at the top or bottom. Capture it; if it's > 1 year stale, double-check against the visa-centre operator.

## Recording what you found

When you finish research, write a brief summary to `{application-folder}/research-summary.md`:

```markdown
# Research summary — {destination} visa from {origin}

Researched: {today's date}

## Sources consulted
- [Consulate page]({url}) — last updated {date}
- [VFS operator]({url}) — last updated {date}
- [Third-party guide]({url}) — published {date}

## Confirmed requirements
- Visa fee: €XX (cross-checked against {N} sources)
- Photo: 35x45mm, white background, < 6 months old
- ...

## Items where sources disagreed
- Processing time: consulate says 5-15 days; VFS says up to 45 days. Going with the longer figure to be safe.
- ...

## Recent changes the user should know about
- ...
```

This file becomes useful if the same skill is invoked again later — and it lets the user verify what you based your recommendations on.

## The trust calibration

If you can't find an official source for a specific claim — **say so**. Do not invent a value. Tell the user "I couldn't find a definitive figure for X on the consulate site; the most cited number in third-party guides is Y, but I'd recommend confirming by email to {consulate email} before relying on it."
