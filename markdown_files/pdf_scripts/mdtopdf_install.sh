#!/bin/sh

CWD=`pwd`
cd ../ja/docs/install
cat index.md install_01.md install_02.md install_03.md install_04.md install_05.md install_06.md install_06.md install_07.md install_08.md install_09.md install_10.md install_11.md > install.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	install.md \
	-t html5 \
	-o ../../../pdf/install_ja.pdf \
	-s --mathjax --pdf-engine=wkhtmltopdf \
	--toc --number-sections --css ../css/extra.css
rm -rf install.md *.html

cd $CWD
cd ../en/docs/install
cat index.md install_01.md install_02.md install_03.md install_04.md install_05.md install_06.md install_06.md install_07.md install_08.md install_09.md install_10.md install_11.md > install.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	install.md \
	-t html5 \
	-o ../../../pdf/install_en.pdf \
	-s --mathjax --pdf-engine=wkhtmltopdf \
	--toc --number-sections --css ../css/extra.css
rm -rf install.md *.html

