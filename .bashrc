# .bashrc

# prompt before overwrite
#alias rm='rm -i'
#alias cp='cp -i'
#alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Setting the HISTFILESIZE and HISTSIZE variables to
# an empty string makes the bash history size unlimited.
# (ref.: soberkoder.com/unlimited-bash-history)
export HISTFILESIZE=
export HISTSIZE=

#############################
# BASH/PROMPT CUSTOMIZATION #
#############################
#USER="\e[96m\e[48;5;16m"
#HI="\e[0;34m"
#USER="\e[0;96m"
#BRACKET="\e[0;93m"
#RESET="\e[m"
##
#FIRST_PART_PS1="${BRACKET}[${RESET}${HI}\u${RESET}${BRACKET}@"
#SECOND_PART_PS1="${RESET}${HI}\h${RESET}:${BRACKET}\w${RESET}${BRACKET}]${RESET}${HI}\$ ${RESET}"
#PS1=${FIRST_PART_PS1}${SECOND_PART_PS1}

#export PS1="\u@\h:[\w]\\$\[$(tput sgr0)\]"
# To see colors go to ~/github/thorgeir/utils and python print_colors.py.
# tweak colors to get example like "9;2;93m"


if [[ $(hostname) == "MEGAS" ]]; then
    export PS1="\[\033[38;5;27m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;27m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]:[\[$(tput sgr0)\]\[\033[9;2;93m\]\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\\$\[$(tput sgr0)\] "

elif [[ $(hostname) == "SMYRILL" ]]; then
    color=48
    export PS1="\[\033[38;5;${color}m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;${color}m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]:[\[$(tput sgr0)\]\[\033[9;2;93m\]\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\\$\[$(tput sgr0)\] "

    # 

else
    export PS1="\[\033[38;5;3m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]:[\[$(tput sgr0)\]\[\033[9;2;93m\]\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\\$\[$(tput sgr0)\] "
fi

#export PS1="\[\033[38;5;3m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]:[\[$(tput sgr0)\]\[\033[9;2;93m\]\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\\$\[$(tput sgr0)\] "

#PS1="\[\033[0;0m\]\[\033[0;34m\]thorgeir\[\033[0;0m\]@\[\033[0;34m\]\h:\[\033[1;93m\]\w\[\033[0;0m\]$ "
#export PS1="\[\033[0;0m\]\[\e[32;40m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\]\[\e[33m\]:\[\e[m\]\[\e[32m\]\w\[\e[m\]\[\e[37m\]\\$\[\e[m\] "
           #"\[\033[0;0m\]\[\033[0;31m\]root\[\033[0;0m\]"
#PS1="\e[0;93m[\e[m\e[0;34m\u\e[m\e[0;93m@\e[m\e[0;34m\h\e[m:\e[0;93m\w\e[m\e[0;93m]\e[m\e[0;34m$ \e[m"

#PS1="${BRACKET}[\u${USER}@${RESET}${BRACKET}\h${RESET} ${USER}\W${RESET}${BRACKET}]\$ ${RESET}"

#$PS1="[\[\033[0;0m\]\[\033[0;0m\]thorgeir\[\033[0;0m\]@\[\033[0;32m\]\h \[\033[1;31m\]\W \[\033[0;0m\]]$ "

# Enable vim commands in bash
set -o vi

# Enable vim in sudoedit.
export EDITOR=vim

# For Boost library.
export LIBS="-L/home/thorgeir/downloads/boost_1_64_0/stage/lib"
export CPPFLAGS="-I/home/thorgeir/downloads/boost_1_64_0"

# To make kafkacat work.
export LD_LIBRARY_PATH=/usr/local/lib

# For the mdv tool (terminal markdown viewer)
export MDV_THEME=995.1179

external_ip () {
    echo "curl ipinfo.io/ip"
    curl ipinfo.io/ip
}

update_pi_monitoring () {
    # TODO Do more stuff.
    ssh -t alarm "
        sudo su alarm
        cd /home/alarm/python/
        git status
    "
}

reload_bash () {
    # Load resource file (e.g. colors and font styles)
    xrdb ~/.Xdefaults
    reset
}
#transset-df --actual .9

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# more information:
# http://unix.stackexchange.com/questions/9123/is-there-a-one-liner-that-allows-me-to-create-a-directory-and-move-into-it-at-th

