#!/bin/sh

CWD=`pwd`
FILES="index.md theory_01.md theory_02.md theory_03.md theory_04.md theory_05.md theory_06.md theory_07.md"

cd ../ja/docs/theory
cat $FILES > theory.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	theory.md \
	-t html5 \
	-o ../../../pdf/theory_ja.pdf \
	-s --mathjax --pdf-engine=wkhtmltopdf \
	--metadata pagetitle="FrontISTR 理論マニュアル" \
	--dpi=300 --toc --number-sections --css ../css/extra.css \
	-V papersize:a4 -V margin-left:18.7mm -V margin-right:18.7mm \
        -V margin-top:18.7mm -V margin-bottom:18.7mm
rm -rf theory.md *.html

cd $CWD
cd ../en/docs/theory
cat $FILES > theory.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	theory.md \
	-t html5 \
	-o ../../../pdf/theory_en.pdf \
	-s --mathjax --pdf-engine=wkhtmltopdf \
	--metadata pagetitle="FrontISTR Theory manual" \
	--dpi=300 --toc --number-sections --css ../css/extra.css \
	-V papersize:a4 -V margin-left:18.7mm -V margin-right:18.7mm \
        -V margin-top:18.7mm -V margin-bottom:18.7mm
rm -rf theory.md *.html

