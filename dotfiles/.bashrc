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


# export PS1="\[\033[38;5;3m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]:[\[$(tput sgr0)\]\[\033[9;2;93m\]\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\[$(tput sgr0)\]\n"
# export PS1="\[\033[38;5;3m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]:[\[$(tput sgr0)\]\[\033[9;2;93m\]\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\[$(tput sgr0)\]\n"
export PS1="\[\033[38;5;3m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]:[\[$(tput sgr0)\]\[\033[2;93m\]\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\[$(tput sgr0)\]\n"

    #export PS1=" \w $ "

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
    #pushd ~/git/hub/thorgeir-travel/worklogs/
    mkdir -p ~/work/notes
    pushd ~/work/notes
    vim -n todo.markdown
    popd
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

droneash1 () {
    drone_nr=${1}
    ssh drone@prd-unicomplex-ash1-0${drone_nr}.threatlab.ash1.cynet \
        -i ~/.ssh/drone_rsa \
        -t 'cd /export/unicomplex_data/unicomplex ; bash --login -o vi'
}

dronelf () {
    drone_nr=${1}
    ssh drone@prd-unicomplex-ash1-0${drone_nr}.threatlab.ash1.cynet \
        -i ~/.ssh/drone_rsa \
        -t 'cd /export/unicomplex_data/unicomplex ; bash --login -o vi'
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

setlang () {
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

hdmi_orient_thinkpad_duplicate () {
    xrandr --output HDMI-2 --auto --same-as eDP-1
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

home-office () {
    # Personal laptop + external monitor
    bash ~/.screenlayout/home-hdmi2.sh
}

home-normal () {
    # Only use laptop screen
    bash ~/.screenlayout/home-normal.sh
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
    # copy to clipbard
    cat $1 | xclip -selection c
}

xp () {
    # Paste from clipbard to stdout.
    echo $(xclip -selection clipboard -o)
}

##
## Work
##
daily_browsing () {
    google-chrome --app=https://10.105.15.40/d/EXsm2tnnk/precis-futterkorb?orgId=1&from=now-2d&to=now&refresh=1m
    google-chrome --app=http://production-grafana-ash1-001.threatlab.ash1.cynet/d/000000001/virus-lab?orgId=2
    google-chrome --app="http://production-es-stats-master-ash1-001.threatlab.ash1.cynet/app/kibana#/dashboard/370afc00-19d4-11eb-83ac-1dfb9b48f17e?_g=(refreshInterval:(pause:!t,value:0),time:(from:now-7d,mode:quick,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(darkTheme:!t,hidePanelTitles:!f,useMargins:!t),panels:!((embeddableConfig:(),gridData:(h:13,i:'1',w:48,x:0,y:56),id:a2fc2700-19d3-11eb-83ac-1dfb9b48f17e,panelIndex:'1',type:visualization,version:'6.8.2'),(embeddableConfig:(),gridData:(h:12,i:'3',w:48,x:0,y:0),id:'4d2848c0-5b02-11eb-83ac-1dfb9b48f17e',panelIndex:'3',type:visualization,version:'6.8.2'),(embeddableConfig:(),gridData:(h:12,i:'4',w:48,x:0,y:12),id:'786ecce0-5b0a-11eb-83ac-1dfb9b48f17e',panelIndex:'4',type:visualization,version:'6.8.2'),(embeddableConfig:(),gridData:(h:10,i:'5',w:48,x:0,y:46),id:'21923460-5cc3-11eb-83ac-1dfb9b48f17e',panelIndex:'5',type:visualization,version:'6.8.2'),(embeddableConfig:(),gridData:(h:10,i:'6',w:48,x:0,y:24),id:'29eaffc0-60a1-11eb-83ac-1dfb9b48f17e',panelIndex:'6',type:visualization,version:'6.8.2'),(embeddableConfig:(),gridData:(h:12,i:'7',w:48,x:0,y:34),id:'0cb1e420-60a4-11eb-83ac-1dfb9b48f17e',panelIndex:'7',type:visualization,version:'6.8.2')),query:(language:lucene,query:''),timeRestore:!f,title:'Linkfunnel%20-%20Malware%20URLs%20from%20Fooze',viewMode:view)"
    exit 0
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
    echo 'mkdir -p shrink; for img in $(ls *.jpg); do (set -o xtrace; magick $img -resize '2048x2048' -quality 85 ./shrink/$img); done'
}

facebook_photo () {
    # Image for facebook, max 2048 pixels. The resize flags says, with max 2048 and height max 2048.
    echo 'mkdir -p shrink; for img in $(ls *.jpg); do (set -o xtrace; magick $img -resize '2048x2048' -quality 85 ./shrink/$img); done'
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

ta () {
    TERM=xterm-256color
    tmux a -t ${@}
}

sbl () {
    source ~/virtualenvs/black/bin/activate
}

SQL_TASK_PATH=~/git/lab/thorgeir/db_queries/ash1/unicomplex
sqltaskr() {
    pushd ${SQL_TASK_PATH}
    vim ash1_unicomplex_read.sql
    popd
}

sqltaskw() {
    pushd ${SQL_TASK_PATH}/
    vim ash1_unicomplex_write.sql
    popd
}

tmux_panes_filelines() {
    # Iterate through given file and send each line to tmux panes.
    filepath=${1}; shift

    for pane_nr in $(tmux list-panes -F '#P'); do
        #tmux send-keys -t ${pane_nr} $(sed -n ${pane_nr}p ${filepath});
        tmux send-keys -t ${pane_nr} $(1 + $pane_nr);
    done
}

#
# Kubernetes
#  ~~~~~~~~
kc () {
    # Choose kubernetes context and namespace.
    kubectl-ctx
    kubectl-ns
    kubectl get pods
}


# ref.: superuser.com/questions/249293
# settitle() {
#     printf "\033k$1\033\\"
# }
#
# ssh() {
#     settitle "$*"
#     command ssh "$@"
#     settitle "bash"
# }

xs () {
    # swap caps and esc keys.
    (set -x; xmodmap ~/.speedswapper)
}

helptmux () {
    echo '"C-a + =" - List all copy history'
}

work_clean () {
    echo "Remove unnecessary files and folders"
    rm ./*.pyc
    rm ./*.swp
    rm -r ./__pycache__
    rm -r ./.pytest_cache
}

gitpush () {
    #
    # Created to be able to be quicker to access CI/CD pipline
    # of current repository when doing git push. Even better
    # we can open the repon in repo.
    #
    # To be able to open URL on remote server, may be it is possible
    # to use URXVT perl plugin:
    #   * https://wiki.archlinux.org/title/rxvt-unicode#Yankable_URLs_(no_mouse)
    #
    git push
    echo ""
    echo "Pipeline:"
    git_repo_url=$(git config --get remote.origin.url | sed 's/:/\//' | sed 's/git@/https:\/\//' | sed 's/\.git/\/-\/pipelines/')
    echo ">> $git_repo_url"
}

lbreak () {
    # line break
    echo "====";
}

poetry_mode () {
    prefIx="(POETRY MODE)"
    while true; do
        echo "$prefix u) poetry update"
        echo "$prefix i) poetry install"
        echo "$prefix l) poetry env list"
        echo "$prefix e) exit"
        read -p "" uile
        case $uile in
            [Uu]* ) lbreak; poetry update; lbreak; ;;
            [Ii]* ) lbreak; poetry install; lbreak; ;;
            [Ll]* ) lbreak; poetry env list; lbreak; ;;
            [Ee]* ) echo exit && break;;
            * ) echo exit && break;;
        esac
    done
}

poetry_formatting () {
    prefix="(Format/Check)"
    while true; do
        echo "$prefix Checks -->"
        echo "$prefix v) poetry run validate-pyproject pyproject.toml"
        echo "$prefix c) poetry run black --check . --exclude=.tox"
        echo "$prefix d) poetry run docformatter --close-quotes-on-newline --recursive ."
        echo "$prefix f) poetry run flake8"
        echo "$prefix m) poetry run mypy ."
        echo "$prefix "
        echo "$prefix Formatting -->"
        echo "$prefix b) poetry run black . --exclude=.tox"
        echo "$prefix s) poetry run docformatter --close-quotes-on-newline --recursive --in-place ."
        echo "$prefix "
        echo "$prefix e) exit"
        read -p "" vcbdfme
        case $vcbdfme in
            [Vv]* ) lbreak; poetry run validate-pyproject pyproject.toml; lbreak; ;;
            [Cc]* ) lbreak; poetry run black --check . --exclude=.tox; lbreak; ;;
            [Bb]* ) lbreak; poetry run black . --exclude=.tox; lbreak; ;;
            [Dd]* ) lbreak; poetry run docformatter --close-quotes-on-newline --recursive .; lbreak; ;;
            [Ss]* ) lbreak; poetry run docformatter --close-quotes-on-newline --recursive --in-place .; lbreak; ;;
            [Ff]* ) lbreak; poetry run flake8; lbreak; ;;
            [Mm]* ) lbreak; poetry run mypy .; lbreak; ;;
            [Ee]* ) echo exit && break;;
            * ) echo exit && break;;
        esac
    done
}

poetry_test () {
    prefIx="(TEST MODE)"
    while true; do
        echo "$prefix c) python -m http.server --directory htmlcov/"
        echo "$prefix b) poetry run black . --exclude=.tox"
        echo "$prefix t) poetry run pytest -s"
        echo "$prefix i) poetry run pytest -s -o log_cli=true -o log_cli_level=INFO"
        echo "$prefix l) poetry run pytest -s --looponfail"
        echo "$prefix v) poetry run pytest -vvv -s --looponfail"
        echo "$prefix d) poetry run pytest -vvv -s -o log_cli=true -o log_cli_level=INFO --looponfail"
        echo "$prefix r) poetry run pytest -vvv -s -o log_cli=true -o log_cli_level=DEBUG --looponfail"
        echo "$prefix f) poetry run flake8"
        echo "$prefix m) poetry run mypy ."
        echo "$prefix e) exit"
        read -p "" cbtilvdrefm
        case $cbtilvdrefm in
            [Cc]* ) lbreak; python -m http.server --directory htmlcov/; lbreak; ;;
            [Bb]* ) lbreak; poetry run black . --exclude=.tox; lbreak; ;;
            [Tt]* ) lbreak; poetry run pytest -s; lbreak; ;;
            [Ii]* ) lbreak; poetry run pytest -s -o log_cli=true -o log_cli_level=INFO; lbreak; ;;
            [Ll]* ) lbreak; poetry run pytest -s --looponfail; lbreak; ;;
            [Vv]* ) lbreak; poetry run pytest -vvv -s --looponfail; lbreak; ;;
            [Dd]* ) lbreak; poetry run pytest -vvv -s -o log_cli=true -o log_cli_level=INFO --looponfail; lbreak; ;;
            [Rr]* ) lbreak; poetry run pytest -vvv -s -o log_cli=true -o log_cli_level=DEBUG --looponfail; lbreak; ;;
            [Ff]* ) lbreak; poetry run flake8; lbreak; ;;
            [Mm]* ) lbreak; poetry run mypy .; lbreak; ;;
            [Ee]* ) echo exit && break;;
            * ) echo exit && break;;
        esac
    done
}

sphinx_mode () {
    prefix="(Sphinx)"
    while true; do
        echo "$prefix t) poetry run sphinx-build -vvv -b spelling -d docs/build/doctrees docs docs/build/spelling"
        echo "$prefix d) poetry run sphinx-apidoc --separate --force --templatedir=./docs/_templates/ -o docs <project name>/ "
        echo "$prefix c) poetry run sphinx-apidoc --separate --force --templatedir=./docs/_templates/ -o docs src/"
        echo "$prefix l) poetry run sphinx-autobuild -a --host 0.0.0.0 docs docs/_build/html --watch ./src --watch docs/index.rst --watch docs/conf.py --watch README.rst"
        echo "$prefix e) exit"
        read -p "" tdcle
        case $tdcle in
            [Tt]* ) lbreak; poetry run sphinx-build -vvv -b spelling -d docs/build/doctrees docs docs/build/spelling; lbreak; ;;
            [Dd]* ) lbreak; poetry run sphinx-apidoc --separate --force --templatedir=./docs/_templates/ -o docs $(basename $(pwd)); lbreak; ;;
            [Cc]* ) lbreak; poetry run sphinx-apidoc --separate --force --templatedir=./docs/_templates/ -o docs src/; lbreak; ;;
            [Ll]* ) lbreak; poetry run sphinx-autobuild -a --host 0.0.0.0 docs docs/_build/html --watch ./src --watch docs/index.rst --watch docs/conf.py --watch README.rst; lbreak; ;;
            [Ee]* ) echo exit && break;;
            * ) echo exit && break;;
        esac
    done
}

helm_tests () {
    (set -x; helm template . -f ../configs/staging.yaml)
    (set -x; helm template . -f ../configs/production.yaml)
    (set -x; helm lint .)
}

helm_mode () {
    prefix="(Helm)"
    while true; do
        echo "$prefix NAVIGATE TO THE TEMPLATE FOLDER!"
        echo "$prefix a) RUN ALL TESTS"
        echo "$prefix s) helm template . -f ../configs/staging.yaml"
        echo "$prefix p) helm template . -f ../configs/production.yaml"
        echo "$prefix l) helm lint ."
        echo "$prefix e) exit"
        read -p "" asple
        case $asple in
            [Aa]* ) lbreak; helm_tests; lbreak; ;;
            [Ss]* ) lbreak; pushd $(ls | grep -v configs); helm template . -f ../configs/staging.yaml | less; popd; lbreak; ;;
            [Pp]* ) lbreak; pushd $(ls | grep -v configs); helm template . -f ../configs/production.yaml | less; popd; lbreak; ;;
            [Ll]* ) lbreak; pushd $(ls | grep -v configs); helm lint .; popd; lbreak; ;;
            [Ee]* ) echo exit && break;;
            * ) echo exit && break;;
        esac
    done
}


ksl () {
    # Kubernetes Staging Linkfunnel-pipelines
    k9s --kubeconfig ~/.kube/config --context qlab-threatlab-ash1 --namespace linkfunnel-pipeline
}

kpu () {
    # Kubernetes Production url-pipelines
    k9s --kubeconfig ~/.kube/config --context prd_collective_ash1 --namespace url-pipelines
}

repoinit () {
    # $ repo_init feed2phisherman/pipeline phisherman_db_to_resubmit TL-1662
    #repo_path=${1}; shift
    repo_name=${1}; shift
    ticket=${1}; shift

    PY_VERSION="3.10"

    cp -r ~/git/lab/threatlookup/repository_example ./${repo_name}

    cd ${repo_name}

    # Update CHANGELOG file.
    echo "" >> CHANGELOG.rst
    echo "[0.1.0] - $(date --utc +%F)" >> CHANGELOG.rst
    echo "====================" >> CHANGELOG.rst
    echo "" >> CHANGELOG.rst
    echo "Initilize" >> CHANGELOG.rst
    echo "~~~~~~~~~" >> CHANGELOG.rst
    echo "" >> CHANGELOG.rst
    echo "* Ticket: ${ticket}" >> CHANGELOG.rst

    # TODO Change docs/conf.py gitlab path using repo_path and repo_name

    # Describe the project.
    vim README.rst

    poetry init --name "${repo_name}" --python "^${PY_VERSION}.0" \
        --author "Þorgeir Sigurðsson <thorgeir.sigurdsson@cyren.com>" \
        --dev-dependency pytest:^6.2.4 \
        --dev-dependency mypy:^0.910 \
        --dev-dependency pytest-cov:^2.12.1 \
        --dev-dependency pytest-xdist:^2.5.0 \
        --dev-dependency pylint:^2.13.5 \
        --dev-dependency flake8:^4.0.1 \
        --dev-dependency black:22.3.0 \
        --dev-dependency Sphinx:^4.3.2 \
        --dev-dependency sphinx-autobuild:^2021.3.14 \
        --dev-dependency sphinx-rtd-theme:^1.0.0 \
        --dev-dependency autodoc-pydantic:^1.6.1 \
        --dev-dependency sphinxcontrib-spelling:^7.3.2 \
        --dev-dependency sphinx_mdinclude:^0.5.1 \
        --dev-dependency flake8-pylint:^0.1.3

    poetry env use /home/thorgeir/.pyenv/shims/python${PY_VERSION}

    poetry install


    doc_dir=docs

    poetry run sphinx-quickstart \
        --ext-coverage --ext-viewcode --ext-autodoc --sep \
        --extensions="sphinxcontrib.spelling,sphinx_rtd_theme,sphinx.ext.todo" \
        --makefile --release 0.1.0 -v 0.1.0 \
        --author "Thorgeir Sigurdsson <thorgeir.sigurdsson@cyren.com>" \
        --language "en" \
        --project "${repo_name}" \
        ${doc_dir}

     # Use sphinx_rtd_theme theme instead of default one
     sed -i 's/html_theme = .*/html_theme = "sphinx_rtd_theme"/' ./${doc_dir}/"source"/conf.py
}


kslf () {
    # View [K]ubernetes [S]taging [L]ink[f]unnel
    k9s --kubeconfig ~/.kube/config --context qlab-threatlab-ash1 --namespace linkfunnel-pipeline
}

kplf () {
    # View [K]ubernetes [S]taging [L]ink[f]unnel
    k9s --kubeconfig ~/.kube/config --context prd_collective_ash1 --namespace linkfunnel-pipeline
}



#rfzf () {
#    # Comman command when it comes to GitLab [r]epositoies using [fzf] command.
#    while true; do
#        cmd=$(echo "poetry version" | fzf)
#        (set +x; eval $cmd)
#    done
#}

run_all_tests () {
    (set -x; poetry run validate-pyproject pyproject.toml)
    (set -x; poetry run black --check .)
    (set -x; poetry run flake8)
    (set -x; poetry run mypy)

    # https://github.com/RedCoolBeans/dockerlint
    (set -x; dockerlint Dockerfile)

    (set -x; poetry run pytest)
}

###                    #
## GIT RELATED STUFF  ##
#                    ###

gs () {
    git status
}

gp () {
    git pull
}

gb () {
    # Interactivly choose branch from local branches
    # Newest commits listed at the bottom.
    git checkout $(git branch --sort=-committerdate | tr "*" " " | fzf)
    
}

gcb () {
    # Create new branch locally and switch to that branch.
    git checkout -b $@
    
}

gbla () {
    # Git blame - author
    # Find authors of python scripts in current directory
    for m in $(ls *.py | grep -v __init__); do
        echo -n "- [ ] $(git blame --line-porcelain $m | grep  "^author " | sort | uniq -c | sort -rn | head -n 1 | awk '{print $2, $3}')"
        echo "  $m"
    done

}

gbd () {
    # Delete choosen branch from local branch list.
    # It will not delete it remote.
    git branch -d $(git branch | tr "*" " " | fzf)
}


gd () {
    # Interactivly choose branch from local branches
    git diff
}

ga () {
    (set -x; git add .)
}

gu () {
    # Update current branch with newest changes from development branch.
    git fetch && git merge origin/development 
}

gmd () {
    (set -x; git merge development)
}

gac () {
    git add .
    git commit
}

gr () {
    # Common commands when developing in git python repositories.
    # This method lists commands for interacts with the user and the
    # The method interacts with the user and the

    git status

    while true; do
        echo "a) RUN ALL TESTS"
        echo "b) git branch"
        echo "s) git status"
        echo "d) git diff"
        echo "c) git add . && git commit"
        echo "p) git push"
        echo "u) git push origin \$(git rev-parse --abbrev-ref HEAD)"
        echo "o) [Enter poetry]"
        echo "t) [Enter poetry tests]"
        echo "x) [Enter Sphinx mode]"
        echo "h) [Enter Helm mode]"
        echo "f) [Enter Formatting/Check]"
        echo "r) source /export/unicomplex_data/unicomplex/env.sh && source set_global_env.sh && poetry run process_start"
        echo "e) exit"
        read -p "" absdcpuotxhrfe
        case $absdcpuotxhrfe in
            [Aa]* ) lbreak; run_all_tests; lbreak; ;;
            [Bb]* ) lbreak; gb; lbreak; ;;
            [Ss]* ) lbreak; git status; lbreak; ;;
            [Dd]* ) lbreak; git diff; lbreak; ;;
            [Cc]* ) lbreak; git add . && git commit; lbreak;;
            [Pp]* ) lbreak; gitpush; lbreak; ;;
            [Uu]* ) lbreak; (set -x; git push origin $(git rev-parse --abbrev-ref HEAD)); lbreak; ;;
            [Oo]* ) lbreak; poetry_mode; lbreak; ;;
            #[Tt]* ) lbreak; poetry run pytest -s; lbreak; ;;
            [Tt]* ) lbreak; poetry_test; lbreak; ;;
            [Xx]* ) lbreak; sphinx_mode; lbreak; ;;
            [Ff]* ) lbreak; poetry_formatting; lbreak; ;;
            [Hh]* ) lbreak; helm_mode; lbreak; ;;
            [Rr]* ) lbreak; source /export/unicomplex_data/unicomplex/env.sh && source set_global_env.sh && poetry run process_start; lbreak; ;;
            #[Ll]* ) lbreak; cd "$(dirname "$(find . -type d -name templates | head -1)")" && helm lint && helm ; lbreak; ;;
            [Ee]* ) echo exit && break;;
            * ) echo exit && break;;
        esac
    done

    #git add .
    #git commit
}

