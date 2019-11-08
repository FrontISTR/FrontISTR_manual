#!/bin/sh

CWD=`pwd`
FILES="index.md 00_release_note.md 00_cheat_sheet.md"

for i in en ja
do
  echo $i
  if [ $i = "ja" ]; then
    docclass="bxjsarticle"
  else
    docclass="article"
  fi

  cd ../$i/docs/intro
  cat $FILES > tmp.md
  pandoc \
    tmp.md \
    -o intro_$i.pdf \
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
    -V geometry:left=15.7mm,right=15.7mm,top=18.7mm,bottom=30.0mm \
    -V titlepage=true
  rm -rf tmp.md *.html
#  mv *.pdf $CWD
  cd $CWD
done

