#!/bin/sh

CWD=`pwd`
FILES="index.md theory_01.md theory_02.md theory_03.md theory_04.md theory_05.md theory_06.md theory_07.md"

for i in en ja
do
  cd ../$i/docs/theory
  cat $FILES > tmp.md
  pandoc -f markdown+link_attributes+tex_math_dollars \
    tmp.md \
    -t html5 \
    -o ../../../pdf/theory_$i.pdf \
    -s --mathjax --pdf-engine=wkhtmltopdf \
    --metadata pagetitle="FrontISTR Theory manual" \
    --toc --number-sections --css ../css/extra.css \
    -V papersize:a4 -V margin-left:18.7mm -V margin-right:18.7mm \
    -V margin-top:18.7mm -V margin-bottom:18.7mm
  rm -rf tmp.md *.html
  cd $CWD
done


