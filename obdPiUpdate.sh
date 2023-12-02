#!/bin/bash
cd /home/pi/obdPiDash
if [[ `git status --porcelain` ]]; then
  sudo systemctl stop obdPiDash.service
  git pull
  sudo systemctl start obdPiDash.service
else
  fi
cd
fi