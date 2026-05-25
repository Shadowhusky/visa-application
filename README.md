<p align="center">
  <img src="assets/banner.png" alt="visa-application banner" />
</p>

A Claude Code skill that takes you from *"I need a visa"* to a printed, officer-ready document pack.

## Why

Visa rules drift every quarter. Half the third-party guides recycle 2019 information. The consulate site is two clicks deep and three years stale. Miss one document and you wait another month for a new appointment.

This skill keeps the rules current and the paperwork tidy. You handle what only you can — flights, photos, signing things. It handles the rest.

## Demo

```
You:    I need a Schengen visa to Italy from the UK. Trip 22-26 June.

Skill:  Four quick questions… [you answer]
        No profile yet — drop in your passport, payslip, and a bank
        statement. Or type the values if you prefer.

You:    [drops 3 files]

Skill:  Read them. Profile saved.
        Researching Italy visa from UK against the Italian consulate
        page, VFS Italy London, and the MFA portal…
        Cross-validated: €90 fee, €30k insurance, 35×45mm photo,
        EES live at the border since Oct 2025.

        Generating cover letter, employment letter draft for your
        manager, application form via e-applicationvisa.esteri.it
        (with 2D barcode), and a one-page checklist.

        One issue caught: your hotel checkout is dated a day after your
        return flight. Email the hotel before submitting.

You:    [signs, prints, walks in]
```

**First visa: ~45 minutes. Every visa after: ~10 minutes.**

## What you get

- A reusable profile at `~/.claude/visa-profile.json` — passport, address, employer, banking. Built once, replayed forever.
- A document pack — cover letter, employment letter draft, filled application form, checklist PDF. The skill fills the form itself: via the destination's online portal where one exists (with 2D barcode), directly into the PDF for interactive forms, or vision-aligned overlay for flat PDFs — manual transcription only as a last resort.
- A numbered Print Pack folder in officer flip-order. Print A4, sign, walk in.

## Install

```bash
git clone https://github.com/Shadowhusky/visa-application.git ~/.claude/skills/visa-application
```

Then in any Claude Code session, just mention a visa. The skill takes over.

## Coverage

Schengen (all 27), US B1/B2, UK Visitor, Japan, Canada, China, Australia — any country with a documented visa process. The skill researches whichever destination you name.

## Not for

Asylum, family reunification, or anything that wants a real visa lawyer. Payments are always on you — the skill never enters card details.

## Privacy

Profile is local only, never transmitted. Application folders default to `~/Documents/Visa Applications/{Country}-{Year}/`.

## License

MIT.
