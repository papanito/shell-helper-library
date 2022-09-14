# @file filesfolders.sh
# @brief Directories/Folders
# @description Helper functions to deal with directories

# @section navigation
# @description functions for easier navigation

# @description Change directory and list files
# @arg $1 string directory name
function cds()
{
    # only change directory if a directory is specified
    [ -n "${1}" ] && cd $1
    ll
}

# @description Makes directory then moves into it
# @arg $1 string directory name
function mkdircd()
{
    mkdir -p -v $1
    cd $1
}

# @section size and statistics
# @description get sizes and statistics for files and folders
alias df='df -h -x tmpfs -x usbfs' # displays global disk usage by partition, excluding supermounted devices
alias directorydiskusage='du -s -k -c * | sort -rn'
alias dir='ls --color=auto --format=vertical'
alias ducks='ls -A | grep -v -e '\''^\.\.$'\'' |xargs -i du -ks {} |sort -rn |head -16 | awk '\''{print $2}'\'' | xargs -i du -hs {}' # useful alias to browse your filesystem for heavy usage quickly # to show processes reading/writing to disk
alias du1='du -h --max-depth=1' # displays disk usage by directory, in human readable format
alias dush='du -sm *|sort -n|tail' # easily find megabyte eating files or directories
alias numFiles='echo $(ls -1 | wc -l)' # numFiles: number of (non-hidden) files in current directory
alias sizeof='du -sh'
alias space='df -h' # disk space usage

# @description Show empty files in the directed directory
# copyright 2007 - 2010 Christopher Bratusek
# @arg $1 string path to check
function empty_files()
{
   find "$1" -empty
}

# @description Count files in current directory
# copyright 2007 - 2010 Christopher Bratusek
function count_files()
{
   case $1 in
      *+h)
         echo $(($(ls --color=no -1 -la . | grep -v ^l | wc -l)-1))
      ;;
      *-h)
         echo $(($(ls --color=no -1 -l . | grep -v ^l | wc -l)-1))
      ;;
      *+d)
         echo $(($(ls --color=no -1 -la . | grep -v ^- | wc -l)-1))
      ;;
      *-d)
         echo $(($(ls --color=no -1 -l . | grep -v ^- | wc -l)-1))
      ;;
      *+f)
         echo $(($(ls --color=no -1 -la . | grep -v ^d | wc -l)-1))
      ;;
      *-f)
         echo $(($(ls --color=no -1 -l . | grep -v ^d | wc -l)-1))
      ;;
      *)
         echo -e "\n${ewhite}Usage:"
         echo -e "\n${eorange}count_files${ewhite} | ${egreen}+h ${eiceblue}[count files and folders - include hidden ones] \
         \n${eorange}count_files${ewhite} | ${egreen}-h ${eiceblue}[count files and folders - exclude hidden ones] \
         \n${eorange}count_files${ewhite} | ${egreen}+d ${eiceblue}[count folders - include hidden ones] \
         \n${eorange}count_files${ewhite} | ${egreen}-d ${eiceblue}[count folders - exclude hidden ones] \
         \n${eorange}count_files${ewhite} | ${egreen}+f ${eiceblue}[count files - include hidden ones] \
         \n${eorange}count_files${ewhite} | ${egreen}-f ${eiceblue}[count files - exclude hidden ones]\n"
         tput sgr0
      ;;
   esac
}

# @description Finds directory sizes and lists them for the current directory
# @noargs
function dirsize()
{
   du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
   egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
   egrep '^ *[0-9.]*M' /tmp/list
   egrep '^ *[0-9.]*G' /tmp/list
   rm /tmp/list
}

# @descripton Size of directories in MB
# @arg $1 string directory for size
function ds()
{
    echo "size of directories in MB"
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
      echo "you did not specify a directy, using pwd"
      DIR=$(pwd)
      find $DIR -maxdepth 1 -type d -exec du -sm \{\} \; | sort -nr
    else
      find $1 -maxdepth 1 -type d -exec du -sm \{\} \; | sort -nr
    fi
}

