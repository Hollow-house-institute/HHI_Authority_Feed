#!/data/data/com.termux/files/usr/bin/bash

FILE=$(ls -t logs/*.md | head -n 1)

# Basic checks
grep -q "## LinkedIn" "$FILE" || { echo "Missing LinkedIn section"; exit 1; }
grep -q "## DEV" "$FILE" || { echo "Missing DEV section"; exit 1; }
grep -q "## Comment" "$FILE" || { echo "Missing Comment section"; exit 1; }
grep -q "## POST_LOG" "$FILE" || { echo "Missing POST_LOG"; exit 1; }

# Check content is not empty
grep -A1 "## LinkedIn" "$FILE" | tail -n1 | grep -q "." || { echo "LinkedIn empty"; exit 1; }
grep -A1 "## Comment" "$FILE" | tail -n1 | grep -q "." || { echo "Comment empty"; exit 1; }

echo "Validation passed"