git_push () {
    # Push the commits and leaves last commit URL to be copied.

    # Get the URL of the 'origin' remote repository
    REMOTE_URL=$(git config --get remote.origin.url)

    # Extract the username and repository name from the URL
    # This works for URLs of the form: https://github.com/username/repo.git
    # or the SSH equivalent: git@github.com:username/repo.git
    GITHUB_USERNAME=$(echo $REMOTE_URL | sed -n 's/.*github.com[:\/]\(.*\)\/.*/\1/p')
    REPOSITORY_NAME=$(basename -s .git $REMOTE_URL)

    # Push the changes
    git push

    # Get the latest commit hash
    COMMIT_HASH=$(git rev-parse HEAD)

    # Construct the commit URL
    COMMIT_URL="https://github.com/${GITHUB_USERNAME}/${REPOSITORY_NAME}/commit/${COMMIT_HASH}"

    # Output the URL
    echo "Commit URL: $COMMIT_URL"

    (set -x; echo $COMMIT_URL | xclip -sel clip)
    echo "Use Ctrl+v to paste the URL."
}


dbuni () {
    vim ~/git/lab/thorgeir/db_queries/ash1/unicomplex/ash1_unicomplex_write.sql
}

#copy () {
#    # Copy file name and use paste command to copy from the newly copy file.
#    filename=$1
#    export FILEPATH_COPY=$(pwd)/$filename
#
#    echo "Copied $FILEPATH_COPY"
#    echo "Use paste command to copy that newly copied file to current directory."
#}

