#!/usr/bin/env bash
#
# find-existing.sh — search the user's machine for an existing visa profile or
# application folder before creating a new one.
#
# Usage:
#   find-existing.sh profile
#   find-existing.sh folder "Italy"
#
set -euo pipefail

MODE="${1:-}"

# Candidate roots to search — quick, bounded.
ROOTS=()
[ -d "$HOME/.claude" ] && ROOTS+=("$HOME/.claude")
[ -d "$HOME/Documents" ] && ROOTS+=("$HOME/Documents")
[ -d "$HOME/Desktop" ] && ROOTS+=("$HOME/Desktop")
[ -d "$HOME/Downloads" ] && ROOTS+=("$HOME/Downloads")
ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
[ -d "$ICLOUD" ] && ROOTS+=("$ICLOUD")

case "$MODE" in
  profile)
    # Canonical first
    if [ -f "$HOME/.claude/visa-profile.json" ]; then
      echo "$HOME/.claude/visa-profile.json"
    fi
    # Then anything that looks like a visa profile
    for r in "${ROOTS[@]}"; do
      find "$r" -maxdepth 5 -type f \
        \( -iname "visa-profile.json" -o -iname "visa_profile.json" \
           -o -iname "personal_profile.json" -o -iname "personal-profile.json" \) \
        2>/dev/null
    done
    ;;

  folder)
    DEST="${2:-}"
    if [ -z "$DEST" ]; then
      echo "Usage: $0 folder DESTINATION_NAME" >&2
      exit 1
    fi
    for r in "${ROOTS[@]}"; do
      find "$r" -maxdepth 4 -type d \
        \( -iname "*${DEST}*visa*" -o -iname "*visa*${DEST}*" -o -iname "*${DEST}*" \) \
        2>/dev/null | grep -vi "node_modules\|\.git" || true
    done
    ;;

  *)
    echo "Usage: $0 profile" >&2
    echo "       $0 folder DESTINATION_NAME" >&2
    exit 1
    ;;
esac
