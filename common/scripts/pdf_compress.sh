#!/usr/bin/env sh

FILE_INPUT="$1"
FILENAME="${FILE_INPUT%.*}"
EXTENSION="${FILE_INPUT##*.}"
NEW_STRING="${FILENAME}_comp.${EXTENSION}"
echo "$NEW_STRING"

# gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$NEW_STRING" "$FILE_INPUT"
# gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dBATCH -dQUIET -dDownsampleColorImages=true -dColorImageResolution=200 -dColorImageDownsampleType=/Bicubic -sOutputFile="$NEW_STRING" "$FILE_INPUT"
pdf2ps "$FILE_INPUT" tmp.ps
ps2pdf -dPDFSETTINGS=/screen -dDownsampleColorImages=true -dColorImageResolution=200 -dColorImageDownsampleType=/Bicubic tmp.ps "$NEW_STRING"
rm tmp.ps
