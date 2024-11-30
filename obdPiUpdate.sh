#!/bin/bash
cd /home/nick.mantia/myDash
git pull
cd
sudo systemctl restart obdPiDash.service
exit
