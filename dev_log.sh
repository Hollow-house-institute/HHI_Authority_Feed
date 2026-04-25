#!/data/data/com.termux/files/usr/bin/bash
set -e

DATE=$(date +%F)
FILE="logs/$DATE.md"

# ensure log file
mkdir -p logs
[ -f "$FILE" ] || echo -e "# $DATE — Content Log\n\n## DEV Comments\n" > "$FILE"

echo "Paste TITLE, then ENTER. Paste your COMMENT. End with Ctrl+D:"
echo ""

# read title (first line) + body (rest)
IFS= read -r TITLE || true
BODY=$(cat)

# basic guard
if [ -z "$TITLE" ] || [ -z "$BODY" ]; then
  echo "Missing title or comment. Aborting."
  exit 1
fi

ENTRY=$(cat <<EOT
### $TITLE
$BODY

---
EOT
)

# append
printf "%s\n" "$ENTRY" >> "$FILE"

# save
git add "$FILE"
git commit -m "log: DEV comment ($DATE)" || true
git pull --rebase origin main || true
git push || true

echo "Logged to $FILE"
