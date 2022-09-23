# @file security
# @description helper functions related to security

# @section Passwording
# @description helper functions for secure passwords

# @description generate a random password
# copyright 2007 - 2010 Christopher Bratusek
# @arg $1 int number of characters; defaults to 32
# @arg $2 int include special characters; 1 = yes, 0 = no; defaults to 1
randompw() {
   if [[ $2 == "!" ]]; then
      echo $(cat /dev/random | tr -cd '[:graph:]' | head -c ${1:-32})
   else
      echo $(cat /dev/random | tr -cd '[:alnum:]' | head -c ${1:-32})
   fi
}

# @description generate a unique and secure password for every website that you login to
sitepass() {
   echo -n "$@" |  md5sum | sha1sum | sha224sum | sha256sum | sha384sum | sha512sum | gzip - | strings -n 1 | tr -d "[:space:]"  | tr -s '[:print:]' | tr '!-~' 'P-~!-O' | rev | cut -b 2-11; history -d $(($HISTCMD-1));
}

# @description generates a unique and secure password with SALT for every website that you login to
sitepass2() {
   salt="this_salt";pass=`echo -n "$@"`;for i in {1..500};do pass=`echo -n $pass$salt|sha512sum`;done;echo$pass|gzip -|strings -n 1|tr -d "[:space:]"|tr -s '[:print:]' |tr '!-~' 'P-~!-O'|rev|cut -b 2-15;history -d $(($HISTCMD-1));
}

# @section Encryption / decryption
# @description helper functions for encryption and decryption

# @description More advanced encryption / decryption
# Author: Martin Langasek <cz4160@gmail.com>
# @example
#  encrypt filename
#  decrypt filename
encrypt() {
   case $LANG in
     * )
      err_title="Error"
      err_files="No file selected"
      encrypt="Encrypt"
      decrypt="Decrypt"
      file_msg="file:"
      pass_msg="Enter passphrase";;
   esac
   if [ "$1" != "" ]
   then
     i=1
     file=`echo "$1" | sed ''$i'!d'`
     while [ "$file" != "" ]
     do
      ext=`echo "$file" | grep [.]gpg$ 2>&1`
      if [ "$ext" != "" ]
      then
        pass_decrypt=`zenity --entry --entry-text "$pass_decrypt" --hide-text --title "$pass_msg" --text "$decrypt $file_msg ${file##*/}" "" 2>&1`
        if [ "$pass_decrypt" != "" ]
        then
      output=${file%.*}
      echo "$pass_decrypt" | gpg -o "$output" --batch --passphrase-fd 0 -d "$file"
        fi
      else
        pass_encrypt=`zenity --entry --hide-text --entry-text "$pass_encrypt" --title "$pass_msg" --text "$encrypt $file_msg ${file##*/}" "" 2>&1`
        if [ "$pass_encrypt" != "" ]
        then
      echo "$pass_encrypt" | gpg --batch --passphrase-fd 0 --cipher-algo aes256 -c "$file"
        fi
      fi
      i=$(($i+1))
      file=`echo "$1" | sed ''$i'!d'`
     done
   else
     zenity --error --title "$err_title" --text "$err_files"
   fi
}

alias decrypt='encrypt'


# @description rot13 ("rotate alphabet 13 places" Caesar-cypher encryption)
# @arg $1 string text to encypher
rot13() {
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
      echo "Seriously?  You don't know what rot13 does?"
    else
      echo $@ | tr A-Za-z N-ZA-Mn-za-m
    fi
}

# @description rot47 ("rotate ASCII characters from '!" to '~' 47 places" Caesar-cypher encryption)
# @arg $1 string text to encypher
rot47() {
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
      echo "Seriously?  You don't know what rot47 does?"
    else
      echo $@ | tr '!-~' 'P-~!-O'
    fi
}


# @section OpenPGP/GPG
# @description OpenPGP/GPG pubkeys stuff (for Launchpad / etc.

# @description to export public OpenPGP keys to a file for safe keeping and potential restoration
gpg:exportmykeys() 
{ 
   gpg:exportmykeys_private && gpg:exportmykeys_public
}

# @description to export private OpenPGP keys to a file for safe keeping and potential restoration
# using 'mykeys', put the appropriate GPG key after you type this function
gpg:exportmykeys_private() {
   gpg --list-secret-keys
   echo -n "Please enter the appropriate private key...
   Look for the line that starts something like "sec 1024D/".
   The part after the 1024D is the key_id.
   ...like this: '2942FE31'...

   "
   read MYKEYPRIV
   gpg -ao Private_Keys-private.key --export-secret-keys "$MYKEYPRIV"
   echo -n "All done."
}

# @description to export public OpenPGP keys to a file for safe keeping and potential restoration
# using 'mykeys', put the appropriate GPG key after you type this function
gpg:exportmykeys_public() {
   gpg --list-keys
   echo -n "Please enter the appropriate public key...
   Look for line that starts something like "pub 1024D/".
   The part after the 1024D is the public key_id.
   ...like this: '2942FE31'...

   "
   read MYKEYPUB
   gpg -ao Public_Keys-public.key --export "$MYKEYPUB"
   echo -n "All done."
}

# to get the new key fingerprint for use in the appropriate section on Launchpad.net to start verification process
alias gpg:fingerprintmykeys='gpg --fingerprint'

# to get a list of your public and private OpenPGP/GPG pubkeys
alias gpg:mykeys='gpg --list-keys && gpg --list-secret-keys'

# publish newly-created mykeys for use on Launchpad / etc.
alias gpg:publishmykeys='gpg --keyserver hkps://keys.openpgp.org --send-keys'

# @description to restore your public and private OpenPGP keys
# from Public_Key-public.key and Private_Keys-private.key files
gpg:restoremykeys() {
   echo -n "Please enter the full path to Public keys (spaces are fine)...

   Example: '/home/(your username)/Public_Key-public.key'...

   "
   read MYKEYS_PUBLIC_LOCATION
   gpg --import "$MYKEYS_PUBLIC_LOCATION"
   echo -n "Please enter the full path to Private keys (spaces are fine)...

   Example: '/home/(your username)/Private_Keys-private.key'...

   "
   read MYKEYS_PRIVATE_LOCATION
   gpg --import "$MYKEYS_PRIVATE_LOCATION"
   echo -n "All done."
}

# to setup new public and private OpenPGP keys
gpg_setupmykeys() {
   # Generate new key
   gpg --gen-key
   # Publish new key to Ubuntu keyserver
   gpg --keyserver hkp://keyserver.ubuntu.com --send-keys
   # Import an OpenPGP key
   gpg --fingerprint
   # Verify new key
   read -sn 1 -p "Before you continue, you must enter the fingerprint
   in the appropriate place in your Launchpad PPA on their website...

   Once you have successfully inputed it, wait for your email before
   you press any key to continue...

   "
   gedit $HOME/file.txt
   read -sn 1 -p "Once you have received your email from Launchpad to
   verify your new key, copy and paste the email message received upon
   import of OpenPGP key from "-----BEGIN PGP MESSAGE-----" till
   "-----END PGP MESSAGE-----" to the 'file.txt' in your home folder
   that was just opened for you

   Once you have successfully copied and pasted it, save it and
   press any key to continue...

   "
   gpg -d $HOME/file.txt
   echo -n "All done."
}

