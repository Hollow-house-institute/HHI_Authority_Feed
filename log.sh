#!/data/data/com.termux/files/usr/bin/bash

DATE=$(date +%F_%H-%M)
FILE="logs/${DATE}.md"

mkdir -p logs

<<<<<<< HEAD
echo "# ${DATE} — Content Log" > $FILE
echo "" >> $FILE
echo "## LinkedIn" >> $FILE
echo "" >> $FILE
echo "## DEV" >> $FILE
echo "" >> $FILE
echo "## Comment" >> $FILE
echo "" >> $FILE
echo "## POST_LOG" >> $FILE
echo "" >> $FILE

# THIS is the correct way (multi-line paste)
nano $FILE
# Create file ONLY if it doesn't exist
if [ ! -f "$FILE" ]; then
  echo "# ${DATE} — Content Log" > $FILE
  echo "" >> $FILE
  echo "## LinkedIn" >> $FILE
  echo "" >> $FILE
  echo "## DEV" >> $FILE
  echo "" >> $FILE
  echo "## Comment" >> $FILE
  echo "" >> $FILE
  echo "## POST_LOG" >> $FILE
  echo "" >> $FILE
fi
 a60dd59 (log: 2026-04-23_13-01)

# Open editor FIRST
nano $FILE

# THEN validate
~/HHI_Authority_Feed/validate.sh || exit 1

# THEN commit
git add .
git commit -m "log: $DATE"
git push
