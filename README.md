# VPLAYER

## TODO
Auto start holding graphic
Why does it not work with layer?

Auto start connection to sne cloud for ssh support


package the install

setup ntp


## command notes

sudo ln -s /home/pi/vplayer/vplayer.desktop  /etc/xdg/autostart/vplayer.desktop
sudo ln -s /home/pi/vplayer/omxplayer1.service /lib/systemd/system/omxplayer1.service
sudo systemctl daemon-reload

apt install ntp
