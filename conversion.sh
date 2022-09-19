
# @file conversion.sh
# @description helper functions to convert to any other format

# @section ascii and numeric conversion
# @description helper functions to convert to ascii to another format

# @description Output an ASCII character given its decimal equivalent
# @arg $1 int decimal value to convert
chr() {
   printf \\$(($1/64*100+$1%64/8*10+$1%8))
}

# @description convert ascii to another format
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string text to convert
asc2all() {
   if [[ $1 ]]; then
      echo "ascii $1 = binary $(asc2bin $1)"
      echo "ascii $1 = octal $(asc2oct $1)"
      echo "ascii $1 = decimal $(asc2dec $1)"
      echo "ascii $1 = hexadecimal $(asc2hex $1)"
      echo "ascii $1 = base32 $(asc2b32 $1)"
      echo "ascii $1 = base64 $(asc2b64 $1)"
   fi
}

# @description convert ascii to binary
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string text to convert
asc2bin() {
   if [[ $1 ]]; then
      echo "obase=2 ; $(asc2dec $1)" | bc
   fi
}

# @description convert ascii to base64
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string text to convert
asc2b64() {
   if [[ $1 ]]; then
      echo "obase=64 ; $(asc2dec $1)" | bc
   fi
}

# @description convert ascii to base32
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string text to convert
asc2b32() {
   if [[ $1 ]]; then
      echo "obase=32 ; $(asc2dec $1)" | bc
   fi
}

# @description convert ascii to decimal
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string text to convert
asc2dec() {
   if [[ $1 ]]; then
      printf '%d\n' "'$1'"
   fi
}

# @description convert ascii to hex
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string text to convert
asc2hex() {
   if [[ $1 ]]; then
      echo "obase=16 ; $(asc2dec $1)" | bc
   fi
}

# @description convert ascii to octal
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string text to convert
asc2oct() {
   if [[ $1 ]]; then
      echo "obase=8 ; $(asc2dec $1)" | bc
   fi
}

# @section convert binaries
# @description convert binaries to another format

# @description convert binary value to any other format
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string binary value to convert
bin2all() {
   if [[ $1 ]]; then
      echo "binary $1 = octal $(bin2oct $1)"
      echo "binary $1 = decimal $(bin2dec $1)"
      echo "binary $1 = hexadecimal $(bin2hex $1)"
      echo "binary $1 = base32 $(bin2b32 $1)"
      echo "binary $1 = base64 $(bin2b64 $1)"
      echo "binary $1 = ascii $(bin2asc $1)"
   fi
}

# @description convert binary value to ascii
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string binary value to convert
bin2asc() {
   if [[ $1 ]]; then
      echo -e "\0$(printf %o $((2#$1)))"
   fi
}

# @description convert binary value to base64
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string binary value to convert
bin2b64() {
   if [[ $1 ]]; then
      echo "obase=64 ; ibase=2 ; $1" | bc
   fi
}

# @description convert binary value to base32
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string binary value to convert
bin2b32() {
   if [[ $1 ]]; then
      echo "obase=32 ; ibase=2 ; $1 " | bc
   fi
}