# @description Size of items in directory
# @noargs
function dubigf()
{
   du -sh * | awk '/[[:space:]]*[[:digit:]]+,*[[:digit:]]*G/' | sort -nr
   du -sh * | awk '/[[:space:]]*[[:digit:]]+,*[[:digit:]]*M/' | sort -nr
}

# @section File Edit and File Info
# @description Functions for editing files or getting file infos
alias wordcount='wc -w $1' # count number of words in text file
# @description Echo the lines of a file preceded by line   number
# @arg $1 string filename
function numLines()
{ 
   perl -pe 's/^/$. /' "$@" ;
}

# @description How many pages will my text files print on?
# @arg $1 string filename
function numpages()
{ 
   echo $(($(wc -l $* | sed -n 's/ total$//p')/60));
}

# @description Computes most frequent used words of text file
# @arg $1 string filenamesage:   most_frequent "file.txt"
function most_frequent()
{
   cat "$1" | tr -cs "[:alnum:]" "\n"| tr "[:lower:]" "[:upper:]" | awk '{h[$1]++}END{for (i in h){print h[i]" "i}}'|sort -nr | cat -n | head -n 30
}

# Wordcount counts frequency of words in a file
function wordfreq()
{
   cat "$1"|tr -d '[:punct:]'|tr '[:upper:]' '[:lower:]'|tr -s ' ' '\n'|sort|uniq -c|sort -rn
}

# @description counts words in selection and displays result in zenity window
# dependencies xsel, wc, zenity
function numWords()
{
   text=$(xsel)
   words=$(wc -w <<<$text)
   zenity --info --title "Word Count" --text "Words in selection:\n${words}\n\n\"${text}\""
}

