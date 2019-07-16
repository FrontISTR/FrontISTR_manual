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
    -f markdown+header_attributes+fenced_code_blocks+link_attributes+tex_math_single_backslash-tex_math_dollars+definition_lists \
    -t latex-smart \
    --pdf-engine=lualatex \
    -V documentclass=$docclass \
    -V classoption=pandoc,ja=standard \
    -s --toc --number-sections \
    -V papersize=a4 \
    -V geometry:left=18.7mm,right=18.7mm,top=18.7mm,bottom=25.4mm \
    --css ../css/extra.css \
    --listings \
    --wrap=preserve \
    --highlight-style tango \
    -V titlepage=true
  rm -rf tmp.md *.html
  cd $CWD
done

