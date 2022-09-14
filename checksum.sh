# @filename checksum.sh
# @brief Calculate checksums
# @description Helper functions for checksumm calculation

# @description Calculate checksum of a file
# copyright 2007 - 2010 Christopher Bratusek
# @arg $1 string filename
function checksum()
{ 
   action=$1
   shift
   if [[ ($action == "-c" || $action == "--check") && $1 == *.* ]]; then
      type="${1/*./}"
   else
      type=$1
      shift
   fi
   case $type in
   md5)
      checktool=md5sum
      ;;
   sha1 | sha)
      checktool=sha1sum
      ;;
   sha224)
      checktool=sha224sum
      ;;
   sha256)
      checktool=sha256sum
      ;;
   sha384)
      checktool=sha384sum
      ;;
   sha512)
      checktool=sha512sum
      ;;
   esac
   case $action in
   -g | --generate)
      for file in "${@}"; do
         $checktool "${file}" >"${file}".$type
      done
      ;;
   -c | --check)
      for file in "${@}"; do
         if [[ "${file}" == *.$type ]]; then
            $checktool --check "${file}"
         else
            $checktool --check "${file}".$type
         fi
      done
      ;;
   -h | --help) ;;

   esac
}