#paste () {
#    (set -x; cp $FILEPATH_COPY ./)
#}


# FZF - Fuzzy finder tools

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}


# cat file | wc -l | to_dot
# 1.000.000
alias to_dot="perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1./g'"

help_disk_eject () {
    echo sudo umount /run/media/thorgeir/Elements
    echo udisksctl power-off -b /dev/sda1
}

unmute_all () {
    amixer -c 0 set Master unmute
    amixer -c 0 set Headphone unmute
    amixer -c 0 set Speaker unmute
}

help_audio () {
    unmute_all
}

help_print () {
    echo "This chatGPT thread might help: https://chat.openai.com/c/58438be1-2dee-4275-aef3-cf691a10f3a7"
    echo ""
    echo "Install canon drivers"
    echo "$ yay -S capt-src"
    echo ""
    echo "Need to enable mutlib mirrorlist follow to install the above package:"
    echo "https://wiki.archlinux.org/title/Official_repositories#Enabling_multilib"
    echo ""
    echo "Install CUPS, the printing managing tool:"
    echo "$ sudo pacman -S cups"
    echo ""
    echo "Start CUPS service to be able to use lpinfo"
    echo "$ systemctl status cups.service"
    echo ""
    echo "Navigate to:"
    echo "http://localhost:631"
    echo ""
    echo "Then Go to administrator tab, add credential, then add printer."
    echo "Follow the instructions there."
    echo ""
    echo "List available printers:"
    echo "$ lpstat -p -d"
    echo ""
    echo ""
    echo "1) Before doing anything, be sure to add your user to the lp group:"
    echo "eg."
    echo "gpasswd -a your_user lp"
    echo "and then reboot, or relogin"
    echo ""
    echo "2) Connect the printer to your computer, turn it on and start CUPS, or restart it if it was already running"
    echo "eg."
    echo "systemctl restart cups.service"
    echo ""
    echo "3) /usr/bin/lpadmin -p <name> -m <corresponding ppd> -v ccp://localhost:59687 -E"
    echo "eg."
    echo "/usr/bin/lpadmin -p LBP2900 -m CNCUPSLBP2900CAPTK.ppd -v ccp://localhost:59687 -E"
    echo "(you can find ppds in the /usr/share/cups/model/ directory)"
    echo ""
    echo "4)"
    echo "a) For a locally connected printer (USB / Parallel port), check the name of"
    echo "   the device, udev created for you."
    echo "eg. /dev/usb/lp0"
    echo "and run: /usr/bin/ccpdadmin -p <name> -o udev_device"
    echo "eg."
    echo "/usr/bin/ccpdadmin -p LBP2900 -o /dev/usb/lp0"
    echo "(it should show a table with the new printer)"
    echo ""
    echo "b) For a network printer:"
    echo "/usr/bin/ccpdadmin -p <Printer name> -o net:<IP address>"
    echo "eg. /usr/bin/ccpdadmin -p LBP2900 -o net:192.168.0.10"
    echo ""
    echo "5) systemctl start ccpd.service (using systemd)"
    echo ""
    echo "6) Check you have two instances of ccpd in memory, then run captstatusui, check it's"
    echo "   telling you it's ready to print and the printer should work."
    echo "eg. ps awx | grep ccpd"
    echo "or using systemd: systemctl status ccpd.service"
    echo "For captstatusui: /usr/bin/captstatusui -P LBP2900"
    echo ""
    echo "7) Make sure cupsd and ccpd are running at boot"
    echo "eg."
    echo "systemctl enable ccpd.service"


    echo "Choose one of the printers above and print the file:"
    echo "$ lp -d myprinter file.pdf"



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

export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/home/thorgeir/perl5";
export PERL_MB_OPT="--install_base /home/thorgeir/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/thorgeir/perl5";
export PERL5LIB="/home/thorgeir/perl5/lib/perl5:$PERL5LIB";

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

#source /usr/share/bash-completion/bash_completion
#source <(kubectl completion bash)
#alias k=kubectl
#complete -F __start_kubectl k

#source ~/git/hub/jonmosco/kube-ps1/kube-ps1.sh
#PS1='[\u@\h \W $(kube_ps1)]\$ '
#export PS1="\[\033[38;5;3m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]:[\[$(tput sgr0)\]\[\033[9;2;93m\]\w $(kube_ps1) \[$(tput sgr0)\]\[\033[38;5;7m\]]\\$\[$(tput sgr0)\] "
#export PS1="$(kube_ps1) \[\033[38;5;3m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]:[\[$(tput sgr0)\]\[\033[9;2;93m\]\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\\$\[$(tput sgr0)\] "


#initialize Z (https://github.com/rupa/z)
. ~/bin/z.sh

source ~/.git-prompt.sh
PS1="$PS1\$(__git_ps1) $ "

start_psql () {
    source ~/.venv/pgadmin4/bin/activate
    pgadmin4 &
}

help_sync_images () {

    echo "Run this command on different terminal to watch "
    echo "what happen for external hard drives."
    echo ""
    echo "  $ udisksctl monitor"
    echo ""
    echo ""

    echo "Mount my icybox external hard drive to my local directory."
    echo "First you can choose partition using this command:"
    echo ""
    echo "  $ disk_path=\$(lsblk -pJO | jq '.blockdevices | .[] | select(.size == \"3.7T\" and .serial == \"152D00539000\") | .children | .[] | select(.size == \"1T\" and .label == \"Linux1T\") | .name'\)"
    echo "  $ mkdir -p /mnt/icybox"
    echo "  $ sudo mount \${disk_path} /mnt/icybox"
    echo "  $ cd ~/media/photos"
    echo ""

    # Notice the end-backslash on the first `2020`.
    # Remove -n flag if you want to run this command.
    # -n is just dry run and shows what will happen.
    echo ""
    echo "Notice the end-backslash on the first '2020'."
    echo "Remove -n flag if you want to run this command."
    echo "-n is just dry run and shows what will happen."
    echo "-c Uses checksum to determine if file is equal, considered as more accurate."
    echo "-u, --update: skip files that are newer on the receiver."
    echo "--stats: See stats about the transfer."
    echo "-h: human readable format"
    echo "--progress: showing the progress of the transfer."
    echo ""
    echo "  $ rsync -anvc 2020/ /mnt/icybox/media/photos/2020"
    echo ""
    echo ""

    echo "Count number files in directories under current path."
    echo ""
    echo '  $ for dir in $(ls); do echo -n "$dir: "; ls $dir | wc -l; done'
    echo ""
    echo ""

    echo "Confirm no difference between folder and"
    echo "then you can delete the original copy"
    echo "Credit: https://askubuntu.com/questions/421712/comparing-the-contents-of-two-directories"
    echo ""
    echo "  $ diff <(find videos/ -type f -exec md5sum {} + | sort -k 2) <(find /run/media/thorgeir/Linux1T/media/videos/ -type f -exec md5sum {} + | sort -k 2)"
    echo ""
    echo "Possible to use the meld GUI command"
    echo "  $ meld DIR1 DIR2"
    echo ""
    echo ""
    echo "Possible to use this command:"
    echo "  $ diff -y <(pushd ~/media/photos/2021; for dir in \$(ls); do echo -n "\$dir: "; ls \$dir | wc -l; done; popd) <(pushd /mnt/icybox/media/photos/2021; for dir in \$(ls); do echo -n "\$dir: "; ls \$dir | wc -l; done; popd) | less"

    echo ""
    echo "NEWEST SYNC METHOD!"
    echo "-------------------"
    echo ""
    echo "$ rsync -anhvc --backup --suffix=.backup --progress ~/media/ /mnt/icybox2/media/"
    echo ""
    echo "Remove -n to run actual command."
    echo ""
    echo "Then verify that the all source media have been copied over"
    echo "MIGHT NEED TO VERIFY FILE PATH IN THE SCRIPT:"
    echo ""
    echo "$ bash ~/bin/media_sync/verify_sync.sh"
    echo ""
    echo "or be fast:"
    echo "$ bash ~/bin/media/sync/verify_sync_fast.sh ~/media /mnt/icybox2/media"
    echo ""
    echo ""
    echo "LAST SYNC (2024-01-01)!"
    echo "-------------------"
    echo ""
    echo "$ rsync -avc ~/media/photos/2024/ /mnt/icybox2/media/photos/2024/ && bash ~/bin/media/sync/verify_sync_fast.sh ~/media/photos/2024 /mnt/icybox2/media/photos/2024"
    echo ""
    echo "LAST SYNC (2024-06-14)!"
    echo "-------------------"
    echo ""
    echo "$ rsync -ahvc --backup --suffix=.backup ~/media/ /mnt/icybox3/media/ && bash ~/bin/media/sync/verify_sync_fast.sh ~/media /mnt/icybox3/media"
    echo ""
    echo "--backup/--suffix - Keep a backup of the existing file"
    echo "in the destination folder before it is overwritten,"
    echo "you can use the --backup option along with --suffix"
    echo "to specify a suffix for the backup file."
    echo ""
    echo "Notice, if a file have same checksum, we do not create backup."
    echo "Backup is only created when filename is equal and the content is different"
    echo ""

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
    echo 'mkdir -p shrink; for img in $(ls *.jpg); do (set -o xtrace; magick $img -resize '2048x2048' -quality 85 ./shrink/$img); done'
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

help_move_files_into_subdir () {
    echo "originally create to split 14GB image folder into several directories to be able to send each folder via WeTransfer"
    echo 'for img in $(ls **); do num=$(echo $img | tr -dc '0-9'); dir=$(echo $(($num/80*80))); mkdir -p $dir; mv $img ./$dir/; done'
}

travelshift_dp1 () {
    bash ~/.screenlayout/travelshift-dp1.sh
}

travelshift_hdmi1 () {
    bash ~/.screenlayout/travelshift-hdmi1.sh
}

pacman_update () {
    # Update the keyrings before
    sudo pacman -S archlinux-keyring
    # Update packages
    sudo pacman -Syu
}

pu () {
    # Shortcut for pacman update
    pacman_update
}

pi () {
    pacman_update
    sudo pacman -S $1
}

import_photos () {
    pushd /home/thorgeir/git/hub/thorgeir/image_tool/
    bash ./import_image.sh
    popd
}

arch_clean () {
    # Method to run general clean up.

    # Remove unused packages (orphans)
    sudo pacman -Rns $(pacman -Qtdq)

    # Clean Systemd journal
    # This should be cronjob or systemd service.
    sudo journalctl --vacuum-time=4weeks

    # Can use rmlint to remove duplicates
    # $ rmlint --help

    # Cleaning the cache
    # k1: Retain only one past version (k0 to remove all cached versions)
    # Remove monthly: https://averagelinuxuser.com/clean-arch-linux/
    # More: https://wiki.archlinux.org/title/Pacman#Cleaning_the_package_cache
    paccache -rv -k 2
}

png2jpg() {
  # Credit: 
  #   https://chatgpt.com/share/6703ff9f-21b8-800c-acd4-dd0f26bf658b
  # Function to convert PNG to JPG and copy file path to clipboard (Linux)
  # Check if the input file exists
  if [ ! -f "$1" ]; then
    echo "Input file not found!"
    return 1
  fi

  # Extract directory and filename without extension
  dir=$(dirname "$1")
  filename=$(basename "$1" .png)
  
  # Define output JPG file path
  output_file="$dir/$filename.jpg"

  # Convert the PNG to JPG
  magick "$1" "$output_file"

  # Check if the conversion was successful
  if [ $? -eq 0 ]; then
    echo "Conversion successful: $output_file created."
    
    # Copy the new file path to the clipboard using xclip
    if command -v xclip &> /dev/null; then
      echo -n "$output_file" | xclip -selection clipboard
      echo "File path copied to clipboard."
    else
      echo "xclip not found! Install it using 'sudo apt install xclip' to enable clipboard functionality."
    fi
  else
    echo "Conversion failed!"
    return 1
  fi
}


md2pdf() {
	# Credit ChatGPT:
	#	* https://chat.openai.com/share/ca6f2d8b-a4df-4a0a-9ec2-d0388458476c
    if [ -z "$1" ]; then
        echo "Usage: md2pdf <markdown_file>"
        return 1
    fi

    if ! command -v lowdown > /dev/null 2>&1; then
        echo "Error: lowdown is not installed. Please install lowdown to use this function."
        return 1
    fi

    if ! command -v wkhtmltopdf > /dev/null 2>&1; then
        echo "Error: wkhtmltopdf is not installed. Please install wkhtmltopdf to use this function."
        return 1
    fi

    local input_file=$1
    local html_file=${input_file%.md}.html
    local output_file=${input_file%.md}.pdf

    lowdown "$input_file" > "$html_file"
    wkhtmltopdf "$html_file" "$output_file"

    echo "Converted $input_file to $output_file"
}

function vpn() {
    # Options:
    #    $ vpn up
    #    $ vpn down
    nmcli connection $1 megas
}

disable_suspend () {
    (set -x; xset s off -dpms)
}

enable_suspend () {
    (set -x; xset s on -dpms)
}


me () {
    cd ~/media/photos/export/
}

m3 () {
    cd ~/media/photos/2023/
}

xs () {
    # Switch caps lock and esc buttons.
    (set -x; xmodmap ~/.speedswapper)
}


vpnon () {
    # Turn of VPN connection.
    nmcli connection down megas 
}

vpnoff () {
    # Turn of VPN connection.
    nmcli connection down megas 
}

home () {
    (set -x; xmodmap ~/.speedswapper)
    #(set -x; setxkbmap -option altwin:swap_alt_win)
    # add monitor settings
    (set -x; bash ~/.screenlayout/home-laptop-02.sh)
}

home_office () {
    # Enable external home monitor.
    (set -x; bash ~/.screenlayout/home-office-hdmi2.sh)
}

work () {
    # Activate big monitor as well increase size in the laptop.
    bash ~/.screenlayout/travelshift-hdmi1.sh

    # Turn of VPN connection.
    nmcli connection down megas 

    sleep 1

    # TOOD: reset i3
}

meetingstart () {
    # Pause notifications. Once paused dunst will
    # hold back all notifications. After enabling
    # dunst again all held back notifications will
    # be displayed.
    dunstctl set-paused toggle

    # Activate big monitor as well increase size in the laptop.
    bash ~/.screenlayout/office-meeting-aratunga.sh

    # Turn of VPN connection.
    nmcli connection down megas 

    # Activate pro-audio in pavucontrol
    # To be able to use the mic.
    speakers
}

meetingstop () {

    # Disable attached HDMI-1 if any.
    xrandr --output HDMI-1 --off

    # Back to headphones sound configuration.
    headphones
}

speakers () {
    # Set pro-audio sound configuration
    # This will enable mic usage in google meetings.
    pactl set-card-profile 45 pro-audio
}

headphones () {
    # Set headphones configuration
    pactl set-card-profile 45 output:analog-stereo
}



calis () {
    pushd ~/git/hub/thorgeir/calendar_icelandic/calendar_icelandic/ >/dev/null
    poetry run python cal_is.py $@
    popd >/dev/null

}

wgrep () {
    # $ wgrep <search_string> <optional file>
    # 
    # Grep without noise
    # ------------------
    # Searches for string in repository and excludes all unecessary files.
    #   
    search_string=$1; shift
    optional_file=$1; shift
    grep -ilrn --exclude-dir=.git --exclude-dir=.venv "$search_string" | grep -v .json | grep -v .pyc | grep -v .lock | grep -v .ipyn | grep $optional_file
}

mvs() {
    # My Move - mv and creates the destination directory
    # Validate the number of arguments
    if [ $# -ne 2 ]; then
        echo "Error: Exactly two arguments are required: source file and target directory/filepath."
        return 1
    fi

    local source_file="$1"
    local target="$2"

    # Check if the source file exists
    if [ ! -f "$source_file" ]; then
        echo "Error: Source file '$source_file' does not exist."
        return 1
    fi

    # Determine if the target is a directory (ends with a slash) or a filepath
    if [[ "$target" == */ ]]; then
        # It's a directory; ensure it exists
        mkdir -p "$target"
    else
        # It's a filepath; ensure its directory exists
        local target_dir
        target_dir=$(dirname "$target")
        mkdir -p "$target_dir"
    fi

    # Move the source file to the target
    mv "$source_file" "$target" && echo "+ mv $source_file $target"
}

mva_old() {
	# Move all given files to folder.
	# Folder is created if not exists.

    # Validate the number of arguments
    if [ $# -ne 2 ]; then
        echo "Error: Exactly two arguments are required: source pattern and target directory."
        return 1
    fi

    local source_pattern="$1"
    local target_directory="$2"

    # Ensure the target is a directory (not a filepath)
    if [[ "$target_directory" != */ ]]; then
        target_directory="$target_directory/"
    fi

    # Ensure the target directory exists
    mkdir -p "$target_directory"

    # Move each matching file to the target directory
    local file
    for file in $source_pattern; do
        if [ -f "$file" ]; then
            mv "$file" "$target_directory" && echo "+ mv $file $target_directory"
        else
            echo "No files match the pattern '$source_pattern'."
            return 1
        fi
    done
}

mva() {
    # There should be at least two arguments
    if [ $# -lt 2 ]; then
        echo "Error: Need at least two arguments: source files and target directory."
        return 1
    fi

    # The last argument is the target directory
    local target_directory="${@: -1}"

    # Ensure the target is a directory (not a filepath)
    if [[ "$target_directory" != */ ]]; then
        target_directory="$target_directory/"
    fi

    # Ensure the target directory exists
    mkdir -p "$target_directory"

    # Move each specified file to the target directory
    local source_file
    for source_file in "${@:1:$#-1}"; do
        if [ -f "$source_file" ]; then
            mv "$source_file" "$target_directory" && echo "+ mv $source_file $target_directory"
        else
            echo "Warning: '$source_file' does not exist or is not a regular file."
        fi
    done
}


audio () {
    echo "pavucontrol - High level GUI configuration."
    echo "alsamixer - Command line audio configuration [M (mute)]"
}

save () {
    # Move all given files to tmp folder.
    dir_name=~/work/tmp/"$(date +%F)"
    mkdir -p $dir_name
    (set -x; mv $@ $dir_name/)
}

gsave () {
    (set -x; cp $1 ~/work/tmp/ && git restore $1)
}

search_in_tests () {
    grep_word=$1; shift
    for tf in $(find . -type f -name "test_*" | grep -v .pyc); do cat $tf | grep "$grep_word"; done
}

git_status () {
    bash ~/bin/git_status_check.sh
}

gt () {
    # Navigate to guidetoiceland/travelplan repo and set things up.
    cd /home/thorgeir/git/hub/guidetoiceland/travelplan/
    poetry shell
}

function reset_notification () {
     # Reset notification system
     killall dunst; notify-send foo
}

function refresh () {
    # Refresh arch desktop
    reset_notification
}

set_python3 () {
    pyenv local 3.11.6
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/thorgeir/.pyenv/pyenv/versions/3.11.6/lib
    poetry env use 3.11.6
}

sp3 () {
    set_python3
}

# poetry () {
#     # This is a hax! Make sure not use that in new syst
#     # Override broken python-poetry (package from Arch)
# 
#     echo "[ INFO ] using hax solution to use poetry installed by pipx."
#     echo "[ INFO ] More info in \`poetry\` method in ~/.bashrc."
# 
#     # This package was installed with pipx: `pipx install poetry`.
#     /home/thorgeir/.local/share/pipx/venvs/poetry/bin/poetry $@
# }


export PYENV_ROOT="$HOME/.pyenv/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# source /usr/share/nvm/init-nvm.sh
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

export POETRY_BIN="$HOME/.local/bin"
export PATH="$POETRY_BIN:$PATH"
# source /usr/share/nvm/init-nvm.sh

# add Pulumi to the PATH
export PATH=$PATH:/home/thorgeir/.pulumi/bin

export CHEAT_USE_FZF=true
# add Emacs doom to path
export PATH=$PATH:/home/thorgeir/.config/emacs/bin

# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(python3.12 -c "import sysconfig; print(sysconfig.get_config_var('LIBDIR'))")
# >>> TRANSLATES TO >>>$LD_LIBRARY_PATH:/home/thorgeir/.pyenv/pyenv/versions/3.11.6/lib
