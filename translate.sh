# @file translate.sh
# @description helper functions to translate text via console -- to be verified

# file translate.sh
# @description helper functions for word definitions and translations

# @description Lookup a word with dict.org
# @arg $# string word to lookup
dic() { 
   curl dict://dict.org/d:"$@" ; 
}

# @description find matches of $1, with optional strat $2 and optional db $3
# @arg $1 string to find
# @arg $2 string Search type
# @arg $3 string db
ref() {
    if [[ -z $3 ]]; then
      curl dict://dict.org/m:${1}:english:${2};
    else
      curl dict://dict.org/m:${1}:${3}:${2};
    fi
}

# @description Lookup a word with dict.org in WordNet
# @arg $1 string word to lookup
wordnet() { 
   curl dict://dict.org/d:${1}:wn;
}

# @description define a word
# @example
#   define dog
define() {
   local LNG=$(echo $LANG | cut -d '_' -f 1)
   local CHARSET=$(echo $LANG | cut -d '.' -f 2)
   lynx -accept_all_cookies -dump -hiddenlinks=ignore -nonumbers -assume_charset="$CHARSET" -display_charset="$CHARSET" "http://www.google.com/search?hl=${LNG}&q=define%3A+${1}&btnG=Google+Search" | grep -m 5 -C 2 -A 5 -w "*" > /tmp/define
   if [ ! -s /tmp/define ]; then
      echo "Sorry, google doesn't know this one..."
      rm -f /tmp/define
      return 1
   else
      cat /tmp/define | grep -v Search
      echo ""
   fi
   rm -f /tmp/define
   return 0
}