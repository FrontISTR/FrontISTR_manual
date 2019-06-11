#!/bin/sh

CWD=`pwd`
FILES="index.md install_01.md install_02.md install_03.md install_04.md install_05.md install_06.md install_06.md install_07.md install_08.md install_09.md install_10.md install_11.md"

for i in en ja
do
  cd ../$i/docs/install
  cat $FILES > tmp.md
  pandoc -f markdown+link_attributes+tex_math_dollars \
    tmp.md \
    -t html5 \
    -o ../../../pdf/install_$i.pdf \
    --metadata pagetitle="FrontISTR Installation manual" \
    -s --mathjax --pdf-engine=wkhtmltopdf \
    --toc --number-sections --css ../css/extra.css \
    -V papersize:a4 -V margin-left:18.7mm -V margin-right:18.7mm \
    -V margin-top:18.7mm -V margin-bottom:18.7mm
    rm -rf tmp.md *.html
    cd $CWD
done

