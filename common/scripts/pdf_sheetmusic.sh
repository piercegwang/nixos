#!/usr/bin/env sh
# Compress and Resize a PDF

FILE_INPUT="$1"
ORIGINAL_FILE_INPUT="$1"
FILENAME="${FILE_INPUT%.*}"
EXTENSION="${FILE_INPUT##*.}"
LETTER_STRING="${FILENAME}_letter.${EXTENSION}"

source ~/.config/nixos/common/scripts/pdf_letter.sh "$FILE_INPUT"
source ~/.config/nixos/common/scripts/pdf_compress.sh "$LETTER_STRING"
mkdir -p unprocessed
mv "$ORIGINAL_FILE_INPUT" unprocessed
rm "$LETTER_STRING"
