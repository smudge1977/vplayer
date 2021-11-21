#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
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

# Setup conf
# TODO: Need to pass an offset or regex last didgets of host name for offset
echo SSH_REMOTE=5222 > /etc/snesupport.conf
echo VNC_REMOTE=5922 >> /etc/snesupport.conf

# Setup ssh keys
mkdir -p /root/.ssh
cp ${DIR}/keys/* /root/.ssh/
chown root:root /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
# Trust cloud.sneconsulting
ssh-keyscan -H cloud.sneconsulting.co.uk >> /root/.ssh/known_hosts
#echo "|1|EB6uJf5WEQfdbfq0aP3DK0I9+WM=|WbkXGNygQVIiZxDI8v69GdPYYAY= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNpncLgeqYqLULLeoej+uN/48upZW/WijUH3PjUDtyimBMNg5TvVcL7VMO/7JbL8KqhUFBx3cQcMfxJu3klAWyg=" >> /root/.ssh/known_hosts


# Copy service files
# TODO - Make a loop maybe!
#rm /lib/systemd/system/snesupportssh.service
cp ${DIR}/systemd/snesupportssh.service /lib/systemd/system/snesupportssh.service
#rm /lib/systemd/system/snesupportvnc.service
cp ${DIR}/systemd/snesupportvnc.service /lib/systemd/system/snesupportvnc.service

#echo "|1|l4aXi6lWzC6vFJROA/8s6L7/qsY=|x5k4eY3Mx/fP35YRg9YMODW7tmM= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNpncLgeqYqLULLeoej+uN/48upZW/WijUH3PjUDtyimBMNg5TvVcL7VMO/7JbL8KqhUFBx3cQcMfxJu3klAWyg=" >> /root/.ssh/known_hosts
systemctl daemon-reload
systemctl enable snesupportssh.service
systemctl enable snesupportvnc.service

systemctl start snesupportssh.service
systemctl start snesupportvnc.service

