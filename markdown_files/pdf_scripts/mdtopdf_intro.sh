#!/bin/sh

CWD=`pwd`
cd ../ja/docs/intro
cat index.md 00_release_note.md 00_cheat_sheet.md > intro.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	intro.md \
	-t html5 \
	-o ../../../pdf/intro_ja.pdf \
	-s --pdf-engine=wkhtmltopdf \
	--toc --number-sections --css ../css/extra.css
rm -rf intro.md *.html

cd $CWD
cd ../en/docs/intro
cat index.md 00_release_note.md 00_cheat_sheet.md > intro.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	intro.md \
	-t html5 \
	-o ../../../pdf/intro_en.pdf \
	-s --pdf-engine=wkhtmltopdf \
	--toc --number-sections --css ../css/extra.css
rm -rf intro.md *.html