wifi_list() {
    nmcli device wifi 
}

wifi_connect_with_username_and_password () {
    connection_name=$1; shift
    SSID=$1; shift
    USERNAME=$1; shift
    nmcli connection add  type wifi con-name "$connection_name" \
        ifname wlp3s0 ssid "$SSID" --  \
            wifi-sec.key-mgmt wpa-eap \
            802-1x.eap ttls \
            802-1x.phase2-auth mschapv2 \
            802-1x.identity "$USERNAME"

    # wifi_connect_with_username_and_password hrstudents01 HR-Students guolin19
    # Translates to:
    # + nmcli connection add  type wifi con-name "hrstudents01" ifname wlp3s0 ssid "HR-Students" --  wifi-sec.key-mgmt wpa-eap 802-1x.eap ttls 802-1x.phase2-auth mschapv2 802-1x.identity "guolin19"

}

wifi_connect() {
    # :params: <WIFI name> <Password>
    #   Accept a wifi name which you can get from `wifi_list` command.
    #   and a password to access the router.
    nmcli device wifi connect "$1" password \'$2\'
}

wifi_connect_no_password() {
    # :param: <WIFI name>
    #   Accept a wifi name which you can get from `wifi_list` command.
    #   and a password to access the router.
    nmcli device wifi connect $1
}

# Get window id from the slack application.
# only if slack application is running.
get_slack_win_id () {
    xwininfo -name "Slack - CYREN" | head -n 2 | tail -n 1 | awk '{ print $4; }'
}

# Get window id from the mysql workbench.
# only if the application is running.
get_mysqlw_win_id () {
    xwininfo -name "MySQL Workbench" | head -n 2 | tail -n 1 | awk '{ print $4; }'
}

# When mysql workbench is fired up, it will get 6% trancparency.
mysql-workbench-transparent () {
    mysql-workbench &
    sleep 8 && transset-df --id `get_slack_win_id` 0.94 &
}

# When slack is fired up, it will get 6% trancparency.
slack-transparent () {
    slack &
    sleep 8 && transset-df --id `get_mysqlw_win_id` 0.94 &
}

# Display the current directory in the titlebar.
PROMPT_COMMAND='echo -en "\033]0;$PWD\007"'
#wname() { echo -en "\033]0;$@\007"; }

########
# NEED #
########
battery () {
    echo "Check battery!"
    bash ~/.config/i3/microprograms/notify_battery.sh
}

todo () {
    vim -n ~/git/lab/thorgeir/worklogs/worklogs/todo.log
}

todomd () {
    vim -n ~/git/lab/thorgeir/worklogs/worklogs/todo.markdown
}

todomu () {
    vim -n ~/git/lab/thorgeir/worklogs/worklogs/todo_malware_urls.log
}

###############
## MOVEMENTS ##
###############
# TODO create cd method like => `cd 3`
# it would go to third parent directory above
mkcd () {
    # Creates a directory og move into it
    mkdir "$1"
    cd "$1"
}

cpcd () {
    # copy the file to path and then goes to that path
    cp "$1" "$2"
    cd "$2"
}

cdls() { cd "$@" && ls;  }
cd2 () { cd "../..";     }
cd3 () { cd "../../..";  }

###################
## ENTERTAINMENT ##
###################
sup () {
    echo "$1" | curl -F "sprunge=<-" http://sprunge.us | xclip -selection "clipboard" 
}

######################
## VIRTUAL MACHINES ##
######################
vmssh () {
    cd ~/Documents/virtual_machine/vagrant
    sudo vagrant ssh
}

vmstart () {
    cd ~/Documents/virtual_machine/vagrant
    sudo vagrant up
}

# ssh to server with vi as a terminal navigator.

#ssh_recursive_count=0
#origin
#ssh () { 
#    if [[ $ssh_recursive_count -gt 0 ]]; then
#        ssh_recursive_count=0
#    else
#        ssh_recursive_count=$((ssh_recursive_count))
#        /bin/ssh $@ -lt 'bash -o vi'; 
#    fi
#}
        
drone () { 
    drone_nr=${1}
    /bin/ssh drone${drone_nr} -t 'cd /export/unicomplex_data/unicomplex ; bash --login -o vi'
}

#######################
## KEYBOARD SETTINGS ##
#######################
is () {
    echo "setxkbmap -layout is"
    setxkbmap -layout is
    xmodmap ~/.speedswapper
}

