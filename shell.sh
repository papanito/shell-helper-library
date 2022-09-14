# @file shell.sh
# @brief Terminal functions
# @description helper functions for the work in the terminal

##### Color chart
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

alias showallaliases='compgen -A alias' # list bash alias defined in .bash_profile or .bashrc
alias showallfunctions='compgen -A function' # list bash functions defined in .bash_profile or .bashrc

# @description Helper function to separate output with a given character
# @arg $1 string (optional) character for separation, default is `-`
# @arg $2 int (optional) how much characters to print, default is 80
text_separator() {
   ch="-"
   len="80"
   if [ "$#" -eq 2 ]; then
      ch=$1
   elif [ "$#" -gt 2 ]; then
      ch=$1
      len=$2
   fi 
   printf '%*s\n' "$len" | tr ' ' "$ch"
}

# @description Helper function to check if a given tool is installed, otherwise die
# @arg $1 string name of the binary
# @arg $2 string additional text to the error message (e.g. where to download)
need() {
   which "$1" &>/dev/null || die "Binary '$1' is missing but required\n$2"
}

# @description Temporarily add to PATH
# @arg $1 string path to add
function apath()
{
   if [ $# -lt 1 ] || [ $# -gt 2 ]; then
      echo "Temporarily add to PATH"
      echo "usage: apath [dir]"
   else
      PATH=$1:$PATH
   fi
}

# @description center text in console with simple pipe like
# @arg $1 string text to print
function align_center()
{
   l="$(cat -)"; s=$(echo -e "$l"| wc -L); echo "$l" | while read l;do j=$(((s-${#l})/2));echo "$(while ((--j>0)); do printf " ";done;)$l";done;
} #; ls --color=none / | center

# @description right-align text in console using pipe like ( command | right )
# @arg $1 string text to print
function align_right()
{
   l="$(cat -)"; [ -n "$1" ] && s=$1 || s=$(echo -e "$l"| wc -L); echo "$l" | while read l;do j=$(((s-${#l})));echo "$(while ((j-->0)); do printf " ";done;)$l";done;
} #; ls --color=none / | right 150

# @description Set terminal title
# @arg $1 string title of the terminal
function terminal_title
{
    echo -en "\033]2;$@\007"
}

# @description Set terminal title
# @arg $1 string title of the terminal
function xtitle()
{
    case "$TERM" in
   *term | rxvt)
       echo -n -e "\033]0;$*\007" ;;
   *)
       ;;
    esac
}

# @description Open a GUI app from CLI
# @arg $1 string name of the GUI app
function open()
{
   $1 >/dev/null 2>&1 &
}

# @description Super stealth background launch
# @arg $1 string command to run in stealth mode
function daemon()
{
    (exec "$@" >&/dev/null &)
}

# @description Shell function to exit script with error in exit status and print optional message to stderr
function die()
{
   result=$1;shift;[ -n "$*" ]&&printf "%s\n" "$*" >&2;exit $result;
}

# @description Run a command, redirecting output to a file, then edit the file with vim
function vimcmd()
{ 
   $1 > $2 && vim $2;
}

# @description Ask user for y/Y
# @arg $1 string question to display
function ask()
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
      y*|Y*) return 0 ;;
      *) return 1 ;;
    esac
}

# @description Repeats a command every x seconds
# @arg $1 int PERIOD in s after COMMAND is executed
# @arg $2 string COMMAND to be executed
function repeat()
{
   local period
   period=$1; shift;
   while (true); do
      eval "$@";
      sleep $period;
   done
}

# @description Function that outputs dots every second until command completes
function progress()
{ 
   while `ps -p $1 &>/dev/null`; do echo -n "${2:-.}"; sleep ${3:-1}; done; 
}

# @description show progress bar while running a command
# copyright 2007 - 2010 Christopher Bratusek
# @arg $1 string process to wait for
# @arg $2 string characters to show in the progress bar
function progressbar()
{
   SP_COLOUR="\e[37;44m"
   SP_WIDTH=5.5
   SP_DELAY=0.2
   SP_STRING=${2:-"'|/=\'"}
   while [ -d /proc/$1 ]
   do
      printf "$SP_COLOUR\e7  %${SP_WIDTH}s  \e8\e[01;37m" "$SP_STRING"
      sleep ${SP_DELAY:-.2}
      SP_STRING=${SP_STRING#"${SP_STRING%?}"}${SP_STRING%?}
   done
   tput sgr0
}

# @description show "please wait" while running a command
# copyright 2007 - 2010 Christopher Bratusek
# @arg $1 string process to wait for
function spanner()
{
   PROC=$1;COUNT=0
   echo -n "Please wait "
   while [ -d /proc/$PROC ];do
      while [ "$COUNT" -lt 10 ];do
         echo -ne '\x08  ' ; sleep 0.1
         ((COUNT++))
      done
      until [ "$COUNT" -eq 0 ];do
         echo -ne '\x08\x08 ' ; sleep 0.1
         ((COUNT -= 1))
      done
   done
}

# @description show moving spinner while running a command
# copyright 2007 - 2010 Christopher Bratusek
# @arg $1 string process to wait for
# @arg $2 string characters to show in the progress bar
function spin()
{
   echo -n "|/     |"
   while [ -d /proc/$1 ]
   do
   # moving right
   echo -ne "\b\b\b\b\b\b\b-     |"
   sleep .05
   echo -ne "\b\b\b\b\b\b\b\\     |"
   sleep .05
   echo -ne "\b\b\b\b\b\b\b|     |"
   sleep .05
   echo -ne "\b\b\b\b\b\b\b /    |"
   sleep .05
   echo -ne "\b\b\b\b\b\b-    |"
   sleep .05
   echo -ne "\b\b\b\b\b\b\\    |"
   sleep .05
   echo -ne "\b\b\b\b\b\b|    |"
   sleep .05
   echo -ne "\b\b\b\b\b\b /   |"
   sleep .05
   echo -ne "\b\b\b\b\b-   |"
   sleep .05
   echo -ne "\b\b\b\b\b\\   |"
   sleep .05
   echo -ne "\b\b\b\b\b|   |"
   sleep .05
   echo -ne "\b\b\b\b\b /  |"
   sleep .05
   echo -ne "\b\b\b\b-  |"
   sleep .05
   echo -ne "\b\b\b\b\\  |"
   sleep .05
   echo -ne "\b\b\b\b|  |"
   sleep .05
   echo -ne "\b\b\b\b / |"
   sleep .05
   echo -ne "\b\b\b- |"
   sleep .05
   echo -ne "\b\b\b\\ |"
   sleep .05
   echo -ne "\b\b\b| |"
   sleep .05
   echo -ne "\b\b\b /|"
   sleep .05
   echo -ne "\b\b-|"
   sleep .05
   echo -ne "\b\b\\|"
   sleep .05
   echo -ne "\b\b||"
   sleep .05
   echo -ne "\b\b/|"
   sleep .05
   # moving left
   echo -ne "\b\b||"
   sleep .05
   echo -ne "\b\b\\|"
   sleep .05
   echo -ne "\b\b-|"
   sleep .05
   echo -ne "\b\b\b/ |"
   sleep .05
   echo -ne "\b\b\b| |"
   sleep .05
   echo -ne "\b\b\b\\ |"
   sleep .05
   echo -ne "\b\b\b- |"
   sleep .05
   echo -ne "\b\b\b\b/  |"
   sleep .05
   echo -ne "\b\b\b\b|  |"
   sleep .05
   echo -ne "\b\b\b\b\\  |"
   sleep .05
   echo -ne "\b\b\b\b-  |"
   sleep .05
   echo -ne "\b\b\b\b\b/   |"
   sleep .05
   echo -ne "\b\b\b\b\b|   |"
   sleep .05
   echo -ne "\b\b\b\b\b\\   |"
   sleep .05
   echo -ne "\b\b\b\b\b-   |"
   sleep .05
   echo -ne "\b\b\b\b\b\b/    |"
   sleep .05
   echo -ne "\b\b\b\b\b\b|    |"
   sleep .05
   echo -ne "\b\b\b\b\b\b\\    |"
   sleep .05
   echo -ne "\b\b\b\b\b\b-    |"
   sleep .05
   echo -ne "\b\b\b\b\b\b\b/     |"
   sleep .05
   done
   echo -e "\b\b\b\b\b\b\b\b\b|=======| done!"
}

# @description show non-moving spinner while running a command
# copyright 2007 - 2010 Christopher Bratusek
# @arg $1 string process to wait for
# @arg $2 string characters to show in the progress bar
function spinner()
{
   PROC=$1
   while [ -d /proc/$PROC ];do
      echo -ne '\e[01;32m/\x08' ; sleep 0.05
      echo -ne '\e[01;32m-\x08' ; sleep 0.05
      echo -ne '\e[01;32m\\\x08' ; sleep 0.05
      echo -ne '\e[01;32m|\x08' ; sleep 0.05
   done
}

# @description Display a progress process
# To start the spinner2 function, you have to send the function
# into the background. To stop the spinner2 function, you have
# to define the argument "stop".
# @exaple
#    echo -n "Starting some daemon "; spinner2 &
#    if sleep 10; then
#       spinner2 "stop"; echo -e "   [ OK ]"
#    else
#       spinner2 "stop"; echo -e "   [ FAILED ]"
#    fi
function spinner2()
{
   local action=${1:-"start"}
   declare -a sign=( "-" "/" "|" "\\\\" )
   # define singnal file...
   [ "$action" = "start" ] && echo 1 > /tmp/signal
   [ "$action" = "stop" ] && echo 0 > /tmp/signal
   while [ "$( cat /tmp/signal 2>/dev/null )" == "1" ] ; do
     for (( i=0; i<${#sign[@]}; i++ )); do
         echo -en "${sign[$i]}\b"
         # with this command you can use millisecond as sleep time - perl rules ;-)
         perl -e 'select( undef, undef, undef, 0.1 );'
     done
   done
   # clear the last ${sign[$i]} sign at finish...
   [ "$action" = "stop" ] && echo -ne " \b"
}

# @description colorize message in shell
# @arg $1 string text to colorize
function sh_colormsg()
{
   [ -n "$1" ] && echo -en "${txtcolor}${@}${txtrst}"
}

# @description colorize and display error message in shell
# @arg $1 string text to colorize
function sh_error()
{
   echo -e "${txtred}[ e ] $@ ${txtrst}"
}

# @description colorize and display info message in shell
# @arg $1 string text to colorize
function sh_info()
{
   echo -e "${txtinfo}[ i ] $@ ${txtrst}"
}

# @description colorize and display success message in shell
# @arg $1 string text to colorize
function sh_success()
{
   echo -e "${txtgrn}[ k ] $@ ${txtrst}"
}

# @description colorize and display message in shell
# @arg $1 string text to colorize
function sh_mesg()
{
   echo -e "${txtmsg}[ m ] $@ ${txtrst}"
}

# @description Extract a particular column of space-separated output
# @arg $1 int number of the column to extract
# @example
# lsof | getcolumn 0 | sort | uniq
function getcolumn()
{ 
   perl -ne '@cols = split; print "$cols['$1']\n"' ;
}

# @description Surround lines with quotes (useful in pipes) - from mervTormel
function enquote()
{
   /usr/bin/sed 's/^/"/;s/$/"/'
}

# @description ruler that stretches across the terminal
function ruler()
{ for s in '....^....|' '1234567890'; do w=${#s}; str=$( for (( i=1; $i<=$(( ($COLUMNS + $w) / $w )) ; i=$i+1 )); do echo -n $s; done ); str=$(echo $str | cut -c -$COLUMNS) ; echo $str; done; }

# @description Determining the meaning of error codes
# @arg $1 int error code
function err()
{
    grep --recursive --color=auto --recursive -- "$@" /usr/include/*/errno.h
    if [ "${?}" != 0 ]; then
      echo "Not found."
    fi
}

# @section colors
# @description work with colors on the terminal

# @description print all 256 colors for testing TERM or for a quick reference
# show numerical values for each of the 256 colors in bash
function colors2nums()
{
   for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done
}

# @description show color for given number
# @arg $1 int value of the color to show
function getColor()
{
   echo -e "\e[38;05;$1mColor"
}


# @description takes a name of a color and some text and then echoes out the text in the named color
# @example
# colorize_text "color" "whatever text"
function colorize-text()
{
   b='[0;30m'
   # Implement command-line options
   while getopts "nr" opt
   do
      case $opt in
         n  )  o='-n' ;;
         r  )  b=''   ;;
      esac
   done
   shift $(($OPTIND - 1))
   # Set variables
   col=$1
   shift
   text="$*"
   # Set a to console color code
   case $col in
       'black'  ) a='[0;30m' ;;
       'blue'   ) a='[0;34m' ;;
       'green'  ) a='[0;32m' ;;
       'cyan'   ) a='[0;36m' ;;
       'red'    ) a='[0;31m' ;;
       'purple' ) a='[0;35m' ;;
       'brown'  ) a='[0;33m' ;;
       'ltgray' ) a='[0;37m' ;;
       'white'  ) a='[1;30m' ;;
       'ltblue' ) a='[1;34m' ;;
       'ltgreen') a='[1;32m' ;;
       'ltcyan' ) a='[1;36m' ;;
       'ltred'  ) a='[1;31m' ;;
       'pink'   ) a='[1;35m' ;;
       'yellow' ) a='[1;33m' ;;
       'gray'   ) a='[1;37m' ;;
   esac
   # Display text in designated color, no newline
   echo -en "\033$a$text"
   # If 'b' switch not on, restore color to black
   if [ -n $b ]
   then
      echo -en "\033$b"
   fi
   # If 'n' switch on, do not display final newline
   # otherwise output newline
   echo $o
}

# @description displays all 256 possible background colors, using ANSI escape sequences.
# author: Chetankumar Phulpagare
# used in ABS Guide with permission.
function colors2()
{
   T1=8
   T2=6
   T3=36
   offset=0
   for num1 in {0..7}
   do {
      for num2 in {0,1}
         do {
        shownum=`echo "$offset + $T1 * ${num2} + $num1" | bc`
        echo -en "\E[0;48;5;${shownum}m color ${shownum} \E[0m"
        }
         done
      echo
      }
   done
   offset=16
   for num1 in {0..5}
   do {
      for num2 in {0..5}
         do {
        for num3 in {0..5}
           do {
              shownum=`echo "$offset + $T2 * ${num3} \
              + $num2 + $T3 * ${num1}" | bc`
              echo -en "\E[0;48;5;${shownum}m color ${shownum} \E[0m"
              }
            done
        echo
        }
         done
   }
   done
   offset=232
   for num1 in {0..23}
   do {
      shownum=`expr $offset + $num1`
      echo -en "\E[0;48;5;${shownum}m ${shownum}\E[0m"
   }
   done
   echo
}

# @section UI enhancements
# @description functions used within a DE

# @description Reminder for whatever whenever
# @arg $1 int time to sleep in ms
# @arg ä2 string text to show after time has elapsed
function remindme()
{
   sleep $1 && zenity --info --text "$2" &
}

# @description used for bash nautilus scripts to show a warning if something goes wrong
# use as follows in your scripts
# trap errormsg  SIGINT SIGTERM ERR
# @arg $1 string error message to show
function errormsg()
{
    zenity --warning \
   --text $1 2>/dev/null
}

# @description Add an "alert" alias for long running commands. Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# @section Bash History
# @description Helper functions for bash history

# @description search bash history using sed
# @arg $1 string search pattern
function hgrepl()
{
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
      echo "search bash history"
      echo "usage: hgrepl [search pattern]"
    else
      history | sed s/.*\ \ // | grep $@
   fi
}

# @description search bash history using sed
# @arg $1 string search pattern
function hgrep()
{
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
      echo "search bash history"
      echo "usage: hgrep [search pattern]"
   fi
}

# @description search bash history using sed
# @arg $1 string search pattern
function hhgrep()
{
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
      echo "search bash history"
      echo "usage: hhgrep [search pattern]"
    else
      history | grep -E "$@" | grep -v -E "hgrep $@"
   fi
}

# @description Analyze your bash usage
function histtop()
{
   cut -f1 -d" " $HISTFILE | sort | uniq -c | sort -nr | head -n 30
}

# Edit your history file
function he()
{
   history -a ; vi $HISTFILE history -r ;
}

# @section pipe helper
# @description helper functions to use with pipes

alias counts='sort | uniq -c | sort -nr' # a nice command for summarising repeated information