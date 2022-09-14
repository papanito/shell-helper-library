# @file processes.sh
# @brief Process Management
# @description helper functions for process management

alias hiddenpnps='unhide (proc|sys|brute)' # forensic tool to find hidden processes and ports
alias hogc='ps -e -o %cpu,pid,ppid,user,cmd | sort -nr | head' # display the processes that are using the most CPU time and memory
alias hogm='ps -e -o %mem,pid,ppid,user,cmd | sort -nr | head' # display the processes that are using the most CPU time and memory
alias mem_hogs_ps='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10' # to find memory hogs
alias mem_hogs_top='top -l 1 -o rsize -n 10' # to find memory hogs
alias myps='/bin/ps -u "$USER" -o user,pid,ppid,pcpu,pmem,args|less' # ps
alias processbycpuusage="ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed '/^ 0.0 /d'"
alias processbymemusage='ps -e -o rss=,args= | sort -b -k1,1n | pr -TW$COLUMNS'
alias processtree='ps -e -o pid,args --forest'
alias topforever='top -l 0 -s 10 -o cpu -n 15' # continual 'top' listing (every 10 sec) showing top 15 CPU things
alias topten='du -sk $(/bin/ls -A) | sort -rn | head -10' # displays the top ten biggest folders/files in the current directory
alias top20='du -xk | sort -n | tail -20' # find the 20 biggest directories on the current filesystem
alias top_='xtitle Processes on $HOST && top' # uses the function 'xtitle'

# @description Kill a process by name
# @arg $1 string name of process to kill
# @arg $2 int SIGNAL to send to process
function killps()
{
   local pid pname sig="-TERM" # default signal
   if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
      echo "Usage: killps [-SIGNAL] pattern"
      return
   fi
   if [ $# = 2 ]; then sig=$1; fi
   for pid in $(myps | nawk '!/nawk/ && $0~pat { print $2 }' pat=${!#}); do
      pname=$(myps | nawk '$2~var { print $6 }' var=$pid)
      if ask "Kill process $pid <$pname> with signal $sig ? "; then
         kill $sig $pid
      fi
   done
}

# @description Count processes that are running
# copyright 2007 - 2010 Christopher Bratusek
function count_processes()
{
   case $1 in
   *help)
      echo -e "\n${ewhite}Usage:"
      echo -e "\n${eorange}count_processes${ewhite} | ${egreen}! no options !\n"
      tput sgr0
      ;;
   *)
      procs=$(ps ax | wc -l | awk '{print $1}')
      if [[ $procs -lt 10 ]]; then
         echo "000$procs"
      elif [[ $procs -lt 100 ]]; then
         echo "00$procs"
      elif [[ $procs -lt 1000 ]]; then
         echo "0$procs"
      fi
      ;;
   esac
}