co () {
    echo "setxkbmap -layout is"
    setxkbmap -layout is
    xmodmap ~/.speedswapper
}

us () {
    echo "setxkbmap -layout us"
    setxkbmap -layout us
    xmodmap ~/.speedswapper
}

dvorak () {
    echo "setxkbmap dvorak"
    setxkbmap dvorak
}

go () {
    echo "setxkbmap -layout us"
    setxkbmap -layout us
    xmodmap ~/.speedswapper
}

#############
## VPN/SSH ##
#############
c3emulator () {
    user='thorgeir'
    host='c3unicmplx'
    number=31
    rest='.amadis.com'
    ssh $user'@'$host$number$rest
}

c3drone () {
    # c3drone 23
    user='drone'
    host='c3unicmplx'
    number=$1
    rest='.amadis.com'
    name=$user'@'$host$number$rest
    ssh $name
}

c3random_drone () {
    # Machines I'm pretty sure are OK are listed first
    drones=(23 01 03 04 05 06 07 12 15 16 17 18 19 22 24 25 26)
    randf=("${drones[RANDOM % ${#drones[@]}]}")
    cmd="ssh drone@c3unicmplx$randf.amadis.com"
    echo $cmd
    $cmd
}

#c3thorgeir (){
#    user='thorgeir'
#    host='c3dev-thorgeir01.amadis.com'
#    ssh $user'@'$host
#}
#
#c3devcuckoo (){
#    sshvi $1'@c3devcuckoo01.amadis.com'
#}

c3_api_drone13 (){
    user='thorgeir'
    host='c3unicmplx13.amadis.com'
    ssh $user'@'$host
}

# ssh to server with vi as a terminal navigator.
sshvi () { ssh $@ -t 'bash -o vi'; }

#vpnoffice () {
#    cd ~
#    sudo openvpn --config ~/openvpn/office.ovpn
#    # add username and password (thorgeir, 3jZhpd####)
#}

vpnoffice () {
    cd ~
    # old method (RSA)
    # sudo openvpn --config ~/openvpn/office.ovpn
    # add username and password (thorgeir, 3jZhpd####)
   
    # new method (DUO)
    sudo openvpn --auth-retry interact --config ~/openvpn3/client.ovpn
    # thorgeirs, SG**.01, push, <iphone DUO>, 
}

vpnoffice_via_duo () {
    cd ~
    # old method (RSA)
    # sudo openvpn --config ~/openvpn/office.ovpn
    # add username and password (thorgeir, 3jZhpd####)
   
    # new method (DUO)
    sudo openvpn --auth-retry interact --config ~/openvpn3/client.ovpn
    # thorgeirs, SG**.., push, <iphone DUO>, 
    # Update 4. mars 2018: thorgeirs/SG..6! and wait for 4 sec. and then type push.
    # Update 19. may 2018: thorgeirs/SG..1 and wait for 4 sec. and then type push.
    # Update Mon Sep 17 16:57:00 GMT 2018: thorgeirs/KBVe...01! (mail.cyren.com) and wait for 4 sec. and then type push.
    # Update Wed Nov 28 20:07:33 UTC 2018: thorgeirs/KBVe...02! (mail.cyren.com) and wait for 4 sec. and then type push.
    # Update Sun Jan 20 19:14:40 UTC 2019: thorgeirs/KBVe...03! (mail.cyren.com) and wait for 4 sec. and then type push.
    # Update Fri Jul 12 11:25:37 UTC 2019: thorgeirs/KBVe...04! (mail.cyren.com) and wait for 4 sec. and then type push.
    # Update Wed Sep 18 16:36:56 UTC 2019: thorgeirs/KBVe...05! (mail.cyren.com) and wait for 4 sec. and then type push.
    # Update Tue Dec  3 16:03:48 UTC 2019: thorgeirs/KBVe...06! (mail.cyren.com) and wait for 4 sec. and then type push.
    # Update Wed Mar 11 18:33:11 UTC 2020: thorgeirs/KBVe...07! (mail.cyren.com) and wait for 4 sec. and then type push.



    # Connect to ber1, for example to be able to use vncviewer.
    #sudo route add -net 10.105.54.0/24 gw 172.30.232.1 tun0

    # Connect to C3
    #sudo route add -net 10.3.0.0/16 gw 172.30.232.1 tun0
    # OR #
    #sudo route add -net 10.3.0.0/16 gw 172.30.236.1 tun0
}

