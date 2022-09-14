# @file terminal.sh
# @brief Terminal and ssh improvements
# @description Helper functions to work with terminal and ssh

# @section ssh
# @description helper functions for ssh
alias sshall='logwatch --service sshd --range all --detail high --print --archives'
alias sshtoday='logwatch --service sshd --range today --detail high --print --archives'