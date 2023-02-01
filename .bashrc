# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# source /export/unicomplex_data/unicomplex/env.sh

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
else
    export PS1="\[\033[38;5;3m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]:[\[$(tput sgr0)\]\[\033[9;2;93m\]\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\[$(tput sgr0)\]\n"
    #export PS1=" \w $ "
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
    xrandr --output eDP-1 --auto --output HDMI-2 --auto --left-of eDP-1
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
    left='HDMI-2'
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
    echo 'mkdir -p shrink; for img in $(ls *.JPG); do (set -o xtrace; convert $img -resize '2048x2048' -quality 85 ./shrink/$img); done'
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

gb () {
    # Interactivly choose branch from local branches
    git checkout $(git branch | tr "*" " " | fzf)
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

dbuni () {
    vim ~/git/lab/thorgeir/db_queries/ash1/unicomplex/ash1_unicomplex_write.sql
}

copy () {
    # Copy file name and use paste command to copy from the newly copy file.
    filename=$1
    export FILEPATH_COPY=$(pwd)/$filename

    echo "Copied $FILEPATH_COPY"
    echo "Use paste command to copy that newly copied file to current directory."
}

paste () {
    (set -x; cp $FILEPATH_COPY ./)
}


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
export PATH="/home/thorgeir/perl5/bin:$PATH";
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
eval "$(pyenv virtualenv-init -)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k

#source ~/git/hub/jonmosco/kube-ps1/kube-ps1.sh
#PS1='[\u@\h \W $(kube_ps1)]\$ '
#export PS1="\[\033[38;5;3m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]:[\[$(tput sgr0)\]\[\033[9;2;93m\]\w $(kube_ps1) \[$(tput sgr0)\]\[\033[38;5;7m\]]\\$\[$(tput sgr0)\] "
#export PS1="$(kube_ps1) \[\033[38;5;3m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;7m\]:[\[$(tput sgr0)\]\[\033[9;2;93m\]\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\\$\[$(tput sgr0)\] "


#initialize Z (https://github.com/rupa/z) 
. ~/z.sh 

source ~/.git-prompt.sh
PS1="$PS1\$(__git_ps1) $ "