vpnc4 () {
    cd ~
    # old method (RSA)
    # sudo openvpn is the version 2.3
    # openvpn is the version 2.4, we want to use that version.
    #sudo openvpn --config ~/openvpn/c4.ovpn
    # add username and password 
    # (thsigurdsson, [pin to RSA app] then passw. is the RSA token number)

    # Last update: 2018-03-07
    sudo /root/Downloads/openvpn-2.4.5/src/openvpn/openvpn --config /home/thorgeir/openvpn/c4.ovpn
    #sudo su --command="/home/thorgeir/Downloads/openvpn-2.4.5/src/openvpn --config /home/thorgeir/openvpn/c4.ovpn"
    #        --shell=/bin/bash root
    # add username and password 
    # (thsigurdsson,  </a...!>:push)
}

#sshoffice () {
#    ssh thorgeir@10.101.1.14
#    # add thorgeir's password (6oN...)
#    # now you are connected
#}
#
#sshdev () {
#    ssh thorgeir@10.3.80.41
#}

forticlient () {
    #cp /etc/resolv.conf /tmp/resolv.conf.backup && (sleep 60; sudo cp -f /tmp/resolv.conf.backup /etc/resolv.conf) &

    echo "SMS METHOD"
    echo "=========="
    echo "Go to: https://is.vpn.cyren.com"
    echo "Type in Master Username and Password"
    echo "In next window type 'sms' and hit enter."
    echo "Password for VPN:<free ip password>,<one of sms codes>"

    # Search in lastpass for password, search "forti"
    /home/thorgeir/forticlient/forticlientsslvpn/fortisslvpn.sh ASH1 thsigurdsson
    #/home/thorgeir/forticlient/forticlientsslvpn/fortisslvpn.sh IL thsigurdsson
    # (thsigurdsson,  /a...#) without push
    #(set -x; sleep 60)

}

vpnc3 () {
    cd ~
    # RSA
    #sudo openvpn --config ~/openvpn/commtouch2.ovpn
    # add username and password (thsigurdsson, pin and rsa passcode)

    # DUO
    sudo openvpn --auth-retry interact --config ~/openvpn/c9-duo-openvpn-tcp.conf 
    # add username and password (thsigurdsson, /asolf...:push)
}

vpnc3 () {
    cd ~
    # RSA
    #sudo openvpn --config ~/openvpn/commtouch2.ovpn
    # add username and password (thsigurdsson, pin and rsa passcode)

    # DUO
    sudo openvpn --auth-retry interact --config ~/openvpn/c3-duo-openvpn.conf 
    # add username and password (thsigurdsson, /asolf...#:push)
}
##############
## DISPLAYS ##
##############
vga_orient () {
    xrandr --output LVDS1 --auto --output VGA1 --auto LVDS1
}

hdmi_orient () {
    xrandr --output LVDS1 --auto --output HDMI1 --auto --right-of LVDS1
}

hdmi_orient_thinkpad () {
    xrandr --output eDP-1 --auto --output HDMI-2 --auto --right-of eDP-1
}

hdmi_orient_docker () {
    # Using HDMI and DVI as adapters.
    #xrandr --output eDP-1 --auto --output DP-2-1 --left-of eDP-1 --output DP-2-2 --auto --left-of DP-2-1
    #xrandr --output DP-2-1 --auto --output DP-2-2 --right-of DP-2-1 --output eDP-1 --right-of DP-2-2
    xrandr --output DP-2-2 --auto --output DP-2-1 --right-of DP-2-2 --output eDP-1 --right-of DP-2-1
}

screenrecord () {
    ffmpeg -f x11grab -s $(xdpyinfo | grep -i dimensions: | sed 's/[^0-9]*pixels.*(.*).*//' | sed 's/[^0-9x]*//') -r 25 -i :0.0 valami.avi
}

