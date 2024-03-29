# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
bindkey -v

# Enable reverse-search.
bindkey '^R' history-incremental-search-backward

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/thorgeir/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


#                #
#  FROM .BASHRC  #
#                #

#
# Load resource file (e.g. colors and font styles)
#xrdb ~/.Xr
#transset-df --actual .9

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# more information:
# http://unix.stackexchange.com/questions/9123/is-there-a-one-liner-that-allows-me-to-create-a-directory-and-move-into-it-at-th

# Get window id from the slack application.
# only if slack application is running.
get_slack_win_id () {
    xwininfo -name "Slack - CYREN" | head -n 2 | tail -n 1 | awk '{ print $4; }'
}

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
	echo "$1" | sprunge | xclip -selection "clipboard" 
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
sshvi () { ssh $@ -t 'bash -o vi'; }

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
    # thorgeirs, SG**.., push, <iphone DUO>, 
}

vpnc4 () {
    cd ~
    # old method (RSA)
    # sudo openvpn is the version 2.3
    # openvpn is the version 2.4, we want to use that version.
    sudo /usr/local/sbin/openvpn --config ~/openvpn/c4.ovpn
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
    sudo openvpn --config ~/openvpn/commtouch2.ovpn
    # add username and password (thsigurdsson, pin and rsa passcode)
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

hdmi_3_orient () {
    xrandr --output DP-1 --auto --rotate left --output HDMI-1 --auto --right-of DP-1 --output HDMI-3 --auto --right-of HDMI-1
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

###################
## ENTERTAINMENT ##
###################
sup () {
	echo "$1" | sprunge | xclip -selection "clipboard" 
}
####################
## SYSTEM CONTROL ##
####################

# prevent terminal to freeze
# Ctrl-s freezes the terminal
# Ctrl-q thawed the terminal
stty -ixon

source ~/.aliases
source ~/.kube/zsh_completion # Complete the words for kubectl tool.

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
