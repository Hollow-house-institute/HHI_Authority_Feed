#!/data/data/com.termux/files/usr/bin/bash
set -e

DATE=$(date +%F)
FILE="logs/$DATE.md"

# Ensure log exists
mkdir -p logs
[ -f "$FILE" ] || echo -e "# $DATE — Content Log\n\n## LinkedIn\n\n## DEV\n\n## Comment\n\n## POST_LOG\n" > "$FILE"

LIB="datasets/comment_library_weighted.md"
[ -f "$LIB" ] || { echo "Missing $LIB"; exit 1; }

# Build weighted pool
POOL=()
while IFS='|' read -r w line; do
  [[ -z "$w" || "$w" =~ ^# ]] && continue
  for ((i=0;i<w;i++)); do POOL+=("$line"); done
done < "$LIB"

# Unique picks (by index)
USED=()
pick_unique() {
  local idx
  while true; do
    idx=$((RANDOM % ${#POOL[@]}))
    if [[ ! " ${USED[@]} " =~ " ${idx} " ]]; then
      USED+=("$idx")
      echo "${POOL[$idx]}"
      return
    fi
  done
}

LINE1=$(pick_unique)
LINE2=$(pick_unique)
LINE3=$(pick_unique)

COMMENT="$LINE1

$LINE2

Simple test:

Where is the Decision Boundary actually enforced?

$LINE3

That’s Behavioral Drift."

echo ""
echo "$COMMENT"
echo ""

# Insert into log under ## Comment
awk -v c="$COMMENT" '
/## Comment/ && !x {print; print c; x=1; next}1
' "$FILE" > tmp && mv tmp "$FILE"

# Save
git add "$FILE" datasets/comment_library_weighted.md
git commit -m "log: weighted comment ($DATE)" || true
git pull --rebase origin main || true
git push || true