hdmi_orient_3 () {
    # Positions:
    #  __  __  __
    # |  ||__||__|
    # |__|
    #

    # Positions:
    #  __  __  __ 
    # |__||__||  |
    #         |__|
    #
    communication="DP-2"
    #up="DVI-I-2"
    #--output $up --auto  --left-of $left \
    browser='HDMI-2'
    code="HDMI-1"
    xrandr  --output $communication --auto --rotate left \
            --output $browser --auto --left-of $communication \
            --output $code --auto --left-of $browser
   
        
    # Positions:
    #  __  __  __
    # |__||  ||__|
    #     |__|
    #
    #communication="HDMI-1"
    #browser='HDMI-3'
    #code="DP-1"
    #xrandr  --output $code --auto \
    #        --output $communication --auto --rotate normal --left-of $code \
    #        --output $browser --auto --right-of $code
}

hdmi_orient_office () {

    # Positions:
    #  __  __ 
    # |__||__|
    #     
    left='HDMI-3'
    right="HDMI-1"
    xrandr  --output $left --auto \
            --output $right --auto --right-of $left
}


hdmi_monitor_data_office () {
    display1='HDMI-1'
    display2='HDMI-3'
    bright_step='0.1'
    brightness=`xrandr --verbose | grep -m 2 -i brightness | cut -f2 -d ' ' | cat -n | awk '$1 == "2" {print $2}'`
}

hdmi_monitor_data_lenovo () {
    display='HDMI-2'
    bright_step='0.1'
    brightness=`xrandr --verbose | grep -m 2 -i brightness | cut -f2 -d ' ' | cat -n | awk '$1 == "2" {print $2}'`
}

hdmi_bright_down_lenovo () {
    hdmi_monitor_data_lenovo
   
    SUB=`echo $brightness $bright_step | awk '{ print $1 - $2 }'`
    echo $display' brightness '$SUB
    xrandr --output $display --brightness $SUB
}

hdmi_bright_up_lenovo () {
    hdmi_monito_data_lenovo
   
    ADD=`echo $brightness $bright_step | awk '{ print $1 + $2 }'`
    echo $display' brightness '$ADD
    xrandr --output $display --brightness $ADD
}

hdmi_bright_up_office () {
    hdmi_monitor_data_office
   
    ADD=`echo $brightness $bright_step | awk '{ print $1 + $2 }'`
    echo $display2' brightness '$ADD
    xrandr --output $display2 --brightness $ADD

    echo $display1' brightness '$ADD
    xrandr --output $display1 --brightness $ADD
    
}

hdmi_bright_down_office () {
    hdmi_monitor_data_office
   
    SUB=`echo $brightness $bright_step | awk '{ print $1 - $2 }'`
    echo $display1' brightness '$SUB
    xrandr --output $display1 --brightness $SUB
    
    echo $display2' brightness '$SUB
    xrandr --output $display2 --brightness $SUB
}

#hdmi_orient_3

##########
## COPY ##
##########
txtcp () {
    # txtcp file.txt 10 20
    # will copy text from line 10 to 20 to clipboard
    cat $1 | head -n $2 | tail -n $3 | xclip -sel clip
}

cptext () {
    # Copy the output of cat and send 
    # it to the clipboard that works with
    # Ctrl-V
    cat $1 | xclip -selection c
    echo "Copy"
    echo $1
    echo "---------"
    echo "Use Ctrl-v to export output"
}

xc () {
    # Paste from clipbard to stdout.
    echo $(xclip -selection clipboard -o)
}

##########################
## COMMAND-LINE SCRIPTS ##
##########################
mykill() {
    for pid in pgrep $1; do pkill $pid; done 
}

#function cal_is () {
#    python ~/github/thorgeir/calendar_icelandic/cal_is.py "$@"
#    python ~/github/thorgeir/calendar_icelandic/cal_is/cal_is.py "$@"
#}

is_caps_lock_on () {
    xset q | grep LED | tail -c 2
}

wifi_connect_phone () {
    wifi_connect "AndroidAP" "ee4b0b56297e"
}


photo_facebook () {
    # Image for facebook, max 2048 pixels. The resize flags says, with max 2048 and height max 2048.
    echo 'mkdir -p shrink; for img in $(ls *.jpg); do (set -o xtrace; convert $img -resize '2048x2048' -quality 85 ./shrink/$img); done'
}

facebook_photo () {
    # Image for facebook, max 2048 pixels. The resize flags says, with max 2048 and height max 2048.
    echo 'mkdir -p shrink; for img in $(ls *.jpg); do (set -o xtrace; convert $img -resize '2048x2048' -quality 85 ./shrink/$img); done'
}

c3_connect_to_specific_host () {
 echo "ssh -L 8080:c3blowfishclient02.amadis.com:80 10.101.1.14"
 echo "then run localhost:8080"
}


