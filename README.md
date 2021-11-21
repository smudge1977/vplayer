# VPLAYER

## TODO
Auto start holding graphic
Why does it not work with layer?

~Auto start connection to sne cloud for ssh support~
Look at ssh keys and unique ports for different pis'

package the install

setup ntp

## Cron Tab

We have to use root crontab as we are starting and stopping services:
To edit:
```
sudo crontab -e
```
To list:
```
sudo crontab -l
```

```
# m h  dom mon dow   command
5,15,25,35,45,55 * * * * systemctl start omxplayer0.service && systemctl stop omxplayer1.service
10,20,30,40,50,0 * * * * systemctl start omxplayer1.service && systemctl stop omxplayer0.service
```


## Setup pi notes

Using oldest Jessie or Weazy - which ever is the newer and then omxplayer works fine


## command notes

Clone the repo
- Do we need git keys as it is public?

Run script to do this stuff:

Doing all with .services now
just enable omxplayer0 it it starts on boot the other get manually startted and stopped


```
ln -s /home/pi/vplayer/vplayer.desktop  /etc/xdg/autostart/vplayer.desktop
ln -s /home/pi/vplayer/omxplayer1.service /lib/systemd/system/omxplayer1.service
ln -s /home/pi/vplayer/vplayer.conf /etc/vplayer.conf
systemctl daemon-reload

apt install ntp
```
