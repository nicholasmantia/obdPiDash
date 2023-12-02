#!/bin/bash
cd /home/pi/obdPiDash
if [[ `git status --porcelain` ]]; then
  sudo systemctl stop obdPiDash.service
  cd /home/pi/obdPiDash
  git pull
  cd
  sudo systemctl stop obdPiDash.service
else
  fi
fi