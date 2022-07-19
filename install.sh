#!/bin/bash
#

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ ! "$(command -v rsync)" ]; then
    echo -e 'rsync isnt installed! please install it'
    exit 1
fi


mkdir -p "${HOME}/.config/wilfrield/"
rsync -a --delete --exclude="install.sh" "${SCRIPT_DIR}/" "${HOME}/.config/wilfrield/std/"

