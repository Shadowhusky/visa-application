<p align="center">
  <img src="assets/banner.png" alt="visa-application" />
</p>

<p align="center"><sub><em>icon &amp; banner are placeholders — regenerate with the prompts in <a href="assets/PROMPTS.md">assets/PROMPTS.md</a></em></sub></p>

A Claude Code skill that takes you from "I need a visa" to a printed, officer-ready document pack — without you spending a week reading consulate websites that contradict each other.

## What it solves

Visa applications are fiddly. The rules drift quarterly, half the third-party guides on Google are recycling 2019 information, the consulate site is two clicks deep and three years stale, and forgetting one document means a wasted appointment slot and another month of waiting. This skill standardises the workflow so the time you spend is on the things only you can do — booking flights, signing letters, getting biometric photos — instead of cross-referencing four sites trying to figure out what €120/day actually means for a 5-day trip.

## Features

- **Four-question kickoff.** Destination, origin country, visa type, dates. That's it before research starts.
- **Reusable user profile.** Identity, passport, employer, banking, prior visas — captured once at `~/.claude/visa-profile.json`, replayed for every future application.
- **Searches before it creates.** Looks for an existing profile and an existing application folder on your machine before assuming you need new ones.
- **Research cross-validated against ≥2 sources** every time. Consulate page first, visa-centre operator second, recent guides as sanity check. Source disagreements get surfaced, not papered over.
- **Generates the document pack** — cover letter PDF, employment letter draft for your manager to sign, application form (via the destination's online portal where one exists, including 2D-barcode output), and a one-page checklist PDF.
- **Numbered Print Pack folder.** Officer-flip order, clear filenames, ready to print on A4 and walk in.
- **Knows the gotchas.** EES at the Schengen border, UK eVisas replacing BRPs, biometric 59-month reuse, Italy going digital on 1 June 2026, hotel bookings showing two guests when you're solo — all the small things that derail real applications.

## Demo

See [`DEMO.md`](DEMO.md) for an end-to-end walkthrough. A condensed version:

```
You:   I want to apply for a Schengen visa to Italy from the UK.

Skill: Using the visa-application skill. Four quick questions:
       1. Destination cities? (e.g. Rome, Florence)
       2. Confirm origin: UK?
       3. Visa type — Tourist?
       4. Trip dates and total days?

You:   Rome and Milan, yes UK, tourist, 22-26 June 2026.

Skill: Found an existing profile at ~/.claude/visa-profile.json
       (last updated 2026-04-12). Anything changed since then?
       … researching VFS Italy London + Italian Consulate London …
       … cross-checking against Italian MFA portal + Wise 2026 guide …

       Required documents (cross-validated):
       ✓ Passport (valid until 18/05/2030 — pass)
       ✓ 2 biometric photos 35×45 mm
       ✓ Travel insurance ≥ €30,000 (you have £10M via Monzo — pass)
       ✗ Employment letter from current manager (TODO)
       ✗ Cover letter (will generate)
       ✓ Round-trip flights confirmed
       ✓ Hotel bookings for all nights
       ✓ 3-month bank statement + 3 payslips
       ✓ UK eVisa status proof (you're on Graduate Route, valid to 15/12/2027)

       Visa fee €90 paid at VFS. €269.60 fund minimum for 5-day trip —
       your bank balance of £5,917 is 25× this.

       Creating: ~/Documents/Visa Applications/Italy-2026/
       Generating: Cover Letter.pdf, Employment Letter (draft).pdf,
                   filled application form via e-applicationvisa.esteri.it,
                   00-CHECKLIST.pdf

You:   [signs and prints]
```

## Install

Drop the folder into your Claude Code skills directory:

```bash
git clone https://github.com/Shadowhusky/visa-application.git ~/.claude/skills/visa-application
```

Or copy from a download:

```bash
mkdir -p ~/.claude/skills
cp -R visa-application ~/.claude/skills/
```

Verify it's loaded:

```bash
# In Claude Code
/skills
```

Then start a normal conversation — mention a visa, the skill takes over.

## Privacy

The reusable profile contains sensitive data (passport, residence, employment, banking). It lives locally at `~/.claude/visa-profile.json` and is never transmitted to any third party by the skill itself. If you sync `~/.claude/` to a cloud service, that's on you.

## License

MIT. See [`LICENSE`](LICENSE).
