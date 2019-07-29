#!/bin/sh

CWD=`pwd`
FILES="index.md tutorial_01.md tutorial_02.md tutorial_03.md tutorial_04.md tutorial_05.md tutorial_06.md tutorial_06.md tutorial_07.md tutorial_08.md tutorial_09.md tutorial_10.md tutorial_11.md tutorial_12.md tutorial_13.md tutorial_14.md tutorial_15.md tutorial_16.md tutorial_17.md example_01.md example_02.md example_03.md example_04.md example_05.md"

for i in en ja
do
  echo $i
  if [ $i = "ja" ]; then
    docclass="bxjsarticle"
  else
    docclass="article"
  fi

  cd ../$i/docs/tutorial
  cat $FILES > tmp.md
    pandoc \
    tmp.md \
    -o tutorial_$i.pdf \
    -f markdown+header_attributes+fenced_code_blocks+link_attributes+tex_math_single_backslash-tex_math_dollars+definition_lists \
    -t latex \
    -s --toc --number-sections \
    --latex-engine=lualatex \
    --css ../css/extra.css \
    --listings \
    --wrap=preserve \
    --highlight-style tango \
    -V documentclass=$docclass \
    -V classoption=pandoc,ja=standard \
    -V fontsize=10pt \
    -V papersize=a4 \
    -V geometry:left=18.7mm,right=18.7mm,top=18.7mm,bottom=30.0mm \
    -V titlepage=true
  rm -rf tmp.md *.html
#  mv *.pdf $CWD
  cd $CWD
done


