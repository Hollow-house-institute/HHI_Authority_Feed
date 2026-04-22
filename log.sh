#!/data/data/com.termux/files/usr/bin/bash

DATE=$(date +%F)
FILE="logs/${DATE}.md"

mkdir -p logs

echo "# ${DATE} — Content Log" > $FILE
echo "" >> $FILE
echo "## LinkedIn" >> $FILE
echo "" >> $FILE
echo "## DEV" >> $FILE
echo "" >> $FILE
echo "## Comment" >> $FILE
echo "" >> $FILE
echo "## POST_LOG" >> $FILE

git add .
git commit -m "log: $DATE"
git push
