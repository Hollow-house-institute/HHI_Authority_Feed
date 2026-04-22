#!/data/data/com.termux/files/usr/bin/bash

DATE=$(date +%F_%H-%M)
FILE="logs/${DATE}.md"

mkdir -p logs

echo "# ${DATE} — Content Log" > $FILE
echo "" >> $FILE

echo "Paste LinkedIn:" 
read LINKEDIN
echo "## LinkedIn" >> $FILE
echo "$LINKEDIN" >> $FILE
echo "" >> $FILE

echo "Paste DEV:"
read DEV
echo "## DEV" >> $FILE
echo "$DEV" >> $FILE
echo "" >> $FILE

echo "Paste Comment:"
read COMMENT
echo "## Comment" >> $FILE
echo "$COMMENT" >> $FILE
echo "" >> $FILE

echo "## POST_LOG" >> $FILE

git add .
git commit -m "log: $DATE"
git push
