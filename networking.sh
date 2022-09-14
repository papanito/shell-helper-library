# @file networking.sh
# @brief Network/Internet-oriented stuff
# @description Useful functions to work with network and internet

# @brief Network/Internet-oriented stuff
# @description Useful functions to work with network and internet
alias bandwidth='dd if=/dev/zero of=/dev/null bs=1M count=32768' # processor / memory bandwidthd? in GB/s
alias browse_bonjour='dns-sd -B' # browse services advertised via Bonjour
alias dns='cat /etc/resolv.conf' # view DNS numbers
alias estab='ss -p | grep STA' # view only established sockets (fails if "ss" is screensaver alias)
alias hdinfo='hdparm -i[I] /dev/sda' # hard disk information - model/serial no.
alias http_trace='pkt_trace port 80' # to show all HTTP packets
alias iftop='sudo iftop -i eth0' # start "iftop" program (sudo apt-get install iftop)
alias ip4grep="grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}'" # look for IPv4 address in files
alias ipt80='sudo iptstate -D 80' # check out only iptables state of http port 80 (requires iptstate)
alias ip_trace='pkt_trace ip' # to show all IP packets
alias ipttrans='sudo iptstate -D 51413' # iptables state of Transmission-Daemon port (requires iptstate)
alias listen='sudo netstat -pnutl' # lists all listening ports together with PID of associated process
alias memrel='free && sync && echo 3 > /proc/sys/vm/drop_caches && free' # release memory used by the Linux kernel on caches
alias net1='watch --interval=2 "sudo netstat -apn -l -A inet"'
alias net2='watch --interval=2 "sudo netstat -anp --inet --inet6"'
alias net3='sudo lsof -i'
alias net4='watch --interval=2 "sudo netstat -p -e --inet --numeric-hosts"'
alias net5='watch --interval=2 "sudo netstat -tulpan"'
alias net6='sudo netstat -tulpan'
alias net7='watch --interval=2 "sudo netstat -utapen"'
alias net8='watch --interval=2 "sudo netstat -ano -l -A inet"'
alias netapps="netstat -lantp | grep -i stab | awk -F/ '{print $2}' | sort | uniq" # view only the process name using an internet connection
alias nethogs='sudo nethogs eth0' # start "nethogs" program (sudo apt-get install nethogs)
alias netl='sudo nmap -sT -O localhost'
alias netdump='sudo tcpdump not port 22' # dump all the network activity except ssh stuff
alias nmr='sudo /etc/rc.d/networkmanager restart'
alias nsl='netstat -f inet | grep -v CLOSE_WAIT | cut -c-6,21-94 | tail +2' # show all programs connected or listening on a network port
alias ns='netstat -alnp --protocol=inet | grep -v CLOSE_WAIT | cut -c-6,21-94 | tail +2' 
alias chownn='sudo chown -R $USER:$USER'
alias openports='sudo netstat -nape --inet' # view open ports
alias pkt_trace='sudo tcpflow -i `active_net_iface` -c'
alias ports='lsof -i -n -P' # view programs using an internet connection
alias portstats='sudo netstat -s' # show statistics for all ports
alias randomip='echo $((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))' # generate a random IP address
alias ramvalue='sudo dd if=/dev/mem | cat | strings' # will show you all the string (plain text) values in ram
alias randommac='python -c "from itertools import imap; from random import randint; print ':'.join(['%02x'%x for x in imap(lambda x:randint(0,255), range(6))])"' # generate random valid mac addresses
alias rdp='rdesktop -u "$USER" -g 1600x1200 -D -r disk:home=/home -r clipboard:PRIMARYCLIPBOARD' # quick full screen RDP connection
alias spavr='gtkterm -c avr'
alias sql='mysql -p -u root'
alias tcpstats='sudo netstat -st' # show statistics for tcp ports
alias tcp_='sudo netstat -atp' # list all TCP ports
alias tcp_trace='pkt_trace tcp' # to show all TCP packets
alias tproxy='ssh -ND 8118 user@server&; export LD_PRELOAD="/usr/lib/libtsocks.so"' # creates a proxy based on tsocks
alias udpstats='sudo netstat -su' # show statistics for udp ports
alias udp='sudo netstat -aup' # list all UDP ports
alias udp_trace='pkt_trace udp' # to show all UDP packets
alias vncup='x11vnc -nopw -ncache 10 -display :0 -localhost'
alias website_dl='wget --random-wait -r -p -e robots=off -U mozilla "$1"' # download an entire website
alias website_images='wget -r -l1 --no-parent -nH -nd -P/tmp -A".gif,.jpg" "$1"' # download all images from a site
alias whois='whois -H'

# @section Wireless / WLAN
# @description functions to deal with Wireless/WLAN
alias wscan='iwlist wlp2s0 scan' # terminal network scan for wireless signals
alias netscan='sudo iwlist wlan0 scan' # to scan your environment for available networks, do the following
alias netstats='sudo iwspy wlan0' # if card supports it, you can collect wireless statistics by using
alias setessid='sudo iwconfig wlan0 essid network-essid' # set the essid, which identifies the network access point you want