# VPLAYER

## User notes

See the config files:
```
cat /etc/vplayer.conf
cat /etc/snesupport.conf
```

Get latest version from git:
The install also pulls latest content
```
cd ~/vplayer
git pull --ff-only
git status
./install.sh <player number 1-3>
```

Get latest content:
```
cd ~/vplayer
./content-pull.sh
```

See schedules:
```
sudo crontab -l
```
Edit Schedules:
```
sudo crontab -e
```

It players content folder needs a video1.mp4 and a holding.mp4
These are links to the files in vplayer/content


Player | Location | Holding | Video1 | Video 2
1 | Argos     | 
2 | Laura lee |
3 | Matalan   |



test change
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

### Core omxplayer bits:

```
sudo -i

ln -s /home/pi/vplayer/omxplayer0.service /lib/systemd/system/omxplayer0.service
ln -s /home/pi/vplayer/omxplayer1.service /lib/systemd/system/omxplayer1.service
ln -s /home/pi/vplayer/vplayer.conf /etc/vplayer.conf
systemctl daemon-reload
systemctl enable omxplayer0.service
```

### Remote support

Does the echo work? Do an ssh turn@cloud.sneconsulting.co.uk and it should connect...

```
sudo -i

mkdir -p /root/.ssh
cp /home/pi/vplayer/keys/* /root/.ssh/
ln -s /home/pi/vplayer/snesupport.service /lib/systemd/system/snesupport.service
systemctl daemon-reload
systemctl enable snesupport.service

echo "|1|l4aXi6lWzC6vFJROA/8s6L7/qsY=|x5k4eY3Mx/fP35YRg9YMODW7tmM= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNpncLgeqYqLULLeoej+uN/48upZW/WijUH3PjUDtyimBMNg5TvVcL7VMO/7JbL8KqhUFBx3cQcMfxJu3klAWyg=" >> /root/.ssh/known_hosts

apt install ntp
```


ln -s /home/pi/vplayer/vplayer.desktop  /etc/xdg/autostart/vplayer.desktop
