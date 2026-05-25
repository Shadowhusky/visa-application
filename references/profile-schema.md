# User Profile Schema

The reusable profile at `~/.claude/visa-profile.json`. Grow it organically — never demand fields up front the user hasn't volunteered.

## Top-level structure

```json
{
  "_meta": {
    "owner": "Full Name as on passport",
    "preferred_name": "What to call them",
    "created": "YYYY-MM-DD",
    "last_updated": "YYYY-MM-DD",
    "version": "1.0"
  },
  "identity": { … },
  "passport": { … },
  "current_residence": { … },
  "employment": { … },
  "banking": { … },
  "travel_insurance": { … },
  "contact": { … },
  "visa_history": [ … ]
}
```

## identity

```json
"identity": {
  "full_name_en": "FAMILY GIVEN",
  "full_name_local": "(optional, e.g. Chinese characters)",
  "surname": "FAMILY",
  "surname_at_birth": "Same as surname unless changed",
  "given_name": "GIVEN",
  "preferred_name": "Casual name",
  "date_of_birth": "YYYY-MM-DD",
  "sex": "Male / Female / Other",
  "place_of_birth": "City / Province",
  "country_of_birth": "Country (full English name)",
  "nationality": "Nationality (single string, e.g. 'Chinese')",
  "marital_status": "Single / Married / Divorced / Widowed",
  "national_id_number": "If applicable (e.g. Chinese 身份证)"
}
```

## passport

```json
"passport": {
  "type": "Ordinary / Diplomatic / Service / Other",
  "country_code": "ISO 3-letter (CHN, USA, GBR, etc.)",
  "number": "Passport number",
  "date_of_issue": "YYYY-MM-DD",
  "date_of_expiry": "YYYY-MM-DD",
  "place_of_issue": "Issuing authority / city",
  "scan_file_path": "Local path to the bio-page scan (PNG/JPG/PDF)"
}
```

## current_residence

```json
"current_residence": {
  "address_line_1": "Apt / Building / Street",
  "address_line_2": "Optional extra line",
  "city": "City",
  "postcode": "Postcode/ZIP",
  "country": "Country",
  "country_code": "ISO 3-letter",
  "phone_intl": "+CC XXX XXXXXXX",
  "phone_local": "Local format",
  "residence_status": "Citizen / Permanent Resident / Graduate Visa / Student / Skilled Worker / etc.",
  "residence_proof_type": "eVisa / BRP / National ID / etc.",
  "residence_proof_number": "Document number or eVisa share code",
  "residence_valid_until": "YYYY-MM-DD"
}
```

## employment

```json
"employment": {
  "status": "Employed / Self-employed / Student / Retired / Unemployed",
  "role": "Job title",
  "employer_name": "Company name",
  "employer_address": "Full address",
  "employer_phone": "+CC … or 'email-only'",
  "employer_email": "main@company.com",
  "employer_website": "https://…",
  "annual_salary": "65000",
  "salary_currency": "GBP / USD / EUR / etc.",
  "start_date": "YYYY-MM-DD",
  "manager_name": "Direct manager",
  "manager_email": "manager@company.com",
  "manager_title": "Title for sign-off"
}
```

## banking (for proof-of-funds, not for payments)

```json
"banking": {
  "primary_bank": "Bank name",
  "account_holder": "As registered with the bank",
  "sort_code": "If UK",
  "account_number": "Local account number (last 4 may be sufficient)",
  "iban": "If applicable",
  "bic_swift": "If applicable",
  "typical_balance_range_gbp": "e.g. '4000–6000'",
  "salary_deposit_label": "How the salary appears on statements (helps officers cross-check)"
}
```

## travel_insurance

```json
"travel_insurance": {
  "preferred_provider": "Monzo / Revolut / AXA / etc.",
  "policy_type": "Bundled with account / standalone / one-off purchase",
  "minimum_cover_gbp": "10000000",
  "how_to_get_certificate": "e.g. 'Generate from Monzo app, Help → Travel Insurance → Get certificate'"
}
```

## contact

```json
"contact": {
  "primary_email": "main@example.com",
  "secondary_email": "(optional)",
  "preferred_for_applications": "Which of the two emails to put on visa forms"
}
```

## visa_history

A growing array — every prior visa application:

```json
"visa_history": [
  {
    "country": "France",
    "type": "Schengen Tourist",
    "applied_via": "TLScontact London Wandsworth",
    "application_reference": "FRA1LO20257091222",
    "biometrics_date": "2025-04-14",
    "trip_dates": "2025-05-01 to 2025-05-06",
    "destination_detail": "Paris",
    "outcome": "Granted",
    "visa_sticker_number_if_known": "(often unknown)"
  }
]
```

Prior visa entries matter — most Schengen forms have a "previous visas in last 3 years" question, and the entries above are exactly what's needed.

## Privacy

This file contains sensitive data (passport, residence, employment, banking). Keep it local only. **Never** transmit it to a web service. If the user uses iCloud Drive or another cloud sync, the file is at their discretion — don't assume.

## Updates

After every visa application:

1. Add new `visa_history` entry.
2. Update `last_updated`.
3. If user has moved / changed jobs / renewed passport, update the relevant section. Don't mass-rewrite; surgically update only what changed.
