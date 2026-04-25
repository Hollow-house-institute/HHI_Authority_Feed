#!/data/data/com.termux/files/usr/bin/bash
set -e

DATE=$(date +%F)
FILE="logs/$DATE.md"

[ -f "$FILE" ] || { echo "No log for today"; exit 1; }

echo "Paste EXACT comment title to tag:"
read -r TITLE

echo "Impressions (number):"
read -r IMP

echo "Replies (number):"
read -r REP

echo "Reactions (number):"
read -r REACT

STAMP=$(date +%F)

TAG="Performance: impressions=$IMP replies=$REP reactions=$REACT date=$STAMP"

# append tag under the matching title (first match only)
awk -v t="$TITLE" -v tag="$TAG" '
$0 ~ "^### "t"$" && !x {print; print tag; x=1; next}1
' "$FILE" > tmp && mv tmp "$FILE"

git add "$FILE"
git commit -m "perf: tag DEV comment ($DATE)" || true
git pull --rebase origin main || true
git push || true

echo "Tagged."
