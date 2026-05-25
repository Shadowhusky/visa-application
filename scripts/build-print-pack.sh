#!/usr/bin/env bash
#
# build-print-pack.sh — assemble a numbered Print Pack subfolder from the
# documents in an application folder, in officer-flip order.
#
# Usage:
#   build-print-pack.sh "/path/to/application-folder" "ordering.txt"
#
# Where ordering.txt is a text file with one line per document, in the order
# you want them numbered. Each line: SOURCE_FILE | DISPLAY_NAME
#
# Example ordering.txt:
#   appointment.pdf | VFS Appointment Confirmation
#   visa-form.pdf | Visa Application Form - SIGN PAGE 5
#   cover.pdf | Cover Letter - SIGN AT BOTTOM
#
set -euo pipefail

APPFOLDER="${1:-}"
ORDERING="${2:-}"

if [ -z "$APPFOLDER" ] || [ -z "$ORDERING" ]; then
  echo "Usage: $0 APPLICATION_FOLDER ORDERING_FILE" >&2
  exit 1
fi

if [ ! -d "$APPFOLDER" ]; then
  echo "Application folder not found: $APPFOLDER" >&2
  exit 2
fi

if [ ! -f "$ORDERING" ]; then
  echo "Ordering file not found: $ORDERING" >&2
  exit 3
fi

PACK="$APPFOLDER/Print Pack"
mkdir -p "$PACK"

i=0
while IFS='|' read -r SRC DISP; do
  # Trim whitespace
  SRC="$(echo "$SRC" | sed 's/^ *//;s/ *$//')"
  DISP="$(echo "$DISP" | sed 's/^ *//;s/ *$//')"
  [ -z "$SRC" ] && continue
  [ -z "$DISP" ] && continue

  i=$((i+1))
  NN=$(printf "%02d" "$i")

  # Source can be absolute or relative to APPFOLDER
  case "$SRC" in
    /*) FROM="$SRC" ;;
    *)  FROM="$APPFOLDER/$SRC" ;;
  esac

  if [ ! -f "$FROM" ]; then
    echo "  [skip] $NN - $DISP (source missing: $FROM)" >&2
    continue
  fi

  # Preserve extension
  EXT="${FROM##*.}"
  DEST="$PACK/$NN - $DISP.$EXT"
  cp "$FROM" "$DEST"
  echo "  $NN  $DISP"
done < "$ORDERING"

echo
echo "Print Pack assembled at: $PACK"
ls -la "$PACK"
