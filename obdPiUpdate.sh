#!/bin/bash
cd /home/pi/obdPiDash
git pull
cd
sudo systemctl restart obdPiDash.service
exit