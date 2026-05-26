#!/usr/bin/env bash
#
# smoke-test.sh — structural sanity test for the visa-application skill.
#
# Run this in CI or by hand after edits to confirm the skill still has the
# right shape. It checks files exist, scripts are executable, templates
# have known placeholders, no leaked personal data, and renders work.
#
# Usage:  bash tests/smoke-test.sh
# Exit code 0 = all pass.

set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0
FAIL=0
WARN=0

ok()  { printf '  ✓ %s\n' "$1"; PASS=$((PASS+1)); }
no()  { printf '  ✗ %s\n' "$1"; FAIL=$((FAIL+1)); }
hm()  { printf '  ! %s\n' "$1"; WARN=$((WARN+1)); }

echo "[1/6] File structure"
for f in SKILL.md README.md INSTALL.md LICENSE \
         references/research-protocol.md \
         references/document-checklist.md \
         references/known-portals.md \
         references/profile-schema.md \
         references/form-filling-strategy.md \
         references/visa-scenarios.md \
         templates/cover-letter.html \
         templates/employment-letter.html \
         templates/checklist.html \
         templates/application-status.html \
         templates/form-data.html \
         templates/questionnaire.html \
         scripts/render-pdf.sh \
         scripts/find-existing.sh \
         scripts/build-print-pack.sh; do
  if [ -f "$ROOT/$f" ]; then ok "$f present"; else no "$f MISSING"; fi
done

echo
echo "[2/6] SKILL.md YAML frontmatter"
head -1 "$ROOT/SKILL.md" | grep -q '^---$' && ok "starts with YAML delimiter" || no "missing YAML delimiter"
grep -q '^name: visa-application$' "$ROOT/SKILL.md" && ok "has 'name: visa-application'" || no "wrong/missing name"
grep -q '^description: ' "$ROOT/SKILL.md" && ok "has description" || no "missing description"

echo
echo "[3/6] Scripts are executable and have shebangs"
for s in scripts/render-pdf.sh scripts/find-existing.sh scripts/build-print-pack.sh; do
  [ -x "$ROOT/$s" ] && ok "$s is executable" || no "$s not executable"
  head -1 "$ROOT/$s" | grep -q '^#!/usr/bin/env bash$' && ok "$s has bash shebang" || no "$s wrong shebang"
done

echo
echo "[4/6] Templates contain expected placeholders"
grep -q 'APPLICANT_FULL_NAME' "$ROOT/templates/cover-letter.html" && ok "cover-letter has APPLICANT_FULL_NAME" || no "cover-letter missing APPLICANT_FULL_NAME"
grep -q 'DESTINATION_COUNTRY' "$ROOT/templates/cover-letter.html" && ok "cover-letter has DESTINATION_COUNTRY" || no "cover-letter missing DESTINATION_COUNTRY"
grep -q 'EMPLOYER_NAME' "$ROOT/templates/employment-letter.html" && ok "employment-letter has EMPLOYER_NAME" || no "employment-letter missing EMPLOYER_NAME"
grep -q 'STACK_ORDER_ROWS_PLACEHOLDER' "$ROOT/templates/checklist.html" && ok "checklist has STACK_ORDER_ROWS_PLACEHOLDER" || no "checklist missing STACK_ORDER_ROWS_PLACEHOLDER"
grep -q 'APPLICATION_STATUS' "$ROOT/templates/application-status.html" && ok "application-status has APPLICATION_STATUS" || no "application-status missing APPLICATION_STATUS"
grep -q 'PROGRESS_ROWS_PLACEHOLDER' "$ROOT/templates/application-status.html" && ok "application-status has PROGRESS_ROWS_PLACEHOLDER" || no "application-status missing PROGRESS_ROWS_PLACEHOLDER"
grep -q 'FORM_ROWS_PLACEHOLDER' "$ROOT/templates/form-data.html" && ok "form-data has FORM_ROWS_PLACEHOLDER" || no "form-data missing FORM_ROWS_PLACEHOLDER"
grep -q 'FORM_SECTIONS_PLACEHOLDER' "$ROOT/templates/questionnaire.html" && ok "questionnaire has FORM_SECTIONS_PLACEHOLDER" || no "questionnaire missing FORM_SECTIONS_PLACEHOLDER"
grep -q 'PREFILLED_JSON_PLACEHOLDER' "$ROOT/templates/questionnaire.html" && ok "questionnaire has PREFILLED_JSON_PLACEHOLDER" || no "questionnaire missing PREFILLED_JSON_PLACEHOLDER"

echo
echo "[5/6] No personal data leaks"
LEAKS=$(grep -rE "Yuxuan|EJ3963586|330182200005113614|Hanbury|SDM LAH|a983974247|FRA1LO2025|7919 706117|SE17 1GU" \
  --include="*.md" --include="*.html" --include="*.json" --include="*.sh" "$ROOT" 2>/dev/null | grep -v 'tests/' || true)
if [ -z "$LEAKS" ]; then
  ok "no personal data leaks found in shipped files"
else
  no "LEAKS DETECTED:"
  echo "$LEAKS" | head -5
fi

echo
echo "[6/6] HTML→PDF pipeline works"
TMP=$(mktemp -d)
sed -e 's/APPLICANT_FULL_NAME/TEST USER/g; s/DESTINATION_COUNTRY/TESTLAND/g; s/[A-Z_]\{4,\}/X/g' \
    "$ROOT/templates/cover-letter.html" > "$TMP/in.html"
if bash "$ROOT/scripts/render-pdf.sh" "$TMP/in.html" "$TMP/out.pdf" >/dev/null 2>&1 \
   && [ -s "$TMP/out.pdf" ]; then
  ok "cover-letter template renders to PDF"
else
  hm "cover-letter render failed (Chrome / cupsfilter missing? non-blocking on CI without browser)"
fi
rm -rf "$TMP"

echo
echo "─────────────────────────────"
printf 'Pass: %d  Fail: %d  Warn: %d\n' "$PASS" "$FAIL" "$WARN"
[ "$FAIL" -eq 0 ] && exit 0 || exit 1
