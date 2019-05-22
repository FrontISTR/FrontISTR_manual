#!/bin/sh

CWD=`pwd`
FILES="index.md 00_release_note.md 00_cheat_sheet.md"

cd ../ja/docs/intro
cat $FILES > intro.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	intro.md \
	-t html5 \
	-o ../../../pdf/intro_ja.pdf \
	-s --pdf-engine=wkhtmltopdf \
	--metadata pagetitle="FrontISTR イントロダクション" \
	--dpi=300 --toc --number-sections --css ../css/extra.css \
        -V papersize:a4 -V margin-left:18.7mm -V margin-right:18.7mm \
        -V margin-top:18.7mm -V margin-bottom:18.7mm
rm -rf intro.md *.html

cd $CWD
cd ../en/docs/intro
cat $FILES > intro.md
pandoc -f markdown+link_attributes+tex_math_dollars \
	intro.md \
	-t html5 \
	-o ../../../pdf/intro_en.pdf \
	-s --pdf-engine=wkhtmltopdf \
	--metadata pagetitle="Introduction to FrontISTR" \
	--dpi=300 --toc --number-sections --css ../css/extra.css \
        -V papersize:a4 -V margin-left:18.7mm -V margin-right:18.7mm \
        -V margin-top:18.7mm -V margin-bottom:18.7mm
rm -rf intro.md *.html

