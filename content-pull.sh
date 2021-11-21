#!/bin/bash

source /etc/vplayer.conf
echo Pulling content

# TODO Service to get content
rsync ${CONTENT_SOURCE} ${VPLAYER_CONTENT} -vr
