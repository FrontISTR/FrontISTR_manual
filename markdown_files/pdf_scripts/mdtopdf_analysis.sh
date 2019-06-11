#!/bin/sh

CWD=`pwd`
FILES="index.md analysis_01.md analysis_02.md analysis_03.md analysis_04.md analysis_05.md analysis_06.md analysis_07.md"

for i in en ja
do
  cd ../$i/docs/analysis
  cat $FILES > tmp.md
  pandoc -f markdown+link_attributes+tex_math_dollars \
    tmp.md \
    -t html5 \
    -o ../../../pdf/analysis_$i.pdf \
    -s --mathjax --pdf-engine=wkhtmltopdf \
    --metadata pagetitle="FrontISTR Analysis flow manual" \
	  --toc --number-sections --css ../css/extra.css \
    -V papersize:a4 -V margin-left:18.7mm -V margin-right:18.7mm \
	  -V margin-top:18.7mm -V margin-bottom:18.7mm
    rm -rf tmp.md *.html
    cd $CWD
done

