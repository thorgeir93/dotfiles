# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

#############################
# BASH/PROMPT CUSTOMIZATION #
#############################
#USER="\e[96m\e[48;5;16m"
#HI="\e[34m"
#USER="\e[96m"
#BRACKET="\e[93m"
#RESET="\e[0m"
#
#FIRST_PART_PS1="${BRACKET}[${RESET}${HI}\u${RESET}${BRACKET}@"
#SECOND_PART_PS1="${RESET}${HI}\h${RESET} ${USER}\W${RESET}${BRACKET}]${RESET}${USER}\$ ${RESET}"
#PS1=${FIRST_PART_PS1}${SECOND_PART_PS1}

#PS1="${BRACKET}[\u${USER}@${RESET}${BRACKET}\h${RESET} ${USER}\W${RESET}${BRACKET}]\$ ${RESET}"

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

# Load resource file (e.g. colors and font styles)
#xrdb ~/.Xr
#transset-df --actual .9

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# more information:
# http://unix.stackexchange.com/questions/9123/is-there-a-one-liner-that-allows-me-to-create-a-directory-and-move-into-it-at-th

wifi_list() {
    nmcli device wifi 
}

wifi_connect() {
    # :params: <WIFI name> <Password>
    #   Accept a wifi name which you can get from `wifi_list` command.
    #   and a password to access the router.
    nmcli device wifi connect $1 password $2 
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
        
#ssh () { 
    #/bin/ssh $@ -t 'bash --login -o vi'
#}

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

c3thorgeir (){
    user='thorgeir'
    host='c3dev-thorgeir01.amadis.com'
    ssh $user'@'$host
}

c3devcuckoo (){
    sshvi $1'@c3devcuckoo01.amadis.com'
}

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
}

vpnc4 () {
    cd ~
    # old method (RSA)
    # sudo openvpn is the version 2.3
    # openvpn is the version 2.4, we want to use that version.
    sudo openvpn --config ~/openvpn/c4.ovpn
    # add username and password 
    # (thsigurdsson, [pin to RSA app] then passw. is the RSA token number)
}

sshoffice () {
    ssh thorgeir@10.101.1.14
    # add thorgeir's password (6oN...)
    # now you are connected
}

sshdev () {
    ssh thorgeir@10.3.80.41
}

vpnc3 () {
    cd ~
    # RSA
    #sudo openvpn --config ~/openvpn/commtouch2.ovpn
    # add username and password (thsigurdsson, pin and rsa passcode)

    # DUO
    sudo openvpn --auth-retry interact --config ~/openvpn/c3-duo-openvpn.conf 
    # add username and password (thsigurdsson, /asolf...:push)
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

hdmi_orient_3 () {
    # Positions:
    #  __  __  __
    # |  ||__||__|
    # |__|
    #
    left="DP-1"
    middle="HDMI-1"
    right='HDMI-3'
    xrandr  --output $left --auto --rotate left \
            --output $middle --auto --right-of $left \
            --output $right --auto --right-of $middle
}


hdmi_monitor_data_office () {
    display1='HDMI-1'
    display2='HDMI-3'
    bright_step='0.1'
    brightness=`xrandr --verbose | grep -m 2 -i brightness | cut -f2 -d ' ' | cat -n | awk '$1 == "2" {print $2}'`
}

hdmi_monitor_data_lenovo () {
    display='HDMI1'
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
    hdmi_monitor_data_lenovo
   
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

function cal_is () {
    python ~/github/thorgeir/calendar_icelandic/cal_is.py "$@"
}

is_caps_lock_on () {
    xset q | grep LED | tail -c 2
}



####################
## SYSTEM CONTROL ##
####################

# prevent terminal to freeze
# Ctrl-s freezes the terminal
# Ctrl-q thawed the terminal
stty -ixon

source ~/.aliases
