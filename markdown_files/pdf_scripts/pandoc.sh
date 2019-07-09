#!/bin/sh
pandoc \
  $1 \
  -o $1.pdf \
  -f markdown+header_attributes+fenced_code_blocks+link_attributes+tex_math_single_backslash+definition_lists \
  -t latex \
  --pdf-engine=lualatex \
  -V documentclass="article" \
  -s --toc --number-sections \
  -V geometry:a4paper \
  -V geometry:left=18.7mm,right=18.7mm,top=18.7mm,bottom=18.7mm \
  --css ../css/extra.css \
  --listings \
  --wrap=preserve \
  --highlight-style tango \
  -V titlepage=true
