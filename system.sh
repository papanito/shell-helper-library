# @file system.sh
# @description helper functions to get system info, set system settings incl. hardware stuff

# @section Systemd service
# @description Helper functions for systemd

# @description start a service
# @arg $1 string name of service
start() {
   sudo systemctl start $1.service
}

# @description stop a service
# @arg $1 string name of service
stop() {
   sudo systemctl stop $1.service
}

# @description query status of a service
# @arg $1 string name of service
status() {
   sudo systemctl status $1.service
}

# @description query status of a service
# @arg $1 string name of service
statusg() {
   sudo systemctl | grep $1
}

# @description enable a service
# @arg $1 string name of service
senable() {
   sudo systemctl status $1.service
}

# @desciption list available systemd services
# @noargs
services() {
   ll /usr/lib/systemd/system
   ll /etc/system/systemd
}

# @section System Information
# @description show information about your system
alias big='function BIG() { find . -size +${1}M -ls; }; BIG $1' # find large files in current directory
alias biggest='BLOCKSIZE=1048576; du -x | sort -nr | head -10' # show biggest directories
alias boothistory='for wtmp in `dir -t /var/log/wtmp*`; do last reboot -f $wtmp; done | less'
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10' # to find CPU hogs
alias cputemp='while sleep 1; do acpi -t | osd_cat -p bottom; done &' # to get the CPU temperature continuously on the desktop
alias freqwatch='watch --interval 1 "cat /proc/acpi/thermal_zone/THRM/*; cat /proc/cpuinfo | grep MHz; cat /proc/acpi/processor/*/throttling"' # monitor cpu freq and temperature
alias mountedinfo='df -hT'
alias ver='cat /etc/lsb-release' # Ubuntu version detail
alias whoamii='getent passwd $(whoami) | cut -f 5 -d: | cut -f 1 -d,' # prints out what the users name, notifyed in the gecos field is
alias free='free -m' # RAM and SWAP detail in MBs

# @description show load of the battery
# copyright 2007 - 2010 Christopher Bratusek
show_battery_load() {
   case $1 in
      *acpi )
         check_opt acpi show_battery_load::acpi
         if [[ $? != "1" ]]; then
            load=$(acpi -b | sed -e "s/.* \([1-9][0-9]*\)%.*/\1/")
            out="$(acpi -b)"
            state="$(echo "${out}" | awk '{print $3}')"
            case ${state} in
               charging,)
                  statesign="^"
               ;;
               discharging,)
                  statesign="v"
               ;;
               charged,)
                  statesign="°"
               ;;
            esac
            battery="${statesign}${load}"
            echo $battery
         fi
      ;;
      *apm )
         check_opt apm show_battery_load::apm
         if [[ $? != "1" ]]; then
            result="$(apm)"
            case ${result} in
               *'AC on'*)
                  state="^"
               ;;
               *'AC off'*)
                  state="v"
               ;;
            esac
            load="${temp##* }"
            battery="${state}${load}"
            echo $battery
         fi
      ;;
      * )
         echo -e "\n${ewhite}Usage:\n"
         echo -e "${eorange}show_battery_load${ewhite} |${egreen} --acpi${eiceblue} [show batteryload using acpi]\
         \n${eorange}show_battery_load${ewhite} |${egreen} --apm${eiceblue} [show batteryload using apm]" | column -t
         echo ""
         tput sgr0
      ;;
   esac
}

# @description show infromation about your system
# copyright 2007 - 2010 Christopher Bratusek
system_infos() {
   case $1 in
      *cpu)
         echo -e "${ewhite}CPU:\n"
         echo -e "${eorange}Model:${eiceblue} $(grep "model name" /proc/cpuinfo | sed -e 's/.*: //g')"
         echo -e "${eorange}MHz  :${eiceblue} $(grep "cpu MHz" /proc/cpuinfo | sed -e 's/.*: //g')\n"
      ;;
      *kernel)
         echo -e "${ewhite}Kernel:\n"
         echo -e "${eorange}Release:${eiceblue} $(uname -r)"
         echo -e "${eorange}Version:${eiceblue} $(uname -v)"
         echo -e "${eorange}Machine:${eiceblue} $(uname -m)\n"
      ;;
      *mem | *ram | memory)
         echo -e "${ewhite}RAM:\n"
         echo -e "${eorange}Total:${eiceblue} $(((`showmem --free`) + (`showmem --used`))) MB"
         echo -e "${eorange}Free :${eiceblue} $(showmem --free) MB"
         echo -e "${eorange}Used :${eiceblue} $(showmem --used) MB\n"
      ;;
      *partitions)
         echo -e "${ewhite}Partitions:${eorange}\n"
         echo -e "major minor blocks device-node ${eiceblue}\
         \n$(cat /proc/partitions | sed -e '1,2d')" | column -t
         echo ""
      ;;
      *pci)
         check_opt lspci systeminfos::pci
         if [[ $? != "1" ]]; then
            echo -e "${ewhite}PCI Devices:\n${eiceblue}"
            lspci -vkmm
            echo ""
         fi
      ;;
      *usb)
         check_opt lsusb systeminfos::usb
         if [[ $? != "1" ]]; then
            echo -e "${ewhite}USB Devices:\n${eiceblue}"
            lsusb -v
            echo ""
         fi
      ;;
      *mounts)
         echo -e "${ewhite}Mounts:\n${eorange}\
         \ndevice-node on mount-point type filesystem options\n" ${eiceblue} "\n\n$(mount)" | column -t
         echo ""
      ;;
      *bios)
         check_opt dmidecode systeminfos::bios
         if [[ $? != "1" && $EUID == 0 ]]; then
            echo -e "${ewhite}SMBIOS/DMI Infos:${eiceblue}\n"
            dmidecode -q
         fi
      ;;
      *all)
         system_infos cpu
         system_infos kernel
         system_infos memory
         system_infos partitions
         system_infos pci
         # system_infos_usb
         system_infos mounts
         # system_infos_bios
      ;;
      *)
         echo -e "\n${ewhite}Usage:\n"
         echo -e "${eorange}system_infos ${ewhite}|${egreen} --cpu      ${eiceblue}[Display CPU Model and Freq]\
         \n${eorange}system_infos ${ewhite}|${egreen} --kernel   ${eiceblue}    [Display Kernel Version, Release and Machine]\
         \n${eorange}system_infos ${ewhite}|${egreen} --memory   ${eiceblue}    [Display Total, Free and Used RAM]\
         \n${eorange}system_infos ${ewhite}|${egreen} --partitions   ${eiceblue}[Display Major, Minor, Blocks and Node for all Paritions]\
         \n${eorange}system_infos ${ewhite}|${egreen} --pci      ${eiceblue}[Display Infos about all PCI Devices (and their kernel-module)]\
         \n${eorange}system_infos ${ewhite}|${egreen} --usb      ${eiceblue}[Display Infos about all USB Devices (and their kernel-module)]\
         \n${eorange}system_infos ${ewhite}|${egreen} --bios   ${eiceblue}    [Display SMBIOS DMI Infos]\
         \n${eorange}system_infos ${ewhite}|${egreen} --mounts   ${eiceblue}    [Display all mounted devices]\n"
         tput sgr0
      ;;
   esac
}