t () {
    # Create given number of panes in the current tmux window/session.
    number_of_panes=${1};
    bash ~/git/lab/thorgeir/tools/tgrid.sh ${number_of_panes}
}

help_disk_eject () {
    echo sudo umount /run/media/thorgeir/Elements
    echo udisksctl power-off -b /dev/sda1
}


help_network_wired_troubleshooting () {
    echo nmcli device status
    echo journal -f # To see networking logs.
}

help_laptop_tempature () {
    echo $ sensors {get CPU temp}
    echo $ sudo systemctl stop systemd-logind.service
}

help_scan_photos () {
    # Search:
    #   Linux driver epson perfection 1240U
    # Download:
    # * http://download.ebz.epson.net/dsc/search/01/search/searchModule
    # * http://download.ebz.epson.net/dsc/search/01/search/searchModule
    # * http://support.epson.net/linux/en/iscan_c.php?version=2.30.4
    echo "Use iscan program."
}

notification () {
    # information about notification system.
    echo 'notify-send "test" "body"'
    echo "ps aux | grep -i noti"
    echo "cat /usr/share/dbus-1/services/org.freedesktop.Notifications.service"
    echo "To fix the missing notification, I clicked on the icon in right down corner and hit clear all notifications."
}

touchdate () {
    # $ touchdate mytext.log
    # Creates file mytext_<current date>.log
    name=$(echo ${1} | cut -d"." -f1)
    ext=$(echo ${1} | cut -d"." -f2)
    touch ${name}_$(date --utc '+%Y%m%dT%H%M%S').${ext}
}

#export IS_DISPLAY_SET=0
#
#if [[ ${IS_DISPLAY_SET} == 0 ]] && [[ $(xrandr | grep eDP | wc -l) == 1 ]] && [[ $(xrandr | grep " connected " | wc -l) == 3 ]];
#    then hdmi_orient_docker
#    export IS_DISPLAY_SET=1
#fi

####################
## SYSTEM CONTROL ##
####################

# prevent terminal to freeze
# Ctrl-s freezes the terminal
# Ctrl-q thawed the terminal
stty -ixon

source ~/.aliases

help_sync_images () {

    # Run this command on different terminal to watch 
    # what happen for external hard drives.
    echo udisksctl monitor

    # Mount my icybox external hard drive to my local directory.
    echo sudo mount /dev/sda1 /mnt/icybox
    echo cd ~/media

    # Notice the end-backslash on the first `2020`.
    # Remove -n flag if you want to run this command.
    # -n is just dry run and shows what will happen.
    echo rsync -anv 2020/ /mnt/icybox/media/photos/2020

    # Confirm no difference between folder and
    # then you can delete the original copy
    # Credit: https://askubuntu.com/questions/421712/comparing-the-contents-of-two-directories
    echo  "diff <(find videos/ -type f -exec md5sum {} + | sort -k 2) <(find /run/media/thorgeir/Linux1T/media/videos/ -type f -exec md5sum {} + | sort -k 2)"
}

help_set_caps() {
    echo "xdotool key Caps_Lock"
}


BARRACUDA () {
    echo BARRACUDA LOVES GREG.
}
embla () {
    echo Hi, Embla!
}

default_browser () {
    vim ~/.config/mimeapps.list
}

