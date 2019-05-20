#!/bin/sh

CWD=`pwd`
cd ../ja/docs/tutorial
cat index.md tutorial_01.md tutorial_02.md tutorial_03.md tutorial_04.md tutorial_05.md tutorial_06.md tutorial_06.md tutorial_07.md tutorial_08.md tutorial_09.md tutorial_10.md tutorial_11.md tutorial_12.md tutorial_13.md tutorial_14.md tutorial_15.md tutorial_16.mdi tutorial_17.md example_01.md example_02.md example_03.md example_04.md example_05.md > tutorial.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	tutorial.md \
	-t html5 \
	-o ../../../pdf/tutorial_ja.pdf \
	-s --mathjax --pdf-engine=wkhtmltopdf \
	--metadata pagetitle="FrontISTR チュートリアルマニュアル" \
	--toc --number-sections --css ../css/extra.css
rm tutorial.md *.html

cd $CWD
cd ../en/docs/tutorial
cat index.md tutorial_01.md tutorial_02.md tutorial_03.md tutorial_04.md tutorial_05.md tutorial_06.md tutorial_06.md tutorial_07.md tutorial_08.md tutorial_09.md tutorial_10.md tutorial_11.md tutorial_12.md tutorial_13.md tutorial_14.md tutorial_15.md tutorial_16.mdi tutorial_17.md example_01.md example_02.md example_03.md example_04.md example_05.md > tutorial.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	tutorial.md \
	-t html5 \
	-o ../../../pdf/tutorial_en.pdf \
	-s --mathjax --pdf-engine=wkhtmltopdf \
	--metadata pagetitle="FrontISTR Tutorial manual" \
	--toc --number-sections --css ../css/extra.css
rm tutorial.md *.html
