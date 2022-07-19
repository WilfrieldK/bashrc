#!/bin/bash
#

# root login
function susu() {
    if [ "$(command -v sudo)" ]; then
        sudo -i bash -rcfile "${CONFIG_PATH}/std/.bashrc"
    else
        echo -e "< sudo > isnt installed! Load rcfile after login :"
        echo -e "source ${CONFIG_PATH}/std/.bashrc"
    fi
}

#
# Debian based
#
function apti() {
    if [ ! "$(command -v apt-get)" ]; then
        echo -e "< apt-get > isnt installed"
    else
        apt-get install "$@"
    fi
}
function apts() {
    if [ ! "$(command -v apt-cache)" ]; then
        echo -e "< apt-cache > isnt installed"
    else
        apt-cache search "$@"
    fi
}
function aptu() {
    if [ ! "$(command -v apt-get)" ]; then
        echo -e "< apt-get > isnt installed"
    else
        apt-get update && apt-get upgrade;
    fi
}
function aptf() {
    if [ ! "$(command -v apt-file)" ]; then
        echo -e "< apt-file > isnt installed"
    else
        apt-file search "$@"
    fi
}
function aptp() {
    if [ ! "$(command -v dpkg)" ]; then
        echo -e "< dpkg > isnt installed"
    else
        dpkg -L "$@"
    fi
}

#
# RedHat based
#
function yumi() {
    if [ ! "$(command -v yum)" ]; then
        echo -e "< yum > isnt installed"
    else
        yum install "$@"
    fi
}
function yums() {
    if [ ! "$(command -v yum)" ]; then
        echo -e "< yum > isnt installed"
    else
        yum search "$@"
    fi
}
function yumu() {
    if [ ! "$(command -v yum)" ]; then
        echo -e "< yum > isnt installed"
    else
        yum upgrade
    fi
}
function yumf() {
    if [ ! "$(command -v yum)" ]; then
        echo -e "< yum > isnt installed"
    else
        yum provides "*/${@}"
    fi
}
function yump() {
    if [ ! "$(command -v rpm)" ]; then
        echo -e "< rpm > isnt installed"
    else
        rpm -ql "$@"
    fi
}

#
# Arch based
#
function paci() {
    if [ ! "$(command -v pacman)" ]; then
        echo -e "< pacman > isnt installed"
    else
        pacman -S "$@"
    fi
}
function pacs() {
    if [ ! "$(command -v pacman)" ]; then
        echo -e "< pacman > isnt installed"
    else
        pacman -Ss "$@"
    fi
}
function pacu() {
    if [ ! "$(command -v pacman)" ]; then
        echo -e "< pacman > isnt installed"
    else
        pacman -Sy && pacman -Su
    fi
}
function pacf() {
    if [ ! "$(command -v pacman)" ]; then
        echo -e "< pacman > isnt installed"
    else
        pacman -Fy && pacman -F "$@"
    fi
}
function pacp() {
    if [ ! "$(command -v pacman)" ]; then
        echo -e "< pacman > isnt installed"
    else
        pacman -Fl "$@"
    fi
}

# ReadHat 8 / Fedora 30
function dnfi() {
    if [ ! "$(command -v dnf)" ]; then
        echo -e "< dnf > isnt installed"
    else
        dnf install "$@"
    fi
}
function dnfs() {
    if [ ! "$(command -v dnf)" ]; then
        echo -e "< dnf > isnt installed"
    else
        dnf search "$@"
    fi
}
function dnfu() {
    if [ ! "$(command -v dnf)" ]; then
        echo -e "< dnf > isnt installed"
    else
        dnf upgrade
    fi
}
function dnff() {
    if [ ! "$(command -v dnf)" ]; then
        echo -e "< dnf > isnt installed"
    else
        dnf provides "*/$@"
    fi
}
function dnfp() {
    if [ ! "$(command -v rpm)" ]; then
        echo -e "< rpm > isnt installed"
    else
        rpm -ql "$@"
    fi
}
