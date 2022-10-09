
# @file find.sh
# @description Functions and aliases to find files

# @description find files with pattern $1 in name and Execute $2 on it
# @arg $1 string search pattern
# @arg $2 string command to execute on found files
find::execute() {
   find . -type f -iname '*$1*' -exec "${2:-file}" {} \;  ;
}
alias fe='find::execute'

# @description find files under current directory
# @arg $1 string search pattern
find::current() { /usr/bin/find . -name "$@" ; }

# @description find files whose name ends with a given string
# @arg $1 string search pattern
find::endswith() { /usr/bin/find . -name '*'"$@" ; }

# @description find files whose name starts with a given string
# @arg $1 string search pattern
find::startwith() { /usr/bin/find . -name "$@"'*' ; }

# @description find files larger than a certain size (in bytes)
# @arg $1 string search pattern
find::larger() { find . -type f -size +${1}c ; }

# @description find a file with a pattern in name in the local directory
# @arg $1 string search pattern
find::pattern()   { find . -type f -iname '*'$*'*' -ls ; }

# @description Find in file and ( AND relation ) 
# Will search PWD for text files that contain $1 AND $2 AND $3 etc...
# Actually it does the same as grep word1|grep word2|grep word3 etc, but in a more elegant way.
# @arg $1 string search pattern1
# @arg $2 string search pattern2
# @arg $3 string search pattern3 (optional)
find::and() { (($# < 2)) && { echo "usage: ffa pat1 pat2 [...]" >&2; return 1; };awk "/$1/$(printf "&&/%s/" "${@:2}")"'{ print FILENAME ":" $0 }' *; }

# @description tgrep through files found by find, e.g. grepf pattern '*.c'
# note that 'grep -r pattern dir_name' is an alternative if want all files
# @arg $1 string search pattern for find
# @arg $2 string search pattern for grep
find::grep() { find . -type f -name "$2" -print0 | xargs -0 grep "$1" ; }

# @description find pattern in a set of files and highlight them
# @arg $1 string search pattern for grep
# @arg $2 string search pattern for find
find:str() {
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
    Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
      case "$opt" in
         i) case="-i " ;;
         *) echo "$usage"; return;;
         esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
      echo "$usage"
      return;
    fi
    local SMSO=$(tput smso)
    local RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print0 | xargs -0 grep -sn ${case} "$1" 2>&- | \
   sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

# @description searches through the text of all the files in your current directory, see http://seanp2k.com/?p=13
# @arg $1 string search pattern for grep
grip() {
   grep -ir "$1" "$PWD"
}

# @description who is the newest file in a directory
# @arg $1 string folder to search in (defaults to .)
find::newest() { find ${1:-\.} -type f |xargs ls -lrt ; }