# @description convert binary value to decimal
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string binary value to convert
bin2dec() {
   if [[ $1 ]]; then
      echo $((2#$1))
   fi
}

# @description convert binary value to hex
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string binary value to convert
bin2hex() {
   if [[ $1 ]]; then
      echo "obase=16 ; ibase=2 ; $1" | bc
   fi
}

# @description convert binary value to octal
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string binary value to convert
bin2oct() {
   if [[ $1 ]]; then
      echo "obase=8 ; ibase=2 ; $1" | bc
   fi
}

# @section hexadecimal conversion
# @description convert hexadecimal value to another format

# @description convert hexadecimal numbers to decimals
# @arg 1 string hexadecimal value to convert
dec2hex() {  printf "%d\n" $1; }
# @description convert hexadecimal value to any other format
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string hexadecimal value to convert
hex2all() { 
   if [[ $1 ]]; then
      echo "hexadecimal $1 = binary $(hex2bin $1)"
      echo "hexadecimal $1 = octal $(hex2oct $1)"
      echo "hexadecimal $1 = decimal $(hex2dec $1)"
      echo "hexadecimal $1 = base32 $(hex2b32 $1)"
      echo "hexadecimal $1 = base64 $(hex2b64 $1)"
      echo "hexadecimal $1 = ascii $(hex2asc $1)"
   fi
}

# @description convert hexadecimal value to ascii
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string hexadecimal value to convert
hex2asc() { 
   if [[ $1 ]]; then
      echo -e "\0$(printf %o $((16#$1)))"
   fi
}

# @description convert hexadecimal value to binary
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string hexadecimal value to convert
hex2bin() { 
   if [[ $1 ]]; then
      echo "obase=2 ; ibase=16 ; $1" | bc
   fi
}

# @description convert hexadecimal value to base64
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string hexadecimal value to convert
hex2b64() { 
   if [[ $1 ]]; then
      echo "obase=64 ; ibase=16 ; $1" | bc
   fi
}

# @description convert hexadecimal value to base32
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string hexadecimal value to convert
hex2b32() { 
   if [[ $1 ]]; then
      echo "obase=32 ; ibase=16 ; $1" | bc
   fi
}

# @description convert hexadecimal value to decimal
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string hexadecimal value to convert
hex2dec() { 
   if [[ $1 ]]; then
      echo $((16#$1))
   fi
}

# @description convert hexadecimal value to octal
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string hexadecimal value to convert
hex2oct() { 
   if [[ $1 ]]; then
      echo "obase=8 ; ibase=16 ; $1" | bc
   fi
}

# @section decimal conversion
# @description convert decimal value to another format

# @description convert decimals to hexadecimal numbers
# @arg 1 string decimal value to convert
hex() {  printf "0x%08x\n" $1; }

# @section decimal conversion
# @description convert octal value to another format 

# @description convert decimal value to any other format
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string octet value to convert
oct2all() { 
   if [[ $1 ]]; then
      echo "octal $1 = binary $(oct2bin $1)"
      echo "octal $1 = decimal $(oct2dec $1)"
      echo "octal $1 = hexadecimal $(oct2hex $1)"
      echo "octal $1 = base32 $(oct2b32 $1)"
      echo "octal $1 = base64 $(oct2b64 $1)"
      echo "octal $1 = ascii $(oct2asc $1)"
   fi
}

# @description convert decimal value to ascii
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string octet value to convert
oct2asc() { 
   if [[ $1 ]]; then
      echo -e "\0$(printf %o $((8#$1)))"
   fi
}

# @description convert decimal value to binary
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string octet value to convert
oct2bin() { 
   if [[ $1 ]]; then
      echo "obase=2 ; ibase=8 ; $1" | bc
   fi
}

# @description convert decimal value to base64
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string octet value to convert
oct2b64() { 
   if [[ $1 ]]; then
      echo "obase=64 ; ibase=8 ; $1" | bc
   fi
}

# @description convert decimal value to base32
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string octet value to convert
oct2b32() { 
   if [[ $1 ]]; then
      echo "obase=32 ; ibase=8 ; $1" | bc
   fi
}

# @description convert decimal value to decimal
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string octet value to convert
oct2dec() { 
   if [[ $1 ]]; then
      echo $((8#$1))
   fi
}

# @description convert decimal value to hexa
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string octet value to convert
oct2hex() { 
   if [[ $1 ]]; then
      echo "obase=16 ; ibase=8 ; $1" | bc
   fi
}

# @description convert decimal value to any other format
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string decimal value to convert
dec2all() { 
   if [[ $1 ]]; then
      echo "decimal $1 = binary $(dec2bin $1)"
      echo "decimal $1 = octal $(dec2oct $1)"
      echo "decimal $1 = hexadecimal $(dec2hex $1)"
      echo "decimal $1 = base32 $(dec2b32 $1)"
      echo "decimal $1 = base64 $(dec2b64 $1)"
      echo "deciaml $1 = ascii $(dec2asc $1)"
   fi
}

# @description convert decimal value to ascii
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string decimal value to convert
dec2asc() { 
   if [[ $1 ]]; then
      echo -e "\0$(printf %o 97)"
   fi
}

# @description convert decimal value to binary
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string decimal value to convert
dec2bin() { 
   if [[ $1 ]]; then
      echo "obase=2 ; $1" | bc
   fi
}

# @description convert decimal value to base64
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string decimal value to convert
dec2b64() { 
   if [[ $1 ]]; then
      echo "obase=64 ; $1" | bc
   fi
}

# @description convert decimal value to base32
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string decimal value to convert
dec2b32() { 
   if [[ $1 ]]; then
      echo "obase=32 ; $1" | bc
   fi
}

# @description convert decimal value to hexadecimal
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string decimal value to convert
dec2hex() { 
   if [[ $1 ]]; then
      echo "obase=16 ; $1" | bc
   fi
}

# @description convert decimal value to octal
# copyright 2007 - 2010 Christopher Bratusek
# @arg 1 string decimal value to convert
dec2oct() { 
   if [[ $1 ]]; then
      echo "obase=8 ; $1" | bc
   fi
}

# @description convert decimal integer to english words
# Author: Noah Friedman <friedman@prep.ai.mit.edu>
# @example:
#   dec2text 1234 -> one thousand two hundred thirty-four
# @arg $1 int value to convert to string
dec2text() { 
   prog=$(echo "$0" | sed -e 's/[^\/]*\///g')
   garbage=$(echo "$*" | sed -e 's/[0-9,.]//g')
   if test ".$garbage" != "."; then
      echo "$prog: Invalid character in argument." 1>&2
   fi
   case "$*" in
   # This doesn't always seem to work.
   #   *[!0-9,.]* ) echo "$prog: Invalid character in argument." 1>&2; ;;
   *.*) echo "$prog: fractions not supported (yet)." 1>&2 ;;
   '') echo "Usage: $prog [decimal integer]" 1>&2 ;;
   esac
   result=
   eval set - "$(echo ${1+\"$@\"} | sed -n -e '
     s/[, ]//g
     s/^00*/0/g
     s/\(.\)\(.\)\(.\)$/\"\1 \2 \3\"/
     :l
     /[0-9][0-9][0-9]/{
       s/\([^\" ][^\" ]*\)\([^\" ]\)\([^\" ]\)\([^\" ]\)/\1\"\2 \3 \4\"/g
       t l
     }
     /^[0-9][0-9][0-9]/s/\([^\" ]\)\([^\" ]\)\([^\" ]\)/\"\1 \2 \3\"/
     /^[0-9][0-9]/s/\([^\" ]\)\([^\" ]\)/\"\1 \2\"/
     /^[0-9]/s/^\([^\" ][^\" ]*\)/\"\1\"/g;s/\"\"/\" \"/g
     p')"
   while test $# -ne 0; do
      eval $(
         set - $1
         d3='' d2='' d1=''
         case $# in
         1) d1=$1 ;;
         2) d2=$1 d1=$2 ;;
         3) d3=$1 d2=$2 d1=$3 ;;
         esac
         echo "d3=\"$d3\" d2=\"$d2\" d1=\"$d1\""
      )
      val1='' val2='' val3=''
      case "$d3" in
      1) val3=one ;; 6) val3=six ;;
      2) val3=two ;; 7) val3=seven ;;
      3) val3=three ;; 8) val3=eight ;;
      4) val3=four ;; 9) val3=nine ;;
      5) val3=five ;;
      esac
      case "$d2" in
      1) val2=teen ;; 6) val2=sixty ;;
      2) val2=twenty ;; 7) val2=seventy ;;
      3) val2=thirty ;; 8) val2=eighty ;;
      4) val2=forty ;; 9) val2=ninety ;;
      5) val2=fifty ;;
      esac
      case "$val2" in
      teen)
         val2=
         case "$d1" in
         0) val1=ten ;; 5) val1=fifteen ;;
         1) val1=eleven ;; 6) val1=sixteen ;;
         2) val1=twelve ;; 7) val1=seventeen ;;
         3) val1=thirteen ;; 8) val1=eighteen ;;
         4) val1=fourteen ;; 9) val1=nineteen ;;
         esac
         ;;
      0) : ;;
      *)
         test ".$val2" != '.' -a ".$d1" != '.0' &&
            val2="${val2}-"
         case "$d1" in
         0) val2="$val2 " ;; 5) val1=five ;;
         1) val1=one ;; 6) val1=six ;;
         2) val1=two ;; 7) val1=seven ;;
         3) val1=three ;; 8) val1=eight ;;
         4) val1=four ;; 9) val1=nine ;;
         esac
         ;;
      esac
      test ".$val3" != '.' && result="$result$val3 hundred "
      test ".$val2" != '.' && result="$result$val2"
      test ".$val1" != '.' && result="$result$val1 "
      if test ".$d1$d2$d3" != '.000'; then
         case $# in
         0 | 1) ;;
         2) result="${result}thousand " ;;
         3) result="${result}million " ;;
         4) result="${result}billion " ;;
         5) result="${result}trillion " ;;
         6) result="${result}quadrillion " ;;
         7) result="${result}quintillion " ;;
         8) result="${result}sextillion " ;;
         9) result="${result}septillion " ;;
         10) result="${result}octillion " ;;
         11) result="${result}nonillion " ;;
         12) result="${result}decillion " ;;
         13) result="${result}undecillion " ;;
         14) result="${result}duodecillion " ;;
         15) result="${result}tredecillion " ;;
         16) result="${result}quattuordecillion " ;;
         17) result="${result}quindecillion " ;;
         18) result="${result}sexdecillion " ;;
         19) result="${result}septendecillion " ;;
         20) result="${result}octodecillion " ;;
         21) result="${result}novemdecillion " ;;
         22) result="${result}vigintillion " ;;
         *) echo "Error: number too large (66 digits max)." 1>&2 ;;
         esac
      fi
      shift
   done
   set $result >/dev/null
   case "$*" in
   '') set zero ;;
   esac
   echo ${1+"$@"}
   # number ends here
}

