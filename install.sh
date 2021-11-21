#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -z ${1+x} ]; then 
	echo "Need to specify player number 1-3"
fi

function whereami {
    #https://stackoverflow.com/a/246128
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
        DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    # echo ${DIR}
}


whereami
echo "This script is in: ${DIR}"
echo "You specified player id ${1}"
# exit 0
# Setup config file
CONF=/etc/vplayer.conf
CONTENT_SOURCE=vplayer@home.sneconsulting.co.uk:/var/shared/vplayer/contentJdog
VPLAYER_CONTENT=/home/pi/vplayer/content
echo CONTENT_SOURCE=${CONTENT_SOURCE} > ${CONF}
echo VPLAYER_CONTENT=${VPLAYER_CONTENT} >> ${CONF}
echo VPLAYER_NUMBER=${1} >> ${CONF}

# Setup service files
# Ensure only 0 is enabled on boot
cp ${DIR}/omxplayer*.service /lib/systemd/system
systemctl disable 'omxplayer*.service'
systemctl stop 'omxplayer*.service'
systemctl enable 'omxplayer0.service'
systemctl start 'omxplayer*.service'

# TODO Service to get content
mkdir -p ${VPLAYER_CONTENT}
rsync ${CONTENT_SOURCE}/* ${VPLAYER_CONTENT} -avz
chown pi:pi ${VPLAYER_CONTENT}

# crontab initial setup
echo "Current cron:"
crontab -l
