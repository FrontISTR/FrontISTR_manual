#!/bin/sh

CWD=`pwd`
FILES="index.md 00_release_note.md 00_cheat_sheet.md"

for i in en ja
do
  cd ../$i/docs/intro
  cat $FILES > tmp.md
  pandoc -f markdown+link_attributes+tex_math_dollars \
    tmp.md \
    -t html5 \
    -o ../../../pdf/intro_$i.pdf \
    -s --pdf-engine=wkhtmltopdf \
    --metadata pagetitle="FrontISTR イントロダクション" \
    --toc --number-sections --css ../css/extra.css \
    -V papersize:a4 -V margin-left:18.7mm -V margin-right:18.7mm \
    -V margin-top:18.7mm -V margin-bottom:18.7mm
  rm -rf tmp.md *.html
  cd $CWD
done

