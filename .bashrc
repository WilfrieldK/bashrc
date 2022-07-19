#!/bin/bash
# Adrien std config
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Message du jour
if [ -s "/etc/motd" ]; then
    cat "/etc/motd"
fi

# Load common user bashrc
if [ -n "${BASH_PROFILE_LOADED}" ] && [ -s "${HOME}/.bash_profile" ] ; then
    export BASH_PROFILE_LOADED=1
    source "${HOME}/.bash_profile"
fi

# Utilise pour charger differentes libs
CONFIG_PATH=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/../")
readonly CONFIG_PATH
export CONFIG_PATH

# Ma config screen
export SYSSCREENRC="${CONFIG_PATH}/std/.screenrc"

# Config std
export EDITOR='vi'
export TERM='xterm-256color'

declare -a dir_list=(
                     '/bin'
                     '/usr/bin'
                     '/usr/local/bin'
                     '/sbin'
                     '/usr/sbin'
                     "${HOME}/bin"
                     "${CONFIG_PATH}/std/bin"
                    )

for my_dir in "${dir_list[@]}"; do
    if [[ -d "${my_dir}" ]] && [[ $(echo "${PATH}" | grep -cE ":?(${my_dir}):?") -lt 1 ]]; then
        PATH="${PATH}:${my_dir}"
    fi
done

# En anglais wesh
export LANG='en_US.utf8'
export LC_ADDRESS='fr_FR.UTF-8'
export LC_IDENTIFICATION='fr_FR.UTF-8'
export LC_MEASUREMENT='fr_FR.UTF-8'
export LC_MONETARY='fr_FR.UTF-8'
export LC_NAME='fr_FR.UTF-8'
export LC_NUMERIC='fr_FR.UTF-8'
export LC_PAPER='fr_FR.UTF-8'
export LC_TELEPHONE='fr_FR.UTF-8'
export LC_TIME='fr_FR.UTF-8'
export LC_CTYPE='fr_FR.UTF-8'
export LC_ALL='POSIX'

# On augmente la taille de l'historique parce que c'est chiant sinon
HISTSIZE=10000
HISTFILESIZE=10000
# On ne duplique pas les commandes dans l'historique
export HISTCONTROL=ignoreboth:erasedups

# Verification de la taille de la fenetre apres chaque commande
shopt -s checkwinsize

# On vire cette merde de Ctrl+MAJ+R qui freeze tout
stty -ixon

# Ma conf readline
bind -f "${CONFIG_PATH}"/std/.inputrc

# Outils root
source "${CONFIG_PATH}/std/lib/root_packages_manager.sh"
# Chiffrement/dechiffrement yubikey
source "${CONFIG_PATH}/std/lib/yubikey_crypt_decrypt.sh"


# User specific aliases and functions
# ls
alias ll='ls -lh'
alias lla='ls -lha'
alias lhsr='ls -lhSr'
alias llll='ls -lhtr'
alias ls='ls --color=auto -CF'
alias la='ls -A'
alias l.='ls -d .* --color=auto'
# disk
alias du1='du --max-depth=1 -h'
alias du2='du --max-depth=2 -h'
alias du1slash='du --max-depth=1 -h --exclude=home / 2> /dev/null | sort -h'
alias dus='du --summarize -h'
alias dfh='df -h'
alias lsdisks='lsblk -o NAME,TYPE,FSTYPE,SIZE,MOUNTPOINT,MODEL'
alias lsdisksverbose='lsblk -o NAME,TYPE,FSTYPE,SIZE,MOUNTPOINT,MODEL,PARTLABEL,PARTUUID,UUID'
# grep
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias grepip="grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'"
alias grepmail="grep -oP '[\w\.\-\+\?]+@[\w\.-]+'"
# sec
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# misc
alias count="sort | uniq -c | sort -g"
alias colt="column -t"
alias screen="export PROMPT_COMMAND && screen -UxRR"
alias man="LANG=en_US man"
alias ipppp="iptables -L -n"
alias ipt="vim /etc/sysconfig/iptables"
alias phpg="vim /etc/celeonet/httpd/conf.d/client.conf"
alias cleanjournalctl='egrep -v "_pure-ftpd|dsa_key"'
alias cleanmessages='egrep -v "95.128.79.50|_pure-ftpd"'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../../'


# Je sais plus pourquoi
case "$TERM" in
    screen*)
        PROMPT_COMMAND='echo -ne "\033k\033\0134"'
        color_prompt=yes
        ;;
    xterm-color|*-256color)
        PROMPT_COMMAND="echo -ne \"\033]0;$USER@$HOSTNAME\007\""
        color_prompt=yes
        ;;
esac

# Vimrc file
if [ -f "${CONFIG_PATH}/std/.vimrc" ] ; then
    alias vi='vim -u ${CONFIG_PATH}/std/.vimrc'
    alias vim='vim -u ${CONFIG_PATH}/std/.vimrc'
    export EDITOR='vim'

    # Plugins vim
    if [ ! -d "${CONFIG_PATH}/vim_plugins" ]; then
        mkdir -p "${CONFIG_PATH}/vim_plugins"
    fi
    if [ ! -f "${CONFIG_PATH}/vim_plugins/plugins.list" ]; then
        {
            echo -e "Plugin 'justinmk/vim-dirvish'"
            echo -e "Plugin 'vim-airline/vim-airline'"
            echo -e "Plugin 'vim-airline/vim-airline-themes'"
            echo -e "Plugin 'easymotion/vim-easymotion'"
            echo -e "Plugin 'kshenoy/vim-signature'"
        } >> "${CONFIG_PATH}/vim_plugins/plugins.list"
    fi
fi

# Socket agent ssh
# Pour recuperer un socket viable quand on ra-attache un screen
if [[ "${SSH_AUTH_SOCK}" != "/tmp/ssh-agent-${USER}-screen-adr" ]]; then
    if [ -L "/tmp/ssh-agent-${USER}-screen-adr" ] ; then
        unlink "/tmp/ssh-agent-${USER}-screen-adr"
    elif [ -f "/tmp/ssh-agent-${USER}-screen-adr" ] ; then
        rm -f "/tmp/ssh-agent-${USER}-screen-adr"
    fi

    test "$SSH_AUTH_SOCK" && ln -sf "$SSH_AUTH_SOCK" "/tmp/ssh-agent-${USER}-screen-adr" && chmod 600 "/tmp/ssh-agent-${USER}-screen-adr"
    SSH_AUTH_SOCK="/tmp/ssh-agent-${USER}-screen-adr"
fi

# La vie est plus belle en couleurs
if [ "$color_prompt" = yes ]; then
    export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    export PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Configuration entreprise
if [ -d "${CONFIG_PATH}/entreprise" ]; then
    source "${CONFIG_PATH}/entreprise/.bashrc"
fi

# Configuration locale
if [ -d "${CONFIG_PATH}/local" ]; then
    source "${CONFIG_PATH}/local/.bashrc"
fi

