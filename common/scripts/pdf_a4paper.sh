#!/usr/bin/env sh

FILE_INPUT="$1"
FILENAME="${FILE_INPUT%.*}"
EXTENSION="${FILE_INPUT##*.}"
NEW_STRING="${FILENAME}_a4.${EXTENSION}"
echo "$NEW_STRING"

pdfjam --paper a4paper -o "$NEW_STRING" "$FILE_INPUT"
