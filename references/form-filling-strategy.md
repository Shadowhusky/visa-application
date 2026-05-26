# Form-Filling Strategy

The single biggest source of friction in a visa application is filling the form. Government forms are often 4–6 pages of fields, some are interactive PDFs, most aren't, some are online-only portals. The skill should *do* this work, not delegate it.

## The principle

**Don't make the user fill the form by hand unless every automation path has been tried and failed.** Manual entry is the last resort, not the default.

The user already gave us their profile data once. There is no reason to ask them to type their passport number into a government form when we have it on file. The skill's job is to convert profile → filled form, not to act as a more polite version of "here's the form, you fill it".

## Strategy hierarchy

Try in this order. Stop at the first one that produces a clean, verifiable output.

### Tier 1 — Official online portal (preferred)

Many destinations now run government portals that produce a printable PDF with a 2D barcode. Use the browser MCP to fill them:

- 🇮🇹 Italy: `e-applicationvisa.esteri.it`
- 🇫🇷 France: `france-visas.gouv.fr`
- 🇩🇪 Germany: `videx.diplo.de`
- 🇳🇱 Netherlands: `schengenvisa.netherlandsworldwide.nl`
- 🇬🇧 UK: `gov.uk/standard-visitor`
- 🇺🇸 US: `ceac.state.gov` (DS-160)
- 🇨🇦 Canada: IRCC portal
- 🇦🇺 Australia: ImmiAccount

**How to execute:**

1. Load the browser MCP (`mcp__Claude_in_Chrome__*` via ToolSearch). If the user doesn't have the Chrome extension installed, briefly tell them how to install it.
2. Navigate to the portal.
3. Read the page structure with `read_page`.
4. Fill each field from `~/.claude/visa-profile.json` using `form_input`.
5. Take a screenshot after each page so the user can spot issues.
6. At the end, click the portal's "Print" / "Submit" button — most portals download a PDF with a 2D barcode.
7. Copy that PDF into the application folder.

**Why this is best:** the officer's scanner reads the 2D barcode and auto-populates their internal system. No transcription errors. Same source of truth on both sides.

### Tier 2 — Interactive PDF form (AcroForm fields)

If no online portal exists, check whether the official PDF form has real form fields (AcroForm). About a third of country forms do.

```python
import fitz  # pymupdf
doc = fitz.open("application-form.pdf")
print("Has form fields:", doc.is_form_pdf)
for page in doc:
    for w in page.widgets():
        print(w.field_name, w.field_type_string, w.rect)
```

If `is_form_pdf` is True, fill the named fields directly:

```python
for page in doc:
    for w in page.widgets():
        if w.field_name in mapping:
            w.field_value = mapping[w.field_name]
            w.update()
doc.save("filled.pdf")
```

This produces a perfect PDF — text aligned to field boxes by the document itself, no manual coordinate math.

### Tier 3 — Vision-driven coordinate overlay (flat PDFs)

If the PDF is flat (no form fields, no portal), the agent itself is the smart filler. Use this loop:

1. Render the blank form page-by-page to PNG at high DPI (~200) using pymupdf.
2. Open each PNG with the Read tool — Claude's vision can see field labels and underlines.
3. For each field, identify where the answer should go (immediately to the right of the colon, or on the next line below the label, or on the dotted line, etc.). Read off approximate coordinates from the rendered page.
4. Use pymupdf to overlay text at those coordinates onto a copy of the PDF.
5. **Re-render and verify.** Compare the filled output to the blank — does any text overlap a label or the next field? If yes, adjust coordinates and try again. Stop when the output looks clean.

```python
import fitz
doc = fitz.open("blank-form.pdf")
page = doc[0]
# Example: surname goes 145pt right of left margin, 240pt down from page top
page.insert_text((145, 240), "LIAO", fontsize=9, fontname="helv")
doc.save("filled.pdf")
```

**Key:** *always re-render after filling and visually inspect.* Coordinate guesses get refined by looking at the result, not by hoping the first attempt was right.

### Tier 4 — Data sheet fallback (rare)

Only when Tiers 1–3 all fail (which should be very rare):

Generate `application_form_data.html` (+ PDF via `render-pdf.sh`) from `templates/form-data.html` — a styled table with every field name and the value to copy in. Hand the user the blank printed form plus this sheet, and they transcribe. This is a last resort because the user typing 80 fields from a sheet is exactly the friction this skill exists to remove.

## Quality verification — every tier

After filling, *before* declaring the form ready, the agent re-opens the output and:

1. Renders the filled pages to PNG.
2. Visually inspects each page for: text overlap, missing fields, wrong placement, illegible output.
3. If anything looks off, drops back to the next-best tier or refines the coordinates.

If the agent has produced an offset / overlapping / messy PDF, it is **not** finished. Either fix the coordinates or fall through to the browser-portal tier even if it means asking the user to install the Chrome extension.

## When to escalate to the user

Only in these specific cases:

- **The portal requires payment.** The user pays. The skill never enters card details.
- **The portal requires a CAPTCHA or biometric prompt.** The user solves it; the skill waits.
- **A field has a value the profile doesn't cover** (e.g., "are you in possession of any weapons?"). Ask once, save the answer to the profile under a free-form `additional_declarations` field for future reuse.
- **The PDF is genuinely unfillable** — encrypted, image-only scan with no machine-readable text, etc. In that case, contact the consulate; the skill can't fix a broken upstream document.

For everything else, the skill does the work.

## Library setup

Tier 2 and Tier 3 use `pymupdf`. Install once:

```bash
pip install --break-system-packages pymupdf
# or in a venv if the user prefers
```

The Chrome MCP for Tier 1 is loaded dynamically via ToolSearch — no separate install on the skill side.
