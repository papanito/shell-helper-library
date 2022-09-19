# media.sh

## Overview

helper to work with media (images, videos, ..)

## Index

* [pdf2png](#pdf2png)
* [pdfpextr](#pdfpextr)
* [pdfreduce](#pdfreduce)
* [resizeimg](#resizeimg)
* [pngoptim](#pngoptim)
* [txt2pdf](#txt2pdf)
* [image_resize](#image_resize)

## images

Working with Youtube

### pdf2png

Convert a single-page PDF to a hi-res PNG, at 300dpi
If you skip this part: -density 300x300, you'll get a very lo-res image

#### Arguments

* **$1** (string): input file
* **$2** (string): output file

### pdfpextr

Extract pages from pdf
output file will be named "inputfile_pXX-pYY.pdf"
http://www.linuxjournal.com/content/tech-tip-extract-pages-pdf

#### Arguments

* **$1** (int): first page of the range to extract
* **$2** (int): last page of the range to extract
* **$3** (string): the input file

### pdfreduce

Reduce PDF

#### Arguments

* **$1** (string): file to Reduce
* **$2** (int): dpi

### resizeimg

batch resize image

### pngoptim

Optimize PNG files

### txt2pdf

Convert text file to pdf
Requires:txt2html python-pisa

#### Arguments

* **$1** (string): input textfile

### image_resize

Resizing an image

#### Arguments

* **$1** (int): percentage of image resize
* **$2** (string): input image file
* **$3** (string): output image file

