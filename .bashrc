# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# more information:
# http://unix.stackexchange.com/questions/9123/is-there-a-one-liner-that-allows-me-to-create-a-directory-and-move-into-it-at-th

xmodmap ~/.speedswapper

alias vi='vimx'
alias vim='vimx'
alias ls='ls --color -la'
alias sprunge='curl -F "sprunge=<-" http://sprunge.us'
# view image
alias img='gpicview'
alias chrome='google-chrome --proxy-pac-url="http://jira-proxy.mordor.local/proxy.pac"' 
alias c3writedb='mysql --defaults-extra-file=/home/thorgeir/.config/mysql/write-config'
alias c3readdb='mysql --defaults-extra-file=/home/thorgeir/.config/mysql/read-config'

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
cd2 () {
	cd "../.."
}
cd3 () {
	cd "../../.."
}
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

#######################
## KEYBOARD SETTINGS ##
#######################
is () {
    echo "setxkbmap -layout is"
    setxkbmap -layout is
}

us () {
    echo "setxkbmap -layout us"
    setxkbmap -layout us
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
    ssh $user'@'$host$number$rest
}

c3thorgeir (){
    user='thorgeir'
    host='c3dev-thorgeir01.amadis.com'
    ssh $user'@'$host
}

vpnoffice () {
    cd ~
    sudo openvpn --config ~/openvpn/office.ovpn
    # add username and password (thorgeir, 3jZhpd####)
  
}
sshoffice () {
    ssh thorgeir@10.101.1.14
    # add thorgeir's password (6oN...)
    # now you are connected
}

vpnc3 () {
    cd ~
    sudo openvpn --config ~/openvpn/commtouch2.ovpn
    # add username and password (thsigurdsson, pin and rsa passcode)
}

##############
## DISPLAYS ##
##############
hdmi () {
    xrandr --output LVDS1 --auto --output HDMI1 --auto --right-of LVDS1
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
alias config='/usr/bin/git --git-dir=/home/thorgeir/.cfg/ --work-tree=/home/thorgeir'
alias config='/usr/bin/git --git-dir=/home/thorgeir/.cfg/ --work-tree=/home/thorgeir'
alias config='/usr/bin/git --git-dir=/home/thorgeir/.cfg/ --work-tree=/home/thorgeir'
