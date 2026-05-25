# Installing this skill

This is a Claude Code skill. To make it usable by future Claude agents on this machine:

## One-liner install (recommended)

```bash
mkdir -p ~/.claude/skills && cp -R "/path/to/visa-application" ~/.claude/skills/
```

That puts the skill at `~/.claude/skills/visa-application/`, where Claude Code looks for user-level skills.

## Verify

Open Claude Code, in any session run:

```
/skills
```

…and you should see `visa-application` listed. From then on, any time you (or any future session) mentions a visa application, Claude will automatically consult this skill.

## Using

Just start a normal conversation, e.g.:
- *"I need to apply for a Japan tourist visa from the UK next month."*
- *"Help me with my Schengen visa application."*
- *"My friend needs a US B1/B2 — can you walk her through it?"*

The skill takes over from there.

## Updating

Edit files in `~/.claude/skills/visa-application/` directly. Changes take effect on the next conversation.

## Privacy note

The skill stores a reusable profile at `~/.claude/visa-profile.json` containing your identity, passport, employment, and banking details. It's local-only — Claude never transmits it to a third party. If you sync `~/.claude/` to a cloud service, you're trusting that service with your data.
