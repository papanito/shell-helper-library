# @file datetime.sh
# @brief Helper functions for date and time
# @description helper functions for date and time

# @section aliases for date and tiem
# @description Information (clock and date stuff)
alias bdate2="date +'%a %Y-%m-%d %H:%M:%S %z'" # date command (ex. Sun 2011-01-23 05:39:26 -0500)
alias bdate3='date "+%Y-%m-%d %A %T %Z"' # date command (ex. 2011-01-23 Sunday 05:39:23 EST)
alias bdate="date '+%a, %b %d %Y %T %Z'" # date command (ex. Sun, Jan 23 2011 05:39:13 EST)
alias cal='cal -3' # show 3 months by default
alias dateh='date --help|sed "/^ *%a/,/^ *%Z/!d;y/_/!/;s/^ *%\([:a-z]\+\) \+/\1_/gI;s/%/#/g;s/^\([a-y]\|[z:]\+\)_/%%\1_%\1_/I"|while read L;do date "+${L}"|sed y/!#/%%/;done|column -ts_' # view all date formats, quick reference help alias
alias day='date +%A' # day of the week (ex. Saturday)
alias dayn='date +%d' # date (numeric) (ex. 22)
alias daysleft='echo "There are $(($(date +%j -d"Dec 31, $(date +%Y)")-$(date +%j))) left in year $(date +%Y)."' # how many days until the end of the year
alias month='date +%B' # month (ex. January)
alias ntpdate='sudo ntpdate ntp.ubuntu.com pool.ntp.org' # time synchronisation with NTP (ex. 23 Jan 05:46:29)
alias oclock='read -a A<<<".*.**..*....*** 8 9 5 10 6 0 2 11 7 4";for C in `date +"%H%M"|fold -w1`;do echo "${A:${A[C+1]}:4}";done' # odd clock
alias secconvert='date -d@1234567890' # convert seconds to human-readable format (ex. Fri Feb 13 18:31:30 EST 2009)
alias stamp='date "+%Y%m%d%H%M"' # timestamp (ex. 201101230545)
alias time2='date +"%I:%M"' # time (hours:minutes) (ex. 05:13)
alias time3='date +"%l:%M %p"' # time (ex. 5:13 AM)
alias time4='date +"%H:%M"' # time (hours:minutes) (ex. 05:13)
alias timestamp='date "+%Y%m%dT%H%M%S"' # timestamp (ex. 20110123T054906)
alias today='date +"%A, %B %-d, %Y"' # date command (ex. Sunday, January 23, 2011)
alias weeknum='date +%V' # perl one-liner to get the current week number (ex. 03)

###############################################################################
# Miscellaneous Fun
###############################################################################
alias matrix='echo -e "\e[32m"; while :; do for i in {1..16}; do r="$(($RANDOM % 2))"; if [[ $(($RANDOM % 5)) == 1 ]]; then if [[ $(($RANDOM % 4)) == 1 ]]; then v+="\e[1m $r "; else v+="\e[2m $r "; fi; else v+=" "; fi; done; echo -e "$v"; v=""; done'
alias matrix2='echo -e "\e[31m"; while $t; do for i in `seq 1 30`;do r="$[($RANDOM % 2)]";h="$[($RANDOM % 4)]";if [ $h -eq 1 ]; then v="\e[1m $r";else v="\e[2m $r";fi;v2="$v2 $v";done;echo -e $v2;v2="";done;'
alias matrix3='COL=$(( $(tput cols) / 2 )); clear; tput setaf 2; while :; do tput cup $((RANDOM%COL)) $((RANDOM%COL)); printf "%$((RANDOM%COL))s" $((RANDOM%2)); done'
alias matrix4='echo -ne "\e[32m" ; while true ; do echo -ne "\e[$(($RANDOM % 2 + 1))m" ; tr -c "[:print:]" " " < /dev/urandom | dd count=1 bs=50 2> /dev/null ; done'
alias matrix5='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=lcase,unblock | GREP_COLOR="1;32" grep --color "[^ ]"'
alias screensaver='for ((;;)); do echo -ne "\033[$((1+RANDOM%LINES));$((1+RANDOM%COLUMNS))H\033[$((RANDOM%2));3$((RANDOM%8))m$((RANDOM%10))"; sleep 0.1 ; done'  # terminal screensaver

# @description convert normal to unix
# @arg $1 string normlatime
function normal2unix()
{
    echo "${@}" | awk '{print mktime($0)}';
}

# @description convert unix to normal
# @arg $1 string unixtime
function unix2normal()
{
    echo $1 | awk '{print strftime("%Y-%m-%d %H:%M:%S",$1)}';
}

# @description convert seconds to minutes, hours, days, and etc.
# inputs a number of seconds, outputs a string like "2 minutes, 1 second"
# @arg $1 int number of seconds
function sec2all()
{
    local millennia=$((0))
    local centuries=$((0))
    local years=$((0))
    local days=$((0))
    local hour=$((0))
    local mins=$((0))
    local secs=$1
    local text=""
    # convert seconds to days, hours, etc
    millennia=$((secs / 31536000000))
    secs=$((secs % 31536000000))
    centuries=$((secs / 3153600000))
    secs=$((secs % 3153600000))
    years=$((secs / 31536000))
    secs=$((secs % 31536000))
    days=$((secs / 86400))
    secs=$((secs % 86400))
    hour=$((secs / 3600))
    secs=$((secs % 3600))
    mins=$((secs / 60))
    secs=$((secs % 60))
    # build full string from unit strings
    text="$text$(seconds-convert-part $millennia "millennia")"
    text="$text$(seconds-convert-part $centuries "century")"
    text="$text$(seconds-convert-part $years "year")"
    text="$text$(seconds-convert-part $days "day")"
    text="$text$(seconds-convert-part $hour "hour")"
    text="$text$(seconds-convert-part $mins "minute")"
    text="$text$(seconds-convert-part $secs "second")"
    # trim leading and trailing whitespace"
    text=${text## }
    text=${text%% }
    # special case for zero seconds
    if [ "$text" == "" ]; then
      text="0 seconds"
    fi
    # echo output for the caller
    echo ${text}
}

# @description formats a time unit into a string
# @arg $1 int integer count of units: 0, 6, etc
# @arg $2 string unit name: "hour", "minute", etc
function seconds-convert-part()
{
    local unit=$1
    local name=$2
    if [ $unit -ge 2 ]; then
   echo " ${unit} ${name}s"
    elif [ $unit -ge 1 ]; then
   echo " ${unit} ${name}"
    else
   echo ""
    fi
}