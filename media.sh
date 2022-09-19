# @file media.sh
# @description helper to work with media (images, videos, ..)

# @section Youtube
# @description Working with Youtube
alias ytdl-mp3='youtube-dl -x --audio-format mp3 $@'

# @section images
# @description Image and PDF manipulation

# @description Convert a single-page PDF to a hi-res PNG, at 300dpi
# If you skip this part: -density 300x300, you'll get a very lo-res image
# @arg $1 string input file
# @arg $2 string output file
pdf2png() {
   convert -density 300x300 $1 $2
}

# @description Extract pages from pdf
#     output file will be named "inputfile_pXX-pYY.pdf"
#     http://www.linuxjournal.com/content/tech-tip-extract-pages-pdf
# @arg $1 int first page of the range to extract
# @arg $2 int last page of the range to extract
# @arg $3 string the input file
pdfpextr() {
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
       -dFirstPage=${1} \
       -dLastPage=${2} \
       -sOutputFile="${3%.pdf}_p${1}-p${2}.pdf" \
       "${3}"
}

# @description Reduce PDF
# @arg $1 string file to Reduce
# @arg $2 int dpi
pdfreduce() {
   gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite \
      -dCompatibilityLevel=1.4 \
      -dDownsampleColorImages=true \
      -dDownsampleGrayImages=true \
      -dDownsampleMonoImages=true \
      -dColorImageResolution=${2} \
      -dGrayImageResolution=${2} \
      -dMonoImageResolution=${2} \
      -sOutputFile="${1}_${2}dpi" \
      "${1}"
}

# @description batch resize image
resizeimg() {
   NAME_="resizeimg"
   HTML_="batch resize image"
   PURPOSE_="resize bitmap image"
   PURPOSE_="resize bitmap image"
   SYNOPSIS_="$NAME_ [-hlv] -w <n> <file> [file...]"
   REQUIRES_="standard GNU commands, ImageMagick"
   VERSION_="1.2"
   DATE_="2001-04-22; last update: 2004-10-02"
   AUTHOR_="Dawid Michalczyk <dm@eonworks.com>"
   URL_="www.comp.eonworks.com"
   CATEGORY_="gfx"
   PLATFORM_="Linux"
   SHELL_="bash"
   DISTRIBUTE_="yes"
   # This program is distributed under the terms of the GNU General Public License
   usage () {
   echo >&2 "$NAME_ $VERSION_ - $PURPOSE_
   Usage: $SYNOPSIS_
   Requires: $REQUIRES_
   Options:
       -w <n>, an integer referring to width in pixels; aspect ratio will be preserved
       -v, verbose
       -h, usage and options (this help)
       -l, see this script"
      exit 1
   }
   gfx_resizeImage()
   {
      # arg check
      [[ $1 == *[!0-9]* ]] && { echo >&2 $1 must be an integer; exit 1; }
      [ ! -f $2 ] && { echo >&2 file $2 not found; continue ;}
      # scaling down to value in width
      mogrify -geometry $1 $2
   }
   # args check
   [ $# -eq 0 ] && { echo >&2 missing argument, type $NAME_ -h for help; exit 1; }
   # var init
   verbose=
   width=
   # option and arg handling
   while getopts vhlw: options; do
      case $options in
      v) verbose=on ;;
      w) width=$OPTARG ;;
      h) usage ;;
      l) more $0; exit 1 ;;
         \?) echo invalid argument, type $NAME_ -h for help; exit 1 ;;
      esac
   done
   shift $(( $OPTIND - 1 ))
   # check if required command is in $PATH variable
   which mogrify &> /dev/null
   [[ $? != 0 ]] && { echo >&2 the required ImageMagick \"mogrify\" command \
   is not in your PATH variable; exit 1; }
   for a in "$@";do
      gfx_resizeImage $width $a
      [[ $verbose ]] && echo ${NAME_}: $a
   done
}

# @description Optimize PNG files
pngoptim() {
   NAME_="pngoptim"
   HTML_="optimize png files"
   PURPOSE_="reduce the size of a PNG file if possible"
   SYNOPSIS_="$NAME_ [-hl] <file> [file...]"
   REQUIRES_="standard GNU commands, pngcrush"
   VERSION_="1.0"
   DATE_="2004-06-29; last update: 2004-12-30"
   AUTHOR_="Dawid Michalczyk <dm@eonworks.com>"
   URL_="www.comp.eonworks.com"
   CATEGORY_="gfx"
   PLATFORM_="Linux"
   SHELL_="bash"
   DISTRIBUTE_="yes"
   # This program is distributed under the terms of the GNU General Public License
   usage()
   {
      echo >&2 "$NAME_ $VERSION_ - $PURPOSE_
      Usage: $SYNOPSIS_
      Requires: $REQUIRES_
      Options:
         -h, usage and options (this help)
         -l, see this script"
      exit 1
   }
   # tmp file set up
   tmp_1=/tmp/tmp.${RANDOM}$$
   # signal trapping and tmp file removal
   trap 'rm -f $tmp_1 >/dev/null 2>&1' 0
   trap "exit 1" 1 2 3 15
   # var init
   old_total=0
   new_total=0
   # arg handling and main execution
   case "$1" in
      -h) usage ;;
      -l) more $0; exit 1 ;;
       *.*) # main execution
      # check if required command is in $PATH variable
      which pngcrush &> /dev/null
      [[ $? != 0 ]] && { echo >&2 required \"pngcrush\" command is not in your PATH; exit 1; }
      for a in "$@";do
         if [ -f $a ] && [[ ${a##*.} == [pP][nN][gG] ]]; then
             old_size=$(ls -l $a | { read b c d e f g; echo $f ;} )
             echo -n "${NAME_}: $a $old_size -> "
             pngcrush -q $a $tmp_1
             rm -f -- $a
             mv -- $tmp_1 $a
             new_size=$(ls -l $a | { read b c d e f g; echo $f ;} )
             echo $new_size bytes
             (( old_total += old_size ))
             (( new_total += new_size ))
         else
             echo ${NAME_}: file $a either does not exist or is not a png file
         fi
      done ;;
      *) echo ${NAME_}: skipping $1 ; continue ;;
   esac
   percentage=$(echo "scale = 2; ($new_total*100)/$old_total" | bc)
   reduction=$(echo $(( old_total - new_total )) \
   | sed '{ s/$/@/; : loop; s/\(...\)@/@.\1/; t loop; s/@//; s/^\.//; }')
   echo "${NAME_}: total size reduction: $reduction bytes (total size reduced to ${percentage}%)"
}

# @description Convert text file to pdf
# Requires:txt2html python-pisa
# @arg $1 string input textfile
txt2pdf() { 
   xhtml2pdf -b "${1%.*}" < <(txt2html "$1");
}

# @description Resizing an image
# @arg $1 int percentage of image resize
# @arg $2 string input image file
# @arg $3 string output image file
image_resize() {
   convert -sample "$1"%x"$1"% "$2" "$3"
}