# @file debian.sh
# @brief functions for debian-based distros
# @description helper functions for all debian-based distros

alias unusedkernels="dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d'"  # show installed but unused linux headers, image, or modules