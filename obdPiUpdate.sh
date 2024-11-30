#!/bin/bash
cd /home/nick.mantia/obdPiDash
git pull
cd
sudo systemctl restart obdPiDash.service
exit
