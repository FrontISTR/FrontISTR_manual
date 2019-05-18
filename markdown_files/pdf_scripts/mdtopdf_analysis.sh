#!/bin/sh

CWD=`pwd`
cd ../ja/docs/analysis
cat index.md analysis_01.md analysis_02.md analysis_03.md analysis_04.md analysis_05.md analysis_06.md analysis_06.md analysis_07.md > analysis.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	analysis.md \
	-t html5 \
	-o ../../../pdf/analysis_ja.pdf \
	-s --mathjax --pdf-engine=wkhtmltopdf \
	--toc --number-sections --css ../css/extra.css
rm -rf analysis.md *.html

cd $CWD
cd ../en/docs/analysis
cat index.md analysis_01.md analysis_02.md analysis_03.md analysis_04.md analysis_05.md analysis_06.md analysis_06.md analysis_07.md > analysis.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	analysis.md \
	-t html5 \
	-o ../../../pdf/analysis_en.pdf \
	-s --mathjax --pdf-engine=wkhtmltopdf \
	--toc --number-sections --css ../css/extra.css
rm -rf analysis.md *.html
