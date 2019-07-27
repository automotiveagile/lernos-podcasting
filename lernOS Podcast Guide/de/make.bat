@echo off
echo Starting lernOS Guide Generation ...

REM Required Software
REM Calibre, includes ebook-convert, https://calibre-ebook.com
REM Ghostscript, https://www.ghostscript.com (version 9.24, version 9.26 does not work!)
REM ImageMagick, https://www.imagemagick.org
REM MiKTeX, https://miktex.org
REM Pandoc, https://pandoc.org
REM Wandmalfarbe Pandoc Template, https://github.com/Wandmalfarbe/pandoc-latex-template

REM Variables
set filename="lernOS-Podcasting-Guide-de"

REM Delete Old Versions
del %filename%.docx %filename%.epub %filename%.mobi %filename%.html %filename%.pdf images\ebook-cover.png

REM Create Microsoft Word Version (docx)
pandoc -s -o %filename%.docx %filename%.md

REM Create Web Version (html)
pandoc -s --toc -o %filename%.html %filename%.md

REM Create PDF Version (pdf)
pandoc %filename%.md metadata/metadata.yaml -o %filename%.pdf --from markdown --template lernOS --number-sections -V lang=de-de

REM Create eBook Versions (epub, mobi)
REM magick -density 300 %filename%.pdf[0] images/ebook-cover.png
REM pandoc -s --epub-cover-image=images/ebook-cover.png -o %filename%.epub %filename%.md
REM ebook-convert %filename%.epub %filename%.mobi

magick -density 300 %filename%.pdf[0] images/ebook-cover.jpg
magick mogrify -size 2500x2500 -resize 2500x2500 images/ebook-cover.jpg
magick mogrify -crop 1563x2500+102+0 images/ebook-cover.jpg
pandoc %filename%.md metadata/metadata.yaml -s --epub-cover-image=images/ebook-cover.jpg -o %filename%.epub
ebook-convert %filename%.epub %filename%.mobi

pause