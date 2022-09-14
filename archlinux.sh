# @file archlinux.sh
# @brief Helper functions for Archlinux
# @description Helper functions for Archlinux distros

# @section pacman helper functions
# @description helper functions to work with pacman package manager of Arch linux distro
alias pacclean='sudo pacman -Scc' # clean package cache
alias pacin='sudo pacman -S' # install a specific package
alias pacupg='sudo pacman -Syu' # Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacin='sudo pacman -S' # Install specific package(s) from the repositories
alias pacins='sudo pacman -U' # Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R' # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns' # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si' # Display information about a given package in the repositories
alias pacreps='pacman -Ss' # Search for package(s) in the repositories
alias pacloc='pacman -Qi' # Display information about a given package in the local database
alias paclocs='pacman -Qs' # Search for package(s) in the local database
alias paclsusr='pacman -Qqett' # List packages including explicitly-installed packages that are also dependencies of some other package.

# Additional pacman alias examples
alias pacupd='sudo pacman -Sy && sudo abs' # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps' # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman -Syy' # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

#'[r]emove [o]rphans' - recursively remove ALL orphaned packages
alias pacro="/usr/bin/pacman -Qtdq > /dev/null && sudo /usr/bin/pacman -Rns \$(/usr/bin/pacman -Qtdq | sed -e ':a;N;\$!ba;s/\n/ /g')"


# @description Pacman Search
# @arg $1 string package to search for
function pacsearch()
{
       echo -e "$(pacman -Ss $@ | sed \
       -e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
       -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
       -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
       -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}

# @description Pacman remove orphans
orphans()
{
  if [[ ! -n $(pacman -Qdt) ]]; then
    echo no orphans to remove
  else
    sudo pacman -Rs $(pacman -Qdtq)
  fi
}
