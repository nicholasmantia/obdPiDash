#!/bin/bash

# Update and install system dependencies
sudo apt update && \
sudo apt install -y libfreetype6-dev libgl1-mesa-dev libgles2-mesa-dev libdrm-dev libgbm-dev libudev-dev libasound2-dev liblzma-dev libjpeg-dev libtiff-dev libwebp-dev git build-essential && \
sudo apt install -y gir1.2-ibus-1.0 libdbus-1-dev libegl1-mesa-dev libibus-1.0-5 libibus-1.0-dev libice-dev libsm-dev libsndio-dev libwayland-bin libwayland-dev libxi-dev libxinerama-dev libxkbcommon-dev libxrandr-dev libxss-dev libxt-dev libxv-dev x11proto-randr-dev x11proto-scrnsaver-dev x11proto-video-dev x11proto-xinerama-dev

# Install SDL2
wget https://libsdl.org/release/SDL2-2.0.10.tar.gz && \
tar -zxvf SDL2-2.0.10.tar.gz && \
pushd SDL2-2.0.10 && \
./configure --enable-video-kmsdrm --disable-video-opengl --disable-video-x11 --disable-video-rpi && \
make -j$(nproc) && \
sudo make install && \
popd

# Install SDL2_image
wget https://libsdl.org/projects/SDL_image/release/SDL2_image-2.0.5.tar.gz && \
tar -zxvf SDL2_image-2.0.5.tar.gz && \
pushd SDL2_image-2.0.5 && \
./configure && \
make -j$(nproc) && \
sudo make install && \
popd

# Install SDL2_mixer
wget https://libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.4.tar.gz && \
tar -zxvf SDL2_mixer-2.0.4.tar.gz && \
pushd SDL2_mixer-2.0.4 && \
./configure && \
make -j$(nproc) && \
sudo make install && \
popd

# Install SDL2_ttf
wget https://libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.15.tar.gz && \
tar -zxvf SDL2_ttf-2.0.15.tar.gz && \
pushd SDL2_ttf-2.0.15 && \
./configure && \
make -j$(nproc) && \
sudo make install && \
popd

# Update dynamic libraries cache
sudo ldconfig -v

# Update and upgrade system dependencies
sudo apt update && \
sudo apt upgrade -y && \
sudo apt install -y pkg-config libgl1-mesa-dev libgles2-mesa-dev python3-setuptools libgstreamer1.0-dev git gstreamer1.0-plugins-{bad,base,good,ugly} gstreamer1.0-{omx,alsa} libmtdev-dev xclip xsel libjpeg-dev

# Install pip3 and dependencies
sudo apt install -y python3-pip && \
pip3 install --upgrade pip setuptools && \
pip3 install --upgrade Cython==0.29.19 pillow && \
pip3 install kivy