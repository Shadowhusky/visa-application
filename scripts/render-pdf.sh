#!/usr/bin/env bash
#
# render-pdf.sh — render an HTML file to PDF using Chrome headless.
#
# Usage:
#   render-pdf.sh INPUT.html OUTPUT.pdf
#
# Works on macOS (Google Chrome.app) and Linux (google-chrome / chromium).
# Falls back to /usr/sbin/cupsfilter if Chrome isn't available.
#
set -euo pipefail

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 INPUT.html OUTPUT.pdf"
  exit 1
fi

INPUT="$1"
OUTPUT="$2"

if [ ! -f "$INPUT" ]; then
  echo "Input HTML not found: $INPUT" >&2
  exit 2
fi

# Resolve to absolute file URL
case "$INPUT" in
  /*) INPUT_URL="file://$INPUT" ;;
  *) INPUT_URL="file://$(pwd)/$INPUT" ;;
esac

mkdir -p "$(dirname "$OUTPUT")"

CHROME=""
if [ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]; then
  CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
elif command -v google-chrome >/dev/null 2>&1; then
  CHROME="$(command -v google-chrome)"
elif command -v chromium >/dev/null 2>&1; then
  CHROME="$(command -v chromium)"
elif command -v chromium-browser >/dev/null 2>&1; then
  CHROME="$(command -v chromium-browser)"
fi

if [ -n "$CHROME" ]; then
  "$CHROME" --headless --disable-gpu --no-pdf-header-footer \
    --print-to-pdf="$OUTPUT" "$INPUT_URL" >/dev/null 2>&1
  if [ -f "$OUTPUT" ]; then
    echo "Wrote: $OUTPUT"
    exit 0
  fi
fi

# Fallback: cupsfilter on macOS
if [ -x /usr/sbin/cupsfilter ]; then
  /usr/sbin/cupsfilter -o PageSize=A4 "$INPUT" > "$OUTPUT" 2>/dev/null
  if [ -f "$OUTPUT" ]; then
    echo "Wrote (via cupsfilter): $OUTPUT"
    exit 0
  fi
fi

echo "ERROR: could not find Chrome / Chromium / cupsfilter to render PDF" >&2
exit 3
