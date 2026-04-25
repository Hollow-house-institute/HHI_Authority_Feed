#!/data/data/com.termux/files/usr/bin/bash

LIB="datasets/comment_library_weighted.md"
LOG="logs/$(date +%F).md"

[ -f "$LIB" ] || { echo "Missing weighted dataset"; exit 1; }
[ -f "$LOG" ] || { echo "No log for today"; exit 1; }

# Extract performance lines
grep "Performance:" "$LOG" | while read -r line; do

  IMP=$(echo "$line" | sed -n 's/.*impressions=\([0-9]*\).*/\1/p')

  # scoring rule
  if [ "$IMP" -ge 50 ]; then
    INC=2
  elif [ "$IMP" -ge 200 ]; then
    INC=1
  else
    INC=0
  fi

  [ "$INC" -eq 0 ] && continue

  # find previous title line
  TITLE=$(grep -B1 "$line" "$LOG" | head -n1 | sed 's/^### //')

  # update matching lines in dataset
  awk -F'|' -v inc="$INC" -v title="$TITLE" '
  BEGIN{OFS="|"}
  {
    if ($2 ~ /system still runs|gap|Decision Boundary|Behavioral Drift/) {
      $1=$1+inc
    }
    print
  }' "$LIB" > tmp && mv tmp "$LIB"

done

echo "Weights updated."

git add "$LIB"
git commit -m "weights: auto update from performance"
git pull --rebase origin main
git push
