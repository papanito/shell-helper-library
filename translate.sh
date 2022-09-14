# @file translate.sh
# @brief translation of text
# @description helper functions to translate text via console -- to be verified

# file translate.sh
# @brief Translation and Dictionary
# @description helper functions for word definitions and translations

# @description Lookup a word with dict.org
# @arg $# string word to lookup
function dic()
{ 
   curl dict://dict.org/d:"$@" ; 
}

# @description find matches of $1, with optional strat $2 and optional db $3
# @arg $1 string to find
# @arg $2 string Search type
# @arg $3 string db
function ref()
{
    if [[ -z $3 ]]; then
      curl dict://dict.org/m:${1}:english:${2};
    else
      curl dict://dict.org/m:${1}:${3}:${2};
    fi
}

# @description Lookup a word with dict.org in WordNet
# @arg $1 string word to lookup
function wordnet()
{ 
   curl dict://dict.org/d:${1}:wn;
}

# @description define a word
# @example
#   define dog
function define()
{
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

# @description detect language of a string
function detectlanguage()
{ 
   curl -s "http://ajax.googleapis.com/ajax/services/language/detect?v=1.0&q=$@" | sed 's/{"responseData": {"language":"\([^"]*\)".*/\1\n/'; 
}


# Google text-to-speech in mp3/wav format
function say()
{ 
   mplayer -user-agent Mozilla "http://translate.google.com/translate_tts?tl=en&q=$(echo $* | sed 's#\ #\+#g')" > /dev/null 2>&1 ;
}