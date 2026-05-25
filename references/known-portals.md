# Known Online Application Portals + Country Quirks

Updated 2026-05. **Verify** before relying on any URL — portals move.

## Online application portals

| Destination | Portal | Notes |
|---|---|---|
| **Italy** (Schengen + national) | `https://e-applicationvisa.esteri.it/` | Generates a printable form with 2D barcode. Goes fully mandatory 1 Jun 2026. Output accepted at all VFS Italy centres worldwide. |
| **France** (Schengen + national) | `https://france-visas.gouv.fr/` | Mandatory. End-to-end online application with fee payment, then in-person at TLScontact. |
| **Germany** (Schengen) | `https://videx.diplo.de/` | VIDEX portal. Output is a PDF you print and sign. |
| **Spain** (Schengen) | Spanish consulates use BLS in most countries; each consulate publishes its own form. No nationwide portal yet. |
| **Netherlands** (Schengen) | `https://schengenvisa.netherlandsworldwide.nl/` | Online application with appointment booking integrated. |
| **United States** | `https://ceac.state.gov/ceac/` (DS-160 for nonimmigrant) | Generates confirmation page with barcode — print this to bring to interview. |
| **United Kingdom** (visitor and most categories) | `https://www.gov.uk/standard-visitor` | Full online application, biometric appointment booked through UKVCAS / VFS. |
| **Canada** | `https://www.canada.ca/en/immigration-refugees-citizenship/services/visit-canada.html` | IRCC online portal. eTA for visa-exempt; TRV for others. |
| **Australia** | `https://immi.homeaffairs.gov.au/` | ImmiAccount portal. Most categories online-only. |
| **Japan** | Tokyo MOFA → consulate-specific. Some consulates still paper-only. | |
| **China** | `https://avas.mfa.gov.cn/` (COVA online application) | Then book at CVASC centre. |

## Common visa-centre operators

| Operator | Destinations they handle (examples) | URL pattern |
|---|---|---|
| **VFS Global** | Italy, UK, Germany, Spain, Australia, Saudi Arabia, India, South Africa, many more | `visa.vfsglobal.com/{country-code}/{lang}/{destination}` |
| **TLScontact** | France, China (from UK), Sweden, Switzerland (some routes) | `{destination-cc}.tlscontact.com` |
| **BLS International** | Spain (most countries), Portugal, India | `blsinternational.com` |
| **VFS Tasheel** | UAE | `vfstasheel.com` |
| **CGI Federal** | US (some countries) | `ustraveldocs.com` |

## Country-specific quirks worth knowing

### Italy
- **Field 7 "Nationality at birth, if different"** on the e-application portal incorrectly forces a value even when same as current nationality. Enter the user's birth nationality (most often same as current); officers are familiar with this quirk.
- **Field 11 National identity number** has a max-length under 18 digits — Chinese national IDs (18 digits) get rejected. The field is "where applicable" — leave blank.
- **Field 31 Hotel/inviter** allows only ONE entry. For multi-city trips, enter the primary hotel; supporting bookings for other cities go in the document pack as separate PDFs.
- **Biometric reuse** — fingerprints captured for any Schengen visa within the prior 59 months are reused; the applicant still attends to submit docs but doesn't redo fingerprints.

### France
- TLScontact handles UK lodgement at Wandsworth.
- The France-visas portal is genuinely end-to-end: pay online, then a short in-person submission of docs and biometrics.
- Children under 12 are usually exempt from fingerprinting.

### UK
- **Physical BRP is being phased out**. As of late 2024 onward most categories migrate to eVisa accounts at gov.uk. For non-UK consulates asking for "UK residence permit", give the user's **share code printout** plus the **"View your immigration status" PDF** from `view-immigration-status.service.gov.uk`. Do *not* attach an outdated physical BRP — it confuses officers.

### US (B1/B2)
- **DS-160 is per-applicant, single-use, and one-shot final.** Once submitted, you can't edit — only start over.
- **Photo must meet strict ICAO spec.** Reject anything that doesn't pass the State Department's online photo checker.
- The **interview** is where supporting docs are reviewed, not before. Bring everything — officers may or may not ask.

### China
- Always carries a politically-sensitive question: prior travel to certain countries may add scrutiny. Honest answers are required, but be brief.
- "Invitation letter" requirements have tightened post-2023 — verify with the relevant CVASC office.

### Japan
- Cover letter ("schedule of stay") in Japan is standard practice and often required by name. A day-by-day itinerary with hotels filled in is what they want.

## Visa centres in London (for UK-based applicants)

| Destination | Centre | Address |
|---|---|---|
| Italy | VFS Italy | Ground Floor, 8-20 Pocock St, London SE1 0BW |
| France | TLScontact France | 18 Ryeland Boulevard (Ram Quarter), Wandsworth, London SW18 1UN |
| Germany | VFS Germany | 66 Wilson St, London EC2A 2BT |
| Spain | BLS Spain | 27 Old Gloucester St, London WC1N 3AX |
| US Embassy | US Embassy London | 33 Nine Elms Lane, London SW11 7US (consular) |
| UK Home Office (UKVCAS) | Many centres across London | book via gov.uk |
| China | CVASC London | 18 Ryeland Boulevard, Wandsworth (shared building with TLS) |

(Verify before sending the user — these move occasionally.)
