# @file timer_stopwatch.sh
# @description Helper functions for stopping time or time countdown

# @description simple stopwatch for terminal
# copyright 2007 - 2010 Christopher Bratusek
stopwatch() { 
   BEGIN=$(date +%s)
   while true; do
      NOW=$(date +%s)
      DIFF=$(($NOW - $BEGIN))
      MINS=$(($DIFF / 60))
      SECS=$(($DIFF % 60))
      echo -ne "Time elapsed: $MINS:$(printf %02d $SECS)\r"
      sleep .1
   done
}

# @description countdown clock
# @arg $1 int seconds to count
countdown() { 
   case "$1" in -s) shift ;; *) set $(($1 * 60)) ;; esac
   local S=" "
   for i in $(seq "$1" -1 1); do
      echo -ne "$S\r $i\r"
      sleep 1
   done
   echo -e "$S\rBOOM!"
}