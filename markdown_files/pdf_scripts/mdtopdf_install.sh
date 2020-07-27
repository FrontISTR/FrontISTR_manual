#!/bin/sh

CWD=`pwd`
FILES="index.md install_01.md install_02.md install_03.md install_04.md install_05.md install_06.md install_06.md install_07.md install_08.md install_09.md install_10.md install_11.md"

for i in en ja
do
  echo $i
  if [ $i = "ja" ]; then
    docclass="bxjsarticle"
  else
    docclass="article"
  fi

  cd ../$i/docs/install
  cat $FILES > tmp.md
  pandoc \
    tmp.md \
    -o install_$i.pdf \
    -f markdown+header_attributes+fenced_code_blocks+link_attributes+tex_math_single_backslash-tex_math_dollars+definition_lists+multiline_tables \
    -t latex \
    -s --toc --number-sections \
    --pdf-engine=lualatex \
    --css ../css/extra.css \
    --listings \
    --wrap=auto \
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

