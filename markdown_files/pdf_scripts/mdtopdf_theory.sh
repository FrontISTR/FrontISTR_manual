#!/bin/sh

CWD=`pwd`
cd ../ja/docs/theory
cat index.md theory_01.md theory_02.md theory_03.md theory_04.md theory_05.md theory_06.md theory_06.md theory_07.md > theory.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	theory.md \
	-t html5 \
	-o ../../../pdf/theory_ja.pdf \
	-s --mathjax --pdf-engine=wkhtmltopdf \
	--metadata pagetitle="FrontISTR 理論マニュアル" \
	--toc --number-sections --css ../css/extra.css
rm -rf theory.md *.html

cd $CWD
cd ../en/docs/theory
cat index.md theory_01.md theory_02.md theory_03.md theory_04.md theory_05.md theory_06.md theory_06.md theory_07.md > theory.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	theory.md \
	-t html5 \
	-o ../../../pdf/theory_en.pdf \
	-s --mathjax --pdf-engine=wkhtmltopdf \
	--metadata pagetitle="FrontISTR Theory manual" \
	--toc --number-sections --css ../css/extra.css
rm -rf theory.md *.html