work_clean () {
    echo "Remove unnecessary files and folders"
    rm ./*.pyc
    rm ./*.swp
    rm -r ./__pycache__
    rm -r ./.pytest_cache
}


help_screensaver_off () {
    # Turn off screensaver on laptop.
    # Add these lines to ~/.bash_profile or ~/.profile
    # After reboot run xset -q to see if
    # it had take affect.
    echo xset s off 
    echo xset s noblank
    echo xset -dpms
}

help_set_default_browser () {
    # Credit: https://unix.stackexchange.com/a/579994
    # See current browser.
    echo xdg-mime query default x-scheme-handler/https

    # Set default Browser.
    echo xdg-mime default google-chrome.desktop x-scheme-handler/https
    echo xdg-mime default google-chrome.desktop x-scheme-handler/http

    # Verify the changes.
    echo xdg-mime query default x-scheme-handler/https
}


help_add_echo_cancel_to_pulseaudio () {
    # Credit:
    #   * https://www.youtube.com/watch?v=lTodCeVAfpI
    #   * https://gist.githubusercontent.com/grigio/cb93c3e8710a6f045a3dd9456ec01799/raw/94f07c7d75bcf5dd9b08a9c3034844223ec6fbe1/fix-microphone-background-noise.sh
    #   * https://askubuntu.com/questions/18958/realtime-noise-removal-with-pulseaudio 
    #
    echo "echo load-module module-echo-cancel source_name=noechosource sink_name=noechosink >> /etc/pulse/default.pa"
    echo "echo set-default-source noechosource >> /etc/pulse/default.pa"
    echo "echo set-default-sink noechosink >> /etc/pulse/default.pa"
    
    echo "pulseaudio -k"
}

help_install_pulseaudio () {
    # Credit: https://linoxide.com/linux-how-to/install-equalizer-pulseeffects-linux/
    # Podcast related: https://dlnxtend.com/8
    echo sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo  
    echo sudo flatpak install flathub com.github.wwmm.pulseeffects
}

help_pulseeffect () {
    # Run this GUI app.
    echo install using flatpak
    echo run with flatpak
    echo $ flatpak run com.github.wwmm.pulseeffects
    echo Also run:
    echo $ pavucontrol
    echo Here you can control wich application use which audio input.
    echo Worth to consider to to use this command
    echo pulseeffects --gapplication-service
    echo more info: https://news.ycombinator.com/item?id=24985090
}

help_network_share_ethernet () {
  echo https://www.cesariogarcia.com/?p=611
}

help_virtualbox_fullscreen () {
    # this helped me:
    #  * https://askubuntu.com/questions/573596/unable-to-install-guest-additions-cd-image-on-virtual-box
    echo "read the comments in the function!"
}

shrink_videos () {
    echo 'mkdir -p shrink; for mov in $(ls *.MOV); do (set -o xtrace; ffmpeg -i $mov -c:v libx264 -c:a copy -crf 20 ./shrink/$mov); done'

    echo "# Recursivly find *.mov files and reduce size"
    echo "# Store the shrinked file with same absolute path in shrink folder."
    echo "# Print out shrink commands to shrink_commands.sh file."
    echo "# For .MOV, mp4"
    echo 'echo "set -o errexit" > shrink_commands.sh; find * -iname "*.mp4" -print0 | while read -r -d $'\0' mov; do echo mkdir -p shrink/$(dirname "$mov"); echo ffmpeg -i \"$mov\" -c:v libx264 -c:a copy -crf 20 \"shrink/$mov\"; done >> shrink_commands.sh;'

    echo "# See the difference between folders."
    echo "diff <(pushd Dropbox; find . | sort; popd) <(pushd Dropbox_shrink/shrink; find . | sort; popd) | less"
}

shrink_photos () {
    # Image for facebook, max 2048 pixels. The resize flags says, with max 2048 and height max 2048.
    echo 'mkdir -p shrink; for img in $(ls *.jpg); do (set -o xtrace; convert $img -resize '2048x2048' -quality 85 ./shrink/$img); done'
}


help_mouse_wireless () {
    echo "Install solaar:"
    echo "git clone https://github.com/pwr-Solaar/Solaar.git"
    echo "read docs/installation.md"
    echo " ... copy udev rule on right place"
    echo " ... pip3 install --user ."
    echo " ... if password prompt, just skip ..."
    echo "Run solaar program:"
    echo "~/.local/bin/solaar"
    echo "1. Click on 'Unifying Receiver'"
    echo "2. then on light bulb"
    echo "3. Turn on the mouse"
}

help_remove_duplicates () {
    # Credit: https://superuser.com/a/691551 
    echo 'fdupes -rf . | grep -v '^$' > duplicate_files'
    echo 'xargs -d '\n' -a duplicate_files rm -v'

    # OTHER WAY, WHICH IS MUCH NICER!
    # https://xyne.archlinux.ca/projects/rmdupes/
    # Download tar, extracted and wolla!
    # -n:   dry-run, just remove this flag to acually remove duplicates.
    #       When this flag is not provide, it will ask you before you
    #       want to remove the files.
    # -r:   reference folder, use 2021 as the main source and
    #       remove duplates in the books directory.
    echo "cd ~/media"
    echo "python3.6 ~/Downloads/rmdupes-2020.12/rmdupes ./books -r ./2021 -n"
}

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
