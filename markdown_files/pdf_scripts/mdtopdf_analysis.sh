#!/bin/sh

CWD=`pwd`
FILES="index.md analysis_01.md analysis_02.md analysis_03.md analysis_04.md analysis_05.md analysis_06.md analysis_07.md"

for i in en ja
do
  echo $i
  if [ $i = "ja" ]; then
    docclass="bxjsarticle"
  else
    docclass="article"
  fi

  cd ../$i/docs/analysis
  cat $FILES > tmp.md
  pandoc \
    tmp.md \
    -o analysis_$i.pdf \
    -f markdown+header_attributes+fenced_code_blocks+link_attributes+tex_math_single_backslash-tex_math_dollars+definition_lists \
    -t latex \
    -s --toc --number-sections \
    --pdf-engine=lualatex \
    --css ../css/extra.css \
    --listings \
    --wrap=preserve \
    --highlight-style tango \
    -V documentclass=$docclass \
    -V classoption=pandoc,ja=standard \
    -V fontsize=10pt \
    -V papersize=a4 \
    -V geometry:left=18.7mm,right=18.7mm,top=18.7mm,bottom=25.4mm \
    -V titlepage=true
  rm -rf tmp.md *.html
  mv *.pdf $CWD
  cd $CWD
done

