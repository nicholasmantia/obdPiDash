![Kivy](https://img.shields.io/badge/Built%20in-Kivy-purple) ![Python](https://img.shields.io/badge/Powered%20by-Python-yellow) ![Arch](https://img.shields.io/badge/Arch-ARM64-blue) ![OS](https://img.shields.io/badge/OS-Raspbian-red)

# obiPiDash
A python project to pull vehicle information from a bluetooth OBD-II adapter and output it to a nice GUI on any touchscreen display.
## Features:
- Coolant Temp, Intake Temp, Battery Voltage, STFT, LTFT, Throttle Pos, Engine Load, Spark Advance, Gear Indicator, RPM (w/ MAX), Speed (w/ MAX)
- Adjustable Warning thresholds for Coolant Temp, Intake Temp, STFT, LTFT, RPM and Speed
- DTC Read and Clear Function
- Selectable F/C MPH/KPH
- Brightness Control

## Screenshots & Photos:
![Alt text](Screenshots/PassView.jpg?raw=true "Title")
![Alt text](Screenshots/TopDown.jpg?raw=true "Title")
![Alt text](Screenshots/Gauges1.png?raw=true "Title")
![Alt text](Screenshots/Gauges2.png?raw=true "Title")
![Alt text](Screenshots/Gauges3.png?raw=true "Title")
![Alt text](Screenshots/Gear.png?raw=true "Title")
![Alt text](Screenshots/MAX.png?raw=true "Title")
![Alt text](Screenshots/DTCs.png?raw=true "Title")
![Alt text](Screenshots/Settings.png?raw=true "Title")

## Hardware and Setup I used:
- Raspberry Pi Zero 2 W
- Raspberry Pi OS Bullseye 32-bit
- Python 3.7.3
- Official 7inch Raspberry Pi Display

## Install Kivy:

`sudo apt update`

`sudo apt install libfreetype6-dev libgl1-mesa-dev libgles2-mesa-dev libdrm-dev libgbm-dev libudev-dev libasound2-dev liblzma-dev libjpeg-dev libtiff-dev libwebp-dev git build-essential -y`

`sudo apt install gir1.2-ibus-1.0 libdbus-1-dev libegl1-mesa-dev libibus-1.0-5 libibus-1.0-dev libice-dev libsm-dev libsndio-dev libwayland-bin libwayland-dev libxi-dev libxinerama-dev libxkbcommon-dev libxrandr-dev libxss-dev libxt-dev libxv-dev x11proto-randr-dev x11proto-scrnsaver-dev x11proto-video-dev x11proto-xinerama-dev -y`

#### Install SDL2:
- `wget https://libsdl.org/release/SDL2-2.0.10.tar.gz`
- `tar -zxvf SDL2-2.0.10.tar.gz`
- `pushd SDL2-2.0.10`
- `./configure --enable-video-kmsdrm --disable-video-opengl --disable-video-x11 --disable-video-rpi`
- `make -j$(nproc)`
- `sudo make install`
- `popd`

#### Install SDL2_image:
- `wget https://libsdl.org/projects/SDL_image/release/SDL2_image-2.0.5.tar.gz`
- `tar -zxvf SDL2_image-2.0.5.tar.gz`
- `pushd SDL2_image-2.0.5`
- `./configure`
- `make -j$(nproc)`
- `sudo make install`
- `popd`

#### Install SDL2_mixer:
- `wget https://libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.4.tar.gz`
- `tar -zxvf SDL2_mixer-2.0.4.tar.gz`
- `pushd SDL2_mixer-2.0.4`
- `./configure`
- `make -j$(nproc)`
- `sudo make install`
- `popd`

#### Install SDL2_ttf:
- `wget https://libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.15.tar.gz`
- `tar -zxvf SDL2_ttf-2.0.15.tar.gz`
- `pushd SDL2_ttf-2.0.15`
- `./configure`
- `make -j$(nproc)`
- `sudo make install`
- `popd`

#### Make sure the dynamic libraries cache is updated:
- `sudo ldconfig -v`

#### Install the dependencies:
- `sudo apt update`
- `sudo apt upgrade`
- `sudo apt install pkg-config libgl1-mesa-dev libgles2-mesa-dev python3-setuptools libgstreamer1.0-dev git gstreamer1.0-plugins-{bad,base,good,ugly} gstreamer1.0-{omx,alsa} thon3-dev libmtdev-dev xclip xsel libjpeg-dev -y`

#### Install pip3:
- `sudo apt install python3-pip`


#### Install pip dependencies:
- `pip3 install --upgrade pip setuptools`
- `pip3 install --upgrade Cython==0.29.19 pillow`

#### Install Kivy:
- `sudo pip3 install kivy`

#### Copy code and data folders to /home/pi/obdPiDash
- `git clone https://github.com/charliehoward/obdPiDash.git`

#### Navigate to obdPiDash directory and run main.py to create the config.ini file
- `cd obdPiDash`
- `sudo python3 main.py`

#### Configure for use with touch screen:

Edit /.kivy/config.ini by:
- `sudo su`
- `cd`
- `sudo nano .kivy/config.ini`


Change [input] to:
````
mouse = mouse
mtdev_%(name)s = probesysfs,provider=mtdev
hid_%(name)s = probesysfs,provider=hidinput
````

`exit` to return to normal user

You can also change this config for the non root user:
- `cd`
- `sudo nano .kivy/config.ini`

## Other Misc Setup (not needed Raspberry Pi Zero 2 W):

In raspi-config -> Advanced Options -> Memory Split
- Change value to 512MB

#### Install Python OBD:
https://python-obd.readthedocs.io/en/latest/#installation
- `pip3 install obd`

#### Install RPi.GPIO, Lite does not come with it..
- `sudo apt-get install python3-rpi.gpio`

#### Bluetooth Setup:
- `sudo bluetoothctl`
- `agent on`
- `default-agent`
- `scan on`
- `pair xx:xx:xx:xx:xx:xx` <- Your BT MAC here
- `connect xx:xx:xx:xx:xx:xx`
- `trust xx:xx:xx:xx:xx:xx`

#### Start on Boot:
- `sudo nano /etc/systemd/system/obdPiDash.service`
```
[Unit]
Description=Start OBDPi

[Service]
ExecStart=/bin/sh /home/pi/launcher.sh >/home/obd/obdPiDash/logs/log.log 2>&1
ExecStop=/usr/bin/pkill -9 -f main.py
WorkingDirectory=/home/obd/obdPiDash/
StandardOutput=inherit
StandardError=inherit
User=obd

[Install]
WantedBy=multi-user.target
```
Make sure to change your username if it's not obd
Ctrl+x to Save

Now, enter the line:
- `sudo systemctl enable obdPiDash.service`

Then make the launcher executable:
- `sudo chmod a+x ./obdPiDash/obdPiLauncher.sh`

Reboot for final test

## Configure Variables:
Modify in main.py 
- developermode 0=Off 1=On <- 0 for in vehicle use, 1 for development/demo use
- externalshutdown <- leave as 0 for now, in development
- AccelEnabled <- leave as 0 for now, Accelerometer in development
- OBDEnabled <- 1 if you are using OBDII features, leave it ON
- onPi <- its default 1, but will change to 0 in code if detected not running on Pi (for development on PC)
- autobrightness < 0 will keep brightness same as last boot, 1 allows custom time if using RTC, 2 will always dim on boot

## OPTIONAL Clean up boot (Remove all boot text and logos):
- /boot/config.txt
`disable_splash=1
boot_delay=0`
- /boot/cmdline.txt - change console=tty1 to console=tty3, add the following to the end of the line
`splash quiet logo.nologo vt.global_cursor_default=0 consoleblank=0`
- In /etc/pam.d/login comment out the following lines
`session    optional   pam_lastlog.so`
`session    optional   pam_motd.so motd=/run/motd.dynamic`
`session    optional   pam_motd.so noupdate`
- Run `touch ~/.hushlogin`
- Remove everything from /etc/motd

