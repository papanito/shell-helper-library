# @file archiving.sh
# @description helper functions to work with archives

# @description archive wrapper to automatically select the right command for the given archive type
# @arg $1 string name fo the archive to extract
extract() { 
   local e=0 i c
   for i; do
      if [[ -f $i && -r $i ]]; then
         c=''
         case $i in
         #*.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
         #       c='bsdtar xvf' ;;
         *.7z) c='7z x' ;;
         *.Z) c='uncompress' ;;
         *.bz2) c='bunzip2' ;;
         *.exe) c='cabextract' ;;
         *.gz) c='gunzip' ;;
         *.rar) c='unrar x' ;;
         *.xz) c='unxz' ;;
         *.zip) c='unzip' ;;
         *)
            echo "$0: cannot extract \`$i': Unrecognized file extension" >&2
            e=1
            ;;
         esac
         [[ $c ]] && command $c "$i"
      else
         echo "$0: cannot extract \`$i': File is unreadable" >&2
         e=2
      fi
   done
   return $e
}

# @description Pull a single file out of a .tar.gz
# @arg $1 string name fo the archive
# @arg $1 string name fo the file to extract from archive
pullout() { 
   if [ $# -ne 2 ]; then
      echo "need proper arguments:"
      echo "pullout [file] [archive.tar.gz]"
      return 1
   fi
   case $2 in
   *.tar.gz | *.tgz)
      gunzip <$2 | tar -xf - $1
      ;;
   *)
      echo $2 is not a valid archive
      return 1
      ;;
   esac
   return 0
}

# @description Sets the compression level for file-roller
compression_level() { 
   echo -n "Please enter the number for the desired compression level for file-roller:

   (1) very_fast
   (2) fast
   (3) normal
   (4) maximum

   Press 'Enter' for default (default is '3')...

   "
   read COMPRESSION_LEVEL_NUMBER
   # extra blank space
   echo "
   "
   # default
   if [[ -z $COMPRESSION_LEVEL_NUMBER ]]; then
      # If no COMPRESSION_LEVEL passed, default to '3'
      COMPRESSION_LEVEL=normal
   fi
   # preset
   if [[ $COMPRESSION_LEVEL_NUMBER = 1 ]]; then
      COMPRESSION_LEVEL=very_fast
   fi
   if [[ $COMPRESSION_LEVEL_NUMBER = 2 ]]; then
      COMPRESSION_LEVEL=fast
   fi
   if [[ $COMPRESSION_LEVEL_NUMBER = 3 ]]; then
      COMPRESSION_LEVEL=normal
   fi
   if [[ $COMPRESSION_LEVEL_NUMBER = 4 ]]; then
      COMPRESSION_LEVEL=maximum
   fi

   gconftool-2 --set /apps/file-roller/general/compression_level --type string "$COMPRESSION_LEVEL"
}

# @description Creates a tar archive from directory
# @arg $1 string directory to archive
mktar() {  tar cvf "${1%%/}-$(date +%Y%m%d).tar" "${1%%/}/"; }

# @description Creates a bz archive from directory
# @arg $1 string directory to archive
mktbz() {  tar cvjf "${1%%/}-$(date +%Y%m%d).tar.bz2" "${1%%/}/"; }

# @description Creates a gz archive from directory
# @arg $1 string directory to archive
mktgz() {  tar cvzf "${1%%/}-$(date +%Y%m%d).tar.gz" "${1%%/}/"; }

# @description Creates a zip archive from directory
# @arg $1 string directory to archive
mkzip() {  zip -r "$1"-$(date +%Y%m%d).zip "$1"; }