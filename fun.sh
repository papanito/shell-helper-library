# @file fun.sh
# @brief Random fun stuff
# @description functions just for fun on the terminal

alias rcommand='ls /usr/bin | shuf -n 1' # get a random command

# @description pretend to be busy in office to enjoy a cup of coffee
# @noargs
function grepcolor()
{
   cat /dev/urandom | hexdump -C | grep --color=auto "ca fe"
}