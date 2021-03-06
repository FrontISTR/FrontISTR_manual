#!/bin/sh

CWD=`pwd`
FILES="index.md theory_01.md theory_02.md theory_03.md theory_04.md theory_05.md theory_06.md theory_07.md"

for i in en ja
do
  echo $i
  if [ $i = "ja" ]; then
    docclass="bxjsarticle"
  else
    docclass="article"
  fi

  cd ../$i/docs/theory
  cat $FILES > tmp.md
  pandoc \
    tmp.md \
    -o theory_$i.pdf \
    -f markdown+header_attributes+fenced_code_blocks+link_attributes+tex_math_single_backslash-tex_math_dollars+definition_lists \
    -t latex \
    --pdf-engine=lualatex \
    -s --toc --number-sections \
    --css ../css/extra.css \
    --listings \
    --wrap=preserve \
    --highlight-style tango \
    -V documentclass=$docclass \
    -V classoption=pandoc,ja=standard \
    -V fontsize=10pt \
    -V papersize=a4 \
    -V geometry:left=15.7mm,right=15.7mm,top=18.7mm,bottom=30.0mm \
    -V titlepage=true
  rm -rf tmp.md *.html
#  mv *.pdf $CWD
  cd $CWD
done