# @description Show the contents of a file, including additional useful info
function showfile()
{
   width=72
   for input
   do
   lines="$(wc -l < $input | sed 's/ //g')"
   chars="$(wc -c < $input | sed 's/ //g')"
   owner="$(ls -ld $input | awk '{print $3}')"
   echo "-----------------------------------------------------------------"
   echo "File $input ($lines lines, $chars characters, owned by $owner):"
   echo "-----------------------------------------------------------------"
   while read line
      do
         if [ ${#line} -gt $width ] ; then
            echo "$line" | fmt | sed -e '1s/^/  /' -e '2,$s/^/+ /'
         else
            echo "  $line"
         fi
      done < $input
      echo "-----------------------------------------------------------------"
   done | more
}

# @description Search and replace words/phrases from text file
# @arg $1 string whatever oldtext
# @arg $2 string whatever newtext
# @arg $3 file(s) to act on
function searchnreplace()
{
   # Store old text and new text in variables
   old=$1;
   new=$2;
   # Shift positional parameters to places to left (get rid of old and
   # new from command line)
   shift;
   shift;
   # Store list of files as a variable
   files=$@;
   a='';
   for a in $files
   do
      temp=$(echo "/tmp/$LOGNAME-$a");
      # echo "$temp";
      echo -n ".";
      sed -e "s/$old/$new/g" $a > $temp;
      mv $temp $a;
   done
   echo;
   echo -e "Searched $# files for '$old' and replaced with '$new'";
}

# @description Make a backup before editing a file
# @arg $1 string filename
function safeedit()
{
   cp $1 ${1}.backup && $EDITOR $1
}

# @description sort lines in a text file
# @arg $1 string filename
function linesort()
{
   sort -u "$1" > "$1".new
}

# @description remove duplicate lines in a file (without resorting)
# @arg $1 string filename
function removeduplines()
{
   awk '!x[$0]++' "$1" > "$1".new
}

# @description Edit files in place to ensure Unix line-endings
# @arg $1 string filename
function fixeol()
{
   /usr/bin/perl -pi~ -e 's/\r\n?/\n/g' "$@" ;
}

# @section File Properties manipulation
# @description helper functions to rename files or manipulate properties

alias 000='chmod 000'
alias 640='chmod 640'
alias 644='chmod 644'
alias 755='chmod 755'
alias 775='chmod 775'
alias mx='chmod a+x'
alias chownn='sudo chown -R $USER:$USER'
alias perm='stat --printf "%a %n \n "' # requires a file name e.g. perm file
alias restoremod='chgrp users -R .;chmod u=rwX,g=rX,o=rX -R .;chown $(pwd |cut -d / -f 3) -R .' # restore user,group and mod of an entire website

alias linecount='wc -l $1' # count number of lines in text file

# @description Changes spaces to underscores in names
function underscore()
{
   for f in * ; do
       [ "${f}" != "${f// /_}" ]
      mv -- "${f}" "${f// /_}"
   done
}

# @description move filenames to lowercase
# @noargs
function files_lc()
{
    for file ; do
      filename=${file##*/}
      case "$filename" in
         */*) dirname==${file%/*} ;;
         *) dirname=.;;
         esac
         nf=$(echo $filename | tr A-Z a-z)
         newname="${dirname}/${nf}"
      if [ "$nf" != "$filename" ]; then
         mv "$file" "$newname"
         echo "lowercase: $file --> $newname"
      else
         echo "lowercase: $file not changed."
      fi
    done
}

# @description lowercase all files in the current directory
# @noargs
function dir_lc()
{
   print -n 'Really lowercase all files? (y/n) '
   if read -q ; then
      for i in * ; do
         mv $i $i:l
   done
   fi
}

# Moves specified files to ~/.Trash. Will not overwrite files that have the same name
function trashit()
{
   local trash_dir=$HOME/.Trash
   for file in "$@" ; do
   if [[ -d $file ]] ; then
       local already_trashed=$trash_dir/`basename $file`
       if [[ -n `/bin/ls -d $already_trashed*` ]] ; then
           local count=`/bin/ls -d $already_trashed* | /usr/bin/wc -l`
           count=$((++count))
           /bin/mv --verbose "$file" "$trash_dir/$file$count"
           continue
       fi
   fi
   /bin/mv --verbose --backup=numbered "$file" $HOME/.Trash
    done
}

# @description Swap 2 filenames around (from Uzi's bashrc)
# @arg $1 string first filename
# @arg $2 string second filename
function files_swap()
{
    local TMPFILE=tmp.$$
    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# @description Count total number of subdirectories in current directory starting with specific name.
function subdir_find()
{
   find . -type d -name "*$1*" | wc -l
}

# Sanitize - set file/directory owner and permissions to normal values (644/755)
# usage: sanitize <file>
function sanitize()
{
   chmod -R u=rwX,go=rX "$@"
   chown -R ${USER}:users "$@"
}

# ShowTimes: show the modification, metadata-change, and access times of a file
function showTimes()
{ stat -f "%N:   %m %c %a" "$@" ; }

##### Ownership Changes { own file user }
function own()
{
   chown -R "$2":"$2" ${1:-.};
}

# Set permissions to "standard" values (644/755), recursive
# Usage: resetp
function resetp()
{
    chmod -R u=rwX,go=rX "$@"
}

# Log rm commands
function rm()
{
   workingdir=$( pwdx $$ | awk '{print $2}' ) 
   /usr/bin/rm $*
   echo "rm $* issued at $(date) by the user $(who am i| awk '{print $1} ') in the directory ${workingdir}"  >> /tmp/rm.out ; 
}

# Show all strings (ASCII & Unicode) in a file    #
function allStrings()
{ cat "$1" | tr -d "\0" | strings ; }

# Creates a backup of the file passed as parameter with the date and time
function bak()
{
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
      echo "Creates a backup of the file passed as parameter with the date and time"
      echo "usage: bak [filename]"
    else
      cp $1 ${1}-`date +%Y%m%d%H%M`.backup
    fi
}

# @section Wipe and Secure Delete
# @description securely wipe stuff from disk

alias shred-dev-r='sudo shred -v -z -n 1 $1'
alias shred-dev='sudo shred -v -z -n 0 $1'

# @description overwrite a file with zeros
# @arg $1 string filename
function zero()
{
   case "$1" in
      "")   echo "Usage: zero <file>"
            return -1;
   esac
   filesize=`wc -c  "$1" | awk '{print $1}'`
   `dd if=/dev/zero of=$1 count=$filesize bs=1`
}