# @description individual numbers as text
# @example
#   dec2text 1234 -> one two three four
# @arg $1 int value to convert to string
dec2text_() { 
   # This script is part of nixCraft shell script collection (NSSC)
   # Visit http://bash.cyberciti.biz/ for more information.
   n=$1
   len=$(echo $n | wc -c)
   len=$(($len - 1))
   for ((i = 1; i <= $len; i++)); do
      # get one digit at a time
      digit=$(echo $n | cut -c $i)
      # use case control structure to find digit equivalent in words
      case $digit in
      0) echo -n "zero " ;;
      1) echo -n "one " ;;
      2) echo -n "two " ;;
      3) echo -n "three " ;;
      4) echo -n "four " ;;
      5) echo -n "five " ;;
      6) echo -n "six " ;;
      7) echo -n "seven " ;;
      8) echo -n "eight " ;;
      9) echo -n "nine " ;;
      esac
   done
   # just print new line
   echo ""
}

# @section temperature conversion
# @description helper functions to convert temparatures

# @description convert C to F
# Copyright 2007 - 2010 Christopher Bratusek
# @arg $1 int degree C to convert
cel2fah() {
   if [[ $1 ]]; then
      echo "scale=2; $1 * 1.8  + 32" | bc
   fi
}

# @description convert C to K
# Copyright 2007 - 2010 Christopher Bratusek
# @arg $1 int degree C to convert
cel2kel() {
   if [[ $1 ]]; then
      echo "scale=2; $1 + 237.15" | bc
   fi
}

# @description convert F to C
# Copyright 2007 - 2010 Christopher Bratusek
# @arg $1 int degree F to convert
fah2cel() {
   if [[ $1 ]]; then
      echo "scale=2 ; ( $1 - 32  ) / 1.8" | bc
   fi
}

# @description convert F to K
# Copyright 2007 - 2010 Christopher Bratusek
# @arg $1 int degree F to convert
fah2kel() {
   if [[ $1 ]]; then
      echo "scale=2; ( $1 + 459.67 ) / 1.8 " | bc
   fi
}

# @description convert K to C
# Copyright 2007 - 2010 Christopher Bratusek
# @arg $1 int degree K to convert
kel2cel() {
   if [[ $1 ]]; then
      echo "scale=2; $1 - 273.15" | bc
   fi
}

# @description convert K to F
# Copyright 2007 - 2010 Christopher Bratusek
# @arg $1 int degree K to convert
kel2fah() {
   if [[ $1 ]]; then
      echo "scale=2; $1 * 1.8 - 459,67" | bc
   fi
}
