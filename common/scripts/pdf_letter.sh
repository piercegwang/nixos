#!/usr/bin/env sh

FILE_INPUT="$1"
FILENAME="${FILE_INPUT%.*}"
EXTENSION="${FILE_INPUT##*.}"
NEW_STRING="${FILENAME}_letter.${EXTENSION}"
echo "$NEW_STRING"

pdfjam --paper letter -o "$NEW_STRING" "$FILE_INPUT"
