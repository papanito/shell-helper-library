# @file strings.sh
# @description helper functions for working with strings

# @description converts a string (words, text) to binary"
# @arg $1 string value to convert
string2bin() {
   perl -nle 'printf "%0*v8b\n"," ",$_'
}

# @description Convert the first letter into lowercase letters
# @arg $1 string string to change
# @exitcode string whhere first letter is lowercase
lcfirst() {
   if [ -n "$1" ]; then
     perl -e 'print lcfirst('$1')'
   else
      cat - | perl -ne 'print lcfirst($_)'
   fi
}

# @description Remove whitespace at the beginning of a string
# @arg $1 string string from which to remove whitespaced
# @exitcode string w/o whitespaces at the beginning of the string
# @example
#    echo "   That is a sentinece" | rtrim
ltrim() {
      if [ -n "$1" ]; then
         echo $1 | sed 's/^[[:space:]]*//g'
      else
         cat - | sed 's/^[[:space:]]*//g'
      fi
}

# @description Remove whitespace at the end of a string
# @arg $1 string string from which to remove whitespaced
# @exitcode string w/o whitespaces at the end
# @example
#    echo "That is a sentinece " | rtrim
rtrim() {
      if [ -n "$1" ]; then
         echo $1 | sed 's/[[:space:]]*$//g'
      else
         cat - | sed 's/[[:space:]]*$//g'
      fi
}

# @description Cut a string after X chars and append three points
# @arg $1 string string to shortened/cut
# @arg $2 int length of the string
# @exitcode shortened string
# @example
#      strim averylongstring 2
strim() {
   local string="$1"
   local length=${2:-30}
   [ "${#string}" -gt ${length} ] && string="${string:0:${length}}..."
   echo $string
}

# @description Convert all alphabetic characters to lowercase
# @arg $1 string string to convert
strtolower() {
      if [ -n "$1" ]; then
         echo $1 | tr '[:upper:]' '[:lower:]'
      else
         cat - | tr '[:upper:]' '[:lower:]'
      fi
}

# @description Convert all alphabetic characters converted to uppercase
# @arg $1 string string to convert
strtoupper() {
   if [ -n "$1" ]; then
      echo $1 | tr '[:lower:]' '[:upper:]'
   else
      cat - | tr '[:lower:]' '[:upper:]'
   fi
}

# @description Remove whitespace at the beginning and end of a string
# @arg $1 string string to convert
# @example
#     echo " That is a sentinece " | trim
trim() {
   if [ -n "$1" ]; then
      echo $1 | sed 's/^[[:space:]]*//g' | sed 's/[[:space:]]*$//g'
   else
      cat - | sed 's/^[[:space:]]*//g' | sed 's/[[:space:]]*$//g'
   fi
}

# @description Convert the first letter into uppercase letters
# @aeg $1 string string to convert
strucfirst() {
      if [ -n "$1" ]; then
     perl -e 'print ucfirst('$1')'
      else
     cat - | perl -ne 'print ucfirst($_)'
      fi
}

# @description Converts first letter of each word within a string into an uppercase, all other to lowercase
# @aeg $1 string string to convert
strucwords() {
      local string="$*"
      for word in $string; do
        # Get the first character with cut and convert them into uppercase.
        local first="$( echo $word | cut -c1 | tr '[:lower:]' '[:upper:]' )"
        # Convert the rest of the word into lowercase and append them to the first character.
        word="$first$( echo $word | cut -c2-${#word} | tr '[:upper:]' '[:lower:]' )"
        # Put together the sentence.
        local phrase="$phrase $word"
      done
      echo "$phrase"
}