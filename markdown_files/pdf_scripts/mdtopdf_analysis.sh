#!/bin/sh

CWD=`pwd`
FILES="index.md analysis_01.md analysis_02.md analysis_03.md analysis_04.md analysis_05.md analysis_06.md analysis_07.md"
cd ../ja/docs/analysis
cat $FILES > analysis.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	analysis.md \
	-t html5 \
	-o ../../../pdf/analysis_ja.pdf \
	-s --mathjax --pdf-engine=wkhtmltopdf \
	--metadata pagetitle="FrontISTR 解析マニュアル" \
	--dpi=300 --toc --number-sections --css ../css/extra.css \
        -V papersize:a4 -V margin-left:18.7mm -V margin-right:18.7mm \
	-V margin-top:18.7mm -V margin-bottom:18.7mm
rm -rf analysis.md *.html

cd $CWD
cd ../en/docs/analysis
cat $FILES > analysis.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	analysis.md \
	-t html5 \
	-o ../../../pdf/analysis_en.pdf \
	-s --mathjax --pdf-engine=wkhtmltopdf \
	--metadata pagetitle="FrontISTR Analysis flow manual" \
	--dpi=300 --toc --number-sections --css ../css/extra.css \
        -V papersize:a4 -V margin-left:18.7mm -V margin-right:18.7mm \
	-V margin-top:18.7mm -V margin-bottom:18.7mm
rm -rf analysis.md *.html
