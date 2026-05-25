# Installation guide

Three ways to install the skill, depending on your OS and tools.

---

## Option 1 — `git clone` (macOS, Linux, WSL, Git Bash)

```bash
mkdir -p ~/.claude/skills
git clone https://github.com/Shadowhusky/visa-application.git ~/.claude/skills/visa-application
```

The `mkdir -p` matters — without it, `git clone` fails if `~/.claude/skills/` doesn't already exist.

## Option 2 — `git clone` (Windows PowerShell)

```powershell
New-Item -ItemType Directory -Force -Path "$HOME\.claude\skills" | Out-Null
git clone https://github.com/Shadowhusky/visa-application.git "$HOME\.claude\skills\visa-application"
```

For pure `cmd.exe`:

```cmd
if not exist "%USERPROFILE%\.claude\skills" mkdir "%USERPROFILE%\.claude\skills"
git clone https://github.com/Shadowhusky/visa-application.git "%USERPROFILE%\.claude\skills\visa-application"
```

## Option 3 — Download ZIP (no git needed)

1. Go to [github.com/Shadowhusky/visa-application](https://github.com/Shadowhusky/visa-application)
2. Click the green **Code** button → **Download ZIP**
3. Extract the ZIP — you'll get a folder called `visa-application-main`
4. Rename it to `visa-application`
5. Move it into your Claude skills directory:
   - **macOS / Linux:** `~/.claude/skills/`
   - **Windows:** `%USERPROFILE%\.claude\skills\` (i.e. `C:\Users\YourName\.claude\skills\`)

After move, you should have: `~/.claude/skills/visa-application/SKILL.md` (or equivalent Windows path).

---

## Verify

In any Claude Code session, run:

```
/skills
```

`visa-application` should appear in the list. If it doesn't:

- Confirm the path is exactly `~/.claude/skills/visa-application/` (not `…/skills/visa-application/visa-application-main/` after extraction).
- Confirm `SKILL.md` is directly inside that folder.
- Restart Claude Code so it re-scans the skills directory.

Then start any normal conversation and mention a visa. The skill takes over.

---

## Prerequisites

- **Claude Code** installed (you wouldn't be reading this otherwise, but just in case: see claude.com/code).
- **git** installed if you choose Option 1 or 2. On macOS: `xcode-select --install`. On Ubuntu/Debian: `sudo apt install git`. On Windows: install Git for Windows.
- A working internet connection during installation (the skill also researches consulate sites on demand, which needs internet later too).

## Updating later

```bash
cd ~/.claude/skills/visa-application
git pull
```

Or re-download the ZIP and replace the folder contents.

## Uninstalling

```bash
rm -rf ~/.claude/skills/visa-application
```

The reusable visa profile at `~/.claude/visa-profile.json` and any history at `~/.claude/visa-history.json` are *separate* — remove them manually if you want them gone too:

```bash
rm ~/.claude/visa-profile.json ~/.claude/visa-history.json
```

---

## Troubleshooting

**"Permission denied" when cloning** — you're cloning into a path you don't own. `~/.claude/` should be your home directory; if your shell has expanded `~` to something else, use `$HOME` explicitly: `git clone … "$HOME/.claude/skills/visa-application"`.

**"Could not resolve host: github.com"** — DNS/network issue, possibly a corporate firewall. Try the ZIP download path instead.

**Skill doesn't appear in `/skills`** — three common causes:
1. Wrong directory level: extract created a nested `visa-application/visa-application-main/SKILL.md` — flatten it so `SKILL.md` sits directly inside `~/.claude/skills/visa-application/`.
2. Claude Code is running an older session — restart it.
3. You installed at a non-default `~/.claude` path. Run `claude --help` to find the active config dir on your system.

**Spaces in your home directory path** — `~/.claude/skills/visa-application` will expand correctly, but if you have to type the absolute path explicitly, quote it: `"/Users/Your Name/.claude/skills/visa-application"`.

**Behind a corporate proxy** — use the ZIP path, or configure git's proxy: `git config --global http.proxy http://proxy.company.com:8080`.
